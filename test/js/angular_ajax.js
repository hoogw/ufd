 
 
 

 
 
 
 
 
 
 var app = angular.module('myApp', ["ngTouch", "angucomplete-alt", '720kb.datepicker']);



 
 





						
						

//--------------------------- date validation -----------------------------

															app.controller('ctrl', ['$scope', function ($scope) {
															  var liveDate;
															
															   $scope.alltree = {
															      'mydate' : '8/9/1976'
															   
															   };
															  // $scope.mydate = "8/9/1976aa";
															    
															// $watch  is one way, but need add nested controller to locate collection's specific item. 
											               // https://stackoverflow.com/questions/20024156/how-to-watch-changes-on-models-created-by-ng-repeat
															  $scope.$watch('alltree.mydate', function (value) {
																try {
																 liveDate = new Date(value);
																// console.log($scope.mydate);
																 console.log(liveDate);
																 
																 
																 
																} catch(e) {
																	
																	
																	
																	}
															
																if (liveDate == 'Invalid Date') {
															       console.log('***** Invalid Date ******');
																   $scope.alltree.mydate = 'Invalid Date';
																  //$scope.error_message = "This is not a valid date";
																  //$scope.error = true;
																} else {
																	console.log(' ok ok ok');
																 // $scope.error = false;
																}
															  }, true);  //watch
															  
															  
															}]);  // controller

   

//-------------------  ---    ListController   -----------------------------------------
	
	
	
				//app.controller("ListController", ['$scope', '$log', function($scope, $log) {
				<!---  	for inject work, this order matter, must match   --->														   
			    app.controller("ListController", ['$scope', '$http',function($scope, $http) {
									
									
									
					$scope.personalDetails = [
						{
							'fname':'Muhammed',
							'lname':'Shanid',
							'email':'shanid@shanid.com',
							'method':'66666',
							'date':'08/9/2017',
							'init_specieSelected':{'code':'','name':'ACACIA9999 SPECIES'}
							
							

						},
						{
							'fname':'John',
							'lname':'Abraham',
							'email':'john@john.com',
							'method':'66666',
							'date':'08/08/1325',
							'init_specieSelected':{'code':'','name':'xxxxxxxxCIES'}
						},
						{
							'fname':'Roy',
							'lname':'Mathew',
							'email':'roy@roy.com',
							'method':'66666',
							'date':'8/08/1985',
							'init_specieSelected':{'code':'','name':'1111111111111'}
						}];
					
					
					$scope.tts = ["xxxxxx", "66666", "00000000000000"];
					
					
					
					
					
					//============= console log =============
					  
					  
					  
					  
					 
					 
					
					
					$scope.$watch('personalDetails', function() {
			       
															  
								console.log($scope.personalDetails);
								
								//  $log.log($scope.personalDetails);  // not in use
							
							                      /*
							                             
															 
							                         */
							
							
							
							//});  // Reference Watches only top level, not every field change, not push new. http://teropa.info/blog/2014/01/26/the-three-watch-depths-of-angularjs.html
							}, true);  // Equality Watches, deep into every field change, push new 
					
					//============= console log =============
					
					
					
					
					
					//               ###########  Date validation  ###############
					// $watch  is one way, but need add nested controller to locate collection's specific item. 
											   // https://stackoverflow.com/questions/20024156/how-to-watch-changes-on-models-created-by-ng-repeat
					
					
					var liveDate;
					$scope.date_changed = function (personalDetail){
						
						 console.log(personalDetail.date);
						 
						 
						 try {
										 liveDate = new Date(personalDetail.date);
																
										 console.log(liveDate); 
							} catch(e) {					
										}
															
						 if (liveDate == 'Invalid Date') {
													    //console.log('***** Invalid Date ******');
														personalDetail.date = 'Invalid Date';
																  
																} else {
																	//console.log(' ok ok ok');
																 // $scope.error = false;
																}
						 
						 
					};
					
					
					//             ########### End  ######  Date validation  ###############
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
						$scope.addNew = function(personalDetail){
							
							if($('#form0')[0].checkValidity())
							{
							
							
								// required field valid	
									
									$scope.personalDetails.push({ 
										'fname': "", 
										'lname': "",
										'email': "",
									});
									
									
							}// if validation is valid 
							else {
								
								// not valid, missing required field
								$('#submit_handle').click();
							}
							
							
							
						}; // addNew
					
					
					
					
					
						$scope.remove = function(){
							var newDataList=[];
							$scope.selectedAll = false;
							angular.forEach($scope.personalDetails, function(selected){
								if(!selected.selected){
									newDataList.push(selected);
								}
							}); 
							$scope.personalDetails = newDataList;
						};
					
					
					$scope.checkAll = function () {
													if (!$scope.selectedAll) {
														$scope.selectedAll = false;
													} else {
														$scope.selectedAll = true;
													}
													angular.forEach($scope.personalDetails, function(personalDetail) {
														personalDetail.selected = $scope.selectedAll;
													});
												};    
					
					
					
					
					// -----------------------------   angucomplete-alt auto complete  --------------------------------------------------
					
				     /*
					  $scope.speciesSelected = function(selected) {
							  if (selected) {
								//window.alert('You have selected ' + selected.title);
								
								$scope.specie = selected.title;
								
							  } else {
								console.log('cleared');
							  }
							};
						*/
						
					     
					  $scope.species_local_list = species_full_list;
					
					// -------------------------       End     --------------    angucomplete-alt auto complete      --------------------------------------------------
					
					
					
					
					
					
					
				// ***********************************  ajax post to server **************************************************
				
				
				/*
				 var post_data = {
									   
									    RemoveTreeList:            $scope.RemoveTreeList,
									    OnSiteReplaceTreeList:     $scope.OnSiteReplaceTreeList,
										OffSiteReplaceTreeList:    $scope.OffSiteReplaceTreeList
									   
									   };
				*/
				
				 var post_data = 
												{

															  RemoveTreeList: [
																				{
																					'count':5,
																					'location':'uuuuuuu',
																					'note':'SHAMEL ASH',
																					
																					'init_specieSelected':{'code':'','name':'ACACIA9999 SPECIES'}
																					
																				},
																				{
																					'count':2,
																					'location':'iiiiiiiiii',
																					'note':'CAMPHOR TREE',
																					'init_specieSelected':{'code':'','name':'xxxxxxxxCIES'}
																				},
																				{
																					'count':1,
																					'location':'ppppppp',
																					'note':'PECAN',
																					'init_specieSelected':{'code':'','name':'1111111111111'}
																				}],
																				
															  OnSiteReplaceTreeList :[
																				{
																					'count':'2',
																					'location':'ppooppoioi',
																					'planting_date':'08/999/20117',
																					'overhead_wire':'No',
																					'note':'3333333333333333333333333',
																					'init_specieSelected':{'code':'','name':'999877655'}
																				},
																				{
																					'count':'8',
																					'location':'errertertrew',
																					'planting_date':'08/089997',
																					'overhead_wire':'',
																					'note':'ttttttttttttttttttttttt',
																					'init_specieSelected':{'code':'','name':'gyhbyrvv'}
																				},
																				{
																					'count':'4',
																					'location':'rtytrhrehtr',
																					'planting_date':'08999/20117',
																					'overhead_wire':'No',
																					'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
																					'init_specieSelected':{'code':'','name':'90890890gjhgff'}
																				}],
									
															OffSiteReplaceTreeList  :[
																				{
																					'count':'7',
																					'location':'5',
																					'planting_date':'08/08999/20117',
																					'overhead_wire':'Yes',
																					'note':'hhhhhhhhhhhhhhhhhhhh',
																					'init_specieSelected':{'code':'','name':'uunh8776890'}
																				},
																				{
																					'count':'9',
																					'location':'87987juy',
																					'planting_date':'08765/08999/20117',
																					'overhead_wire':'No',
																					'note':'uuuuuuuuuuuuuuuuuuuuuuuuuuuuu',
																					'init_specieSelected':{'code':'','name':'<>TYTRG'}
																				},
																				{
																					'count':'8',
																					'location':'56756u65tydghtd',
																					'planting_date':'08/08999/2011',
																					'overhead_wire':'',
																					'note':'5555555555555555555555555',
																					'init_specieSelected':{'code':'','name':'$^&^gghdsa'}
																				}]
									
													};	
				
				
				
					
					$scope.cfdumps = [];
					
					$scope.save = function(){
					
							 var req = {
											method : "POST",
											//url : "http://78boe99prod/ufd/test/cfc/tree_service.cfc?method=save_tree&callback=",
											//url : "http://78boe99prod/ufd/test/cfc/tree_service1.cfm",
											url : "http://78boe99prod/ufd/test/cfc/tree_service.cfc?method=save_tree",
											//data: JSON.stringify($scope.personalDetails)	 // both works (strings or object), same result.
											//data: $scope.personalDetails	
											data: post_data
										};
						
						
						
							$http(req).then(
											
								function Success(_response) 
								{
												var str = JSON.stringify(_response.data, undefined, 4);
												//$scope.server_response = JSON.stringify(_response.data, undefined, 4);
												//output(str);
												output(syntaxHighlight(str));
												
												
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
									  $scope.server_response = _response.statusText;
																			  
																			  
																			  
							}); // http then
																	
					
					
					
					
					};// save clicked
					
				// ********* End ****** ajax post to server **************
					
					
				}]);// app ListController
				
				
				//--------------------   End     ListController   -----------------------------------------




				<!---   allow the HTML to be output for the current demo--->
				
						//  override the "expected" $sanitize service to simply allow the HTML to be
						// output for the current test.
						// --
						// NOTE: Do not use this version in production This is for development only.
				
								app.value(
							"$sanitize",
							function( html ) {
								return( html );
							}
						);
				<!---  END --- allow the HTML to be output for the current demo     --->