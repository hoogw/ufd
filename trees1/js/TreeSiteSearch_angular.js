var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection']);

app.controller('MainCtrl', ['$scope', '$http','$interval', '$q', 'uiGridConstants', function ($scope, $http, $interval, $q, uiGridConstants) {
  
  
				  var today = new Date();
				  var nextWeek = new Date();
				  nextWeek.setDate(nextWeek.getDate() + 7);
				  
				  
				  var fakeI18n = function( title ){
					var deferred = $q.defer();
					$interval( function() {
					  deferred.resolve( 'col: ' + title );
					}, 1000, 1);
					return deferred.promise;
				  };
				  
				  
				  
				  
				
				  $scope.highlightFilteredHeader = function( row, rowRenderIndex, col, colRenderIndex ) {
					if( col.filters[0].term ){
					  return 'header-filtered';
					} else {
					  return '';
					}
				  };



  				$scope.gridOptions = {
	  
							  exporterMenuCsv: true,
							enableGridMenu: true,
							gridMenuTitleFilter: fakeI18n,
	  
	  
							  gridMenuCustomItems: [
							  {
								title: 'Rotate Grid',
								action: function ($event) {
								  this.grid.element.toggleClass('rotated');
								},
								order: 210
							  }
							],
	  
	  
    						enableFiltering: true,
	                         //enableFiltering: false,
	
							onRegisterApi: function(gridApi){
								
							  $scope.gridApi = gridApi;
							  
							    // this line for single filter only
							   $scope.gridApi.grid.registerRowsProcessor( $scope.singleFilter, 200 );
							   
							   
							   // interval of zero just to allow the directive to have initialized
							  $interval( function() {
								gridApi.core.addToGridMenu( gridApi.grid, [{ title: 'Dynamic item', order: 100}]);
							  }, 0, 1);
						 
							  gridApi.core.on.columnVisibilityChanged( $scope, function( changedColumn ){
								$scope.columnChanged = { name: changedColumn.colDef.name, visible: changedColumn.colDef.visible };
							  });
							},   // onRegisterApi
	
	
	
							columnDefs: [
								
							//	{ field: 'ID', headerCellClass: $scope.highlightFilteredHeader },
								
							  
							  {   name: 'Type',
							  
							      field: 'PROGRAM_TYPE', filter: {
								 // term: '1',   //filter field can be pre-populated by setting filter: { term: 'xxx' } in the column def
								  type: uiGridConstants.filter.SELECT,
								  selectOptions: [ { value: '1', label: 'BSS' }, { value: '2', label: 'BOE' }, { value: '3', label: 'REBATE'}]
								},
								cellFilter: 'mapType', headerCellClass: $scope.highlightFilteredHeader },
							 
							 
							 
							 
							
							  
							  
							  // default
							  { 
							     name: 'Site',
							  	field: 'BOE_SITE', 
								
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="' + url + 'forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
							  
							  /*
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="http://78boe99prod/ufd/trees1/forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
							  */
							  },
							  
							  
							  
							  // default
							  { 
							   name: 'CRM',
							  field: 'CRM_NUMBER',
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="' + url + 'forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							 
							 /*
							 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="http://78boe99prod/ufd/trees1/forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							 */
							   },
							  
							   // default
							  { 
							     name: 'Package',
							  	field: 'BOE_BID_PACKAGE', headerCellClass: $scope.highlightFilteredHeader },
							  
							  
							  
							  // default
							  { 
							    name: 'CD',
							  field: 'CD', headerCellClass: $scope.highlightFilteredHeader },
							  
							  
							  // default
							  { 
							   name: 'Rebate',
							  field: 'REBATE', headerCellClass: $scope.highlightFilteredHeader }
							  
							  
																		  
																		
						]   //columnDefs: 
							
					 };  // gridOptions	
  
  
  
  
  
                    // --------- Edit link  --------------   
  
                   $scope.editLink_pk_id = function( grid, myRow ) {
					   return myRow.entity.ID;
				  };
  
                  $scope.editLink_program_type = function( grid, myRow ) {
					   return myRow.entity.PROGRAM_TYPE;
				  };
				  
				  $scope.editLink_package_no = function( grid, myRow ) {
					   return myRow.entity.BOE_BID_PACKAGE;
				  };
				  
				 
				  
				  
				  $scope.editLink_site_no = function( grid, myRow ) {
				   
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
					return myRow.entity.BOE_SITE;
				  };

                  $scope.editLink_cd = function( grid, myRow ) {
					   return myRow.entity.CD;
				  };

                   $scope.editLink_rebate = function( grid, myRow ) {
					   return myRow.entity.REBATE;
				  };
                      
					   $scope.editLink_crm = function( grid, myRow ) {
					   return myRow.entity.CRM_NUMBER;
				  };
				  
				  
				  
				 


				  $http.get(url + 'cfc/tree_service.cfc?method=search_site&returnformat=json&queryformat=struct')
					.success(function(data) {
					 
					 
				     
					 
					// ============= ----------  modify raw response from server  --------------    =======================
						  var ng_grid_data = [];
						  var ng_grid_data_array_obj = {};
					 
					
						angular.forEach(data, function(value, key) {
													   
			                 					
							
							     ng_grid_data_array_obj = {};
							     angular.forEach(value, function(v, k) {
												 
												
												// raw data, any 0 or null value change to blank "" 
												// this is bug, single filter will failed with "null", so must chagne to ""
												
												if ((v == 0) || ( v == null)){
												   ng_grid_data_array_obj[k] = "";
												   console.log(ng_grid_data_array_obj);
												}
												else {		
									   			       // all number change to string for single general filter to work, so all value should be string, no int. 
													   ng_grid_data_array_obj[k] = v.toString();
													   
													   
												}
												// end --- any 0 value change to blank 
												
												
												/*
												// ---- all number change to string ---
												if (isNaN(v)){
												   // v is not a number
												}
												else {
													
													// v is number, change to string for single filter to work
													if ('null' != v) {
													   ng_grid_data_array_obj[k] = v.toString();
													  }
													}
												// ----End  all number change to string ---
												*/
												
																 
							          }); // inner foreach
							
							
							ng_grid_data.push(ng_grid_data_array_obj);
							
							
						}); // outer foreach
					 
						// =============   End =========== modify raw response from server =======================
						
						
						
						
						
					   $scope.ng_grid_data = ng_grid_data;
					  
					  
					   $scope.gridOptions.data = $scope.ng_grid_data;
					   //$scope.gridOptions.data = data;
					   
					});  // success http get
				
				
				
				// -------- single filter -----------
						$scope.filter = function() {
							$scope.gridApi.grid.refresh();
						  };
						
					  $scope.singleFilter = function( renderableRows ){
							var matcher = new RegExp($scope.filterValue);
							renderableRows.forEach( function( row ) {
							  var match = false;
							  ['PROGRAM_TYPE', 'BOE_BID_PACKAGE', 'BOE_SITE', 'CD','REBATE', 'CRM_NUMBER'].forEach(function( field ){
							//  this is bug, only string type allow here, int type will failed.																								  
							 // ['CRM_NUMBER', 'NOTES'].forEach(function( field ){
								if ( row.entity[field].match(matcher) ){
								  match = true;
								}
							  });
							  if ( !match ){
								row.visible = false;
							  }
							});
							return renderableRows;
						  };
				
				// ---- End ---- single filter -----------
				   
				
				
				  $scope.toggleFiltering = function(){
					$scope.gridOptions.enableFiltering = !$scope.gridOptions.enableFiltering;
					$scope.gridApi.core.notifyDataChange( uiGridConstants.dataChange.COLUMN );
				  };   //toggleFiltering
				  
				  
				  
				}]) // app.controller('MainCtrl
				.filter('mapType', function() {
											  
				  var typeHash = {
					1: 'BSS',
					2: 'BOE',
					3: 'REBATE'
				  };
				
				  return function(input) {
					if (!input){
					  return '';
					} else {
					  return typeHash[input];
					}
				  }; // return
  
				});  // filter , app.controller 


// ***************************  End **************  angular  *************************




