// A simple node app for serving up some dummy test data.

var jsonServer = require('json-server');

// Returns an Express server
var server = jsonServer.create();

// Set default middlewares (logger, static, cors and no-cache)
server.use(jsonServer.defaults());

var router = jsonServer.router('dev-server/db.json');
server.use(router);

server.use(jsonServer.rewriter({
    '/proposals/api/': '/'
}));

console.log('Listening at 4000');
server.listen(4000);
