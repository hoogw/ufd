



function ajax_get_data(___url, ___query_param) {
	
	//$(".overlay").show();
	
	
	  fetch(___url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(___query_param)
							// body: ___query_param
						  }
						).then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											//console.log(result)
											//console.log(result.length)
											
											// success
											
											   
											   
											   
											   
											   
											   
											   
											   
											   
											   
											
											//----  build data table  ------
											
																					
											var items = [];
											items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
											items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
											items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
											
											
											
											
											var arrayLength = result.length;
											if (arrayLength > 0)
											{
												  for (var i = 0; i < arrayLength; i++) 
												  {
													  // console.log(result[i]);
													
													
											
														items.push("<tr>");
														
														// Edit 
														items.push("<td style='width:59px;height:20px;' class='small center frm'><a onclick='editUserId("   + result[i].ID + ");'> <img src='../Images/rep.gif' width='13' height='16' alt='Edit User' title='Edit User' style='position:relative;top:-1px;   cursor:pointer;'> </a></td>");
														
														// Remove
														items.push("<td style='width:59px;height:20px;' class='small center frm'><a onclick='removeUserId(" + result[i].ID + ");'><img src='../Images/x.png' width='13' height='16' alt='Remove User' title='Remove User' style='position:relative;top:-1px;   cursor:pointer;'></a></td>");
														
														// Full name
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].FULL_NAME + "</td>");
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].NAME + "</td>");
													//	items.push("<td style='width:119px;' class='small center frm'>" + result[i].PASSWORD + "</td>");
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].AGENCY + "</td>");
														items.push("<td                      class='small center frm'>" + result[i].ROLE + "</td>");
														items.push("</tr>");
												
													}// for
											}
											else {
												items.push("<td style='height:20px;' class='small center frm'>No Records Found</td>");
											}
											
											items.push("</table>");
											items.push("</td></tr>");
											items.push("</table>");
											
											$("#ps_results").html(items.join(""));
											
											$("#ps_header").show();
											$("#ps_results").show();
											$("#ss_arrow").show();
											
											
											 // production uncomment, testing comment out
											changeHeight();
											
											
											  
										//---- end ----  build data table  ------	
											
											
											
										
											
											
		   
		                             })
                 
                 .catch((err)=>console.error(err))
				   
	
	
} // function  ajax  







function set_orderBy_para(___orderByColumnName){
	
											if (search_para.order_by == ___orderByColumnName){
												
												
													 if (search_para.asc_desc == 'asc'){
														 
														   search_para.asc_desc = 'desc'
														 
													 } else {
														 
														   search_para.asc_desc = 'asc'
													 }
												
												
												
											} else {
											
												search_para.order_by = ___orderByColumnName
												search_para.asc_desc = 'asc'
											}
	
	
	} //function set_order_by





function ajax_userById(_userID){
	
	
	
	var getUserByid_url = url + 'cfc/sw.cfc?method=get_user_byid&returnformat=json&queryformat=struct';
	var _query_param = {"user_id":_userID} 
	 
	 
	  fetch(getUserByid_url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(_query_param)
							// body: ___query_param
						  }
						).then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											console.log(result)
											//console.log(result.length)
											
											// success
											
		                                    $("#add_user_id").val(result[0].ID)
											$("#add_user_full_name").val(result[0].FULL_NAME)
											$("#add_user_name").val(result[0].NAME)
											
											// instead of show real password, here need to hide as dots.
											// by toggle input='password'  input='text'
											$("#add_user_password").val(result[0].PASSWORD)
											
											
											// remove selected attr
											console.log(result[0].AGENCY)
											
											
											
											
											//$('#add_user_agency option[value=result[0].AGENCY]').attr("selected", "selected");
											//$('#add_user_role  option[value=result[0].ROLE]').attr("selected", "selected");
		                                    var _select_agency = '#add_user_agency option[value="' + result[0].AGENCY+ '"]'
											var _select_role = '#add_user_role option[value="' + result[0].ROLE+ '"]'
											
											
											//console.log(_select_agency)
											//console.log(_select_role)
											
											//fix bug, failed when user click add new then click edit.
											//$(_select_agency).attr('selected', true);
											//$(_select_role).attr('selected', true);
											
											$(_select_agency).prop("selected", true);
											$(_select_role).prop("selected", true);
											
											
											
											console.log('result[0].CERT ---- ', result[0].CERT)
											// cert checkbox 
											if (result[0].CERT == 1){
											        
													
													
													  $('#add_user_certificate_checkbox').prop('checked', true);
											
											          console.log('result[0].CERT ---- checked ', result[0].CERT)
											
											} else {
											
											           $('#add_user_certificate_checkbox').prop('checked', false);
											
											           console.log('result[0].CERT ---- un--- checked ', result[0].CERT)
											}
											
											// if (($("#add_user_role").val() === 'BSS Power User') || ($("#add_user_role").val() === 'BSS User') || ($("#add_user_role").val() === 'Viewer'))
											if ((result[0].ROLE == 'BSS Power User') || (result[0].ROLE == 'BSS User') || (result[0].ROLE == 'Viewer'))
											{
												$("#certificate_th").show()
												$("#certificate_td").show()
											}
											
											
											//----------- end checkbox ---------------------
											
											
											
											
											
											
											
											
				
		                             })
                 
                 .catch((err)=>console.error(err))
				   
								   
	
	
	
	
}//ajax_userById





function populate_form_byUserID(_userID){
	
	if ( _userID < 0 ){
		// make all field blank
		
		$("#add_user_full_name").val('')
		$("#add_user_name").val('')
		$("#add_user_password").val('')
		
		// remove selected attr
		$('#add_user_agency option:selected').removeAttr('selected');
		$('#add_user_role option:selected').removeAttr('selected');
		//$('#add_user_certificate_checkbox').removeAttr("checked");
		$('#add_user_certificate_checkbox').prop('checked', false);
		
		
		
	} else {
		
		console.log('edit user id: --- ', _userID);
		ajax_userById(_userID);
		
	}// if
	
	
	
	
	
}//populate_form







function editUserId(_user_id) {
	
	<!--- joe hu  7/13/2018 ----- add progressing loading sign ------ (1) ---> 
	
	//$(".overlay").show();
	
	<!--- End ----joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	 
	
	
				
							
						
					$("#search_listing").hide()
								
							
					$("#add_user").show()
					
					// show hide submit button
					$("#save_new_user_btn").hide()
					$("#update_user_btn").show()
					// show reset password button
					$("#reset_password_btn_td").show()
					
					
					
					$("#certificate_th").hide()
					$("#certificate_td").hide()
					//$("#add_user_certificate_checkbox").removeAttr("checked");
					$('#add_user_certificate_checkbox').prop('checked', false);
					
					
					 // hide password
					  var x = document.getElementById("add_user_password");
					  x.type = "password";
							
					
					
					
					$("#add_edit_user").text('Edit User')
					//  user id = -1 means empty all input, all blank for new
					
					
					populate_form_byUserID(_user_id)
					
					
					
					// fix bug
					$("#login_exist_already").hide()
					$("#user_exist_already").hide()
					$("#all_field_required").hide()
					
}// editUserId




function confirmed_removeUserId(_user_id) {

    var removeUser_url = url + 'cfc/sw.cfc?method=remove_user&returnformat=json&queryformat=struct';
	var _query_param = {"user_id":_user_id} 
	 
	 
	  fetch(removeUser_url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(_query_param)
							// body: ___query_param
						  }
						).then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											console.log(result)
											//console.log(result.length)
											
											// success
											
											
											// init get all users
				                            ajax_get_data(getUser_url, search_para);
											
											
											
		                   })
                 
                 .catch((err)=>console.error(err))


}// 








function removeUserId(_user_id) {
	
	// popup dialog to confirm remove user.
	$('#msg2').show();
	
	
	// continue button clicked 
	$('#confirmed_removeUser_btn').click(function(){ confirmed_removeUserId(_user_id); });
				
}// removeUserId









var search_para =  {"full_name" : "", "agency":"", "role":"", "order_by":"", "asc_desc":""};

var getUser_url 
var checkUser_url


var check_para = {"full_name" : "", "name":""};


// document.ready  init entrance 
$(function() {
		   
	
				
				getUser_url    = url + 'cfc/sw.cfc?method=get_user&returnformat=json&queryformat=struct';
				checkUser_url  = url + 'cfc/sw.cfc?method=check_user&returnformat=json&queryformat=struct';
				
				// init get all users
				ajax_get_data(getUser_url, search_para);
		
		
		
		
		
		
		
		
		
		
		       	// ---------- search filter rule change event --------------------
			
		
		
								// full name text input keyup event
								$("#user_full_name").keyup(function(){
											
										search_para.full_name = this.value;
										
										search_para.order_by = ''
										search_para.asc_desc = ''
										 
										ajax_get_data(getUser_url, search_para);
									
								});// keyup
					
					
					
					
					
							// agency select change event
							$('#user_agency').on('change', 'select' ,function(){
															   
								  //console.log( 'user_agency ----- changed  ---:  ', this.value );	
								   
								   search_para.agency = this.value;
								   
								   search_para.order_by = ''
								   search_para.asc_desc = ''
								   
								  ajax_get_data(getUser_url, search_para);
								   
								});
							
							
							
							
							
							
							
							// role select change event
							$('#user_role').on('change', 'select' ,function(){
															   
								   //console.log( 'user_role ----- changed  ---:  ', this.value );						   
									
									search_para.role = this.value;
									
									search_para.order_by = ''
									search_para.asc_desc = ''
									
								   ajax_get_data(getUser_url, search_para);
									
									
								   
								});
							
							
							
							
							
							
							$("#clear_search_parameter").click(function() {
										
								//console.log('clear_search_parameter clicked')
										
								$("#user_full_name").val('');	
								
								
								// remove selected attr
								$('#user_agency option:selected').removeAttr('selected');
								
								$('#user_role option:selected').removeAttr('selected');
								
								
								
								
								search_para.full_name = ''
								search_para.agency = ''
								search_para.role = ''
								search_para.order_by = ''
								search_para.asc_desc = ''
								ajax_get_data(getUser_url, search_para);
										 
							});
							
			
			
			// --------- end ---------- search filter rule change event --------------------
			
			
			
			
			
			
			$("#add_user_agency").change(function(){
												
							$("#all_field_required").hide() 	
			
			});
			
			
			
			
			$("#add_user_role").change(function(){
												
							$("#all_field_required").hide() 					
					
						
						 if (($("#add_user_role").val() === 'BSS Power User') || ($("#add_user_role").val() === 'BSS User') || ($("#add_user_role").val() === 'Viewer'))
						{
						    					
						     $("#certificate_th").show()
					         $("#certificate_td").show()
						     $('#add_user_certificate_checkbox').prop('checked', false);
						
						} else {
							
							 $("#certificate_th").hide()
					         $("#certificate_td").hide()
							 $('#add_user_certificate_checkbox').prop('checked', false);
							 
						}
									   
										  
			});
			
			
			
			
			
			
			
			
			
			
			
	// ++++++++++++++++++++++++++++++  add new user event +++++++++++++++++++++++++++++++++
			
			$("#add_new_user").click(function() {
							
							
							
							
							
						
					$("#search_listing").hide()
								
							
					$("#add_user").show()
					
					// show hide submit button
					$("#save_new_user_btn").show()
					$("#update_user_btn").hide()
					// hide reset password button
					$("#reset_password_btn_td").hide()
					
					
					
					
					// only add new user, display show password, when edit user, password will not show.
					// show password
					  var p = document.getElementById("add_user_password");
							
						  p.type = "text";
							
					
					
					$("#certificate_th").hide()
					$("#certificate_td").hide()
					//$("#add_user_certificate_checkbox").removeAttr("checked");
					$('#add_user_certificate_checkbox').prop('checked', false);
					
					
					$("#add_edit_user").text('Add New User')
					//  user id = -1 means empty all input, all blank for new
					
					
					populate_form_byUserID(-1)
					
						
				    
					
					
					// fix bug
					$("#login_exist_already").hide()
					$("#user_exist_already").hide()
					$("#all_field_required").hide()
						
						
						 
			});
			
			
			
			
			
			
			$("#cancel_btn").click(function() {
										 
							
			console.log('cancel clicked')				
							
					$("#search_listing").show()
								
							
					$("#add_user").hide()
					
					
					
					
					$("#add_user_full_name").val('')
					
					$("#add_user_name").val('')
					
					$("#add_user_password").val('')
					
					
						
						 
			});
			
			
			
			
			
			// test checkbox
			$("#add_user_certificate_checkbox").change(function() {
																		// this will contain a reference to the checkbox   
																		if (this.checked) {
																			// the checkbox is now checked 
																			console.log('checked: ',$("#add_user_certificate_checkbox").prop('checked'))
																			
																			
																		} else {
																			// the checkbox is now no longer checked
																			
																			console.log('un-check: ',$("#add_user_certificate_checkbox").prop('checked'))
																			
																			
																		}
																	});
			
			
			
			
			
			
			$("#save_new_user_btn").click(async function() {
										 
							
							
					
						
						
						
						
						
						
	               // this is add new item and save new item to database 
					
					var _new_added_user = {}
					_new_added_user.full_name      = $("#add_user_full_name").val();
					_new_added_user.name           = $("#add_user_name").val();
					_new_added_user.password       = $("#add_user_password").val();
					_new_added_user.agency         = $("#add_user_agency").val();
					_new_added_user.role           = $("#add_user_role").val();
					
					// failed, always is 0, not sure why?
					// _new_added_user.certificate    = $("#add_user_certificate_checkbox").attr("checked")?1:0;
					
					if ($("#add_user_certificate_checkbox").prop('checked')) 
					{
																			// the checkbox is now checked 
																			
																			_new_added_user.certificate    = 1
																			
					} else {
																			// the checkbox is now no longer checked
																			
																			
																			_new_added_user.certificate    = 0
																			
					} // if
					
					
					
					console.log(_new_added_user);
					
					
					// all field are required. no empty field allowed.
			if ((_new_added_user.full_name == '') || (_new_added_user.name == '' ) || (_new_added_user.password == '') || (_new_added_user.agency == '') || (_new_added_user.role == '')){
						
			
			
			     $("#all_field_required").show()   
			
			
						
			}
			else {		
					
					 $("#all_field_required").hide()   
					
						   
								 // --- insert  database use fetch api, you can specify the method as post, delete, put ----
						   
									var insertUser_url = url + 'cfc/sw.cfc?method=insert_user&returnformat=json&queryformat=struct';
							
									console.log(insertUser_url )
											
								   
								   
								   fetch(insertUser_url, 
										  {
											 method: 'POST',
											 body:JSON.stringify(_new_added_user)
										  }
										)
										  .then(function (response) 
												   {
																	  
														 // if js error here, likely it is coldfusion server output error message instead of valid json 
														 // so check coldfusion server response.
														   return response.json()
														   
													})
													  
										   .then(function (result) {
															
															console.log(result)
															
															
															// init get all users
															ajax_get_data(getUser_url, search_para);
						   
													 })
								 
								 .catch((err)=>console.error(err))
								   
								   // -----   end     ---- fetch  -------------------------------------
								   
											
											
											
											
											
									$("#search_listing").show()
									$("#add_user").hide()
										
					
					
			 } // if
					
					
			}); //$("#save_new_user_btn").click(a
			
			
			
			
			
			
			
			
			// ...........................  check user if duplicate full name, 	..........................................
			
			var getInitials = function (string) {
													var names = string.split(' '),
														initials = names[0].substring(0, 1).toUpperCase();
													
													if (names.length > 1) {
														initials += names[names.length - 1].substring(0, 1).toUpperCase();
													}
													return initials;
												};
			
			
			var getFirstNameFirstLetter_LastName = function (string) {
													var names = string.split(' '),
														initials2 = names[0].substring(0, 1);
													
													if ((names[1] == undefined) || (names[1] == null)) {
														
														initials2 = names[0]
													                             
													} else {
														initials2 += names[1]
														}
													
													
													return initials2;
												};
			
			
			
			// password
			
			$("#add_user_password").keyup(async function(){
			
			                                                  $("#all_field_required").hide()
			
						
								});// keyup
			
			
			
			
			
			
			// full name text input keyup event
					$("#add_user_full_name").keyup(async function(){
											
											
											
											$("#all_field_required").hide()
											
											
											
											console.log(this.value)
										
										 var _calculated_loginName = getFirstNameFirstLetter_LastName(this.value)
										
										  console.log(getFirstNameFirstLetter_LastName(this.value));
										  
										  // login name , password, all lower case
										    _calculated_loginName = _calculated_loginName.toLowerCase();
										  
										  
										  $("#add_user_name").val(_calculated_loginName);
										
										  // add new user, default password is same as login name
										  $("#add_user_password").val(_calculated_loginName);
										
										
										
										
										
										
										
										
								// check full name 
										
								if (this.value.length > 0)
								{
									
										check_para.full_name = this.value;
										check_para.name = '';
										
										
													await fetch(checkUser_url, 
																  {
																	 method: 'POST',
																	 body:JSON.stringify(check_para)
																	// body: ___query_param
																  }
																).then(function (response) 
																		   {
																							  
																				 // if js error here, likely it is coldfusion server output error message instead of valid json 
																				 // so check coldfusion server response.
																				   return response.json()
																				   
																			})
																			  
																   .then(function (result) {
																				   
																				   // success
																					
																					console.log(result)
																					console.log(result.length)
																					
																	     // found duplicate name, exist full name
																	    if (result.length >0 ) {
																			
																		         // fail
																		        //  $(this).css("border", "5px solid red");
																		        
																		        $("#user_exist_already").show()
				                                                                $("#save_new_user_btn").hide()
																		
																		} else {
																			
																			     $("#user_exist_already").hide()
				                                                                $("#save_new_user_btn").show()
																			
																		}
																					
																					
																					
																					
																					
																			
															 })
										 
										 .catch((err)=>console.error(err))
										 
								}// if
										 
										 // End check full name 
										 
										 
										 
										 
										 
										 
										 
										 
										 // check login name 
								if (_calculated_loginName.length > 0)
								{
								
										check_para.full_name = '';
										check_para.name = _calculated_loginName;
										
										
													await fetch(checkUser_url, 
																  {
																	 method: 'POST',
																	 body:JSON.stringify(check_para)
																	// body: ___query_param
																  }
																).then(function (response) 
																		   {
																							  
																				 // if js error here, likely it is coldfusion server output error message instead of valid json 
																				 // so check coldfusion server response.
																				   return response.json()
																				   
																			})
																			  
																   .then(function (result) {
																				   
																				   // success
																					
																					console.log(result)
																					console.log(result.length)
																					
																	     // found duplicate name, exist full name
																	    if (result.length >0 ) {
																			
																		         // fail
																		        //  $(this).css("border", "5px solid red");
																		        
																		        $("#login_exist_already").show()
				                                                                $("#save_new_user_btn").hide()
																				// $("#edit_login_name_btn").show()
																				
																				
																		
																		} else {
																			
																			     $("#login_exist_already").hide()
				                                                                $("#save_new_user_btn").show()
																			//	$("#edit_login_name_btn").hide()
																			
																		}
																					
																					
																					
																					
																					
																			
															 })
										 
										 .catch((err)=>console.error(err))
										 
								}// if
										 // End check login name 
										 
				   		
																					
																					
																					
																					
											
								});// keyup
			
			
			
			
			
			
			
			                 
							 
							 
							 
							 	$("#add_user_name").keyup(async function(){
			
			
			                               $("#all_field_required").hide()
			
			
			                                            
							// check login name 
								if (this.value.length > 0)
								{	 
										check_para.full_name = '';
										check_para.name = this.value;
										
										
													await fetch(checkUser_url, 
																  {
																	 method: 'POST',
																	 body:JSON.stringify(check_para)
																	// body: ___query_param
																  }
																).then(function (response) 
																		   {
																							  
																				 // if js error here, likely it is coldfusion server output error message instead of valid json 
																				 // so check coldfusion server response.
																				   return response.json()
																				   
																			})
																			  
																   .then(function (result) {
																				   
																				   // success
																					
																					console.log(result)
																					console.log(result.length)
																					
																	     // found duplicate name, exist full name
																	    if (result.length >0 ) {
																			
																		         // fail
																		        //  $(this).css("border", "5px solid red");
																		        
																		        $("#login_exist_already").show()
				                                                                $("#save_new_user_btn").hide()
																				// $("#edit_login_name_btn").show()
																				
																				
																		
																		} else {
																			
																			     $("#login_exist_already").hide()
				                                                                $("#save_new_user_btn").show()
																				//$("#edit_login_name_btn").hide()
																			
																		}
																					
																					
																					
																					
																					
																			
															 })
										 
										 .catch((err)=>console.error(err))
										 
										 
								}// if
										 // End check login name 
			
			
			
			
			
			                              
			
			
			
			
			
			
			                               	
										// check full name 
								if ($("#add_user_full_name").val().length > 0)
								{		
										
										check_para.full_name = $("#add_user_full_name").val();
										check_para.name = '';
										
										
													await fetch(checkUser_url, 
																  {
																	 method: 'POST',
																	 body:JSON.stringify(check_para)
																	// body: ___query_param
																  }
																).then(function (response) 
																		   {
																							  
																				 // if js error here, likely it is coldfusion server output error message instead of valid json 
																				 // so check coldfusion server response.
																				   return response.json()
																				   
																			})
																			  
																   .then(function (result) {
																				   
																				   // success
																					
																					console.log(result)
																					console.log(result.length)
																					
																	     // found duplicate name, exist full name
																	    if (result.length >0 ) {
																			
																		         // fail
																		        //  $(this).css("border", "5px solid red");
																		        
																		        $("#user_exist_already").show()
				                                                                $("#save_new_user_btn").hide()
																		
																		} else {
																			
																			     $("#user_exist_already").hide()
				                                                                $("#save_new_user_btn").show()
																			
																		}
																					
																					
																					
																					
																					
																			
															 })
										 
										 .catch((err)=>console.error(err))
										 
								}// if
										 // End check full name 
			
			
			
			
			
			
			
			
			
			
																	
											
								});// keyup
			
			
			
			
			
								$("#edit_login_name_btn").click(function() {
												
										// click edit toggle disable, true, false		
										$('#add_user_name').prop('disabled', function(i, v) { return !v; });				 
							          // $("#add_user_name").prop("disabled", false); 
							
							
								});// edit 
			
			
			
			            // ............... end ...........................  check user if duplicate full name, 	..........................................
			
			
			
			
			// ++++++++++++++++++   end    +++++++++++++++++++++  add new user event +++++++++++++++++++++++++++++++++
			
			
			
			
			
			
			
			
			
			
			
			
				
			
	// ============================+  Edit update user event ============================+
			
			
			
			
			
			$("#update_user_btn").click(async function() {
										 
							
							
						
						
	               // this is update item and save  to database 
					
					var _edited_user = {}
					_edited_user.id             = $("#add_user_id").val();
					_edited_user.full_name      = $("#add_user_full_name").val();
					_edited_user.name           = $("#add_user_name").val();
					_edited_user.password       = $("#add_user_password").val();
					_edited_user.agency         = $("#add_user_agency").val();
					_edited_user.role           = $("#add_user_role").val();
					
					if ($("#add_user_certificate_checkbox").prop('checked')) 
					{
																			// the checkbox is now checked 
																			
																			_edited_user.certificate    = 1
																			
					} else {
																			// the checkbox is now no longer checked
																			
																			
																			_edited_user.certificate    = 0
																			
					} // if
					
					
					
					
					console.log(_edited_user);
					
		   
		         // --- insert  database use fetch api, you can specify the method as post, delete, put ----
		   
					var updateUser_url = url + 'cfc/sw.cfc?method=update_user&returnformat=json&queryformat=struct';
			
					console.log(updateUser_url )
							
				   
				   
				   fetch(updateUser_url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(_edited_user)
						  }
						)
						  .then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											console.log(result)
											
											
											
											// init get all users
				                            ajax_get_data(getUser_url, search_para);
		   
		                             })
                 
                 .catch((err)=>console.error(err))
				   
				   // -----   end     ---- fetch  -------------------------------------
				   
							
							
							
							
							
					$("#search_listing").show()
				    $("#add_user").hide()
					
						 
			});
			
			
			
			
			
			
			
			
			$("#reset_password_btn").click(async function() {
				
			          // show password
					  var x = document.getElementById("add_user_password");
							if (x.type === "password") {
								x.type = "text";
							} else {
								x.type = "password";
							}
					  
					  
					  
					  // reset password  = login name
					  var current_loginname = $("#add_user_name").val();
					  $("#add_user_password").val(current_loginname);
			
			
			
				});
			
			// ============================+    end  ============================+  Edit update user event ============================+
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			// ---------- data table header -------  click event ----------- sort asc desc --------------------
			
			
								$("#header_full_name").click(function() {
															 
											set_orderBy_para('full_name')
											
											ajax_get_data(getUser_url, search_para);
											
								});
			
			
			
			
			
			
			
			                    $("#header_name").click(function() {
																 
										set_orderBy_para('name')
										
										ajax_get_data(getUser_url, search_para);
										
							    });
			
			
			
			
			
			
			
			
			
			
			
			
                                 $("#header_password").click(function() {
																	  
										set_orderBy_para('password')
										
										ajax_get_data(getUser_url, search_para);
										
							    });			
			
			
			
			                     $("#header_agency").click(function() {
																	  
										set_orderBy_para('agency')
										
										ajax_get_data(getUser_url, search_para);
										
							    });		
								 
								 
								 
								 
								  $("#header_role").click(function() {
																	  
										set_orderBy_para('role')
										
										ajax_get_data(getUser_url, search_para);
										
							    });		
			
			
			                   
			
			
			
			
				// ---------- End   ---- data table header -------  click event ----------- sort asc desc --------------------
			
			
			
			
			
			
			
			
	});		// document ready 










var sort = {};


$(window).resize(function() {
	
	//  production uncomment, testing comment out
	changeHeight();
	
	
});







function changeHeight() {
	var ht = top.getIFrameHeight();
	var w = top.getIFrameWidth();
	ht = ht - 55;
	if ( $("#searchbox").is(":visible") ) { 
		ht = top.getIFrameHeight() - 243;
	}
	w = w - 14;
	$('#ps_results').height(ht);
	$('#ps_results').width(w);
	$('#ps_header').width(w);
	$('#fldFY').css('width',"82px");
	if ( $("#ps_results").height() > $("#tbl_results").height()) { $("#ps_results").height($("#tbl_results").height());  $('#fldFY').css('width',"65px");}
}

function sortTable(idx) {

	var dir = "ASC";
	if (idx == sort.id) {
		if(sort.dir == "ASC") { dir = "DESC"; } else { dir = "ASC"; }
	}

	switch (idx) {
	case 1: sort.id = idx; sort.dir = dir; sort.order = "package_group " + dir + ",package_no"; break;
	case 2: sort.id = idx; sort.dir = dir; sort.order = "package_no " + dir + ",package_group"; break;
	case 3: sort.id = idx; sort.dir = dir; sort.order = "work_order " + dir + ",package_group,package_no"; break;
	case 4: sort.id = idx; sort.dir = dir; sort.order = "contractor " + dir + ",package_group,package_no"; break;
	case 5: sort.id = idx; sort.dir = dir; sort.order = "fiscal_year " + dir + ",package_group,package_no"; break;
	default: sort.id = idx; sort.dir = "ASC"; sort.order = "";
	}
	submitForm();
}

function setForm() {
	if (typeof top.psearch.length != "undefined") {
		//console.log(top.psearch);
		$.each(top.psearch, function(i, item) {
			//console.log(item);
			$("#" + item.name ).val(item.value);
		});
		if (typeof top.psearch.sort != "undefined") {
			sort = top.psearch.sort;
		}
		submitForm();
	}
}







function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}





function toggleSearchBox() {
	if ( $("#searchbox").is(":visible") ) {
		$("#ss_arrow").css("top",'0px');
		$("#ss_arrow_img").css("top",'3px');
		$("#ss_arrow_img").attr("src",'../images/arrow_down.png');
		$("#ss_arrow_img").attr("title",'Show Search Filter Box');
	}
	else {
		$("#ss_arrow").css("top",'192px');
		$("#ss_arrow_img").css("top",'0px');
		$("#ss_arrow_img").attr("src",'../images/arrow_up.png');
		$("#ss_arrow_img").attr("title",'Hide Search Filter Box');
	}
	$( "#searchbox" ).toggle();
	changeHeight();
}




