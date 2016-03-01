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
