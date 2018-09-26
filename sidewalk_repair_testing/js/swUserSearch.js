



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
		                                    
											console.log(result)
											console.log(result.length)
											
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
													   console.log(result[i]);
													
													
											
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
				   
	
	
	
/*	

   // for some reason, & ajax call failed due to [data: ___query_param,]
	  
	$.ajax({
	  type: "POST",
	  url: ___url,
	  data: ___query_param,
	  success: function(data) { 
	  
	  
	  	data = jQuery.parseJSON(trim(data));
	  	
		console.log('data-:- ', data);
		
		var query = jQuery.parseJSON(data.QUERY);
		
		console.log('query- : - ', query);
		
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		
	*/	
		
		
		
	    
	    //$(".overlay").hide();	
				
	   
	/*
		
		var pg; var pn; var pcon; var pwo; var pid; var pfy;
		$.each(query.COLUMNS, function(i, item) {
			switch (item) {
			case "ID": pid = i; break;
			case "PACKAGE_NO": pn = i; break;
			case "PACKAGE_GROUP": pg = i; break;
			case "WORK_ORDER": pwo = i; break;
			case "CONTRACTOR": pcon = i; break;
			case "FISCAL_YEAR": pfy = i; break;
			}
		});
		
		//console.log(pn);
		//console.log(pg);
		//console.log(pwo);
		//console.log(pcon);
		
		data = data.DATA;
		
		var items = [];
		items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
		items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
		items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
		
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
			
				if (item[pg] == null) {item[pg] = "";}
				if (item[pn] == null) {item[pn] = "";}
				if (item[pwo] == null) {item[pwo] = "";}
				if (item[pcon] == null) {item[pcon] = "";}
				if (item[pfy] == null) {item[pfy] = "";} 
				if (item[pfy] != "") {item[pfy] = "20"+item[pfy];}
	
				items.push("<tr>");
				items.push("<td style='width:39px;height:20px;' class='small center frm'><a href='' onclick='goToPackage(" + item[pid] + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[pg] + "</td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[pn] + "</td>");
				items.push("<td style='width:159px;' class='small center frm'>" + item[pwo] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;' class='small frm'>" + item[pcon] + "</td>");
				items.push("<td style='width:64px;' class='small center frm'>" + item[pfy] + "</td>");
				items.push("</tr>");
			
			});
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
		changeHeight();
		
		
		
		
		
		
		
		
	  } // success 
	  
	  
	  
	  
	  
	  
	}); // ajax
	
	
	*/
	
	
} // function 









// document.ready  init entrance 
$(function() {
		   
	
		// init get all users
		
		var getUser_url = url + 'cfc/sw.cfc?method=get_user&returnformat=json&queryformat=struct';

        var getUser_by_fullname_para = {"full_name" : ""}
				
		
						
		ajax_get_data(getUser_url, getUser_by_fullname_para)
		
		
		
		
		
		
		
		
		
                // full name text input keyup event
				$("#user_full_name").keyup(function(){
													
					    var _user_full_name_val = $("#user_full_name").val()							
					    //console.log(_user_full_name_val)
					
						getUser_by_fullname_para = {"full_name" : _user_full_name_val}
						
						ajax_get_data(getUser_url, getUser_by_fullname_para)
					
					
					
				});// keyup
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
            // agency select change event
			$('#user_agency').on('change', 'select' ,function(){
											   
					console.log( 'user_agency ----- changed  ---:  ', this.value );					   
					
				   
				});
			
			
			
			// role select change event
			$('#user_role').on('change', 'select' ,function(){
											   
					console.log( 'user_role ----- changed  ---:  ', this.value );						   
					
				   
				});
			
			
			
			
			
			
			
			$("#add_new").click(function() {
										 
						
						console.log('add new user clicked')
						
						 
						});
			
			
			
			
			
			
			
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




