








//======================================  angular ================================================


var app = angular.module('app', ['ngAnimate', 'ngTouch', 'checklist-model']);
   
   

app.controller('ReportCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {
															
		
		
								 
			/*		all users 					 
 
					  $scope.roles = [
						(ID:1	,  TEXT: 'Nathan Neumann '},  
						(ID:2	,  TEXT: 'Mike Vesleno'},
						(ID:3	,  TEXT: 'Robert Shinmei '},
						(ID:4	,  TEXT: 'Alice Kim'},
						(ID:5	,  TEXT: 'Joseba Maruri'},
						(ID:6	,  TEXT: 'Scott Bacsikin'},
						(ID:7	,  TEXT: 'Carl Nelson'},
						(ID:8	,  TEXT: 'YooBin Kim'},
						(ID:9	,  TEXT: 'Allan Suan'},
						(ID:10	,  TEXT: 'Kamyar Amjadi'},
						(ID:11	,  TEXT: 'Cindy Wei'},
						(ID:12	,  TEXT: 'Kim Schulz'},
						
		 		
						(ID:13	,TEXT: 'Cameron Amjadi'},
						(ID:14	,TEXT: 'Ryan Ghalehshahi'},
						(ID:15	,TEXT: 'Dominick Esposito'},
						(ID:16	,TEXT: 'Ronneil Johnson'},
						(ID:17	,TEXT: 'Carter Cox'},
						(ID:18	,TEXT: 'Tom Spiker'},
						(ID:19	,TEXT: 'Tobias Wolf'},
						(ID:20	,TEXT: 'Fatima Robinson'},
						(ID:21	,TEXT: 'Kelly Chan'},
						(ID:22	,TEXT: 'BSS'},
						(ID:23	,TEXT: 'Joanne Zhang'},
						(ID:24	,TEXT: 'Alfred Mata'},
						(ID:25	,TEXT: 'Steve Chen'},
						(ID:26	,TEXT: 'Staci Sosa'},
						(ID:27	,TEXT: 'Jennifer Pope'},
						(ID:28	,TEXT: 'Amber Elton'},
						(ID:29	,TEXT: 'Bill Candlish'},
						(ID:30	,TEXT: 'Timothy Tyson'},
						(ID:31	,TEXT: 'David Miranda'},
						(ID:32	,TEXT: 'Luis Torres'},
						(ID:33	,TEXT: 'Firouzeh Shariaty'},
						(ID:34	,TEXT: 'Consultant'},
						(ID:35	,TEXT: 'Jane Parathara'},
						(ID:36	,TEXT: 'Matt Masuda'},
						(ID:37	,TEXT: 'Gene Edwards'},
						(ID:38	,TEXT: 'Tony Barranti'},
						(ID:39	,TEXT: 'Brett McReynolds'},
						(ID:40	,TEXT: 'Maricel El-Amin'},
						(ID:41	,TEXT: 'April Barry'},
						(ID:42	,TEXT: 'John Duran'},
						(ID:43	,TEXT: 'Ana Landaverde'},
						(ID:44	,TEXT: 'Jerry Caropino'},
						(ID:45	,TEXT: 'Laura Roberts'},
						(ID:46	,TEXT: 'Nick Lopez'},
						(ID:47	,TEXT: 'Angela Kaufman'},
						(ID:48	,TEXT: 'Steven Anderson'},
						(ID:49	,TEXT: 'Anonymous'},
						(ID:50	,TEXT: 'Victor Murillo'},
						(ID:51	,TEXT: 'Eric Taguchi'},
						(ID:52	,TEXT: 'Saudia McKnight'},
						(ID:53	,TEXT: 'Patrick Singleton'},
						(ID:54	,TEXT: 'Ciu Sanchez'},
						(ID:55	,TEXT: 'Jeannie Park'},
						(ID:56	,TEXT: 'Michelle Chow'},
						(ID:57	,TEXT: 'Gilbert Zermeno'},
						(ID:58	,TEXT: 'Ted Allen'},
						(ID:59	,TEXT: 'Catherine Garcia'},
						(ID:60	,TEXT: 'Patricia Zavala'},
						(ID:61	,TEXT: 'Nat Baca'},
						(ID:62	,TEXT: 'Loujuana Mitchell'},
						(ID:63	,TEXT: 'Juan Acosta'},
						(ID:64	,TEXT: 'Julie Sauter'},
						(ID:65	,TEXT: 'Gary Lee Moore'},
						(ID:66	,TEXT: 'Glen Hoke'},
						(ID:67	,TEXT: 'Eduardo Hernandez'},
						(ID:68	,TEXT: 'Markos Legesse'},
						(ID:69	,TEXT: 'Pat Shortall'},
						(ID:70	,TEXT: 'Will Steglau'},
						(ID:71	,TEXT: 'Carlos Cueva'},
						(ID:72	,TEXT: 'Yalin Tam'},
						(ID:73	,TEXT: 'Lloyd Matzkin'},
						(ID:74	,TEXT: 'Reza Shahmirzadi'},
						(ID:75	,TEXT: 'Jerry Diego'},
						(ID:76	,TEXT: 'Essam Amarragy'},
						(ID:77	,TEXT: 'Ron Lorenzen'},
						(ID:78	,TEXT: 'Gregg Vandergriff'},
						(ID:79	,TEXT: 'Paul Smith'},
						(ID:80	,TEXT: 'Kirk Bishop'},
						(ID:81	,TEXT:'Jason Valencia'},
						(ID:82	,TEXT:'Arsen Voskerchyan'},
						(ID:83	,TEXT:'Elizabeth Skrzat'},
						(ID:84	,TEXT:'Rachel OLeary'},
						(ID:85	,TEXT:'Elizabeth Jauregui'},
						(ID:86	,TEXT:'Aaron Ruiz'},
						(ID:87	,TEXT:'David Vargas'},
						(ID:88	,TEXT:'Joe Hu'},
						(ID:89	,TEXT:'Annie Dover'}
						
					 	
						
					  ];
				*/	 
		
		
		// https://github.com/vitalets/checklist-model
				
				   //  ===========================   default init setting  ====================
					 
					 //$http.get('/someUrl', config).then(successCallback, errorCallback);
					  $scope.url_get_user = url + "cfc/watering_service.cfc?method=get_user&returnformat=json&queryformat=struct",
					
					  $http.get($scope.url_get_user)
									.then(function(response) {
												   
										$scope.roles = response.data;
										
										console.log(response.data);
										
										
										 
					  
												$scope.user = {
												roles: []
											  };
											  
											  
											 
											  
											   $scope.checkboxModel = {
														   value1 : true,
														  // value2 : 'YES'
														 };
											   $scope.selectAll = true;
											  
											  $scope.check_uncheck_lable = 'Uncheck All';
											  
											  
											  
											  // default init check all 
											  // pick id only
											 // $scope.user.roles = $scope.roles.map(function(item) { return item.ID; });
											  // pick object
											    $scope.user.roles = angular.copy($scope.roles);
											  
											
										
										
										
										
									});
					  
					  
					   //  ===========  End ==========   default init setting  ====================
										
					  
					  
					  
					  
					
					 
					  
					   
					  $scope.check_uncheck_clicked =  function() {
						  
						  if ($scope.selectAll) {
							
							// uncheck all
							
							$scope.user.roles = [];
							$scope.selectAll = false;
							$scope.check_uncheck_lable = 'Check All';
						  }
						  else {
							  
							  // check all
							  
							  // pick id only
							 //$scope.user.roles = $scope.roles.map(function(item) { return item.ID; });
							 // pick object
							 $scope.user.roles = angular.copy($scope.roles);
							 
							 $scope.selectAll = true;
							 $scope.check_uncheck_lable = 'Uncheck All';
							 
						  }
						  
					  };
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  // ----------  supervisor report clicked...........................
					  
					  $scope.get_supervisor_report = function() {
						  
						  
														
													  
													  
													  
													  
													  var post_data = {
														                 selected_users : 		$scope.user.roles,
																		 date: $('#report_date_supervisor').datepicker({ dateFormat: 'mm/dd/yyyy' }).val()
																      };
													
													console.log(url);
													console.log(post_data);   
															   
											
												       var req = {
																		method : "POST",
																		
																		headers: {
																						'Content-type': 'application/json',
																						'Accept': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
																					},
																		
																							
																		//$http.get('/someUrl', config).then(successCallback, errorCallback);
														                //href = ../reports/Watering_Excel.cfm?report_date=#dateFormat(Now(),"mm/dd/yyyy"
													                    url : url + "reports/Watering_Excel.cfm",
													                   // url : url + "cfc/watering_service.cfc?method=get_user&returnformat=json&queryformat=struct",
																									
																		data: post_data
																   };
													
													 $http(req).then(function(response) {
																				   
																		console.log('excel success');
																		
																		var blob = new Blob([response], {
																				type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
																			});
																			saveAs(blob, 'File_Name_With_Some_Unique_Id_Time' + '.xlsx');
																		
																	});
														
														
														
														
														
													};
					  
					   // ----------  End --------  superviser report clicked...........................
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					   // ----------  current_user report clicked...........................
					   
					  
					   
					  
					  $scope.get_current_user_report = function() {
						  
						                     
						                          console.log(url + "reports/Watering_Excel.cfm");
												$location.url(url + "reports/Watering_Excel.cfm");		
													  
											     		  
													  
													  /*
													  
													  var post_data = {
														                 selected_users : {ID:_current_user_id, TEXT:'Current_User'},
																		 date: $('#report_date_current_user').datepicker({ dateFormat: 'mm/dd/yyyy' }).val()
																      };
															   
													console.log(post_data);   
															   
											
												       var req = {
																		method : "POST",
																		//method : "GET",								
																		//$http.get('/someUrl', config).then(successCallback, errorCallback);
														                //href = ../reports/Watering_Excel.cfm?report_date=#dateFormat(Now(),"mm/dd/yyyy"
													                    url : url + "reports/Watering_Excel.cfm",
													                   // url : url + "cfc/watering_service.cfc?method=get_user&returnformat=json&queryformat=struct",
																									
																		data: post_data
																								};
													
													 $http(req).then(function(response) {
																				   
																		console.log('excel success');
																		
																		
																		
																	});
														
														*/
														
														
														
													}; // function
					  
					   // ----------  End --------  current_user report clicked...........................
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					 
  
  
				}]);  // app controller


// ***************************  End **************  angular  *************************




