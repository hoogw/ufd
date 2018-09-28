



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
														items.push("<td style='width:59px;height:20px;' class='small center frm'><a href='' onclick='goToPackage(" + "xxxxx" + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
														
														// Remove
														items.push("<td style='width:59px;height:20px;' class='small center frm'><a href='' onclick='goToPackage(" + "xxxxx" + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
														
														// Full name
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].FULL_NAME + "</td>");
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].NAME + "</td>");
														items.push("<td style='width:119px;' class='small center frm'>" + result[i].PASSWORD + "</td>");
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
			
			
			
			
			
			
			
			
			
			$("#add_new").click(function() {
										 
						
						console.log('add new user clicked')
						
						 
			});
			
			
			
			
			
			
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

function goToPackage(pid) {
	
	<!--- joe hu  7/13/2018 ----- add progressing loading sign ------ (1) ---> 
	
	$(".overlay").show();
	
	<!--- End ----joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	 
	
	location.replace(url + "forms/swPackageEdit.cfm?pid=" + pid);
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




