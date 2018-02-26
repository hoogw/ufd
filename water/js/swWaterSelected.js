var app = angular.module('app', ['ngAnimate', 'ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection', 'ui.grid.edit', '720kb.datepicker', 'ui.bootstrap']);

app.controller('MainCtrl', ['$scope', '$http','$interval', '$q', '$templateCache', 'uiGridConstants', function ($scope, $http, $interval, $q, $templateCache, uiGridConstants) {
  
  
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
				  
				  
				  
				  
				   //.............. for date range filter ..............
				 
				       // Set Bootstrap DatePickerPopup config
						  $scope.datePicker = { 
						
							  options: {  
								  formatMonth: 'MM',
								  startingDay: 1 
							  },
							  format: "yyyy-MM-dd" 
						  };
						
						  // Set two filters, one for the 'Greater than' filter and other for the 'Less than' filter
						  $scope.showDatePopup = [];
						  $scope.showDatePopup.push({ opened: false });
						  $scope.showDatePopup.push({ opened: false });
						
						  $templateCache.put('ui-grid/date-cell',
							  "<div class='ui-grid-cell-contents'>{{COL_FIELD | date:'yyyy-MM-dd'}}</div>"
						  );
						
						  // Custom template using Bootstrap DatePickerPopup
						  // Custom template using Bootstrap DatePickerPopup
						  $templateCache.put('ui-grid/ui-grid-date-filter',
							  "<div class=\"ui-grid-filter-container\" ng-repeat=\"colFilter in col.filters\" >" + 
								  "<input type=\"text\" uib-datepicker-popup=\"{{datePicker.format}}\" " + 
										  "datepicker-options=\"datePicker.options\" " + 
										  "datepicker-append-to-body=\"true\" show-button-bar=\"false\"" +
										  "is-open=\"showDatePopup[$index].opened\" class=\"ui-grid-filter-input ui-grid-filter-input-{{$index}}\"" + 
										  "style=\"font-size:1em; width:11em!important\" ng-model=\"colFilter.term\" ng-attr-placeholder=\"{{colFilter.placeholder || ''}}\" " + 
										  " aria-label=\"{{colFilter.ariaLabel || aria.defaultFilterLabel}}\" />" +
						
									  "<span style=\"padding-left:0.3em;\"><button type=\"button\" class=\"btn btn-default btn-sm\" ng-click=\"showDatePopup[$index].opened = true\">" +
										  "<i class=\"glyphicon glyphicon-calendar\"></i></button></span>" +
						
									  "<div role=\"button\" class=\"ui-grid-filter-button\" ng-click=\"removeFilter(colFilter, $index)\" ng-if=\"!colFilter.disableCancelFilterButton\" ng-disabled=\"colFilter.term === undefined || colFilter.term === null || colFilter.term === ''\" ng-show=\"colFilter.term !== undefined && colFilter.term !== null && colFilter.term !== ''\">" +
										  "<i class=\"ui-grid-icon-cancel\" ui-grid-one-bind-aria-label=\"aria.removeFilter\">&nbsp;</i></div></div><div ng-if=\"colFilter.type === 'select'\"><select class=\"ui-grid-filter-select ui-grid-filter-input-{{$index}}\" ng-model=\"colFilter.term\" ng-attr-placeholder=\"{{colFilter.placeholder || aria.defaultFilterLabel}}\" aria-label=\"{{colFilter.ariaLabel || ''}}\" ng-options=\"option.value as option.label for option in colFilter.selectOptions\"><option value=\"\"></option></select><div role=\"button\" class=\"ui-grid-filter-button-select\" ng-click=\"removeFilter(colFilter, $index)\" ng-if=\"!colFilter.disableCancelFilterButton\" ng-disabled=\"colFilter.term === undefined || colFilter.term === null || colFilter.term === ''\" ng-show=\"colFilter.term !== undefined && colFilter.term != null\"><i class=\"ui-grid-icon-cancel\" ui-grid-one-bind-aria-label=\"aria.removeFilter\">&nbsp;</i></div></div>"
						  );
				 
				 //.........  End  .....f ....  for date range filter ..............
				  
				 
				 
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
																					user_id: user_id,
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
																					
																					// after save, should refresh the current main page index.cfm and iframe content
																			// error, because need to post back the selected rows data.
																			//window.top.location.href = "../index.cfm?iframe=" + window.location.href;
																			
																			
																			
																			 
																			 
																					
																					
																					
																				//------------ ++++++ - refresh page -----------------	
																					
																			 
																			     // ---------- must convert object = string before post, since this post object can not handle deep levle of next object, 
																						
																						//var _str_selected_rows =JSON.stringify(ng_grid_data);
																						var _str_selected_rows =JSON.stringify($scope.gridOptions.data);
																				
																						 var post_data = {
																												selected_rows_str: _str_selected_rows,
																										  selected_rows_count: $scope.gridOptions.data.length
																											   };
																					   
																					   var _water_selected_url = url + "search/swWaterSelected.cfm";
																					   
																					   
																					  
																						  $.redirect(_water_selected_url, post_data);
																			
																			
																			//window.top.location.href = "../index.cfm?iframe=" + window.location.href  ;
																			
																			 //-----------End   ++++++ - refresh page -----------------
																			
																			
																			
																			
																			
																			
																			
																			
																			
																			
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
																		//var _wateringSearch_page_url = url + 'search/swAllTree.cfm';
																		//$.redirect(_wateringSearch_page_url);	
																			
															//  should refresh the current main page index.cfm and iframe content
																			
															window.top.location.href = "../index.cfm?iframe=search/swWateringSearch.cfm";	
																			
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
												  
												                 var post_data = {
																	                save_data: ng_grid_data,
																					user_id: user_id
																			        
																				   };
									   
									   
									   
					
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
																			 
																			          // ---------- must convert object = string before post, since this post object can not handle deep levle of next object, 
																						
																						//var _str_selected_rows =JSON.stringify(ng_grid_data);
																						var _str_selected_rows =JSON.stringify($scope.gridOptions.data);
																						
																				
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
					   
					   
							  //...... exporter config .......   
							      //see --- https://github.com/angular-ui/ui-grid/blob/e30596b/src/features/exporter/js/exporter.js#L31
							  exporterMenuCsv: true,
							  exporterMenuExcel: true,
							  exporterMenuPdf: true,
							  exporterPdfCustomFormatter: true,
							  
							  exporterMenuSelectedData: true,
							  exporterMenuVisibleData: true,
							  
							  
							  exporterPdfOrientation: 'landscape',
						      exporterPdfPageSize:'A4',  // exporterPdfMaxGridWidth = Defaults to 720 (for A4 landscape), use 670 for LETTER
							                             // page size see --- https://github.com/bpampuch/pdfmake/blob/master/src/standardPageSizes.js
														 // https://stackoverflow.com/questions/47804134/ui-grid-export-pdf-column-get-cut/47804135#47804135
														 
														 
							  exporterPdfMaxGridWidth: 600,	// bug, for A4, default is 						 
							  exporterPdfDefaultStyle:{fontSize: 4},
							  exporterPdfTableStyle: { margin: [0, 0, 0, 0] },   // default { margin: [0, 5, 0, 15] }
							  exporterPdfTableHeaderStyle: { bold: true, fontSize: 6, color: 'black' },
							  
							  
											 exporterPdfHeader: { text: "Tree Watering", style: 'headerStyle' },
												exporterPdfFooter: function ( currentPage, pageCount ) {
												  return { text: currentPage.toString() + ' of ' + pageCount.toString(), style: 'footerStyle' };
												},
												exporterPdfCustomFormatter: function ( docDefinition ) {
												  docDefinition.styles.headerStyle = { fontSize: 16, bold: true };
												  docDefinition.styles.footerStyle = { fontSize: 10, bold: true };
												  return docDefinition;
												},
												
												
												/*
												
												exporterExcelFilename: 'watering.xlsx',
												exporterExcelSheetName: 'Sheet1',
												exporterExcelCustomFormatters: function ( grid, workbook, docDefinition ) {
											 
												  var stylesheet = workbook.getStyleSheet();
												  var aFormatDefn = {
													"font": { "size": 9, "fontName": "Calibri", "bold": true },
													"alignment": { "wrapText": true }
												  };
												  var formatter = stylesheet.createFormat(aFormatDefn);
												  // save the formatter
												  $scope.formatters['bold'] = formatter;
											 
												  aFormatDefn = {
													"font": { "size": 9, "fontName": "Calibri" },
													"fill": { "type": "pattern", "patternType": "solid", "fgColor": "FFFFC7CE" },
													"alignment": { "wrapText": true }
												  };
												  formatter = stylesheet.createFormat(aFormatDefn);
												  // save the formatter
												  $scope.formatters['red'] = formatter;
											 
												  Object.assign(docDefinition.styles , $scope.formatters);
											 
												  return docDefinition;
												},
												exporterExcelHeader: function (grid, workbook, sheet, docDefinition) {
													// this can be defined outside this method
													var stylesheet = workbook.getStyleSheet();
													var aFormatDefn = {
															"font": { "size": 9, "fontName": "Calibri", "bold": true },
															"alignment": { "wrapText": true }
														  };
													var formatterId = stylesheet.createFormat(aFormatDefn);
											 
													sheet.mergeCells('B1', 'C1');
													var cols = [];
													cols.push({ value: '' });
													cols.push({ value: 'My header that is long enough to wrap', metadata: {style: formatterId.id} });
													sheet.data.push(cols);
												},
												exporterFieldFormatCallback: function(grid, row, gridCol, cellValue) {
												 // set metadata on export data to set format id. See exportExcelHeader config above for example of creating
												 // a formatter and obtaining the id
												 var formatterId = null;
												 if (cellValue && cellValue.startsWith('W')) {
												   formatterId = $scope.formatters['red'].id;
												 }
											 
												 if (formatterId) {
												   return {metadata: {style: formatterId}};
												 } else {
												   return null;
												 }
											   },
											   
											   */
								
							  //...... End .... exporter config .......
							  
							  
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
								
							
								
							/* colDef.type  define how to sort column by number(integer value) or string(alphabetically) or date.... 
							    https://github.com/angular-ui/ui-grid/issues/3240
							 
							     ------------  source code ------------
							       rowSorter.guessSortFn = function guessSortFn(itemType) {
														switch (itemType) {
														  case "number":
															return rowSorter.sortNumber;
														  case "boolean":
															return rowSorter.sortBool;
														  case "string":
															return rowSorter.sortAlpha;
														  case "date":
															return rowSorter.sortDate;
														  case "object":
															return rowSorter.basicSort;
														  default:
															throw new Error('No sorting function found for type:' + itemType);
														}
													  };
							     -------------
								 
								 
							  for example: 
							  
							    if you know it is date, type:'date', will sort by date not alphabetically
							    if you know it is integer, type:'number', will sort by interger not alphabetically
								if you now sure it is integer or string, type:'numberStr', will sort string typed integer by value, not alphabetically.
							 
							 */
							 
							 
							 
							 
							  // default
							  { 
							     name: 'Tree ID',
								 type:'number',
							  	field: 'ID', 
								enableCellEdit: false,
								headerCellClass: $scope.highlightFilteredHeader,
								
								maxWidth: 60,
								minWidth: 60,
								cellTooltip:true,
								
								// ng-click must use grid.appScope.your-function(), because $scope level in cell is different.
								// grid.appScope.your-function({{...}}) is wrong, should not use {{}}
								 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a style="color: orange;" href=""  ng-click="grid.appScope.watering_modal(grid.appScope.editLink_tree_id(grid, row),grid.appScope.editLink_site_no(grid, row),grid.appScope.editLink_crm(grid, row), grid.appScope.editLink_package_no(grid, row) )">{{grid.appScope.editLink_tree_id(grid, row)}}</a></div>'
								
								
							  
							  },
							  
							 
							 
							  // --------########### --------- water date -----------##############-----------
							  
							  /*
							  { 
							   	  name: 'Previous Water Date',
								  field: 'Previous_Water_Date',
								   headerCellClass: $scope.highlightFilteredHeader,
								  enableCellEdit: false,
								  
								 
							  
							   
							  maxWidth: 180,
							    minWidth: 170,
							  cellTooltip:true,
							  
							  
							  cellFilter: 'date:\'yyyy-MM-dd\'',
								cellTemplate: 'ui-grid/date-cell',
								filterHeaderTemplate: 'ui-grid/ui-grid-date-filter',
								//width: '40%',
								filters: [
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate >= term;
										},
									  placeholder: 'After'
									},
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate <= term;
										},
									  placeholder: 'Less than or equal'
									}
								],
								headerCellClass: $scope.highlightFilteredHeader
							  
							  
							  }, 
							   
							   */
							   
							    { 
							   	  name: 'Current Water Date',
								  field: 'Current_Water_Date',
								  enableFiltering: false,
								  
								  type: 'date', 
								  //cellFilter: 'date:"yyyy-MM-dd"',
								  cellFilter: 'date:"MM/dd/yyyy"',
							  
							   maxWidth: 170,
							    minWidth: 170
							  }, 
							   
							   
							    // ---------########## --------  End  -------- water date ----------##############------------
							   
							
							
							 // default
							  { 
							     name: 'Days',
								 type:'number',
							  	field: 'DAYS_SINCE_LAST_WATER', 
								enableCellEdit: false,
								headerCellClass: $scope.highlightFilteredHeader,
								
								maxWidth: 100,
								minWidth: 100,
								cellTooltip:true,
								
								filters: [
											{
											  condition: uiGridConstants.filter.GREATER_THAN,
											  placeholder: 'more than'
											},
											{
											  condition: uiGridConstants.filter.LESS_THAN,
											  placeholder: 'less than'
											}
										  ]
							  
							  },
							 
							 
							 
							 
							 // default
							  { 
							   name: 'Latest Water Date',
							   type:'date',
							  field: 'LAST_WATER_DATE', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  
							  
							  maxWidth: 170,
							    minWidth: 170,
							  cellTooltip:true,
							  
							  
							  
							  
							  
							  cellFilter: 'date:\'yyyy-MM-dd\'',
								cellTemplate: 'ui-grid/date-cell',
								filterHeaderTemplate: 'ui-grid/ui-grid-date-filter',
								//width: '40%',
								filters: [
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate >= term;
										},
									  //placeholder: 'Greater than or equal'
									  placeholder: 'After'
									},
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate <= term;
										},
									  //placeholder: 'Less than or equal'
									  placeholder: 'Before'
									}
								],
								headerCellClass: $scope.highlightFilteredHeader
							  
							  
							  
							  
							  },
							
							
							
							
							
							
							
							// default
							  { 
							   name: 'Planting Date',
							   type:'date',
							  field: 'PLANTING_DATE', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  
							  
							  maxWidth: 170,
							    minWidth: 170,
							  cellTooltip:true,
							  
							  
							
							  
							  
							  cellFilter: 'date:\'yyyy-MM-dd\'',
								cellTemplate: 'ui-grid/date-cell',
								filterHeaderTemplate: 'ui-grid/ui-grid-date-filter',
								//width: '40%',
								filters: [
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate >= term;
										},
									  //placeholder: 'Greater than or equal'
									  placeholder: 'After'
									},
									{
									  condition: function(term, value, row, column){
											if (!term) return true;
											var valueDate = new Date(value);
											return valueDate <= term;
										},
									 // placeholder: 'Less than or equal'
									 placeholder: 'Before'
									}
								],
								headerCellClass: $scope.highlightFilteredHeader
							  
							  
							  
							  
							  },
							
							
							  
							  
							  // default
							  { 
							     name: 'Site',
								 type:'number',
							  	field: 'BOE_SITE',
								enableCellEdit: false,
								headerCellClass: $scope.highlightFilteredHeader,
								
								filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
								
								cellTooltip:true,

								maxWidth: 70,
								minWidth: 70,
								
								
								
								 cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_site_no(grid, row), 6 )">{{grid.appScope.editLink_site_no(grid, row)}}</a></div>'
								
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
							 
							 maxWidth: 80,
							 minWidth: 80,
							  
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_crm(grid, row), 7 )">{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							  
							  
							  /*
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href="' + url + 'forms/swTreeEdit.cfm?sid={{grid.appScope.editLink_site_no(grid, row)}}&primary_key_id={{grid.appScope.editLink_pk_id(grid, row)}}&type_id={{grid.appScope.editLink_program_type(grid, row)}}&package_no={{grid.appScope.editLink_package_no(grid, row)}}&cd={{grid.appScope.editLink_cd(grid, row)}}&crm_no={{grid.appScope.editLink_crm(grid, row)}}&rebate={{grid.appScope.editLink_rebate(grid, row)}}&returnformat=json" >{{grid.appScope.editLink_crm(grid, row)}}</a></div>'
							 */
							
							   },
							   
							   
							   
							   
							     
							  {   name: 'Type',
							      
								  minWidth: 80,
								  maxWidth: 80,
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
							 
							    maxWidth: 90,
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
								 type:'number',
							  	field: 'BOE_BID_PACKAGE', 
								enableCellEdit: false,
								
								headerCellClass: $scope.highlightFilteredHeader,
								
								filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
								
								
								 maxWidth: 60,
							     minWidth: 60,
								 
								cellTooltip:true,
								
								
								cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_package_no(grid, row), 10 )">{{grid.appScope.editLink_package_no(grid, row)}}</a></div>'
								
								
								},
							  
							  
							  
							  // default
							  { 
							    name: 'CD',
								type:'number',
							  field: 'CD', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							  
							  filter: {
									       // filter exact match, strict match, not 'contain'
										  condition: uiGridConstants.filter.EXACT
										 // placeholder: 'your email'
										} , 
							  
							  
							  maxWidth: 50,
							  minWidth: 50,
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_cd(grid, row), 11 )">{{grid.appScope.editLink_cd(grid, row)}}</a></div>'
								
							  
							  },
							  
							  
							  
							  // default
							  { 
							   name: 'TBM',
							  field: 'TBM', 
							  enableCellEdit: false,
							  
							  headerCellClass: $scope.highlightFilteredHeader,
							  maxWidth: 70,
							    minWidth: 70,
							   cellTooltip:true,
							   
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_tbm(grid, row), 11 )">{{grid.appScope.editLink_tbm(grid, row)}}</a></div>'
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
							   
							   cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_location(grid, row), 12 )">{{grid.appScope.editLink_location(grid, row)}}</a></div>'
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
							  
							    maxWidth: 180,
							    minWidth: 180,
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_species(grid, row), 13 )">{{grid.appScope.editLink_species(grid, row)}}</a></div>'
							  
							  },
							  
							  
							  
							  
							  
							   // default
							  { 
							   name: 'Sub Position',
							  field: 'SUB_POSITION', 
							  enableCellEdit: false,
							  headerCellClass: $scope.highlightFilteredHeader,
							   
							   maxWidth: 80,
							   minWidth: 80,
							
							  cellTooltip:true,
							  
							  cellTemplate: '<div class="ui-grid-cell-contents" title="TOOLTIP"><a href=""  ng-click="grid.appScope.filterGrid(grid.appScope.editLink_sub_position(grid, row), 14 )">{{grid.appScope.editLink_sub_position(grid, row)}}</a></div>'
							  
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


                   $scope.editLink_tbm = function( grid, myRow ) {
					   return myRow.entity.TBM;
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
				  
				  
				 
				  
				 
				 
				  $scope.editLink_sub_position = function( grid, myRow ) {
					   return myRow.entity.SUB_POSITION;
				  };
				 

  
         
				 //-----******  --------------- get selected rows from previous page ------ also populate previous water date column----------
				    
					// "_selected_rows" are raw data from server, must format date, int to string etc...
					
					
					// ============= ----------  modify raw response from server  --------------    =======================
						  var ng_grid_data = [];
						  var ng_grid_data_array_obj = {};
					 
					
					console.log('raw _selected_rows: ',_selected_rows);
					
						angular.forEach(_selected_rows, function(value, key) {
													   
			                 					
							
							     ng_grid_data_array_obj = {};
							     angular.forEach(value, function(v, k) {
												 
												
												// raw data, any 0 or null value change to blank "" 
												// this is bug, single filter will failed with "null", so must chagne to ""
												
												//if ((v == 0) || ( v == null)){
											if ( v == null){
												   ng_grid_data_array_obj[k] = "";
												   console.log(ng_grid_data_array_obj);
												}
												else {		
												
												     
													 
									   			       // all number change to string for single general filter to work, so all value should be string, no int. 
													   // exception is days(days since last water) remain it as int, 
													   //other wise, filter greater than, less than will compare the string not the int value
													   
													   if (k == 'DAYS_SINCE_LAST_WATER')
													   
													   {
														   console.log('days: ',v);
														    ng_grid_data_array_obj[k] = v;   // keep int value, not convert to string, for greater than filter
													   }
													   
													   else 
													   {
													   
													         ng_grid_data_array_obj[k] = v.toString();    // any value, int, etc... to  string 
													   }
													   
													   
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
													if ((k == 'PLANTING_DATE') || (k == 'LAST_WATER_DATE')) 
													{
														                if (v == null) {
														                     
																			 // date is null
																			 ng_grid_data_array_obj[k] = '';
																		}
																		 else 
																		       {
														                         var _date = new Date(v);
																				 //  get 'short date' formate 
																				   ng_grid_data_array_obj[k] = _date.toLocaleDateString();
																			   }
																				   
													} 
												//------ End of Date format change to 09/30/2017 ---------
												
																 
							          }); // inner foreach
							
							
							ng_grid_data.push(ng_grid_data_array_obj);
							
							
						}); // outer foreach
					 
						// =============   End =========== modify raw response from server =======================
					
					
					   $scope.ng_grid_data = ng_grid_data;
					   
					   $scope.gridOptions.data = $scope.ng_grid_data;
					
					
					
					//$scope.gridOptions.data = _selected_rows;   // need format Date, int to string etc....
					console.log(_selected_rows_count);
					console.log(' processed _selected_rows : ',_selected_rows);
					
					
					
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




