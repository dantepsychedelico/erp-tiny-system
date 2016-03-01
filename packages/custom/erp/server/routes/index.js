'use strict';

var ctrl = require('../controllers/erp.js');
module.exports = function(Erp, app, auth, database) {
    app.get('/api/erp/items', function(req, res){
        ctrl.getItems(req, res, database);
    });
    app.post('/api/erp/items/:id', function(req, res) {
    });
};
