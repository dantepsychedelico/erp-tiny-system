'use strict';

exports.getItems = function(req, res, database) {
    var sql = 'SELECT id, desc FROM items';
    database.all(sql)
    .then(function(rows) {
        res.json(rows);
    })
    .catch(function(err) {
        console.log(err.stack);
        res.sendStatus(500);
    });
};

exports.updateItem = function(req, res, database) {
    var sql = 'INSERT OR REPLACE INTO items (id, desc) VALUES(?, ?)';
    database.all(sql, [req.params.id, req.body.desc])
    .then(function() {
        res.sendStatus(200);
    })
    .catch(function(err) {
        console.log(err.stack);
        res.sendStatus(500);
    });
};
