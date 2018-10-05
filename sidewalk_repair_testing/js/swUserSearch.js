



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
														items.push("<td style='width:59px;height:20px;' class='small center frm'><a onclick='removeUserId(" + result[i].ID + ");'><img src='../Images/rep.gif' width='13' height='16' alt='Remove User' title='Remove User' style='position:relative;top:-1px;   cursor:pointer;'></a></td>");
														
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
					
					
					
					
					$("#add_edit_user").text('Edit User')
					//  user id = -1 means empty all input, all blank for new
					
					
					populate_form_byUserID(_user_id)
					
					
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



// document.ready  init entrance 
$(function() {
		   
	
				
				getUser_url = url + 'cfc/sw.cfc?method=get_user&returnformat=json&queryformat=struct';
				
				
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
			
			
			
			
			
			
			
			
			
	// ++++++++++++++++++++++++++++++  add new user event +++++++++++++++++++++++++++++++++
			
			$("#add_new_user").click(function() {
							
							
							
							
							
						
					$("#search_listing").hide()
								
							
					$("#add_user").show()
					
					// show hide submit button
					$("#save_new_user_btn").show()
					$("#update_user_btn").hide()
					
					
					
					
					$("#add_edit_user").text('Add New User')
					//  user id = -1 means empty all input, all blank for new
					
					
					populate_form_byUserID(-1)
					
						
						 
			});
			
			
			
			
			
			
			$("#cancel_btn").click(function() {
										 
							
			console.log('cancel clicked')				
							
					$("#search_listing").show()
								
							
					$("#add_user").hide()
						
						 
			});
			
			
			
			
			
			
			
			$("#save_new_user_btn").click(async function() {
										 
							
							
						
						
	               // this is add new item and save new item to database 
					
					var _new_added_user = {}
					_new_added_user.full_name      = $("#add_user_full_name").val();
					_new_added_user.name           = $("#add_user_name").val();
					_new_added_user.password       = $("#add_user_password").val();
					_new_added_user.agency         = $("#add_user_agency").val();
					_new_added_user.role           = $("#add_user_role").val();
					
					console.log(_new_added_user);
					
		   
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
						
						 
			});
			
			
			
			
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




