# An example SPA in Elm

An example Elm single page application built for http://www.elm-tutorial.org/

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
