 // with cell edit
//var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection', 'ui.grid.edit', 'ui.grid.rowEdit', 'ui.grid.cellNav', '720kb.datepicker']);


var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection', '720kb.datepicker']);
   
   

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
				  
				  
				 
				 
				 //
				  $scope.highlightFilteredHeader = function( row, rowRenderIndex, col, colRenderIndex ) {
																if( col.filters[0].term ){
																  return 'header-filtered';
																} else {
																  return '';
																}
															  };
				
				 



               // +++++++++++++++++++++ ++++++++++++++++ ++++++ watering ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			   
			   
			   
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
															  
															     
																					 // alert(JSON.stringify(row.entity)); 
																					 console.log(row.entity.ID);   // tree ID 
																					 
																					 var _tree_id = row.entity.ID;
																					 
																					  $scope.modal_tree_id = _tree_id;		  
																					 
																					 $scope.modal_current_watering_date = '';
																					   // get previous watering history
																					   
																					   
																					   var post_data = {
																											tree_id: _tree_id
																									 
																										   };
															   
															   
															   
											
																						var req = {
																									method : "POST",
																									
																									url : url + "cfc/watering_service.cfc?method=get_watering_history&returnformat=json&queryformat=struct",
																									
																									data: post_data
																								};
												
												
												
																							$http(req).then(
																											
																								function Success(_response) 
																								{	
																											
																									var _result = _response.data;		
																									//_result = _result.replace(/\s/g, '');  // must remove space in string		
																									
																									
																									console.log(_result);
																									
																									if (_result.length > 0)
																									{
																									  var _array = [];
																	                                  var _obj = {};
																									
																										//  get 'short date' formate - toLocaleDateString
																										angular.forEach(_result, function(value, key) {
																													  console.log(key + ': ' + value);
																													  
																													  var _obj = {};
																													  angular.forEach(value, function(v, k) {
																							 
																							                                if(k == 'DATE'){
																																
																																             var _date = new Date(v);
																		    
																																			//  get 'short date' formate - toLocaleDateString
																																			
																																			_obj['DATE'] = _date.toLocaleDateString();	
																																				
																																		}
																																														 
																							 
																							 
																																					  }); // in foreach
																													  
																													    _array.push(_obj);
																													  
																													}); // out foreach
																									
																									
																									 $scope.opts = _array;
																									 
																									 $scope.modal_previous_watering_date	= _array[0].DATE;
																									 
																									}
																									 else {
																										 // empty history water date, 
																										 
																										 $scope.modal_previous_watering_date = '';
																										 
																									 }
																									 
																									 
																																  
																								}, function Error(_response) {
																									
																																				  
																							}); // http then
																									
																					//  --- end --- get history watering date		
																					
																					
																									
																									
																									
																									
																									
																						
																						 			   
																									  
																					$("#double_click_row_modal").modal();
																										
																												
																										
																										
																		
								   };
						  
								// ~~~~~~~~~~~~~~~~~~~~~    End  ~~~~~~~~~~~~~~~~~ --- double click row modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
							
							
							
							
						 
						
						  $scope.waiting = 'Double click on any row to seed the row data';
						  
						  //------------------  End ------------ row click -------------------------------
			   
			   
			   
			   
			   
			   
			   

                                
								   // ~~~~~~~~~ only 1 modal can ng-binding, so this merge with double_click_row_modal ~~~~~ --- watering modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
								   
									$scope.watering_modal = function(_tree_id, _site_no, _crm, _package_no){
					
								                              
															   
															  $scope.modal_tree_id = _tree_id;		  
																					 
																					 $scope.modal_current_watering_date = '';
																					   // get previous watering history
																					   
																					   
																					   var post_data = {
																											tree_id: _tree_id
																									 
																										   };
															   
															   
															   
											
																						var req = {
																									method : "POST",
																									
																									url : url + "cfc/watering_service.cfc?method=get_watering_history&returnformat=json&queryformat=struct",
																									
																									data: post_data
																								};
												
												
												
																							$http(req).then(
																											
																								function Success(_response) 
																								{	
																											
																									var _result = _response.data;		
																									//_result = _result.replace(/\s/g, '');  // must remove space in string		
																									
																									
																									console.log(_result);
																									if (_result.length > 0)
																									{
																									
																									 var _array = [];
																	                                  var _obj = {};
																									
																									//  get 'short date' formate - toLocaleDateString
																									angular.forEach(_result, function(value, key) {
																													  console.log(key + ': ' + value);
																													  
																													  var _obj = {};
																													  angular.forEach(value, function(v, k) {
																							 
																							                                if(k == 'DATE'){
																																
																																             var _date = new Date(v);
																		    
																																			//  get 'short date' formate - toLocaleDateString
																																			
																																			_obj['DATE'] = _date.toLocaleDateString();	
																																				
																																		}
																																														 
																							 
																							 
																																					  }); // in foreach
																													  
																													    _array.push(_obj);
																													  
																													}); // out foreach
																									
																									
																									 $scope.opts = _array;
																									 
																									 
																									 
																									 $scope.modal_previous_watering_date	= _array[0].DATE;	
																									 
																									 
																									 }
																									 else {
																										 // empty history water date, 
																										 
																										 $scope.modal_previous_watering_date = '';
																										 
																									 }
																									 
																																  
																								}, function Error(_response) {
																									
																																				  
																							}); // http then
																									
																					//  --- end --- get history watering date		
																			
																			
																			
																			
																                /*
															                   $scope.modal_current_watering_date = '';		
																			   $scope.modal_tree_id = _tree_id;
																			   $scope.modal_site_no  = _site_no;
																			   $scope.modal_crm  = _crm;
																			   $scope.modal_package_no  = _package_no ;
																			   */
																			  
																			  
																			  
																			  
																			  
													         $("#double_click_row_modal").modal();						  
															//$("#watering_date_modal").modal();
																				
																				
												}  //watering_modal = function
													
												
													
													
													
																				
									
									//  modal save button clicked.
									$scope.save_modal_watering_date = function(){
										
									
									                  console.log($scope.modal_tree_id);
													  
													  // save current watering date
													  
													  // empty date will get  _valid_save_date = NaN
													  var _valid_save_date = Date.parse($scope.modal_current_watering_date);
													   var _valid_save_date2 = new Date($scope.modal_current_watering_date);
													  
													  console.log(_valid_save_date);
													  console.log(_valid_save_date2);
													  
													  if (_valid_save_date2 == 'Invalid Date')
														{	   
														       console.log("empty date, or invalide date");
														}
														else
														{
															
															
															var post_data = {
																					tree_id: $scope.modal_tree_id,
																			        current_watering_date: $scope.modal_current_watering_date 
																				   };
									   
									   
									   
					
																var req = {
																			method : "POST",
																			
																			url : url + "cfc/watering_service.cfc?method=save_current_watering_date&returnformat=json&queryformat=struct",
																			
																			data: post_data
																		};
						
						
						
																	$http(req).then(
																					
																		function Success(_response) 
																		{	
																					
																			console.log(_response.data);
																										  
																		}, function Error(_response) {
																			
																														  
																	}); // http then
																	
																}// if  date is valid, not empty date
															
															
																
															      
														
																
																			
															//  --- end --- save current watering date		
													  
									                    
													  
									
										
									            }
									
									
									
									
									// ~~~~~~~~~~~~~~   End ~~~~~~~~~~~~~ --- watering modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
									
									
									
									
									
									//  ............... clear button clicked, clear all filter, clear all selection   .................  --->
									
									$scope.clear = function() {
																			
																			$scope.gridApi.grid.clearAllFilters();
																			
																			$scope.gridApi.selection.clearSelectedRows();
																			
																		}
									
									
									
									//  ............... End ......... clear button clicked, clear all filter, clear all selection   .................  --->
									
									
									
									
									
									
							//-----------------   ******************    selected rows watering    **************************   -------------------------
																				
							$scope.watering_selected_row = function(){
										
								var _selected_count = $scope.gridApi.selection.getSelectedCount();
								console.log(_selected_count);
										
								if (_selected_count == 0){
											
											// $scope.modal_warning_message = "Please select some tree/row to water"; 
											$("#select_0_warning_modal").modal();
											
											
										}
								else if (_selected_count > 200){
									
									        //$scope.modal_warning_message = "You selected too much, remove some and try again" ;
									        $("#select_0_warning_modal").modal();
								}
								
								else
									{	
										
										
										
															// similar to getSelectedRows(), but with grid info.
															// getSelectedGridRows().entity =  getSelectedRows()
															//console.log($scope.gridApi.selection.getSelectedGridRows()); 
															
															console.log($scope.gridApi.selection.getSelectedRows());
															
															
															// remove all other data, only selected data stay
															//$scope.gridOptions.data = $scope.gridApi.selection.getSelectedRows();
															
															
															// show column previous water date, current water date
															
															
															
															
															// ****************** 
															
															
															// ==== bug fix ============== remove property	"$$hashKey":"uiGrid-0011"  ================
															
															  var _obj_selected_rows = $scope.gridApi.selection.getSelectedRows();
															  
															   var ng_grid_data = [];
						                                       var ng_grid_data_array_obj = {};
															angular.forEach(_obj_selected_rows, function(value, key) {
													   
																 ng_grid_data_array_obj = {};
																 angular.forEach(value, function(v, k) {
																								 
																				// column '$$hashKey'
																					if (k == '$$hashKey') {
																												
																												}
																					else {
																						
																						  ng_grid_data_array_obj[k] = v.toString();
																					}
																			
																				
																								 
																	  }); // inner foreach
															
															
															ng_grid_data.push(ng_grid_data_array_obj);
															
															
														}); // outer foreach
																							
								                           // ==== bug fix ============== remove property	"$$hashKey":"uiGrid-0011"  ================							
															
															
															
															
															
															         // ---------- must convert object = string before post, since this post object can not handle deep levle of next object, ----------------
															        // var _str_selected_rows = JSON.stringify($scope.gridApi.selection.getSelectedRows());
																	var _str_selected_rows =JSON.stringify(ng_grid_data);
																	
															
																	 var post_data = {
																							selected_rows_str: _str_selected_rows,
																					  selected_rows_count: $scope.gridApi.selection.getSelectedCount()
																						   };
																   
																   var _water_selected_url = url + "search/swWaterSelected.cfm";
																   
																   
																  
																      $.redirect(_water_selected_url, post_data);
																				
																   
																  //location.assign(_water_selected_url);
																   
												
										                    // ******************** End  ******  transfer to another page ************** 
								
										
									          }// if else select count = 0 
										
										
									        }  //$scope.watering_selected_row = function
				
				                     
				
				                                //----------------- End ---------  selected rows watering -------------------------
				
				
				
				
				                                                
																
																   
									                 //==========  click site number filtering ===============
									   							$scope.filterTerm;

																// Watching the value of $scope.filterTerm also works, 
																// as you can uncomment and see below, but I left the 
																// ng-click functionality from your original plunker
															
																// $scope.$watch(function() {return $scope.filterTerm; }, function(newVal) {
																//     if (newVal) {
																//         console.log('filter term updated to ' + JSON.stringify(newVal));
																//         $scope.gridApi.grid.columns[2].filters[0].term = newVal;
																//     }
																// });
															
																$scope.filterGrid = function(value, which_column) {
																	console.log(value);
																	$scope.gridApi.grid.columns[which_column].filters[0].term=value;
																};
				
				                                     
				
				                                     //========== End =========  click site number filtering ===============
				
				
									
					
					               
								    // +++++++++++++++++++++        End  ++++++++++++++++ ++++++ watering ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					
					
					
					
					
					
                 //======================================  grid option =============================

  				   $scope.gridOptions = {
					   
					   
					       rowTemplate: rowTemplate(),  // --- double click row - modal show up 
					   
							  exporterMenuCsv: true,
							enableGridMenu: true,
							gridMenuTitleFilter: fakeI18n,
	                          flatEntityAccess: false,
	  
							  gridMenuCustomItems: [
							  {
								title: 'Rotate Grid',
								action: function ($event) {
								  this.grid.element.toggleClass('rotated');
								},
								order: 210
							  }
							],
	  
	  
	                        //enableFullRowSelection: true,
    						showGridFooter: true,
							//showColumnFooter: true,
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
								
							
								
							
							 
							 
							 
							 
							 // default
							  { 
							     name: 'Tree ID',
							  	field: 'ID', 
								enableCellEdit: false,
								headerCellClass: $scope.highlightFilteredHeader,
								
								maxWidth: 70,
								minWidth: 65,
								cellTooltip:true,
								
								// ng-click must use grid.appScope.your-function(), because $scope level in cell is different.
								// grid.appScope.your-function({{...}}) is wrong, should not use {{}}
								 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a style="color: orange;" href=""  ng-click="grid.appScope.watering_modal(grid.appScope.editLink_tree_id(grid, row),grid.appScope.editLink_site_no(grid, row),grid.appScope.editLink_crm(grid, row), grid.appScope.editLink_package_no(grid, row) )">{{grid.appScope.editLink_tree_id(grid, row)}}</a></div>'
								
								
							  
							  },
							  
							 
							
							  
							  
							  // default
							  { 
							     name: 'Site',
							  	field: 'BOE_SITE',
								enableCellEdit: false,
								headerCellClass: $scope.highlightFilteredHeader,
								
								filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
								
								cellTooltip:true,

								maxWidth: 75,
								minWidth: 70,
								
								
								
								 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_site_no(grid, row), 2 )">{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
								
								/*
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="' + url + 'forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
							  */
							 
							  },
							  
							  
							  
							  // default
							  { 
							   name: 'CRM',
							   displayName: 'SR No.',
							  field: 'CRM_NUMBER',
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  /*
							  filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
							  
							  */
							  
							  cellTooltip:true,
							 
							 maxWidth: 85,
							 minWidth: 80,
							  
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_crm(grid, row), 3 )">{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							  
							  
							  /*
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="' + url + 'forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							 */
							
							   },
							   
							   
							   
							   
							     
							  {   name: 'Type',
							      
								  minWidth: 80,
								  maxWidth: 85,
							      cellTooltip:true,
							  
							      field: 'PROGRAM_TYPE', 
								  enableCellEdit: false,
								  
								  filter: {
								 // term: '1',   //filter field can be pre-populated by setting filter: { term: 'xxx' } in the column def
								  type: uiGridConstants.filter.SELECT,
								  selectOptions: [ { value: '1', label: 'BSS' }, { value: '2', label: 'BOE' }, { value: '3', label: 'REBATE'}]
								},
								cellFilter: 'mapType', headerCellClass: $scope.highlightFilteredHeader 
								
								},
							 
							 
							 
							 
							 {   name: 'Action',
							 
							    maxWidth: 95,
								minWidth: 90,
							     cellTooltip:true,
							  
							      field: 'ACTION', 
								  enableCellEdit: false,
								  
								  filter: {
								 					// term: '1',   //filter field can be pre-populated by setting filter: { term: 'xxx' } in the column def
								  					type: uiGridConstants.filter.SELECT,
								  					//selectOptions: [ { value: '1', label: 'Remove Tree' }, { value: '2', label: 'OnSite Replace' }, { value: '3', label: 'OffSite Replace'}]
													selectOptions: [{ value: '1', label: 'OnSite Replace' }, { value: '2', label: 'OffSite Replace'}]
													},
													
								cellFilter: 'mapAction', headerCellClass: $scope.highlightFilteredHeader
							},
							 
							   
							   
							   
							   
							   
							   
							  
							   // default
							  { 
							     name: 'Package',
							  	field: 'BOE_BID_PACKAGE', 
								enableCellEdit: false,
								
								headerCellClass: $scope.highlightFilteredHeader,
								
								filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
								
								
								 maxWidth:55,
							     minWidth: 50,
								 
								cellTooltip:true,
								
								
								cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_package_no(grid, row), 6 )">{{grid.appScope.editLink_package_no(grid, row)}}</a></div>'
								
								
								},
							  
							  
							  
							  // default
							  { 
							    name: 'CD',
							  field: 'CD', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
							  
							  
							  maxWidth:55,
							  minWidth: 50,
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_cd(grid, row), 7 )">{{grid.appScope.editLink_cd(grid, row)}}</a></div>'
								
							  
							  },
							  
							  
							  // default
							  { 
							   name: 'Location',
							  field: 'LOCATION', 
							  enableCellEdit: false,
							  
							  headerCellClass: $scope.highlightFilteredHeader,
							 // maxWidth: 200,
							    minWidth: 160,
							   cellTooltip:true,
							   
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_location(grid, row), 8 )">{{grid.appScope.editLink_location(grid, row)}}</a></div>'
							  },
							  
							  
							   // default
							  { 
							   name: 'Species',
							   enableCellEdit: false,
							  field: 'SPECIES', 
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  /*
							  filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
							  */
							  
							    //maxWidth: 160,
							    minWidth: 130,
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_species(grid, row), 9 )">{{grid.appScope.editLink_species(grid, row)}}</a></div>'
							  
							  },
							  
							  
							   // default
							  { 
							   name: 'Planting Date',
							  field: 'PLANTING_DATE', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  
							  
							  maxWidth: 75,
							    minWidth: 70,
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_planting_date(grid, row), 10 )">{{grid.appScope.editLink_planting_date(grid, row)}}</a></div>'
							  },
							  
							  
							   // default
							  { 
							   name: 'Sub Position',
							  field: 'SUB_POSITION', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							   
							   maxWidth: 85,
							   minWidth: 60,
							
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_sub_position(grid, row), 11 )">{{grid.appScope.editLink_sub_position(grid, row)}}</a></div>'
							  
							  }
																		  
																		
						]   //columnDefs: 
							
					 };  // gridOptions	
  
                    //=============================   end  =========  grid option =============================
  
                   
				   
				   
				   
				   
				   
				   
				   
				   
  
  
  
                    // --------- Edit link  --------------   
  
                   $scope.editLink_tree_id = function( grid, myRow ) {
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

                   $scope.editLink_location = function( grid, myRow ) {
					   return myRow.entity.LOCATION;
				  };
				  
				   $scope.editLink_species = function( grid, myRow ) {
					   return myRow.entity.SPECIES;
				  };
                      
					   $scope.editLink_crm = function( grid, myRow ) {
					   return myRow.entity.CRM_NUMBER;
				  };
				  
				  
				  
				   $scope.editLink_action = function( grid, myRow ) {
					   return myRow.entity.ACTION;
				  };
				  
				  
				 
				  $scope.editLink_planting_date = function( grid, myRow ) {
					   return myRow.entity.PLANTING_DATE;
				  };
				 
				 
				  $scope.editLink_sub_position = function( grid, myRow ) {
					   return myRow.entity.SUB_POSITION;
				  };
				 




				  $http.get(url + 'cfc/tree_service.cfc?method=search_tree&returnformat=json&queryformat=struct')
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
												
												
												//------ Date format change to 09/30/2017 ---------
												
												// column 'PLANTING_DATE'
													if (k == 'PLANTING_DATE') {
														                         var _date = new Date(v);
																				 //  get 'short date' formate 
																				   ng_grid_data_array_obj[k] = _date.toLocaleDateString();
																				   
																				} 
												//------ End of Date format change to 09/30/2017 ---------
												
																 
							          }); // inner foreach
							
							
							ng_grid_data.push(ng_grid_data_array_obj);
							
							
						}); // outer foreach
					 
						// =============   End =========== modify raw response from server =======================
						
						
						
						
						
					   $scope.ng_grid_data = ng_grid_data;
					  
					  
					   $scope.gridOptions.data = $scope.ng_grid_data;
					  
					   
					});  // success http get
				
				
				
				// -------- single filter -----------
						$scope.filter = function() {
							$scope.gridApi.grid.refresh();
						  };
						
					  $scope.singleFilter = function( renderableRows ){
							var matcher = new RegExp($scope.filterValue);
							renderableRows.forEach( function( row ) {
							  var match = false;
							  // ['PROGRAM_TYPE', 'BOE_BID_PACKAGE', 'BOE_SITE', 'CD', 'CRM_NUMBER'].forEach(function( field ){
							  ['PROGRAM_TYPE', 'BOE_BID_PACKAGE', 'BOE_SITE', 'CD', 'LOCATION', 'SPECIES','CRM_NUMBER', 'PLANTING_DATE','SUB_POSITION'].forEach(function( field ){
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
				.filter('mapType', function() {     // train filter 1:  program type
											  
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
  
				})  // mapType filter
				.filter('mapAction', function() {      // train filter 2:  action
											  
				  var typeHash = {
					//1: 'Remove Tree',
					//2: 'OnSite Replace',
					//3: 'OffSite Replace'
					  1: 'OnSite Replace',
					  2: 'OffSite Replace'
				  };
				
				  return function(input) {
					if (!input){
					  return '';
					} else {
					  return typeHash[input];
					}
				  }; // return
  
				})// mapAction filter
				;  // filter , app.controller 


// ***************************  End **************  angular  *************************




