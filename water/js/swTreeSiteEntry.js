





//----------------------  angular --------------------------




var app = angular.module('app', []);

app.controller('siteController', ['$scope', '$http',function($scope, $http) {
    
	
		//++++++++++ init variable +++++++++++
		var cd_options_full_list = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'];
		
		
			$scope.program_type = {};
			$scope.programType_options ={};
			$scope.package_no ={};
			$scope.package_no_options ={};
			$scope.site_no ={};
			$scope.site_no_options ={};
			$scope.cd ='';
			$scope.cd_options = cd_options_full_list;
			
			$scope.crm ='';
			$scope.rebate = '';
		
		
		
		    $scope.programType_disable = false;
		    $scope.pakageNo_disable = true;
		    $scope.siteNo_disable = true;
		    $scope.cd_disable = true;
			$scope.rebate_disable = true;
			$scope.crm_disable = true;
			
			
			
			
			
			
		//++++++++++ init variable +++++++++++
	
	
	
	
	
				
				
				
				
				
										// ============  get program type  =================
											  var req = {
													method : "POST",
													
													// with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
											        // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
													
													url : url + "cfc/tree_service.cfc?method=get_program_type&returnformat=json&queryformat=struct",
													headers: {'Content-Type': 'application/x-www-form-urlencoded'}   // for angular http post, you must add this line make it form data
													
												};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															/*
															 sample response without "queryformat=struct"   at end of URL
															            {"COLUMNS":["PACKAGE_NO"],"DATA":[[1],[2],[3],[4]]}	
															 sample response with "queryformat=struct" at end of URL
															               [{"PACKAGE_NO":1},{"PACKAGE_NO":2},{"PACKAGE_NO":3},{"PACKAGE_NO":4}]
															*/
															 $scope.programType_options = _response.data;
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
															 
															 								  
													}); // http then
													
													/*
													 $scope.programType_options = [
																				   {type:'BSS'},
																				   {type:'BOE'},
																				   {type:'REBATE'}
																				  
																			];
													 */
				
				                       // ============   End ======  get program type  =================
				
				
				
				
	
	
	
	
   
    
	
	
	
	//******************  program_type_change **************************
	
        $scope.program_type_change = function() {
        
		console.log($scope.program_type.TYPE);
		
		                        var _program_type = $scope.program_type.TYPE;
		                   
							
							if ((_program_type == 'REBATE')) {
								
								
								//alert('Rebate program do not have package #');
								
								//clean and  disable package and site
								$scope.package_no ={};
								$scope.package_no_options ={};
								$scope.site_no ={};
								$scope.site_no_options ={};
								$scope.cd ='';
								$scope.rebate ='';
								$scope.crm ='';
								
								 	$scope.pakageNo_disable = true;
									$scope.siteNo_disable = true;
									$scope.cd_disable = false;
									$scope.rebate_disable = false;
									$scope.crm_disable = false;
								
								
							}
							
							
							else {
									  // foe BSS BOE fill the package #
									  	$scope.package_no ={};
										$scope.package_no_options ={};
										$scope.site_no ={};
										$scope.site_no_options ={};
										$scope.cd ='';
										
										$scope.rebate ='';
										$scope.crm ='';
								
								 	$scope.pakageNo_disable = false;
									$scope.siteNo_disable = true;
									$scope.cd_disable = true;
									$scope.rebate_disable = true;
									$scope.crm_disable = true;
									  
									 
							
											 //var querystring = "program_type="+program_type+"&package_no="+package_no;
											var querystring = "program_type="+ _program_type;
											
											// console.log($scope.program_type.type);
											 
											
											 
											  var req = {
													method : "POST",
													
													// with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
											        // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
													
													url : url + "cfc/tree_service.cfc?method=get_package_by_program_type&returnformat=json&queryformat=struct",
													headers: {'Content-Type': 'application/x-www-form-urlencoded'},   // for angular http post, you must add this line make it form data
													data: querystring
												};
						
						
						
													$http(req).then(
																	
														function Success(_response) 
														{
															
															/*
															 sample response without "queryformat=struct"   at end of URL
															            {"COLUMNS":["PACKAGE_NO"],"DATA":[[1],[2],[3],[4]]}	
															 sample response with "queryformat=struct" at end of URL
															               [{"PACKAGE_NO":1},{"PACKAGE_NO":2},{"PACKAGE_NO":3},{"PACKAGE_NO":4}]
															*/
															
															 $scope.package_no_options = _response.data;
														}, function Error(_response) {
															// called asynchronously if an error occurs or server returns response with an error status.
															 
															 showMsg(_response,1,"Tree");
																					  
													}); // http then
							               }// else
											  
											  
                                       };// program type change
	
	                        //******************  End  *************   program_type_change **************************
	
	
	
	
	
	
	
	                     //******************  package_no_change **************************
	
                             $scope.package_no_change = function() {
	                                     
										 var _package_no = $scope.package_no.PACKAGE_NO;
	
												console.log(_package_no);
												
												
														 
														 
															$scope.site_no ={};
															$scope.site_no_options ={};
															$scope.cd ='';
															$scope.rebate ='';
															$scope.crm ='';
													
														$scope.pakageNo_disable = false;
														$scope.siteNo_disable = false;
														$scope.cd_disable = true;
														$scope.rebate_disable = true;
														$scope.crm_disable = true;
														 
									
									
												
																 //var querystring = "program_type="+program_type+"&package_no="+package_no;
																var querystring = "package_no="+_package_no;
																
																 
																 // with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
																 // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
																 
																 
																 
																 var req = {
																			method : "POST",
																			
																			// with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
																			// without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
																			
																			url : url + "cfc/tree_service.cfc?method=get_site_by_package&returnformat=json&queryformat=struct",
																			headers: {'Content-Type': 'application/x-www-form-urlencoded'},   // for angular http post, you must add this line make it form data
																			data: querystring
																		};
												
												
												
																			$http(req).then(
																							
																				function Success(_response) 
																				{
																					
																					/*
																					 sample response without "queryformat=struct"   at end of URL
																								{"COLUMNS":["PACKAGE_NO"],"DATA":[[1],[2],[3],[4]]}	
																					 sample response with "queryformat=struct" at end of URL
																								   [{"PACKAGE_NO":1},{"PACKAGE_NO":2},{"PACKAGE_NO":3},{"PACKAGE_NO":4}]
																					*/
																					
																					 $scope.site_no_options = _response.data;
																				}, function Error(_response) {
																					// called asynchronously if an error occurs or server returns response with an error status.
																					 
																					 showMsg(_response,1,"Tree");
																											  
																			}); // http then
																 
												
											
	
	
	
	
	                                   };// package_no_change
	
	                       //******************    End  package_no_change **************************
	
	
	
	
	
	
	                  //******************   site_no_change **************************
	
	                          $scope.site_no_change = function() {
	
	                                        
											var _site_no = $scope.site_no.LOCATION_NO;
	
											console.log(_site_no);
											
													
													
													$scope.cd ='';
													$scope.rebate ='';
													$scope.crm ='';
											
												$scope.pakageNo_disable = false;
												$scope.siteNo_disable = false;
												$scope.cd_disable = true;
												$scope.rebate_disable = true;
												$scope.crm_disable = true;
											
										
									
													 
											
															 //var querystring = "program_type="+program_type+"&site_no="+site_no;
															var querystring = "site_no="+_site_no;
															
															 
															 // with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
															 // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
															 
															  var req = {
																			method : "POST",
																			
																			// with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
																			// without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
																			
																			url : url + "cfc/tree_service.cfc?method=get_cd_by_site&returnformat=json&queryformat=struct",
																			headers: {'Content-Type': 'application/x-www-form-urlencoded'},   // for angular http post, you must add this line make it form data
																			data: querystring
																		};
												
												
												
																			$http(req).then(
																							
																				function Success(_response) 
																				{
																					
																					/*
																					 sample response without "queryformat=struct"   at end of URL
																								{"COLUMNS":["PACKAGE_NO"],"DATA":[[1],[2],[3],[4]]}	
																					 sample response with "queryformat=struct" at end of URL
																								   [{"PACKAGE_NO":1},{"PACKAGE_NO":2},{"PACKAGE_NO":3},{"PACKAGE_NO":4}]
																					*/
																					
																					console.log(_response.data);
																					
																					var _council_district = _response.data
																					
																					  // if cd is text
																					 //$scope.cd = _council_district[0].COUNCIL_DISTRICT;
																					 
																					 // if cd is select dropdown
																					  $scope.cd =$scope.cd_options[ _council_district[0].COUNCIL_DISTRICT-1];
																					 
																					 
																				}, function Error(_response) {
																					// called asynchronously if an error occurs or server returns response with an error status.
																					 
																					 showMsg(_response,1,"Tree");
																											  
																			}); // http then
															 
											
																
																	
											};// site_no_change
							
											//******************    End  site_no_change **************************
	
	
	
	
	
	
	
	
	                                  // ***********************  submit form *************************
	
	
	                                        $scope.submitForm = function() {


                                                     var _program_type = 0;
													var _package_no = 0;
													var _site_no = 0;
													var _cd = 0;
													
											    	var _rebate = '';
													var _crm = '';


                                                    $('#msg').hide();
														var errors = '';var cnt = 0;

                                                   console.log(trim($('#sw_type').val()));

                                                  // if (trim($('#sw_type').val()) == '?'){
													   
													 if ( $scope.program_type.TYPE == undefined) {
													   
																	// no type select, can't submit.
																		cnt++; errors = errors + "- Program Type is required!<br>"; 
																		 
																									
																									
																									
																									
												   }// if 
													else if ($scope.program_type.TYPE == 'REBATE'){
														
														     
														
														                         if ( $scope.cd == '')	
																				   { 
																				       cnt++; errors = errors + "- CD is required!<br>"; 
																					   }
																					   else if (isNaN($scope.cd)) { cnt++; errors = errors + "- CD must be a number !<br>"; }
																					   
																					   
																				          else if ($scope.crm == '')	{ cnt++; errors = errors + "- CRM is required!<br>"; }
																					
																					           else {
																											  _program_type = $scope.program_type.ID;
																											 _package_no = 0;
																											 _site_no = 0;
																											 _cd = $scope.cd;
																											_rebate = $scope.rebate;
																											 _crm = $scope.crm;
																							   }
														
														
													}
													
													else {
														
														
																					if ( $scope.program_type.TYPE === undefined)	{ cnt++; errors = errors + "- Program Type is required!<br>"; }
																					 else if ( $scope.package_no.PACKAGE_NO === undefined)	{ cnt++; errors = errors + "- Package Number is required!<br>"; }
																					  else if ( $scope.site_no.LOCATION_NO === undefined)	{ cnt++; errors = errors + "- Site Numer is required!<br>"; }
																					    else {
																								 _program_type = $scope.program_type.ID;
																								 _package_no = $scope.package_no.PACKAGE_NO;
																								 _site_no = $scope.site_no.LOCATION_NO;
																								 _cd = $scope.cd;
																								
																								 _rebate = '';
																								 _crm ='';
																						}
														
														
														
													}// else if
														 
														 
														 
														 // display error 
														                                       if (errors != '') {
																										showMsg(errors,cnt);		
																										return false;	
																									}
														 
														 
														 

													
													
												
													console.log("submit *** ", _rebate, " ** ",_crm , " ---- ", _program_type, " --- ",_package_no, " --- ",_site_no, " --- ",_cd); 
													
													
													
													
													
													
														
														
														
														
														
															
																				
																		
																		var  querystring = 
																						 "sw_type="   +  _program_type  + "&" +
																						 "sw_pkg_no=" +  _package_no    + "&" +
																						 "sw_site_no="+  _site_no       + "&" +
																						 "sw_cd="     + _cd             + "&" +
																						 "sw_rebate=" +  _rebate         + "&" +
																						 "sw_crm="    +  _crm
																						 
																					 ;	
																		
																				
																	console.log(querystring);			
																				
																				
																//  **************  start post  *******************	
																			
															           var req = {
																			method : "POST",
																			
																			// with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
																			// without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
																			
																			url : url + "cfc/tree_service.cfc?method=addTreeSite&returnformat=json&queryformat=struct",
																			headers: {'Content-Type': 'application/x-www-form-urlencoded'},   // for angular http post, you must add this line make it form data
																			data: querystring
																		};
												
												
												
																			$http(req).then(
																							
																				function Success(_response) 
																				{
																					
																					console.log(_response.data);
																					
																					_pk_id = _response.data;
																					
																					_pk_id = _pk_id.replace(/\s/g, '');  // must remove space in string
																					
																					if(isNaN(_pk_id)) {
																							
																							showMsg(_pk_id,1);
																							return false;	
																							
																						}
																						else {
																						
																						
																						//Go to details page
																						
																						 goToSite(_pk_id,_program_type,_package_no,_site_no,_cd,_crm, _rebate );
																						//	goToSite(data);
																						}
																					 
																				}, function Error(_response) {
																					// called asynchronously if an error occurs or server returns response with an error status.
																					 
																					 showMsg(_response,1,"Tree");
																											  
																			}); // http then
																				   
																			//  ************** End post  *******************				
																					
																				
														
														
														
														
														
														
														
														
														
														
														
														
												
	
											};// ***************  END   ********  submit form *************************
	
	
	
	
	
	
	
	

}]);   //app.controller('siteController













//----------------------  End ------  angular --------------------------








function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function goToSite(primary_key_id, type_id, package_no, sid, cd, crm_no, rebate) {
	
	// without watering 
	location.replace(url + "forms/swTreeCreate.cfm?sid=" + sid + "&" + "primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&" + "package_no=" + package_no + "&" + "cd=" + cd + "&" + "crm_no=" + crm_no  + "&" + "rebate=" + rebate );
	
	//location.assign(url + "forms/swTreeCreate.cfm?sid=" + sid + "&" + "primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&" + "package_no=" + package_no + "&" + "cd=" + cd + "&" + "crm_no=" + crm_no  + "&" + "rebate=" + rebate );
	
	/*
	// with watering
	location.replace(url + "forms/swTreeCreate_watering.cfm?sid=" + sid + "&" + "primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&" + "package_no=" + package_no + "&" + "cd=" + cd + "&" + "crm_no=" + crm_no  + "&" + "rebate=" + rebate );
	*/
}

