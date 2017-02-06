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

If this succeeds, t
he compiled and web-packed code will be in the `dist`
directory.

## Running the development server

You can use node-foreman to run the API server and the client:
```
nf start
```

After that the webapp should be available on http://localhost:3000.

When the development server is running, it will monitor changes to the source
code and recompile/redeploy as necessary. This is probably what you want to do
if you're hacking around in the code; it provides a very responsive edit-run
cycle.
