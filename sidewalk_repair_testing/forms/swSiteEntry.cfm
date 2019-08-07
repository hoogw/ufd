<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level is 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
<cfif session.user_power lt 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Create New Sidewalk Repair Site</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Site Number + 1 --->
<cfquery name="getID" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(location_no) as id FROM tblSites
</cfquery>
<cfset swid = getID.id + 1>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType  Where (Deleted IS NULL) ORDER BY type
</cfquery>


<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<cfset dt = dateFormat(Now(),"mm/dd/yyyy")>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<div id="box" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Create New Sidewalk Repair Site</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:700px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:527px;">Create New Sidewalk Repair Site:</th>
						<th class="drk right middle" style="width:100px;">Site Number:</th>
						<td style="width:55px;">
						<input type="Text" name="sw_sno" id="sw_sno" value="#swid#" style="width:50px;border:2px #request.color# solid;font-weight:bold;" class="center rounded" disabled>
						
						<!--- <select name="sw_sno" id="sw_sno" class="rounded" style="width:60px;border:2px #request.color# solid;">
						<cfloop index="i" from="1" to="#swid#">
							<cfset selected = ""><cfif i is swid><cfset selected = "selected"></cfif>
							<option value="#i#" #selected#>#i#</option>
						</cfloop>
						</select> --->
						</td>
						<!--- <th class="drk right middle" style="width:32px;">Suffix:</th>
						<td class="drk right middle" style="width:45px;">
						<select name="sw_sfx" id="sw_sfx" class="rounded" style="width:40px;border:2px #request.color# solid;">
						<option value=""></option>
						<option value="a">a</option>
						<option value="b">b</option>
						<option value="c">c</option>
						<option value="d">d</option>
						<option value="e">e</option>
						<option value="f">f</option>
						<option value="f">g</option>
						<option value="f">h</option>
						<option value="f">i</option>
						<option value="f">j</option>
						<option value="f">k</option>
						</select>
						</td> --->
						</tr>
					</table>
			
			
			</td>
		</tr>
			<tr>
				<th class="left middle" style="height:30px;width:85px;">Facility Name:</th>
				<td class="frm"  style="width:295px;">
				<input type="Text" name="sw_name" id="sw_name" value="" style="width:293px;" class="rounded"></td>
				<th class="left middle" style="width:90px;">Subtype:</th>
				<td class="frm"  style="width:185px;">
				<select name="sw_type" id="sw_type" class="rounded" style="width:184px;">
				<option value=""></option>
				<cfloop query="getType">
					<option value="#id#">#type#</option>
				</cfloop>
				</select>
				</td>
			</tr>
			<tr>
				
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:86px;">Address:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:300px;">
						<input type="Text" name="sw_address" id="sw_address" value="" style="width:293px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:91px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="sw_cd" id="sw_cd" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="15">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:52px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:64px;">
						<input type="Text" name="sw_zip" id="sw_zip" value="" style="width:59px;" class="rounded">
						</td>
						</tr>
					</table>
				</td>
				
				
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:115px;">City Owned Property:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_cityowned" id="sw_cityowned" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:65px;">Priority No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:45px;">
						<input type="Text" name="sw_priority" id="sw_priority" value="1" style="width:40px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:81px;">Date Logged:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:92px;">
						<input type="Text" name="sw_logdate" id="sw_logdate" value="#dt#" style="width:87px;text-align:center;" class="rounded"></td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:118px;">Curb Ramp Only:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:64px;">
						<select name="sw_curbramp" id="sw_curbramp" class="rounded" style="width:59px;">
						<cfloop query="getYesNo">
							<cfset selected = ""><cfif id is 0><cfset selected = "selected"></cfif>
							<option value="#id#" #selected#>#value#</option>
						</cfloop>
						</select>
						</td>
						
						
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:85px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_assessed" id="sw_assessed" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td> --->
						</tr>
					</table>
				</td>
			</tr>
			
			
			<!--- <tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:120px;">City Owned Property:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_cityowned" id="sw_cityowned" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:66px;">Priority No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:48px;">
						<input type="Text" name="sw_priority" id="sw_priority" value="1" style="width:43px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:72px;">Date Logged:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:130px;">
						<input type="Text" name="sw_logdate" id="sw_logdate" value="" style="width:125px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:85px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_assessed" id="sw_assessed" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
				</td>
			</tr> --->
			
			
			<!--- <tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<th class="left middle" style="width:85px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:94px;">
						<input type="Text" name="sw_assdate" id="sw_assdate" value="" style="width:89px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:96px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_repairs" id="sw_repairs" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:77px;">Severity Index:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:45px;">
						<select name="sw_severity" id="sw_severity" class="rounded" style="width:40px;">
						<option value=""></option>
						<cfloop index="id" from="1" to="3">
							<option value="#id#">#id#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:59px;">QC Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:124px;">
						<input type="Text" name="sw_qcdate" id="sw_qcdate" value="" style="width:119px;text-align:center;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr> --->
			
			<!--- <tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:85px;">Construction<br>Start Date:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:94px;">
						<input type="Text" name="sw_con_start" id="sw_con_start" value="" style="width:89px;text-align:center;" class="rounded"></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">Construction<br>Completed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:120px;">
						<input type="Text" name="sw_con_comp" id="sw_con_comp" value="" style="width:115px;text-align:center;" class="rounded"></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:110px;">Anticipated<br>Completion Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:124px;">
						<input type="Text" name="sw_antdate" id="sw_antdate" value="" style="width:119px;text-align:center;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr> --->
			
			<!--- <tr><th class="left middle" colspan="4" style="height:20px;">Tree Removal Notes:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_tree_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;"></textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;"></textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Location Description:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_loc" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;"></textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Damage Description:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_damage" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;"></textarea>
				</td>
			</tr> --->

		</table>
	</td>
	</tr>
	</form>
</table>

<table align=center border="0" cellpadding="0" cellspacing="0">
	<tr><td height=15></td></tr>
	<tr>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="submitForm();return false;">Submit</a>
		</td>
		<td style="width:15px;"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="$('#chr(35)#form1')[0].reset();return false;">Clear</a>
		</td>
	</tr>
	<tr><td height=15></td></tr>
</table>
	
	
	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>
	


</div>
	

</body>
</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
</cfoutput>

function submitForm() {

	$('#msg').hide();
	var errors = '';var cnt = 0;
	if (trim($('#sw_name').val()) == '')	{ cnt++; errors = errors + "- Facility Name is required!<br>"; }
	if (trim($('#sw_address').val()) == '')	{ cnt++; errors = errors + "- Address is required!<br>"; }
	if (trim($('#sw_type').val()) == '')	{ cnt++; errors = errors + "- Subtype is required!<br>"; }

	//var chk = $.isNumeric(trim($('#sw_tcon').val().replace(/,/g,""))); var chk2 = trim($('#sw_tcon').val());
	//if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Total Concrete must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_priority').val().replace(/,/g,""))); var chk2 = trim($('#sw_priority').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Priority No. must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_zip').val().replace(/,/g,""))); var chk2 = trim($('#sw_zip').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Zip Code must be numeric!<br>"; }
	
	
	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	
	}
	
	$('#sw_sno').removeAttr("disabled");
	var frm = $('#form1').serializeArray();
	<!--- frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });
	frm.push({"name" : "sw_loc", "value" : trim($('#sw_loc').val()) });
	frm.push({"name" : "sw_damage", "value" : trim($('#sw_damage').val()) });
	frm.push({"name" : "sw_tree_notes", "value" : trim($('#sw_tree_notes').val()) }); --->
	$('#sw_sno').attr('disabled', true);
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=addSite&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		
		if(data.RESULT != "Success") {
		
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		//Go to Projects List...
		//REDIRECT CODE HERE LATER....
		goToSite(data.ID)
		
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
	location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid);
}

$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
</script>

</html>


            

				

	


