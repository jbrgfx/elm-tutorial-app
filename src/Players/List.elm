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


indentStyle =
    style
        [ ( "padding", "20px" )
        , ( "margin-left", "10px" )
        , ( "background-color", "grey" )
        , ( "color", "white" )
        ]


showQuery =
    div [ indentStyle ]
        [ Html.text "  Query to postgRest: /players?order=level.desc,name.asc"
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


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


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Sort" ]
                    , th [] [ text "View" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ detailsBtn player ]
        ]


detailsBtn : Player -> Html.Html Msg
detailsBtn player =
    let
        path =
            playerPath player.id
    in
    a
        [ class "btn regular"
        , href path
        ]
        -- [ i [ class "fa fa-pencil mr1" ] [], text "Details" ]
        [ i [] [], text "Specialties" ]
