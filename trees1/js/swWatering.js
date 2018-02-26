

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






function submitForm() {

//alert('submit clicked');


	$('#msg').hide();
	var errors = '';var cnt = 0;
	if (trim($('#sw_type').val()) == '')	{ cnt++; errors = errors + "- Program Type is required!<br>"; }
	if (trim($('#sw_pkg_no').val()) == '')	{ cnt++; errors = errors + "- Package Number is required!<br>"; }
	if (trim($('#sw_site_no').val()) == '')	{ cnt++; errors = errors + "- Site Numer is required!<br>"; }
	

	
	
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
		
		// goToSite(data,$('#sw_type'));
			goToSite(data);
		}
		
		
		
		
	  }
	});
	
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

function goToSite(sid) {
	location.replace(url + "forms/swTreeSiteEdit.cfm?sid=" + sid);
}


/*
$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
*/
