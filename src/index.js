'use strict';

require("./static/material.min.css");
require("./static/material.min.js");
require("./static/material_icons.css");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var bookmarksItem = 'accu2017_bookmarks';

// TODO: Load bookmarks proposals from localstorage and pass to embed().
var bookmarks = localStorage.getItem(bookmarksItem);
if (bookmarks) {
    bookmarks = JSON.parse(bookmarks);
}
else {
    bookmarks = [];
}

setTimeout(function() {
    var app = Elm.ACCUSchedule.embed(mountNode, bookmarks);

    // handle "store" port to save bookmarks proposals
    app.ports.store.subscribe(function(bookmarks) {
        localStorage.setItem(bookmarksItem, JSON.stringify(bookmarks));
    });
});
