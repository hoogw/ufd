 
 
  
  
  
  
  
  
       // +++++++++++++++++++++++++++++++++  angular  ++++++++++++++++++++++++++++++++
  
         var app = angular.module("myapp", ["ngTouch", "angucomplete-alt", '720kb.datepicker']);   
   				// var app = angular.module("myapp", ["ngTouch", "angucomplete-alt"]);
				 //var app = angular.module('app', ["angucomplete-alt"]);
	
	
	                       
	
	                     //--------------------    ListController3   -----------------------------------------
							app.controller("ListController3", ['$scope', function($scope) {
							$scope.personalDetails = [
								{
									'fname':'Muhammed',
									'lname':'Shanid',
									//'date':'4/5/1652',
									'email':'shanid@shanid.com'
								},
								{
									'fname':'John',
									'lname':'Abraham',
									//'date':'4/5/1652',
									'email':'john@john.com'
								},
								{
									'fname':'Roy',
									'lname':'Mathew',
									'date':'08/14/2017',
									'email':'roy@roy.com'
								}];
							
							
							$scope.name = 'vvvvvvvv';  
					  console.log($scope.name);
					 
					 console.log($scope.personalDetails);
					
							
							
							
								$scope.addNew = function(personalDetail){
									$scope.personalDetails.push({ 
										'fname': "", 
										'lname': "",
										'email': "",
									});
								};
							
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
									//alert('blank - will checked');
									$scope.selectedAll = false;
								} else {
									//alert('current checked -  going to uncheck');
									$scope.selectedAll = true;
								}
								angular.forEach($scope.personalDetails, function(value, key) {
													
									//alert($scope.selectedAll);				
													
									//personalDetail.selected = $scope.selectedAll;
								    value.selected = $scope.selectedAll;
									
									
								});
							};    
							
							
						}]);
	
	          //-------------------- End -------------    ListController3   -----------------------------------------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//--------------------    ListController   -----------------------------------------
	
	
	
				app.controller("ListController", ['$scope', function($scope) {
																	 
					$scope.personalDetails = [
						{
							'fname':'gggggg',
							'lname':'ggggggg',
							'date':'4/5/1652',
							'email':'shanid@shanid.com'
						},
						{
							'fname':'hhhhh',
							'lname':'hhhhhhhhhhh',
							'date':'4/5/1652',
							'email':'john@john.com'
						},
						{
							'fname':'qqqqqq',
							'lname':'qqqqqqqqqqqq',
							'date':'4/5/1652',
							'email':'roy@roy.com'
						}];
					
					
					$scope.tts = ["xxxxxx", "66666", "00000000000000"];
					
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
					  $scope.countrySelected = function(selected) {
							  if (selected) {
								window.alert('You have selected ' + selected.title);
							  } else {
								console.log('cleared');
							  }
							};
					*/		
					     
					  $scope.species = species_full_list;
					
					// -------------------------       End     --------------    angucomplete-alt auto complete      --------------------------------------------------
					
					
					
					
					
					
					
					
					
					
				}]);// app ListController
				
				
				//--------------------   End     ListController   -----------------------------------------
    
	
	
	              //********************************************    ListController2     ******************************************
				  
				  app.controller("ListController2", ['$scope', function($scope) {
																	 
					$scope.personalDetails = [
						{
							'fname':'o9',
							'lname':'o0',
							'date':'4/5/1652',
							'email':'shanid@shanid.com'
						},
						{
							'fname':'o8',
							'lname':'o8',
							'date':'4/5/1652',
							'email':'john@john.com'
						},
						{
							'fname':'o7',
							'lname':'o8',
							'date':'4/5/1652',
							'email':'roy@roy.com'
						}];
					
						$scope.addNew = function(personalDetail){
							$scope.personalDetails.push({ 
								'fname': "", 
								'lname': "",
								'email': "",
							});
						};
					
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
					  $scope.countrySelected = function(selected) {
							  if (selected) {
								window.alert('You have selected ' + selected.title);
							  } else {
								console.log('cleared');
							  }
							};
					*/		
					     
					  $scope.species = species_full_list;
					
					// -------------------------       End     --------------    angucomplete-alt auto complete      --------------------------------------------------
					
					
					
					
				}]);// app ListController2
	
	 //****************************         End          ****************    ListController2     ******************************************
	
	
	
	
	
	
	
	
	
	
	
	