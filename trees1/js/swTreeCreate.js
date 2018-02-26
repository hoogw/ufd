





	
	
	// ------------------    angular -----------------------------------
	
	var app = angular.module("tree-app", ["ngTouch", "angucomplete-alt", '720kb.datepicker']);
	
	
	   //  ========== tree angular controller ================
	
	    app.controller("TreeController", ['$scope', '$http',function($scope, $http) {


           
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
	
	
	         
	
	
	
						//....................................... remove tree ......................................
									/*													 
										$scope.RemoveTreeList = [
											{
												
												'location':'uuuuuuu',
												'note':'SHAMEL ASH',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'init_specieSelected':{'code':'','name':'ACACIA9999 SPECIES'}
												
											},
											{
												//'count':2,
												'location':'iiiiiiiiii',
												'note':'CAMPHOR TREE',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'init_specieSelected':{'code':'','name':'xxxxxxxxCIES'}
											},
											{
												//'count':1,
												'location':'ppppppp',
												'note':'PECAN',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'init_specieSelected':{'code':'','name':'1111111111111'}
											}];
										*/
										
										$scope.RemoveTreeList = [
											                     { 
																   'tree_id': '-1',
																   'init_specieSelected':{'code':'','name':''},
																   'location': address
										                            }];
										 
										  //if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.RemoveTreeSpecieInputChanged = function(str) {
																								  $scope.RemoveTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										
										
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
						
						
						
						
						
						
						//.............................................. On Site Replace tree ........................................................
						
									/*													 
										$scope.OnSiteReplaceTreeList = [
											{
												//'count':'2',
												'location':'ppooppoioi',
												'planting_date':'08/9/2017',
												'overhead_wire':'No',
												'note':'3333333333333333333333333',
												'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												
												//'init_specieSelected':{'code':'','name':'999877655'}
											},
											{
												//'count':'8',
												'location':'errertertrew',
												'planting_date':'08/02/1996',
												'overhead_wire':'',
												'note':'ttttttttttttttttttttttt',
												'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												//'init_specieSelected':{'code':'','name':'gyhbyrvv'}
											},
											{
												//'count':'4',
												'location':'rtytrhrehtr',
												'planting_date':'5/03/1995',
												'overhead_wire':'No',
												'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
												'selectedSpecie':{'originalObject': {'code': '', name: ''}}
												//'init_specieSelected':{'code':'','name':'90890890gjhgff'}
											}];
										*/
										
										$scope.OnSiteReplaceTreeList = [];
										
										
										  //if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.OnSiteReplaceTreeSpecieInputChanged = function(str) {
																								  $scope.OnSiteReplaceTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										// -----  add new row ------------
											$scope.addNew_onsite_replace_tree = function(OnSiteReplaceTree)
											{
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
												
												
														$scope.OnSiteReplaceTreeList.push({ 
																						  'tree_id': '-1',
																						// 'selectedSpecie':{originalObject: {code: "", name: ""}},					   
																						'init_specieSelected': {'code':'','name':''}, 
																						
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
						
						
						
						
						
						
						
						
						
						
						
						
						
						//........... Off Site Replace tree ..............
															
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
										
										
										$scope.OffSiteReplaceTreeList = [];
										
										//if no match, selectedSpecie will be null, so get user input whatever value, set it to init_specieSelected value, later save to database. 
										 $scope.OffSiteReplaceTreeSpecieInputChanged = function(str) {
																								  $scope.OffSiteReplaceTreeList[this.$parent.$index].init_specieSelected.name = str;
																								}
										
										
										//  --------  add new row -----------------
											$scope.addNew_offsite_replace_tree = function(OffSiteReplaceTree){
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
														$scope.OffSiteReplaceTreeList.push({
																						   'tree_id': '-1',
																							//'selectedSpecie':{originalObject: {code: "", name: ""}},					   
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
						
						
						
						
						
						
						    //===========  save insert creat =============================
						          
									   
									   
						
						 $scope.save = function(){
									   
									   
							if($('#form7')[0].checkValidity())
							{
							// required field valid							
													
							
												
														
												
												
									   
									   
									   
									   
									   
									   
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
									   
									    site_note: $scope.site_note
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
																
																
																goToSite(_primary_key_id,_type_id,_package_no,_site_id,_cd,_crm_no, _rebate );
																
																
																//showMsg("Tree create successfully!",1,"Tree");
																
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

	
	