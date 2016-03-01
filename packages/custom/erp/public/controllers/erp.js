'use strict';

window.agGrid.initialiseAgGridWithAngular1(angular);
angular.module('mean.erp')
.controller('erpManager', ['$scope', '$http', function($scope, $http) { 
    $scope.gridOptions = {
        columnDefs: [
            {headerName: 'id', field: 'id'},
            {headerName: 'desc', field: 'desc'},
        ]
    };
    $http.get('/api/erp/items')
    .then(function(results) {
        $scope.gridOptions.api.setRowData(results.data);
    });
}]);
