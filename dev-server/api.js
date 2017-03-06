// A simple node app for serving up some dummy test data.

var jsonServer = require('json-server');

// Returns an Express server
var server = jsonServer.create();

// Set default middlewares (logger, static, cors and no-cache)
server.use(jsonServer.defaults());

server.use(jsonServer.rewriter({
    '/proposals/api/': '/'
}));

var router = jsonServer.router('dev-server/bio-db.json');
server.use(router);

console.log('Listening at 4000');
server.listen(4000);
