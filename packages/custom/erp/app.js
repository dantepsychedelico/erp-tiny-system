'use strict';

var meanio = require('meanio');
var Module = meanio.Module;
var ErpPackage = new Module('erp');

/*
 * All MEAN packages require registration
 * Dependency injection is used to define required modules
 */
ErpPackage.register(function(app, auth, database) {

    //We enable routing. By default the Package Object is passed to the routes
    ErpPackage.routes(app, auth, database);

    ErpPackage.aggregateAsset('css', '../lib/ag-grid/dist/styles/theme-blue.css');
    ErpPackage.aggregateAsset('css', '../lib/font-awesome/css/font-awesome.min.css');
    ErpPackage.aggregateAsset('js', '../lib/ag-grid/dist/ag-grid.min.js', {weight: -1});
    ErpPackage.angularDependencies(['agGrid']);

  return ErpPackage;

});

