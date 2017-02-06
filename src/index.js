'use strict';

require("./static/material.min.css");
require("./static/material.min.js");
require("./static/material.blue_grey-light_blue.min.css");
require("./static/material_icons.css");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var starredItem = 'accu2017_starred';

// TODO: Load starred proposals from localstorage and pass to embed().
var starred = localStorage.getItem(starredItem);
if (starred) {
    starred = JSON.parse(starred);
}
else {
    starred = [];
}

var app = Elm.ACCUSchedule.embed(mountNode, starred);

// handle "store" port to save starred proposals
app.ports.store.subscribe(function(starred) {
    localStorage.setItem(starredItem, JSON.stringify(starred));
});
