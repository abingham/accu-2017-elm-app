'use strict';

require("./static/material.min.css");
require("./static/material.min.js");
require("./static/material.blue_grey-light_blue.min.css");
require("./static/material_icons.css");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// TODO: handle "store" port to save starred proposals

// TODO: Load starred proposals from localstorage and pass to embed().
var app = Elm.ACCUSchedule.embed(mountNode, []);
