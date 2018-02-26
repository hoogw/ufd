var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection', 'ui.grid.edit', '720kb.datepicker']);

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
																					
																					
																									
																									
																									
																									
																									
																						
																						 			   
																				//disable modal, because it conflict with edit cell. instead use single click tree ID.					  
																			//		$("#double_click_row_modal").modal();
																										
																												
																										
																										
																		
								   };
						  
								// ~~~~~~~~~~~~~~~~~~~~~    End  ~~~~~~~~~~~~~~~~~ --- double click row modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
							
							
							
							
						 
						
						  $scope.waiting = 'Double click on any row to seed the row data';
						  
						  //------------------  End ------------ row click -------------------------------









                                
								   // ~~~~~~~~~ only 1 modal can ng-binding, so this merge with double_click_row_modal ~~~~~ --- watering modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
                                   //  row double click conflict with edit cell, so disable double click row, instead use single click tree ID to show water history
								   
								   // ~~~~~~~~~~~~~~single click tree id cell  --- watering modal ----- ~~~~~~~~~~~~~~~~~~~~~~~
								   
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
																			  
															$("#watering_date_modal").modal();
																				//console.log(_tree_id);
																				
												}  //watering_modal = function
																
											// ~~~~~~~~~~~   End    ~~~single click tree id cell  --- watering modal ----- ~~~~~~~~~~~~~~~~~~~~~~~					
																
																
																
																
																				
									
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
									
									
									
									
									//  ............... cancel button clicked, go back to watering search page  .................  --->
									
									$scope.cancel = function() {
																		var _wateringSearch_page_url = url + 'search/swWateringSearch.cfm';
																		$.redirect(_wateringSearch_page_url);	
																			
																		}
									
									
									
									//  ............... End ......... cancel button clicked, go back to watering search page  .................  --->
									
									
									
									
									
									
							//----------------- selected rows watering -------------------------
																				
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
																	 var post_data = {
																							selected_rows: $scope.gridApi.selection.getSelectedRows(),
																					  selected_rows_count: $scope.gridApi.selection.getSelectedCount()
																						   };
																   
																   var _water_selected_url = url + "forms/swWaterSelected.cfm";
																   
																  // $.redirect(_water_selected_url, post_data);
																   
																  
																   
												
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
				
				
									
									
									
									
									// ************** apply all current water date  **************
									$scope.date_changed = function ()
												{	
													console.log($scope.all_current_water_date);
													
													//update   ----------  $scope.gridOptions.data
													
													
															
															  var _grid_data = $scope.gridOptions.data;
															  
															   var ng_grid_data = [];
						                                       var ng_grid_data_array_obj = {};
															angular.forEach(_grid_data, function(value, key) {
													   
																 ng_grid_data_array_obj = {};
																 angular.forEach(value, function(v, k) {
																								 
																				
																					if (k == 'Current_Water_Date') {
																							
																							// type is Date, so pass obj of Date
																							 ng_grid_data_array_obj[k] = new Date($scope.all_current_water_date);			
																												}
																					else {
																						
																						  ng_grid_data_array_obj[k] = v.toString();
																					}
																			
																				
																								 
																	  }); // inner foreach
															
															
															ng_grid_data.push(ng_grid_data_array_obj);
															
															
														}); // outer foreach
															
															
															
																							
								                   $scope.gridOptions.data = ng_grid_data;
													
													
													
										}// date_changed
									
									// *********   End  ********* apply all current water date  **************
									
									
									
									
									// ************** Save all current water date  **************
									$scope.save_all_current_water_date = function(){
									
									
									              //----------- save ---- tree_id + current water date ----------
									          
											  
											               // --- only need tree_id + current water date
									                       var _grid_data = $scope.gridOptions.data;
															  
															   var ng_grid_data = [];
						                                       var ng_grid_data_array_obj = {};
															   var keepGoing = true;
															   
															angular.forEach(_grid_data, function(value, key) {
													   
																 ng_grid_data_array_obj = {};
																 keepGoing = true;
																 
																 angular.forEach(value, function(v, k) {
																								 
																				    // only need tree_id + current water date
																					
																					
																					
																					
																			         if (k == 'Current_Water_Date') {
																						 
																						 //Current_Water_Date: "Fri Oct 27 2017 00:00:00 GMT-0700 (Pacific Daylight Time)"   ---- will not insert to database
																						 // must re-format mm/dd/yyyy
																						 
																						 
																						 // -- bug fix,  date can not be empty
																						 var timestamp=Date.parse(v)

																							if (isNaN(timestamp)==false)
																							{
																								//var d=new Date(timestamp);
																								ng_grid_data_array_obj[k] = v.toLocaleDateString();
																							
																							}
																						    else {
																							// empty or invalid date, 
																							
																							keepGoing = false;
																							}
																						 
																						 
																					 }
																				
																				
																				    if (k == 'ID') {
																							
																							ng_grid_data_array_obj[k] = v.toString();		
																					}
																					
																					
																								 
																	  }); // inner foreach
															
															if (keepGoing) {   
															// only on valide date, add to list, empty date will not add to list
															                  ng_grid_data.push(ng_grid_data_array_obj);
															}
															
															
														}); // outer foreach
														//  --- End --- only need tree_id + current water date	
									
									              
												  
												         //---- http -----------
												  
												                var post_data = ng_grid_data;
									   
									   
									   
					
																var req = {
																			method : "POST",
																			
																			url : url + "cfc/watering_service.cfc?method=save_all_current_watering_date&returnformat=json&queryformat=struct",
																			
																			data: post_data
																		};
						
						
						
																	$http(req).then(
																					
																		function Success(_response) 
																		{	
																					
																			console.log(_response.data);
																			
																			
																			 //------------ ++++++ - refresh page -----------------
																			 
																			 
																			 
																			 
																			 
																			       //========= bug fix=== before post, should remove 'Previous_Water_Date', 'Current_Water_Date'
																				   var _grid_data = $scope.gridOptions.data;
															  
																						   var ng_grid_data = [];
																						   var ng_grid_data_array_obj = {};
																						   
																						angular.forEach(_grid_data, function(value, key) {
																				   
																							 ng_grid_data_array_obj = {};
																							 angular.forEach(value, function(v, k) {
																															 
																												// only need tree_id + current water date
																												if ((k == 'Previous_Water_Date') || (k == 'Current_Water_Date')) {
																													
																													// remove Previous_Water_Date, Current_Water_Date
																												}
																												else {
																														// keep other field.
																														ng_grid_data_array_obj[k] = v.toString();		
																												}
																												
																												 
																											
																															 
																								  }); // inner foreach
																						
																						
																						ng_grid_data.push(ng_grid_data_array_obj);
																						
																						
																					}); // outer foreach
																			        //======  End === bug fix=== before post, should remove 'Previous_Water_Date', 'Current_Water_Date'
																					
																					
																					
																					
																					
																					
																					
																			 
																			     // ---------- must convert object = string before post, since this post object can not handle deep levle of next object, 
																						
																						var _str_selected_rows =JSON.stringify(ng_grid_data);
																						
																				
																						 var post_data = {
																												selected_rows_str: _str_selected_rows,
																										  selected_rows_count: $scope.gridOptions.data.length
																											   };
																					   
																					   var _water_selected_url = url + "search/swWaterSelected.cfm";
																					   
																					   
																					  
																						  $.redirect(_water_selected_url, post_data);
																			
																			
																			 //-----------End   ++++++ - refresh page -----------------
																			
																			
																			
																										  
																		}, function Error(_response) {
																			
																														  
																	}); // http then
												           
												  
												         //----End ----  http -----------
														 
														 
														 
														 
									
									             
												  
												  
												  
												  
												  
									
									
									} //save_all_current_water_date()
									// *******End   ******* Save all current water date  **************
									
									
									
									
									
					               
								    // +++++++++++++++++++++        End  ++++++++++++++++ ++++++ watering ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					
					
					
					
					
					
                 //======================================  grid option =============================

  				   $scope.gridOptions = {
					   
					   rowTemplate: rowTemplate(),  // --- double click row - modal show up 
					   
					   
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
	  
	  
	                        //enableFullRowSelection: true,
    						showGridFooter: true,
							//showColumnFooter: true,
							enableFiltering: true,
	                         //enableFiltering: false,
							 
							 
							 
	
							onRegisterApi: function(gridApi){
								
							  $scope.gridApi = gridApi;
							  
							    // this line for single filter only, if you do not use single filter, must comment out this line, otherwise will error.
							 //  $scope.gridApi.grid.registerRowsProcessor( $scope.singleFilter, 200 );
							   
							   
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
							  
							 
							 
							  // --------########### --------- water date -----------##############-----------
							  
							  { 
							   	  name: 'Previous Water Date',
								  field: 'Previous_Water_Date',
								  enableFiltering: false,
								  enableCellEdit: false,
								  
								 
							  
							    maxWidth: 150,
							    minWidth: 120
							  }, 
							   
							   
							    { 
							   	  name: 'Current Water Date',
								  field: 'Current_Water_Date',
								  enableFiltering: false,
								  
								  type: 'date', 
								  //cellFilter: 'date:"yyyy-MM-dd"',
								  cellFilter: 'date:"MM/dd/yyyy"',
							  
							   maxWidth: 150,
							    minWidth: 120
							  }, 
							   
							   
							    // ---------########## --------  End  -------- water date ----------##############------------
							   
							
							  
							  
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
								
								
								
								 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_site_no(grid, row), 4 )">{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
								
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
							  
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_crm(grid, row), 5 )">{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							  
							  
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
								
								
								cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_package_no(grid, row), 8 )">{{grid.appScope.editLink_package_no(grid, row)}}</a></div>'
								
								
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
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_cd(grid, row), 9 )">{{grid.appScope.editLink_cd(grid, row)}}</a></div>'
								
							  
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
							   
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_location(grid, row), 10 )">{{grid.appScope.editLink_location(grid, row)}}</a></div>'
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
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_species(grid, row), 11 )">{{grid.appScope.editLink_species(grid, row)}}</a></div>'
							  
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
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_planting_date(grid, row), 12 )">{{grid.appScope.editLink_planting_date(grid, row)}}</a></div>'
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
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_sub_position(grid, row), 13 )">{{grid.appScope.editLink_sub_position(grid, row)}}</a></div>'
							  
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
				 

  
         
				 //-----******  --------------- get selected rows from previous page ------ also populate previous water date column----------
				    $scope.gridOptions.data = _selected_rows;
					console.log(_selected_rows_count);
					console.log(_selected_rows);
					
					
					
			     //----- ******------ End ---  get selected rows from previous page ----------------also populate previous water date column----------
					
					
					
					
					/*
					
				
				// -------- single filter -----------
						$scope.filter = function() {
							$scope.gridApi.grid.refresh();
						  };
						
					  $scope.singleFilter = function( renderableRows ){
							var matcher = new RegExp($scope.filterValue);
							renderableRows.forEach( function( row ) {
							  var match = false;
							  // ['PROGRAM_TYPE', 'BOE_BID_PACKAGE', 'BOE_SITE', 'CD', 'CRM_NUMBER'].forEach(function( field ){
							  ['PROGRAM_TYPE', 'Previous_Water_Date', 'Current_Water_Date', 'BOE_BID_PACKAGE', 'BOE_SITE', 'CD', 'LOCATION', 'SPECIES','CRM_NUMBER', 'PLANTING_DATE','SUB_POSITION'].forEach(function( field ){
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
				
				
				  */
				  
				  
				
				
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




