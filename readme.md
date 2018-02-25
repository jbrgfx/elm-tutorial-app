# An example SPA in Elm

An example Elm single page application built for http://www.elm-tutorial.org/ adapted to use postgRest and postgreSQL data rather than the Javascript JSON server and static JSON data file in the original project.  PostgRest is built with Haskell and provides an API to postgreSQL. Since both Elm and postgRest are type-safe, it makes sense to try to leverage their strengths in terms of safety and security.
Once you configure the pieces and start them, try requesting something using ELM from postgreSQL via postgRest that is not valid. For example, you could change the query to something that you know will not work in the file src/Commands.elm (function to change is entitled fetchPlayersUrl) or just append a query string on the address line of the browser. You know that it will not work because it is either not convered by a case or let statement in Elm or it violates the API spec or it simply is not an authorized operation in postgRest.

Depending on where you make the hack, you will get one of three reports: "Nothing" (a valid case from Elm), a postgRest error or a postgRest warning and explanation of the badRequest.  The point is, since the requests and responses are type-checked, and postgreSQL hold privileges, you cannot do what you are not allowed to do, and nothing that is not allowed even goes to the postgreSQL server --either Elm or postgRest or both spot the client from doing bad things.

## Setup

- [Install Elm](http://elm-lang.org/install)
- [Install Node](https://nodejs.org/en/download/)
- [Install Yarn](https://yarnpkg.com/)

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
