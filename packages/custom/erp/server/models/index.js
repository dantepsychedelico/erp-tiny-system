'use strict';

var mean = require('meanio');
var run = mean.resolved.database.action.run;

// create model
var itemsModel = 'CREATE TABLE IF NOT EXISTS items(id TEXT PRIMARY KEY, desc TEXT, ts INTEGER)';
var mediaModel = 'CREATE TABLE IF NOT EXISTS medias(id TEXT PRIMARY KEY, name TEXT, data BLOB)'

run(itemsModel);
run(mediaModel);
