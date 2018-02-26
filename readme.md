# An example SPA in Elm

An example Elm single page application built for https://www.elm-tutorial.org/en/06-fetching-resources/cover.html adapted to use postgRest and postgreSQL data rather than the Javascript JSON server and static JSON data file in the original project.  PostgRest is built with Haskell and provides an API to postgreSQL. Since both Elm and postgRest are type-safe, it makes sense to try to leverage their strengths in terms of safety and security.
Once you configure the pieces and start them, try requesting something using ELM from postgreSQL via postgRest that is not valid. For example, you could change the query to something that you know will not work in the file src/Commands.elm (function to change is entitled fetchPlayersUrl) or just append a query string on the address line of the browser. You know that it will not work because it is either not convered by a case or let statement in Elm or it violates the postgRest API or it simply is not an authorized operation in postgRest.

Depending on where you make the hack, you will get one of three reports: "Nothing" (a valid case from Elm), a postgRest error or a postgRest warning and explanation of the badRequest.  The point is, since the requests and responses are type-checked, and postgreSQL holds client privileges, you cannot do what you are not allowed to do, and nothing that is not allowed even goes to the postgreSQL server --either Elm or postgRest or both stop the client from doing bad things.

## Setup

- [Install Elm](http://elm-lang.org/install)
- [Install Node](https://nodejs.org/en/download/)
- [Install Yarn](https://yarnpkg.com/)
-CLone this [branch of the tutorial's repo](https://github.com/sporto/elm-tutorial-app/tree/017-05-fetch)

## Install dependencies:

```
yarn
```

## This version:

- Is an adaptation to fetch PostgreSQL data via postgRest, a haskell warp web app.
- The Elm code may contain any supported API call to which the application has been granted privileges in the PostgreSQL database.
- Elm only needs a REST endpoint -- construct a request using core-http with a query string that meets the PostRest API specs.
- [read the docs](https://postgrest.com/en/v4.3/api.html) and download the binary.


## Configuration

In Commands.elm, set the URLs to get data via PostgRest from PostgreSQL.
You can follow the docs on using curl to test:
[PostgRest API](https://postgrest.com/en/v4.4/api.html).

PostgRest uses port 3000 by default and so does this Elm app.,
so change the port on which the elm application runs in
package.json (under devDependencies).
A good choice might be 8080.

## Start PostgreSQL

## Run the Haskell postgRest server 
- from the binary dir where postgRest can execute:

  ```
  $postgrest postgrest.conf
   ```
   
## Running the application:

In terminal run:

```
yarn start
```
Open `http://localhost:8080`

Please note that I have left a bothersome definition inherited from the original in order to make it as easy as possible to combine Elm with the mid-tier postgRest warp app and the postgreSQL backend -- that is, in src/Model.elm the PlayerID alias is set to type string and matched to id in the Player alias.  This means that your postgreSQL database table needs to use a text type for the field id (the primary key).

This "feature" must have been a compromise caused by using the Javascript JSON backend in the orginal project and keeping the Elm code as simple as possible. If I were doing more than a demo, I would leverage Haskell and Elm's type systems to tranforms mixed types into JSON string data and use an Int type in postgreSQL for the primary key rather than just using strings all the way down from the database to the client.
