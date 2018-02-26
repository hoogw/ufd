





	
	
	// ------------------    angular -----------------------------------
	
	var app = angular.module("tree-app", ["ngTouch", "angucomplete-alt", '720kb.datepicker']);
	
	
	   //  ========== tree angular controller ================
	
	    app.controller("TreeController", ['$scope', '$http', '$filter', function($scope, $http, $filter) {


           
	// ============================== init ======================= 
	$scope.init = function () {
			 	//alert("Angularjs call function on page load");
	
	            console.log(_primary_key_id);
				console.log(_type_id );
				console.log(_package_no);
				console.log(_site_id );
				console.log(_crm_no );
				console.log( _rebate);
	
	
	};// ================  end  ============== init ======================= 
	
	
	
	                 // -----------------------------   shared  utility  --------------------------------------------------
					
													
					     
											  	$scope.species = species_full_list;
											  
											  
											  
											  //$scope.sub_positions = sub_positions_full_list;
												$scope.overhead_wires =  overhead_wires_full_list;
												$scope.concrete_completeds =  concrete_completeds_full_list;
												$scope.post_inspecteds =  post_inspecteds_full_list;
										
										
										
												var query_param = {
												   
													primary_key_id:             _primary_key_id,
													type_id:                    _type_id,
													package_no:                 _package_no,
													site_id:                    _site_id,
													crm_no:                     _crm_no,
													rebate:                     _rebate
													
												   };
										
										
										   
										   
										   var retrived_tree_id_array = [];
										   var deleted_tree_id_array = [];
										
										
										
										//============== 720kb datepicker  date validation ===========
										
											var liveDate;
											
											//var today_date = new Date().toJSON().slice(0,10); 
											 var today_date = moment().format('MM/DD/YYYY');
											 
											 /*      
											   // $watch  is one way, but need add nested controller to locate collection's specific item. 
											   // https://stackoverflow.com/questions/20024156/how-to-watch-changes-on-models-created-by-ng-repeat
											  $scope.$watch('OnSiteReplaceTreeList.planting_date', function (value) {
												try {
												 liveDate = new Date(value);
												 console.log(value);
												} catch(e) {}
											
												if (liveDate == 'Invalid Date') {
																	   console.log('***** Invalid Date ******');
																	   $scope.OnSiteReplaceTree.planting_date = 'Invalid Date';
												} else {
												  $scope.date_error = false;
												}
											  }, true);  //watch
											  
											  */
										  
										  
										  
										  // add ng-change is neate, simple
												$scope.date_changed = function (itemTree_in_collection)
												
												{
													
																	 console.log(itemTree_in_collection.planting_date);
																	 
																	 
																	 try {
																					 liveDate = new Date(itemTree_in_collection.planting_date);
																											
																					 console.log(liveDate); 
																		} catch(e) {					
																					}
																										
																	 if (liveDate == 'Invalid Date') {
																									//console.log('***** Invalid Date ******');
																									itemTree_in_collection.planting_date = 'Invalid Date';
																											  
																											} else {
																												
																											}
													 
												    }; // function
										  
										  
										  
										  
										  
										  
										  
										//====== End ==== 720kb datepicker  date validation ===========
										
										
										
										
										
											  
											  
											  
					// -------------------------        End  shared  utility    --------------------------------------------------
	
	
	         
	
	
	
						//.......................................Get info for  remove tree ......................................
										
										/*
										$scope.RemoveTreeList = [
											{
												//'count':5,
												'location':'uuuuuuu',
												'note':'SHAMEL ASH',
												'selectedSpecie':{'originalObject': {'code': '', name: 'xxxxxxxx'}},
												'init_specieSelected':{'code':'','name':'ACACIA9999 SPECIES'}
												
											},
											{
												//'count':2,
												'location':'iiiiiiiiii',
												'note':'CAMPHOR TREE',
												'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'init_specieSelected':{'code':'','name':'xxxxxxxxCIES'}
											},
											{
												//'count':1,
												'location':'ppppppp',
												'note':'PECAN',
												'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'init_specieSelected':{'code':'','name':'1111111111111'}
											}];
										*/
										
										
										 //if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.RemoveTreeSpecieInputChanged = function(str) {
																								  $scope.RemoveTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										//---------- http init value remove tree -----------------------
										
										
													var req = {
															method : "POST",
															
															url : url + "cfc/tree_service.cfc?method=getTree_remove&returnformat=json&queryformat=struct",
															
															data: query_param
														};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															$scope.RemoveTreeList = [];
																	
															var _result = _response.data;		
															//_result = _result.replace(/\s/g, '');  // must remove space in string		
																//console.log(_result);
																	
																	
														    		//   ========= reformat and binding ======	
																	
																	// ============= ----------  modify raw response from server  --------------    =======================
																	  var ng_grid_data = [];
																	  var ng_grid_data_array_obj = {};
																 
																
																	  angular.forEach(_result, function(value, key) {
																								   
																							
																		
																			 ng_grid_data_array_obj = {};
																			 angular.forEach(value, function(v, k) {
																							 
																							 
																							 
																							 if(k == 'ID'){
																							
																									retrived_tree_id_array.push({'removed_id':v});
																									
																									
																									ng_grid_data_array_obj['tree_id'] = v.toString();
																							
																							}
																							 
																							 
																							
																							if(k == 'LOCATION'){
																							ng_grid_data_array_obj['location'] = v.toString();
																							
																							}
																							
																							if(k == 'SPECIES'){
																							ng_grid_data_array_obj['init_specieSelected'] = {'code':'','name':v.toString()};
																							
																							}
																							
																							if(k == 'NOTES'){
																							ng_grid_data_array_obj['note'] = v.toString();
																							
																							}
																							
																							
																							
																							
																											 
																				  }); // inner foreach
																		
																		
																		ng_grid_data.push(ng_grid_data_array_obj);
																		
																		
																	}); // outer foreach
																 
																 
																 $scope.RemoveTreeList = ng_grid_data;
																 
																 console.log($scope.RemoveTreeList);
																	// =============   End =========== modify raw response from server =======================
																	
																	
																	
															
																	//   ======= End === reformat and binding ======	
																	
																	
																	
																				  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then
										
										
										//----------  End ---------  http init value remove tree -----------------------
										
										
										
										
										
										
										//------------------------------------------------
										
											$scope.addNew_remove_tree = function(RemoveTree){
												
												if($('#form7')[0].checkValidity())  // html5 required field check 
													{
													
													
														// required field valid	
												
												
															$scope.RemoveTreeList.push({
																//'specieSelected':{originalObject: {code: "", name: ""}},	
																'tree_id': '-1', 
																'init_specieSelected': {'code':'','name':''}, 
																'location': address
																//'note': "",
															});
															
															
												
												
													}// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
											};// addNew
										
										
										
										
										
										
											$scope.remove_remove_tree = function(){
												var newDataList=[];
												$scope.selectedAll_remove_tree = false;
												angular.forEach($scope.RemoveTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
													else {
														
														deleted_tree_id_array.push({'removed_id':selected.tree_id});
														console.log('deleted_tree_id === ', selected.tree_id);
														
													}
													
													
												}); 
												$scope.RemoveTreeList = newDataList;
												
												
											};
										
										
										
										
										
												$scope.checkAll_remove_tree = function () {
													if (!$scope.selectedAll_remove_tree) {
														/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
															for angular 1.6.x, here should be 'false', 
														*/
														
														$scope.selectedAll_remove_tree = false;  
														
													} else {
														
														/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
															for angular 1.6.x, here should be 'true', 
														*/
														$scope.selectedAll_remove_tree = true;
													}
													angular.forEach($scope.RemoveTreeList, function(RemoveTree) {
														RemoveTree.selected = $scope.selectedAll_remove_tree;
													});
												};    
										
						
						
						
						
						
						
						    $scope.$watch('RemoveTreeList', function() {
								//console.log($scope.RemoveTreeList);
								
							
							
							//});  // Reference Watches only top level, not every field change, not push new. http://teropa.info/blog/2014/01/26/the-three-watch-depths-of-angularjs.html
							}, true);  // Equality Watches, deep into every field change, push new 
					
						
						
						//...........End  remove tree ..............
						
						
						
						
						
						
						//........................................Get info for  ...... On Site Replace tree ........................................................
						
										/*												 
										$scope.OnSiteReplaceTreeList = [
											{
												//'count':'2',
												'location':'ppooppoioi',
												'planting_date':'08/9/2017',
												'overhead_wire':'No',
												'note':'3333333333333333333333333',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												
												'init_specieSelected':{'code':'','name':'999877655'}
											},
											{
												//'count':'8',
												'location':'errertertrew',
												'planting_date':'08/02/1996',
												'overhead_wire':'',
												'note':'ttttttttttttttttttttttt',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}}
											     'init_specieSelected':{'code':'','name':'gyhbyrvv'}
											},
											{
												//'count':'4',
												'location':'rtytrhrehtr',
												'planting_date':'5/03/1995',
												'overhead_wire':'No',
												'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												'init_specieSelected':{'code':'','name':'90890890gjhgff'}
											}];
										
										*/
										
										
										
										 //if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.OnSiteReplaceTreeSpecieInputChanged = function(str) {
																								  $scope.OnSiteReplaceTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										//---------- http init value on site replace tree -----------------------
										
										
													var req = {
															method : "POST",
															
															url : url + "cfc/tree_service.cfc?method=getTree_onSite&returnformat=json&queryformat=struct",
															
															data: query_param
														};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															$scope.OnSiteReplaceTreeList = [];
																	
															var _result = _response.data;		
															//_result = _result.replace(/\s/g, '');  // must remove space in string		
																//console.log(_result);
																	
																	
														    		//   ========= reformat and binding ======	
																	
																	// ============= ----------  modify raw response from server  --------------    =======================
																	  var ng_grid_data = [];
																	  var ng_grid_data_array_obj = {};
																 
																
																	  angular.forEach(_result, function(value, key) {
																								   
																							
																		
																			 ng_grid_data_array_obj = {};
																			 angular.forEach(value, function(v, k) {
																							 
																							  if(k == 'ID'){
																							
																									retrived_tree_id_array.push({'removed_id':v});
																									ng_grid_data_array_obj['tree_id'] = v.toString();
																							
																							}
																							
																							if(k == 'LOCATION'){
																							ng_grid_data_array_obj['location'] = v.toString();
																							
																							}
																							
																							if(k == 'SPECIES'){
																							ng_grid_data_array_obj['init_specieSelected'] = {'code':'','name':v.toString()};
																							
																							}
																							
																							if(k == 'NOTES'){
																							ng_grid_data_array_obj['note'] = v.toString();
																							
																							}
																							
																							if(k == 'PARKWAY_SIZE'){
																							ng_grid_data_array_obj['parkway_size'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'OVERHEAD_WIRES'){
																							ng_grid_data_array_obj['overhead_wire'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'SUB_POSITION'){
																							ng_grid_data_array_obj['sub_position'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'SPD_CONCRETE_WORK_COMPLETED'){
																							ng_grid_data_array_obj['concrete_completed'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'UFD_POST_INSPECTED'){
																							ng_grid_data_array_obj['post_inspected'] = v.toString();
																							
																							}
																							
																							
																							
																							
																							if(k == 'PLANTING_DATE'){
																								
																								
																								var _date = new Date(v);
																								
																							//	console.log($filter('date')(v, "MM/dd/yyyy"));
																							 //    console.log($filter('date')(_date,'shortDate'));
																								 
																							ng_grid_data_array_obj['planting_date'] = $filter('date')(_date, "MM/dd/yyyy");
																							
																							}
																							
																							
																							
																							
																											 
																				  }); // inner foreach
																		
																		
																		ng_grid_data.push(ng_grid_data_array_obj);
																		
																		
																	}); // outer foreach
																 
																 
																 $scope.OnSiteReplaceTreeList = ng_grid_data;
																 
																// console.log($scope.OnSiteReplaceTreeList);
																	// =============   End =========== modify raw response from server =======================
																	
																	
																	
															
																	//   ======= End === reformat and binding ======	
																	
																	
																	
																				  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then
										
										
										//----------  End ---------  http init value on site replace tree -----------------------
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										// -----  add new row ------------
											$scope.addNew_onsite_replace_tree = function(OnSiteReplaceTree)
											{
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
												
												
														$scope.OnSiteReplaceTreeList.push({ 
																						// 'selectedSpecie':{originalObject: {code: "", name: ""}},	
																						'tree_id': '-1',
																						'init_specieSelected': {'code':'','name':''}, 
																						//'count': "", 
																						'location': address
																					//	'planting_date':today_date,  // if predefine today's date or any date, highlight today's css would not work. 
																					//	'note': "",
														});
														
													
												
												  }// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
												
											}; // add new row
											
											
										   // -----  remove  row ------------
											$scope.remove_onsite_replace_tree = function(){
												var newDataList=[];
												$scope.selectedAll_onsite_replace_tree = false;
												angular.forEach($scope.OnSiteReplaceTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
													else {
														
														deleted_tree_id_array.push({'removed_id':selected.tree_id});
														console.log('deleted_tree_id === ', selected.tree_id);
														
													}
													
													
													
												}); 
												$scope.OnSiteReplaceTreeList = newDataList;
												
											
												
											};
										
										
										
										$scope.checkAll_onsite_replace_tree = function () {
											if (!$scope.selectedAll_onsite_replace_tree) {
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
												    for angular 1.6.x, here should be 'false', 
												*/
												
												$scope.selectedAll_onsite_replace_tree = false;  
												
											} else {
												
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
												    for angular 1.6.x, here should be 'true', 
												*/
												$scope.selectedAll_onsite_replace_tree = true;
											}
											angular.forEach($scope.OnSiteReplaceTreeList, function(OnSiteReplaceTree) {
												OnSiteReplaceTree.selected = $scope.selectedAll_onsite_replace_tree;
											});
										};    
						
						
						
						
						
						
						    $scope.$watch('OnSiteReplaceTreeList', function() {
								console.log($scope.OnSiteReplaceTreeList);
								
							
							//});  // Reference Watches only top level, not every field change, not push new. http://teropa.info/blog/2014/01/26/the-three-watch-depths-of-angularjs.html
							}, true);  // Equality Watches, deep into every field change, push new 
					
						
						
						
						
						
						
						//...........End  OnSiteReplaceTree ..............
						
						
						
						
						
						
						
						
						
						
						
						
						
						//   ...................      Get info for    .............. Off Site Replace tree ..............
															
										/*					
										$scope.OffSiteReplaceTreeList = [
											{
												//'count':'7',
												'location':'5',
												'planting_date':'08/09/2017',
												'overhead_wire':'Yes',
												'note':'hhhhhhhhhhhhhhhhhhhh',
											//	'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												'init_specieSelected':{'code':'','name':'uunh8776890'}
											},
											{
												//'count':'9',
												'location':'87987juy',
												'planting_date':'05/08/2017',
												'overhead_wire':'No',
												'note':'uuuuuuuuuuuuuuuuuuuuuuuuuuuuu',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												'init_specieSelected':{'code':'','name':'<>TYTRG'}
											},
											{
												//'count':'8',
												'location':'56756u65tydghtd',
												'planting_date':'08/09/2011',
												'overhead_wire':'',
												'note':'5555555555555555555555555',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												'init_specieSelected':{'code':'','name':'$^&^gghdsa'}
											}];
										
										   */
										
										//if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.OffSiteReplaceTreeSpecieInputChanged = function(str) {
																								  $scope.OffSiteReplaceTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										
										
										//---------- http init value off site replace tree -----------------------
										
										
													var req = {
															method : "POST",
															
															url : url + "cfc/tree_service.cfc?method=getTree_offSite&returnformat=json&queryformat=struct",
															
															data: query_param
														};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															$scope.OffSiteReplaceTreeList = [];
																	
															var _result = _response.data;		
															//_result = _result.replace(/\s/g, '');  // must remove space in string		
																//console.log(_result);
																	
																	
														    		//   ========= reformat and binding ======	
																	
																	// ============= ----------  modify raw response from server  --------------    =======================
																	  var ng_grid_data = [];
																	  var ng_grid_data_array_obj = {};
																 
																
																	  angular.forEach(_result, function(value, key) {
																								   
																							
																		
																			 ng_grid_data_array_obj = {};
																			 angular.forEach(value, function(v, k) {
																							 
																							  if(k == 'ID'){
																							
																									retrived_tree_id_array.push({'removed_id':v});
																									ng_grid_data_array_obj['tree_id'] = v.toString();
																							
																							}
																							 
																							
																							if(k == 'LOCATION'){
																							ng_grid_data_array_obj['location'] = v.toString();
																							
																							}
																							
																							if(k == 'SPECIES'){
																							ng_grid_data_array_obj['init_specieSelected'] = {'code':'','name':v.toString()};
																							
																							}
																							
																							if(k == 'NOTES'){
																							ng_grid_data_array_obj['note'] = v.toString();
																							
																							}
																							
																							if(k == 'PARKWAY_SIZE'){
																							ng_grid_data_array_obj['parkway_size'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'OVERHEAD_WIRES'){
																							ng_grid_data_array_obj['overhead_wire'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'SUB_POSITION'){
																							ng_grid_data_array_obj['sub_position'] = v.toString();
																							
																							}
																							
																							
																							if(k == 'SPD_CONCRETE_WORK_COMPLETED'){
																							ng_grid_data_array_obj['concrete_completed'] = v.toString();
																							
																							}
																							
																							
																							
																							if(k == 'UFD_POST_INSPECTED'){
																							ng_grid_data_array_obj['post_inspected'] = v.toString();
																							
																							}
																							
																							if(k == 'PLANTING_DATE'){
																								
																								
																								var _date = new Date(v);
																								
																							//	console.log($filter('date')(v, "MM/dd/yyyy"));
																							 //    console.log($filter('date')(_date,'shortDate'));
																								 
																							ng_grid_data_array_obj['planting_date'] = $filter('date')(_date, "MM/dd/yyyy");
																							
																							}
																							
																							
																							
																							
																											 
																				  }); // inner foreach
																		
																		
																		ng_grid_data.push(ng_grid_data_array_obj);
																		
																		
																	}); // outer foreach
																 
																 
																 $scope.OffSiteReplaceTreeList = ng_grid_data;
																 
																// console.log($scope.OffSiteReplaceTreeList);
																	// =============   End =========== modify raw response from server =======================
																	
																	
																	
															
																	//   ======= End === reformat and binding ======	
																	
																	
																	
																				  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then
										
										
										//----------  End ---------  http init value on site replace tree -----------------------
										
										
										
										
										
										
										
										
										
										
										
										//  --------  add new row -----------------
											$scope.addNew_offsite_replace_tree = function(OffSiteReplaceTree){
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
														$scope.OffSiteReplaceTreeList.push({
															//'selectedSpecie':{originalObject: {code: "", name: ""}},	
															'tree_id': '-1',
															'init_specieSelected': {'code':'','name':''}, 							   
															//'count': "", 
															//	'planting_date':today_date,  // if predefine today's date or any date, highlight today's css would not work. 
															'location': address
															//'note': "",
														});
														
													
												
												}// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
											};  
											//  -----    End ---  add new row -----------------
											
											
											
										
										  // --------- remove row ----------------
											$scope.remove_offsite_replace_tree = function(){
												var newDataList=[];
												$scope.selectedAll_offsite_replace_tree = false;
												angular.forEach($scope.OffSiteReplaceTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
													else {
														
														deleted_tree_id_array.push({'removed_id':selected.tree_id});
														console.log('deleted_tree_id === ', selected.tree_id);
														
													}
													
													
												}); 
												$scope.OffSiteReplaceTreeList = newDataList;
												
												
											};
										
										// -------  End -- remove row ----------------
										
										
										
										
										$scope.checkAll_offsite_replace_tree = function () {
											if (!$scope.selectedAll_offsite_replace_tree) {
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
												    for angular 1.6.x, here should be 'false', 
												*/
												
												$scope.selectedAll_offsite_replace_tree = false;  
												
											} else {
												
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
												    for angular 1.6.x, here should be 'true', 
												*/
												$scope.selectedAll_offsite_replace_tree = true;
											}
											angular.forEach($scope.OffSiteReplaceTreeList, function(OffSiteReplaceTree) {
												OffSiteReplaceTree.selected = $scope.selectedAll_offsite_replace_tree;
											});
										};    
										
						
						//...........End  OffSiteReplaceTree ..............
						
						
						
						
						// .................. get site_note from main table and binding ......................
						
						   
						   
						          var req = {
															method : "POST",
															
															url : url + "cfc/tree_service.cfc?method=get_site_note&returnformat=json&queryformat=struct",
															
															data: query_param
														};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															
																	
															var _result = _response.data;		
															//_result = _result.replace(/\s/g, '');  // must remove space in string		
																console.log(_result);
																	
																	
														    	$scope.site_note = 	_result[0].NOTES;
																	
																	
																	
																				  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then
						   
						
						
						
						// .................. get site_note from main table and binding ......................
	
	
	
	
	
	
	
	
	//=========================  update button clicked to save tree info =============================
						          
						$scope.cancel = function(){
						
						
						   location.replace(url + "search/swTreeSiteSearch.cfm");
						
						}
									   
									   
									   
						
						 $scope.save = function(){
									   
									   
							if($('#form7')[0].checkValidity())
							{
							// required field valid							
													
							
									
									
									//  *********************  mark current retrived tree as removed status  ***********************
									var post_data_mark_as_removed = {		
										
										//mark_as_removed : retrived_tree_id_array		//[ 146, 45, 67,....]		
										
										mark_as_removed : deleted_tree_id_array
									};
									
									
													
											 var req = {
													method : "POST",
													
													url : url + "cfc/tree_service.cfc?method=mark_as_removed",
													
													data: post_data_mark_as_removed
												};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
																	
																	
															var _result = _response.data;		
															_result = _result.replace(/\s/g, '');  // must remove space in string		
																	
															/*		
															console.log("_response---", _response);		
															console.log("_result%%%%%%%%", _result.valueOf());		
															console.log(_result.length, String("success").length );
															
															*/
																	
															// return result has double quote, you must consider match exact char.  '"success"'		
															if (_result == '"marked_removed_done"')	
															{	
																
																//$('#box_tree').hide();
																
																//showMsg("outdated tree marked successfully!",1,"Tree");
																
																
															}
															else 
															{
																// showMsg("Failed!",1,"Tree");
															}
																/*  -------------  for testing ---- output json result ---------------
																var str = JSON.stringify(_response.data, undefined, 4);
																		//$scope.server_response = JSON.stringify(_response.data, undefined, 4);
																		
																		// if return only string, use this line 
																		output(str);
																		
																		// if return json, use this line to display json at bottom div
																		//output(syntaxHighlight(str));
																		
															-------  for testing ---- output json result ---------------  */	
															
															
															
																		
														/*				
														// this callback will be called asynchronously when the response is available
															//$scope.server_response = response.data;
															$scope.cfdumps.push({
																									//method: method.toUpperCase(),
																									//html: _response    // for angular 1.2.x
																									html: _response.data  // for angular 1.6.x
																								});//push							  
															*/										  
																									  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															// showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then		
													
													
												//  ***************    End    ******  mark current retrived tree as removed status  ***********************	
													
													
												
												
									   
									   
									   
									   
									   
									   // ****************************** save info  **************************
									   
									   
									   
									    var post_data = {
									   
									    primary_key_id:             _primary_key_id,
										type_id:                    _type_id,
										package_no:                 _package_no,
										site_id:                    _site_id,
										crm_no:                     _crm_no,
										rebate:                     _rebate,
										
									    RemoveTreeList:            $scope.RemoveTreeList,
									    OnSiteReplaceTreeList:     $scope.OnSiteReplaceTreeList,
										OffSiteReplaceTreeList:    $scope.OffSiteReplaceTreeList,
									   
									    site_note: $scope.site_note,
																						
																							
									   };
									   
									   
									   
									   
									   
									   
					
									 var req = {
													method : "POST",
													
													url : url + "cfc/tree_service.cfc?method=save_tree",
													
													data: post_data
												};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
																	
																	
															var _result = _response.data;		
															_result = _result.replace(/\s/g, '');  // must remove space in string		
																	
															/*		
															console.log("_response---", _response);		
															console.log("_result%%%%%%%%", _result.valueOf());		
															console.log(_result.length, String("success").length );
															
															*/
																	
															// return result has double quote, you must consider match exact char.  '"success"'		
															if (_result == '"success"')	
															{	
																
																//$('#box_tree').hide();
																
																//showMsg("Tree updated successfully!",1,"Tree");
																
																goToSite(_primary_key_id,_type_id,_package_no,_site_id,_cd,_crm_no, _rebate );
																
															}
															else 
															{
																 showMsg("Failed!",1,"Tree");
															}
																/*  -------------  for testing ---- output json result ---------------
																var str = JSON.stringify(_response.data, undefined, 4);
																		//$scope.server_response = JSON.stringify(_response.data, undefined, 4);
																		
																		// if return only string, use this line 
																		output(str);
																		
																		// if return json, use this line to display json at bottom div
																		//output(syntaxHighlight(str));
																		
															-------  for testing ---- output json result ---------------  */	
															
															
															
																		
														/*				
														// this callback will be called asynchronously when the response is available
															//$scope.server_response = response.data;
															$scope.cfdumps.push({
																									//method: method.toUpperCase(),
																									//html: _response    // for angular 1.2.x
																									html: _response.data  // for angular 1.6.x
																								});//push							  
															*/										  
																									  
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 // $scope.server_response = _response.statusText;
																									  
																									  
																									  
													}); // http then
								
								                  //    *******************   End   ********************* save info  **************************
								
								
								
								
								
								}// if required field validation is valid 
								else {
									// it is same as add row button, html5 required field check, must have submit button clicked.						
									// not valid, missing required field
									$('#submit_handle').click();
								}
											
									
									
									
									
									
									
									
									
											
						};// save clicked
						
						
						
						     
						
						
						  //=========== End ========== save insert crete =============================
						
					}]);// tree controller	
		
	//  ========== End tree angular controller ================
	
	
	// ------------------ END -----   angular -----------------------------------
	
	
	
	function goToSite(primary_key_id, type_id, package_no, sid, cd, crm_no, rebate) {
	location.replace(url + "forms/swTreeEdit.cfm?sid=" + sid + "&" + "primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&" + "package_no=" + package_no + "&" + "cd=" + cd + "&" + "crm_no=" + crm_no  + "&" + "rebate=" + rebate );
}
	
	
	function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

	
	