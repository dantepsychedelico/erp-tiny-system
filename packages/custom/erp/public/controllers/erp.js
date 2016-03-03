'use strict';

window.agGrid.initialiseAgGridWithAngular1(angular);
angular.module('mean.erp')
.controller('erpManager', ['$scope', '$http', '$uibModal', function($scope, $http, $uibModal) { 
    $scope.gridOptions = {
        columnDefs: [
            {headerName: 'id', field: 'id'},
            {headerName: 'desc', field: 'desc'},
        ]
    };
    $scope.getItems = function() {
        return $http.get('/api/erp/items')
        .then(function(results) {
            $scope.gridOptions.api.setRowData(results.data);
        });
    };
    $scope.getItems();
    $scope.addItem = function() {
        var modalInstance = $uibModal.open({
            templateUrl: 'template/addItem.html',
            controller: 'erpManagerAddItem',
            scope: $scope
        });
    };
    $scope.editItem = function() {
    };
}])
.controller('erpManagerAddItem', ['$scope', '$http', '$uibModalInstance', function($scope, $http, $uibModalInstance) {
    $scope.data = {};
    $scope.ok = function () {
        $http.post('/api/erp/items/'+$scope.data.id, $scope.data)
        .then(function() {
            return $scope.getItems()
        })
        .then(function() {
            $uibModalInstance.close();
        });
    }; 
    $scope.cancel = function () {
        $uibModalInstance.dismiss();
    };
}]);
