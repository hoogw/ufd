
//var app = angular.module('app', ['ngMaterial', 'ngMessages','angucomplete-alt']);


var app = angular.module('app', ['ngMaterial', 'ngMessages']);
app.controller('DemoCtrl', function($scope, $q, $timeout) {
  


 // -----------------------------   shared  utility  --------------------------------------------------
					
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
													
					                             // for angucomplete-alt
											  //	$scope.species = species_full_list;
											  
											  
											  
											  //$scope.sub_positions = sub_positions_full_list;
												$scope.overhead_wires =  overhead_wires_full_list;
												$scope.concrete_completeds =  concrete_completeds_full_list;
												$scope.post_inspecteds =  post_inspecteds_full_list;
												
												
												
												/*
												 //  =============== md-autocomplete  sample 1  https://jsfiddle.net/hoogw/Lctcxjqr/257/  ===================== 
												
											 this.getMatches = function(searchText) {
																var deferred = $q.defer();
													
																$timeout(function() {
																	var states = getStates().filter(function(state) {
																		return (state.name.toUpperCase().indexOf(searchText.toUpperCase()) !== -1 || state.abbreviation.toUpperCase().indexOf(searchText.toUpperCase()) !== -1);
																	}); // getStates
																	deferred.resolve(states);
																}, 1500);// timeout
													
																return deferred.promise;
															}  // getMatches
														

												
												
											//  ============    End  ======== md-autocomplete ===================== 
										 	*/
												
												
												
												
												//  =============== md-autocomplete  sample 2 ===================== 
												
												    var self = this;

														// list of `state` value/display objects
														self.states        = loadAll();
														
														console.log(self.states);
														
														self.selectedItem  = null;
														self.searchText    = null;
														self.querySearch   = querySearch;
													
														// ******************************
														// Internal methods
														// ******************************
													
														/**
														 * Search for states... use $timeout to simulate
														 * remote dataservice call.
														 */
														function querySearch (query) {
														  var results = query ? self.states.filter( createFilterFor(query) ) : self.states;
														  var deferred = $q.defer();
														  $timeout(function () { deferred.resolve( results ); }, Math.random() * 1, false);
														  return deferred.promise;
														}
													
														/**
														 * Build `states` list of key/value pairs
														 */
														function loadAll() {
														  
														  return allStates.split(/, +/g).map( function (state) {
															return {
															  value: state.toLowerCase(),
															  display: state
															};// return
														  });// return allStates
														}// function loadAll
														
														
													
														/**
														 * Create filter function for a query string
														 */
														function createFilterFor(query) {
														  var lowercaseQuery = angular.lowercase(query);
													
														  return function filterFn(state) {
															  
															 // only match first letter 
															//return (state.value.indexOf(lowercaseQuery) === 0);
															
															// match any letter in middle
															return (state.value.indexOf(lowercaseQuery) !== -1);
														  };
													
														}// function createFilterFor
													 
												
												//  ===============End  md-autocomplete  sample 2 ===================== 
												

// -------------------------        End  shared  utility    --------------------------------------------------








                  $scope.RemoveTreeList = [
											{
												//'count':5,
												'location':'uuuuuuu',
												'note':'SHAMEL ASH',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'selectedItem':'aaaaaaaaaaaa'
												
												
											},
											{
												//'count':2,
												'location':'iiiiiiiiii',
												'note':'CAMPHOR TREE',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'selectedItem':'bbbbbbbbbbbbb'
											},
											{
												//'count':1,
												'location':'ppppppp',
												'note':'PECAN',
												//'selectedSpecie':{'originalObject': {'code': '', name: ''}},
												'selectedItem':'ccccccccccccc'
											}];




               $scope.OnSiteReplaceTreeList = [
											{
												//'count':'2',
												'location':'ppooppoioi',
												//'planting_date':'08/9/2017',
												'overhead_wire':'No',
												'note':'3333333333333333333333333',
												'selectedItem':'111111111111'
												
												//'init_specieSelected':{'code':'','name':'999877655'}
											},
											{
												//'count':'8',
												'location':'errertertrew',
												//'planting_date':'08/02/1996',
												'overhead_wire':'',
												'note':'ttttttttttttttttttttttt',
												'selectedItem':'2222222222'
												//'init_specieSelected':{'code':'','name':'gyhbyrvv'}
											},
											{
												//'count':'4',
												'location':'rtytrhrehtr',
												//'planting_date':'5/03/1995',
												'overhead_wire':'No',
												'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
												'selectedItem':'333333333333333'
												//'init_specieSelected':{'code':'','name':'90890890gjhgff'}
											}];
										

                      $scope.OffSiteReplaceTreeList = [
											
											{
												//'count':'4',
												'location':'rtytrhrehtr',
												//'planting_date':'5/03/1995',
												'overhead_wire':'No',
												'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
												'selectedItem':'0000000000'
												//'init_specieSelected':{'code':'','name':'90890890gjhgff'}
											}];



						  
						  


       // -----------  add remove button -------------

                     $scope.addNew = function(which_list){
							
							
									switch (which_list) {
										
										case 'remove_list':
											$scope.RemoveTreeList.push({ 
										        
										              
									                                   });
											
											break;
										case 'onsite_list':
											$scope.OnSiteReplaceTreeList.push({ 
																			  
										
									                                   });
											break;
										case 'offsite_list':
											$scope.OffSiteReplaceTreeList.push({ 
																			   
																			   
										
									                                   });
											break;
									
									}
									
									// after add new, go to page bottom.
									//window.scrollTo(0,document.body.scrollHeight);
									//document.body.scrollTop = document.body.scrollHeight;
									
						}; // addNew
						
						
						

					$scope.remove = function(_index, which_list){
							
							
							console.log(_index);
							console.log(which_list);
							
							var newDataList=[];
							
							
							
									switch (which_list) {
										
										case 'remove_list':
														newDataList = $scope.RemoveTreeList;
														newDataList.splice(_index, 1);
														$scope.RemoveTreeList = newDataList;
											break;
							
							
							            case 'onsite_list':
														newDataList = $scope.OnSiteReplaceTreeList;
														newDataList.splice(_index, 1);
														$scope.OnSiteReplaceTreeList = newDataList;
											break;
											
											
									    case 'offsite_list':
														newDataList = $scope.OffSiteReplaceTreeList;
														newDataList.splice(_index, 1);
														$scope.OffSiteReplaceTreeList = newDataList;
											break;		
							
							
							
									} //switch 
							
						};// remove function



          // -----------  End   -----  add remove button -------------


 




   



  });  // function - controller