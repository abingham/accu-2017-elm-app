'use strict';

require("./static/material.min.css");
require("./static/material.min.js");
require("./static/material.blue_grey-light_blue.min.css");
require("./static/material_icons.css");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.ACCUSchedule.embed(mountNode);
