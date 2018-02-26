





	
	
	// ------------------    angular -----------------------------------
	
	var app = angular.module("tree-app", ["ngTouch", "angucomplete-alt", '720kb.datepicker']);
	
	


       /*  ------------- utility tools ----------------- */
	   		
			
			//  .......  get today's date  .........
			//var _today = new Date();
			//var today_date = _today.toString();

    
	   /*  -------------  End ------- utility tools ----------------- */
	
	
	          //  ========== tree angular controller ================
	
	
	
						//........... remove tree ..............
						app.controller("RemoveTreeController", ['$scope', function($scope) {
																						 
										$scope.RemoveTreeList = [
											{
												'count':5,
												'location':'uuuuuuu',
												'note':'SHAMEL ASH'
												
											},
											{
												'count':2,
												'location':'iiiiiiiiii',
												'note':'CAMPHOR TREE'
											},
											{
												'count':1,
												'location':'ppppppp',
												'note':'PECAN'
											}];
										
										$scope.remove_total = $scope.RemoveTreeList.length;
										
										  //-------------  angular select option -------------
										  //species would not work, 
										  //$scope.specs = ["SHAMEL ASH", "CAMPHOR TREE", "PECAN"];
										  //-------------  End angular select option -------------
										
										
										
											$scope.addNew = function(RemoveTree){
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
												
															$scope.RemoveTreeList.push({ 
																'count': "", 
																'location': "",
																'note': "",
															});
															
															$scope.remove_total = $scope.RemoveTreeList.length;
												
												
													}// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
											};// addNew
										
										
										
										
										
										
											$scope.remove = function(){
												var newDataList=[];
												$scope.selectedAll = false;
												angular.forEach($scope.RemoveTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
												}); 
												$scope.RemoveTreeList = newDataList;
												
												$scope.remove_total = $scope.RemoveTreeList.length;
											};
										
										
										
										
										
												$scope.checkAll = function () {
													if (!$scope.selectedAll) {
														/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
															for angular 1.6.x, here should be 'false', 
														*/
														
														$scope.selectedAll = false;  
														
													} else {
														
														/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
															for angular 1.6.x, here should be 'true', 
														*/
														$scope.selectedAll = true;
													}
													angular.forEach($scope.RemoveTreeList, function(RemoveTree) {
														RemoveTree.selected = $scope.selectedAll;
													});
												};    
										
										
										
										   // -----------------------------   angucomplete-alt auto complete  --------------------------------------------------
					
													/*
													  $scope.specieSelected = function(selected) {
															  if (selected) {
																window.alert('You have selected ' + selected.title);
															  } else {
																console.log('cleared');
															  }
															};
													*/		
					     
											  $scope.species = species_full_list;
											
											// -------------------------       End     --------------    angucomplete-alt auto complete      --------------------------------------------------
											
										
										
										
										
										
										
									}]);// app controller
						
						//...........End  remove tree ..............
						
						
						
						//........... On Site Replace tree ..............
						app.controller("OnSiteReplaceTreeController", ['$scope', function($scope) {
																						 
										$scope.OnSiteReplaceTreeList = [
											{
												'count':'2',
												'location':'ppooppoioi',
												'note':'3333333333333333333333333'
											},
											{
												'count':'8',
												'location':'errertertrew',
												'note':'ttttttttttttttttttttttt'
											},
											{
												'count':'4',
												'location':'rtytrhrehtr',
												'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh'
											}];
										
										$scope.on_site_replace_tree_total = $scope.OnSiteReplaceTreeList.length;
										
										
										//$scope.sub_positions = sub_positions_full_list;
										$scope.overhead_wires =  overhead_wires_full_list;
										$scope.concrete_completeds =  concrete_completeds_full_list;
										$scope.post_inspecteds =  post_inspecteds_full_list;
										
										 $scope.species = species_full_list;
										
										
										
											$scope.addNew = function(OnSiteReplaceTree){
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
												
												
														$scope.OnSiteReplaceTreeList.push({ 
															'count': "", 
															'location': "",
															'note': "",
														});
														
														$scope.on_site_replace_tree_total = $scope.OnSiteReplaceTreeList.length;
												
												  }// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
												
											};
										
											$scope.remove = function(){
												var newDataList=[];
												$scope.selectedAll = false;
												angular.forEach($scope.OnSiteReplaceTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
												}); 
												$scope.OnSiteReplaceTreeList = newDataList;
												
												$scope.on_site_replace_tree_total = $scope.OnSiteReplaceTreeList.length;
												
											};
										
										
										
										$scope.checkAll = function () {
											if (!$scope.selectedAll) {
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
												    for angular 1.6.x, here should be 'false', 
												*/
												
												$scope.selectedAll = false;  
												
											} else {
												
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
												    for angular 1.6.x, here should be 'true', 
												*/
												$scope.selectedAll = true;
											}
											angular.forEach($scope.OnSiteReplaceTreeList, function(OnSiteReplaceTree) {
												OnSiteReplaceTree.selected = $scope.selectedAll;
											});
										};    
										
										
										
										
										
										
										
										
									}]);// app controller
						
						//...........End  OnSiteReplaceTree ..............
						
						
						
						//........... Off Site Replace tree ..............
						app.controller("OffSiteReplaceTreeController", ['$scope', function($scope) {
															
															
															
															
															
										$scope.OffSiteReplaceTreeList = [
											{
												'count':'7',
												'location':'5',
												
												'note':'hhhhhhhhhhhhhhhhhhhh'
											},
											{
												'count':'9',
												'location':'87987juy',
												'note':'uuuuuuuuuuuuuuuuuuuuuuuuuuuuu'
											},
											{
												'count':'8',
												'location':'56756u65tydghtd',
												'note':'5555555555555555555555555'
											}];
										
										
										$scope.off_site_replace_tree_total = $scope.OffSiteReplaceTreeList.length;
										
										
										// $scope.sub_positions = sub_positions_full_list;
										 $scope.overhead_wires =  overhead_wires_full_list;
										$scope.concrete_completeds =  concrete_completeds_full_list;
										$scope.post_inspecteds =  post_inspecteds_full_list;
										
										  $scope.species = species_full_list;
										  
										  
										  
										
										
										
										
										
											$scope.addNew = function(OffSiteReplaceTree){
												
												if($('#form7')[0].checkValidity())
													{
													
													
														// required field valid	
												
												
												         
														 
														
												
												
														$scope.OffSiteReplaceTreeList.push({ 
															'count': "", 
															'location': "",
															'note': "",
														});
														
														$scope.off_site_replace_tree_total = $scope.OffSiteReplaceTreeList.length;
												
												}// if validation is valid 
														else {
															
															// not valid, missing required field
															$('#submit_handle').click();
														}
												
												
											};
										
											$scope.remove = function(){
												var newDataList=[];
												$scope.selectedAll = false;
												angular.forEach($scope.OffSiteReplaceTreeList, function(selected){
													if(!selected.selected){
														newDataList.push(selected);
													}
												}); 
												$scope.OffSiteReplaceTreeList = newDataList;
												
												$scope.off_site_replace_tree_total = $scope.OffSiteReplaceTreeList.length;
											};
										
										$scope.checkAll = function () {
											if (!$scope.selectedAll) {
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'true', 
												    for angular 1.6.x, here should be 'false', 
												*/
												
												$scope.selectedAll = false;  
												
											} else {
												
												/* the order of execution of ng-click and ng-model is ambiguous, for verison angular 1.2.x, here should be 'false', 
												    for angular 1.6.x, here should be 'true', 
												*/
												$scope.selectedAll = true;
											}
											angular.forEach($scope.OffSiteReplaceTreeList, function(OffSiteReplaceTree) {
												OffSiteReplaceTree.selected = $scope.selectedAll;
											});
										};    
										
										
									}]);// app controller
						
						//...........End  OffSiteReplaceTree ..............
						
						
						
						
						
						
						
						
						
						
	
	
	//  ========== End tree angular controller ================
	
	
	
	
	
	
	
	
	// ------------------ END -----   angular -----------------------------------
	
	
	
	
	