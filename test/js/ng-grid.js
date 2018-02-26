var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection']);

app.controller('MainCtrl', ['$scope', '$http', '$interval', '$q','uiGridConstants', function ($scope, $http, $interval, $q, uiGridConstants) {
  
  var fakeI18n = function( title ){
    var deferred = $q.defer();
    $interval( function() {
      deferred.resolve( 'col: ' + title );
    }, 1000, 1);
    return deferred.promise;
  };
  
  
  
  var today = new Date();
  var nextWeek = new Date();
  nextWeek.setDate(nextWeek.getDate() + 7);
  
  
  
  
  
  
  
  //------------------ row click -------------------------------
  
  /*
   // Here row is the scope of the row which the mouse is under. 
  // TODO: highlight other cells in the row from this.
  $scope.onRowHover = function(row) {
    console.log(row);
  }
  */
  
  
  
  // you could of course just include the template inline in your code, this example shows a template being returned from a function
  function rowTemplate() {
    return '<div ng-dblclick="grid.appScope.rowDblClick(row)" >' +
                 '  <div ng-repeat="(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name" class="ui-grid-cell" ng-class="{ \'ui-grid-row-header-cell\': col.isRowHeader }"  ui-grid-cell></div>' +
                 '</div>';
  }



                                  // ~~~~~~~~~~~~~~ --- double click row modal ----- ~~~~~~~~~~~~~~~~~~~~~~~

								  $scope.rowDblClick = function(row) {
									                    console.log(row.entity);
									                         // alert(JSON.stringify(row.entity)); 
															   // get previous watering date
															   
															   /*
															   var post_data = {
																					tree_id: _tree_id
																			 
																				   };
									   
									   
									   
					
																var req = {
																			method : "POST",
																			
																			url : url + "cfc/watering_service.cfc?method=get_last_watering_date&returnformat=json&queryformat=struct",
																			
																			data: post_data
																		};
						
						
						
																	$http(req).then(
																					
																		function Success(_response) 
																		{	
																					
																			var _result = _response.data;		
																			//_result = _result.replace(/\s/g, '');  // must remove space in string		
																			
																		    var _date = new Date(_result[0].COMPUTED_COLUMN_1);
																		    
																			//  get 'short date' formate - toLocaleDateString
																			$scope.modal_previous_watering_date	= _date.toLocaleDateString();		
																			
																										  
																		}, function Error(_response) {
																			
																														  
																	}); // http then
																			
															//  --- end --- get previous watering date		
																			
																			
																			
																			
																  
															$scope.modal_current_watering_date = '';			  
																			  
																			  
																			   
																			   $scope.modal_tree_id = _tree_id;
																			   $scope.modal_site_no  = _site_no;
																			   $scope.modal_crm  = _crm;
																			   $scope.modal_package_no  = _package_no ;
																 */				   
																			  
															$("#double_click_row_modal").modal();
																				
								             											
																				
																				
												
           };
  
        // ~~~~~~~~~~~~~~~~~~~~~    End  ~~~~~~~~~~~~~~~~~ --- double click row modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
	
	
	
	
 

  $scope.waiting = 'Double click on any row to seed the row data';
  
  //------------------  End ------------ row click -------------------------------
  
  

  $scope.highlightFilteredHeader = function( row, rowRenderIndex, col, colRenderIndex ) {
    if( col.filters[0].term ){
      return 'header-filtered';
    } else {
      return '';
    }
  };

  $scope.gridOptions = {
	  
	  rowTemplate: rowTemplate(),
	  
	  exporterMenuCsv: true,
    enableGridMenu: true,
    gridMenuTitleFilter: fakeI18n,
	  
	  
	  
    enableFiltering: true,
	
	
    onRegisterApi: function(gridApi){
		
      $scope.gridApi = gridApi;
	  
	   // interval of zero just to allow the directive to have initialized
      $interval( function() {
        gridApi.core.addToGridMenu( gridApi.grid, [{ title: 'Dynamic item', order: 100}]);
      }, 0, 1);
 
      gridApi.core.on.columnVisibilityChanged( $scope, function( changedColumn ){
        $scope.columnChanged = { name: changedColumn.colDef.name, visible: changedColumn.colDef.visible };
      });
	  
	  
    },
	
	
	
	gridMenuCustomItems: [
      {
        title: 'Rotate Grid',
        action: function ($event) {
          this.grid.element.toggleClass('rotated');
        },
        order: 210
      }
    ],
	
    columnDefs: [
      // default
      { field: 'name', 
	  
	  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?key={{grid.appScope.editLink(grid, row)}}&returnformat=json">{{grid.appScope.editLink(grid, row)}}</a></div>',
	  
	  headerCellClass: $scope.highlightFilteredHeader },
	  
	  
	  
	  
      // pre-populated search field
      { field: 'gender', filter: {
          term: '1',
          type: uiGridConstants.filter.SELECT,
          selectOptions: [ { value: '1', label: 'male' }, { value: '2', label: 'female' }, { value: '3', label: 'unknown'}, { value: '4', label: 'not stated' }, { value: '5', label: 'a really long value that extends things' } ]
        },
        cellFilter: 'mapGender', headerCellClass: $scope.highlightFilteredHeader },
     
	 
	 // no filter input
      { field: 'company', 
	     enableFiltering: false, 
		 filter: {
        				noTerm: true,
        				condition: function(searchTerm, cellValue) 
								   {
          							  return cellValue.match(/a/);
       								}
                  },
				  
		cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?key={{grid.appScope.editLink(grid, row)}}&returnformat=json">{{grid.appScope.editLink(grid, row)}}</a></div>'	  
				  
				  
				  
	   },
     
	 
	 
	 
	 
	 // specifies one of the built-in conditions
      // and a placeholder for the input
      {
        field: 'email',
        filter: {
          condition: uiGridConstants.filter.ENDS_WITH,
          placeholder: 'ends with'
        }, headerCellClass: $scope.highlightFilteredHeader
      },
      // custom condition function
      {
        field: 'phone',
        filter: {
          condition: function(searchTerm, cellValue) {
            var strippedValue = (cellValue + '').replace(/[^\d]/g, '');
            return strippedValue.indexOf(searchTerm) >= 0;
          }
        }, headerCellClass: $scope.highlightFilteredHeader
      },
      // multiple filters
      { field: 'age', filters: [
        {
          condition: uiGridConstants.filter.GREATER_THAN,
          placeholder: 'greater than'
        },
        {
          condition: uiGridConstants.filter.LESS_THAN,
          placeholder: 'less than'
        }
      ], headerCellClass: $scope.highlightFilteredHeader},
      // date filter
      { field: 'mixedDate', cellFilter: 'date', width: '15%', filter: {
          condition: uiGridConstants.filter.LESS_THAN,
          placeholder: 'less than',
          term: nextWeek
        }, headerCellClass: $scope.highlightFilteredHeader
      },
      { field: 'mixedDate', displayName: "Long Date", cellFilter: 'date:"longDate"', filterCellFiltered:true, width: '15%',
      }
    ]
  };  // gridOptions
  
  
  
  
  
  $scope.editLink = function( grid, myRow ) {
   
   /*
   var myRowFound = false;
    var cumulativeTotal = 0;
    grid.renderContainers.body.visibleRowCache.forEach( function( row, index ) {
      if( !myRowFound ) {
        cumulativeTotal += row.entity.widgets;
        if( row === myRow ) {
          myRowFound = true;
        }
      }
    });
	
	*/
    return myRow.entity.company;
  };
  
  
  
  
  
  

  $http.get('https://cdn.rawgit.com/angular-ui/ui-grid.info/gh-pages/data/500_complex.json')
    .success(function(data) {
      $scope.gridOptions.data = data;
      $scope.gridOptions.data[0].age = -5;

      data.forEach( function addDates( row, index ){
        row.mixedDate = new Date();
        row.mixedDate.setDate(today.getDate() + ( index % 14 ) );
        row.gender = row.gender==='male' ? '1' : '2';
      });
    });

  $scope.toggleFiltering = function(){
    $scope.gridOptions.enableFiltering = !$scope.gridOptions.enableFiltering;
    $scope.gridApi.core.notifyDataChange( uiGridConstants.dataChange.COLUMN );
  };
}])
.filter('mapGender', function() {
  var genderHash = {
    1: 'male',
    2: 'female'
  };

  return function(input) {
    if (!input){
      return '';
    } else {
      return genderHash[input];
    }
  };
});
