

//-------------------------------------------------------
function program_type_change(){
	
	//var _program_type = $("#sw_type").val();
	//  sample <option value="2">BOE</option>
	var _program_type = $("#sw_type option:selected").text();
	
	
	
    // alert(_program_type);	
	
	
	if ((_program_type === 'REBATE') || (_program_type === '')) {
		
		
		//alert('Rebate program do not have package #');
		
		//clean and  disable package and site
		$('#sw_pkg_no').empty();
		$('#sw_site_no').empty();
		
		$('#sw_pkg_no').attr('disabled', 'disabled');
		$('#sw_site_no').attr('disabled', 'disabled');
		
		
	}
	
	
	else {
	          // foe BSS BOE fill the package #
				 $('#sw_pkg_no').empty();
				 $('#sw_site_no').empty();
				 
	             $('#sw_pkg_no').removeAttr('disabled');
		         $('#sw_site_no').attr('disabled', 'disabled');
	
	
					 //var querystring = "program_type="+program_type+"&package_no="+package_no;
					var querystring = "program_type="+_program_type;
					
					 
					 // with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
					 // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
					 
					 $.ajax({
					  type: "POST",
					 // url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_package_by_program_type&returnformat=json&queryformat=struct",
					   url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_package_by_program_type&returnformat=json",
					  data: querystring,
					  dataType: 'json', 
					  success: function(r_data,r,o) { 
					  
									 var options = r_data.DATA;
									 
									 $('#sw_pkg_no').empty();
									 $('#sw_pkg_no').append($('<option></option>'));  // default blank option
									 
									 $.each(options, function(i, p) {
									$('#sw_pkg_no').append($('<option></option>').val(p).html(p));
								});
					   
						
						
					  }  // success function
					});  // ajax
	
	
	
	}// else
	
}// function program_type_change


//-----------------------------------------------------------------



function package_no_change(){
	
	var _package_no = $("#sw_pkg_no").val();
	
     //alert(_package_no);	
	
	
	if  (_package_no === '') {
		
		
		
		$('#sw_site_no').empty();
		
		
		$('#sw_site_no').attr('disabled', 'disabled');
		
		
	}
	else 
	{
	
	    $('#sw_site_no').removeAttr('disabled');
	         
	
					 //var querystring = "program_type="+program_type+"&package_no="+package_no;
					var querystring = "package_no="+_package_no;
					
					 
					 // with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
					 // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
					 
					 $.ajax({
					  type: "POST",
					 // url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_package_by_program_type&returnformat=json&queryformat=struct",
					   url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_site_by_package&returnformat=json",
					  data: querystring,
					  dataType: 'json', 
					  success: function(r_data,r,o) { 
					  
									 var options = r_data.DATA;
									 $('#sw_site_no').empty();
									 $('#sw_site_no').append($('<option></option>'));  // default blank option
									 
									 $.each(options, function(i, p) {
									$('#sw_site_no').append($('<option></option>').val(p).html(p));
								});
					   
						
						
					  }  // success function
					});  // ajax
	
	}// else
	
	
	
}// function program_type_change

//==========================================================================================








function site_no_change(){
	
	var _site_no = $("#sw_site_no").val();
	
     //alert(_site_no);	
	
	
	if  (_site_no === '') {
		
		
		
		$('#sw_cd').empty();
		
		
		$('#sw_cd').attr('disabled', 'disabled');
		
		
	}
	else 
	{
	
	   // $('#sw_cd').removeAttr('disabled');
	         
	
					 //var querystring = "program_type="+program_type+"&site_no="+site_no;
					var querystring = "site_no="+_site_no;
					
					 
					 // with "queryformat=struct" will return:  [{"NAME":"ray","AGE":33},{"NAME":"todd","AGE":43},{"NAME":"scott","AGE":53}]
					 // without "queryformat=struct" will return default format : {"COLUMNS":["NAME","AGE"],"DATA":[["ray",33],["todd",43],["scott",53]]}
					 
					 $.ajax({
					  type: "POST",
					 // url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_site_by_program_type&returnformat=json&queryformat=struct",
					   url: "http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?method=get_cd_by_site&returnformat=json",
					  data: querystring,
					  dataType: 'json', 
					  success: function(r_data,r,o) { 
					  
									 var _cd = r_data.DATA;
									 console.log(_cd);
									 $('#sw_cd').val(_cd);
									 //
									   
									 
									 
								
						
						
					  }  // success function
					});  // ajax
	
	}// else
	
	
	
}// function program_type_change

//==========================================================================================







function submitForm() {

//alert('submit clicked');


	$('#msg').hide();
	var errors = '';var cnt = 0;
	
	
	if (trim($('#sw_crm').val()) == '')	
	{ 
	
	
	
								if (trim($('#sw_type').val()) == '')	{ cnt++; errors = errors + "- Program Type is required!<br>"; }
								if (trim($('#sw_pkg_no').val()) == '')	{ cnt++; errors = errors + "- Package Number is required!<br>"; }
								if (trim($('#sw_site_no').val()) == '')	{ cnt++; errors = errors + "- Site Numer is required!<br>"; }
								
								//if (trim($('#sw_crm').val()) == '')	{ cnt++; errors = errors + "- CRM Numer is required!<br>"; }
								//if (trim($('#sw_rebate').val()) == '')	{ cnt++; errors = errors + "- Rebate is required!<br>"; }
							
								
								
								//var chk = $.isNumeric(trim($('#sw_cd').val().replace(/,/g,""))); var chk2 = trim($('#sw_cd').val());
								//if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- CD must be numeric!<br>"; }
	
	
								if (errors != '') {
									showMsg(errors,cnt);		
									return false;	
								}
								
								
		
								
								
								
								var form_parameter = $('#form1').serializeArray();
								//var form_parameter = $('#form1').serialize();
							   
								
								$.ajax({
								  type: "POST",
								  url: url + "cfc/tree_service.cfc?method=addTreeSite&callback=",
								  data: form_parameter,
								  success: function(data) { 
									
									if(isNaN(data)) {
										
										showMsg(data,1);
										return false;	
										
									}
									else {
									
									
									//Go to details page
									
									 goToSite(data,$('#sw_type').val(),$('#sw_pkg_no').val(),$('#sw_site_no').val(),$('#sw_cd').val(),$('#sw_crm').val(), $('#sw_rebate').val() );
									//	goToSite(data);
									}
									
									
									
									
								  }
								}); // ajax
	
	
	
	
	}// if crm is empty
			
			else {
				 //   rebate do not have site number, package number, only  crm number, 
				 //$('#sw_type').val('-1');
				 
				 //$('#sw_pkg_no').removeAttr('disabled');
				 //$('#sw_pkg_no').val('-1');
				
				// $('#sw_site_no').removeAttr('disabled');
				// $('#sw_site_no').val('-1');
				
				
				
				
				var form_parameter = $('#form1').serializeArray();
								//var form_parameter = $('#form1').serialize();
							   
								
								$.ajax({
								  type: "POST",
								  url: url + "cfc/tree_service.cfc?method=addTreeSite_rebate&callback=",
								  data: form_parameter,
								  success: function(data) { 
									
									if(isNaN(data)) {
										
										showMsg(data,1);
										return false;	
										
									}
									else {
									
									
									//Go to details page
									
									 goToSite(data,$('#sw_type').val(),$('#sw_crm').val());
									
									}
									
									
									
									
								  }
								}); // ajax
	
				
				
				
				
				
				
				}// else crm not empty 
	
	
			
	
	
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

function goToSite(primary_key_id, type_id, package_no, sid, cd, crm_no, rebate) {
	location.replace(url + "forms/swTreeCreate.cfm?sid=" + sid + "&" + "primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&" + "package_no=" + package_no + "&" + "cd=" + cd + "&" + "crm_no=" + crm_no  + "&" + "rebate=" + rebate );
}


function goToSite2(primary_key_id, type_id, crm_no) {
	location.replace(url + "forms/swTreeCreate2.cfm?primary_key_id=" + primary_key_id + "&" + "type_id=" + type_id + "&"  + "crm_no=" + crm_no  );
}



/*
$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
*/
