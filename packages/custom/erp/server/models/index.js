'use strict';

var mean = require('meanio');
var run = mean.resolved.database.action.run;

// create model
var sql = 'CREATE TABLE IF NOT EXISTS items(id text PRIMARY KEY, desc text)';

run(sql);
