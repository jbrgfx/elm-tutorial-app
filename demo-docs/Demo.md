# What's next in web dev?

I have spent over two years of early mornings, evenings and wekkends
trying to discover a simple, quick way of writing web apps.

## My Overall objectives:

1. Separate frontend from backend development as cleanly, completely
	and simply as possible.

2. Minimize the numbers of things and technologies a developer needs
	to reason about
	-- that is, get rid of pain points and ridiculous abstractions.

3. Make refactoring easy and as painless as possible.

4. Popularize and demonstrate those things that make sense.

## Demo:

Ingredients:

	Elm (frontend)
	postgrest (A remote data request API: warp middleware written in Haskell)
	postgreSQL (backend Db)

1. Start with Haskell middleware
[postgrest API](https://postgrest.com/en/v4.3/api.html)

2. explain basic steps in the Db and warp app config

3. start postgreSQL

4. explain Db permissions and postgres setup

		create schema, table(s), view(s), SPs, etc.
		grant usage (require login - in my case no login - anonymous with JWT)
		grant privileges (in my case, only select)

		configure postgrest by creating postgrest.conf
		user specified in the db-uri is also known as the authenticator role
		supports JWT, OAuth, CORs, Proxy, connection pooling, EKG monitoring


		default output format is JSON, but also outputs on request
			- text/csv
			- openapi+json
			- octet-stream

		db-uri = "postgres://user:pass@host:5432/dbname"
		db-schema = "api"
		db-anon-role = "web_anon"

5. start postgREST

		postgrest ~/Documents/haskell-work/postgrest/postgrest.conf

6. explain [Swagger - OpenAPI](http://localhost:3000)

	highlight the two terms using find in page: players and todos

		The OpenAPI Specification creates the RESTful contract
		for your API, detailing all of its resources and operations
		in a human and machine readable format for easy development,
		discovery, and integration.

	- show

			curl http://localhost:3000/players
			http://localhost:3000/todos
			http://localhost:3000/players
			http://localhost:3000/players?level=gte.7&order=level.desc

7. postgrest code projects on github (some are old, some depricated)

		Count Languages
		   35 JavaScript
		   21 PLpgSQL
		   18 Shell
		    8 Haskell
		    7 Elm
		    7 Python
		    6 Java
		    5 C#
		    5 Go
		    5 Ruby

8. Explain elm-tutorial-app
	- why chosen
		- Uses the best Elm abstractions (modules) for the purpose
		- Easy for you to do what I did to get the feel
		- Demo: refactoring the tutorial to use postgrest and postgresql instead of
			fake (manually edited JSON ) data and node-based JS API server took
			20 minutes.

	from the cloned root directly
		yarn start


[elm-tutorial-app-using-PostgREST-API/src/Commands.elm](https://github.com/jbrgfx/elm-tutorial-app-using-PostgREST-API/blob/master/src/Commands.elm)
``` elm
module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Player, PlayerId)
import Msgs exposing (Msg)
import RemoteData

fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:3000/players?order=level.desc,name.asc"
```

[elm-tutorial-app-using-PostgREST-API/src/Update.elm](https://github.com/jbrgfx/elm-tutorial-app-using-PostgREST-API/blob/master/src/Update.elm)
``` elm
module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Models exposing (Model, Player)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )
				. . .
```


[elm-tutorial-app-using-PostgREST-API/src/Players/List.Elm](https://github.com/jbrgfx/elm-tutorial-app-using-PostgREST-API/blob/master/src/Players/List.elm)
``` elm

module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, style)
import Models exposing (Player)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)


view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        , showQuery
        ]
. . .

maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)
```
![layout screenshot](layout.png)

<div class="page-break" />


![padding and spacing in a layout](pres-pg03.png)

<div class="page-break" />

[jbrgfx.github.home](https://jbrgfx.github.io/)

[jbrgfx github io/src/Main.elm](https://github.com/jbrgfx/jbrgfx.github.io/blob/master/src/Main.elm)
``` elm
module Main exposing (..)

import Color exposing (black, darkBlue, lightGrey, white)
import Element exposing (Element, alignBottom, alignLeft, centerY, column, height, image, layout, newTabLink, padding, paddingEach, paragraph, px, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html

view model =
    Element.layout
        [ Background.color white
        , width (px 900)
        , paddingLeft gutter
        , Font.family
            [ Font.typeface "Open Sans"
            , Font.sansSerif
            ]
        ]
    <|
        column
            []
            [ headerArea
            , mainColumns
                { left =
                    [ theAppDesc
                    , overViewDesc
                    ]
                , right =
                    [ row [ padding gutter ] [ inputForm ]
                    , validateFilter model
                    , paragraph
                        []
                        [ Element.text "Results:" ]
                    , paragraph
                        [ padding gutter
                        , Background.color lightGrey
                        , Font.size 16
                        ]
                        (List.map viewRepos model.filtered)
                    ]
                }
            , footerArea
            ]
```

``` elm
viewRepos entry =
    paragraph
        []
        [ newTabLink
            [ padding gutter
            , Font.bold
            , Font.size 18
            , Font.underline
            , alignBottom
            , Font.color darkBlue
            , Background.mouseOverColor Color.darkBlue
            , Font.mouseOverColor Color.white
            ]
            { url = "https://github.com/jbrgfx/" ++ entry
            , label = Element.text entry
            }
        ]
```

[Oracle Rest Data Services (ORDs)](https://oracle-base.com/articles/misc/oracle-rest-data-services-ords-installation-on-tomcat)


## Benefits of choosing Elm:

1. Just Elm code.

2. Strongly typed language means the compiler outputs informative errors.

3. Impossible states can be avoided by design.

4. Each possible state is type-checked.

5. In this example, even the layout is type-checked, and I wrote no CSS.

6. No run-time errors.

7. A virtual DOM has been included from the beginning;
   unlike other reactive frameworks, there is no intellectual overhead.

8. I can completely separate front-end code from middleware and from backend(s).

## Challenges:

1. Elm is totally different from anything (except Haskell),
	so it has a steep learning curve especially if you do not yet
	know a typed, functional language.

2. Hard to begin thinking about web dev without a framework,
	without HTML, without CSS, without JS, without objects to work with
	directly and using a totally new layout philosophy.
