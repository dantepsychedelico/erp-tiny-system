'use strict';

window.agGrid.initialiseAgGridWithAngular1(angular);
angular.module('mean.erp')
.controller('erpManager', ['$scope', '$http', function($scope, $http) { 
    var columnDefs = [
        {headerName: 'Make', field: 'make'},
        {headerName: 'Model', field: 'model'},
        {headerName: 'Price', field: 'price'}
    ];

    var rowData = [
        {make: 'Toyota', model: 'Celica', price: 35000},
        {make: 'Ford', model: 'Mondeo', price: 32000},
        {make: 'Porsche', model: 'Boxter', price: 72000}
    ];

    $scope.gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData
    };

}]);
