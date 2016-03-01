'use strict';

//Setting up route
angular.module('mean.erp')
.config(['$stateProvider', function($stateProvider) {    
    $stateProvider
    .state('erp-manager', {
        url: '/erp/manager',
        templateUrl: 'erp/views/erp-manager.html',
        controller: 'erpManager'
    });
}]);
