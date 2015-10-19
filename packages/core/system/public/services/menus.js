'use strict';

angular.module('mean.system')
.factory('Menus', function($resource) {
    return $resource('api/admin/menu/:name', {
      name: '@name',
      defaultMenu: '@defaultMenu'
    });
  }
);
