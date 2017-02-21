# ACCU 2017 Elm-based schedule app

This is an Elm-based web application for browsing the ACCU 2017 conference
schedule.

The structure of this project is largely derived from the
excellent [Elm Tutorial](https://www.elm-tutorial.org/).

To build and run the app, make sure
you've
[installed a recent version of node.js](https://docs.npmjs.com/getting-started/installing-node).

## Building

First install the necessary npm dependencies:
```
npm install
```

Then build the Elm code:
```
npm run build
```

If this succeeds, the compiled and web-packed code will be in the `dist`
directory.

## Configuring the environment

The app reads certain configuration information from the file `.env`. You can
find an example of this file in `dot.env`. Before you can run the system, you
need to copy `dot.env` to `.env` and edit it as approporiate.

The default configuration should be good for local development purposes, but
you'll want to use different environments for various deployment scenarios.

## Running the development server

You can use node-foreman to run the API server and the client:
```
nf start
```

After that the app should be available on http://localhost:3000.

When the development server is running, it will monitor changes to the source
code and recompile/redeploy as necessary. This is probably what you want to do
if you're hacking around in the code; it provides a very responsive edit-run
cycle.
