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
<!--- <cfif session.user_level is 0>
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
</cfif> --->
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Create New Curb Ramp Repair</title>
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

<!--- Get Curb Number + 1 --->
<cfquery name="getID" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(ramp_no) as id FROM tblCurbRamps
</cfquery>
<cfset crid = 1>
<cfif getID.id is not "">
	<cfset crid = getID.id + 1>
</cfif>

<!--- Get Sites --->
<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">

   <!---  SELECT location_no as id FROM tblSites WHERE removed is null ORDER BY location_no   --->
   
    <!--- --------------- super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ ---> 
     SELECT location_no as id FROM tblSites WHERE (removed is null) and  ((Locked is null) or (Locked = 0))  ORDER BY location_no
    <!--- -------- end ------- super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ ---> 
    
    
    
</cfquery>


<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblCurbRequestType ORDER BY type
</cfquery>


<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<cfset listCorner = "N,E,S,W,NE,NW,SE,SW">
<cfset arrCorner = listToArray(listCorner)>


<cfset dt = dateFormat(Now(),"mm/dd/yyyy")>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<div id="box" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Create New Curb Ramp Repair</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:746px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:250px;">Create New Curb Ramp Repair:</th>
						
						<th class="drk right middle" style="width:130px;">Assigned Site Number:</th>
						<td class="drk right middle" style="width:80px;padding:2px 3px 0px 0px;">
						<select name="cr_sno" id="cr_sno" class="rounded" style="width:75px;border:2px #request.color# solid;">
						<cfif isdefined("url.sw_id") is false><option value=""></option></cfif>
						<cfloop query="getSites">
							<cfif isdefined("url.sw_id")>
								<cfif url.sw_id is id>
									<option value="#id#">#id#</option>
								</cfif>							
							<cfelse>
								<option value="#id#">#id#</option>
							</cfif>
						</cfloop>
						</select>
						</td>
						
						<th class="drk right middle" style="width:190px;">Ramp Number:</th>
						<td style="width:65px;">
						<input type="Text" name="cr_no" id="cr_no" value="#crid#" style="width:60px;border:2px #request.color# solid;font-weight:bold;" class="center rounded" disabled>
						</td>
						</tr>
					</table>
			
			
			</td>
		</tr>
			<tr>
				<th class="left middle" style="height:30px;width:100px;">Primary Street:</th>
				<td class="frm" style="width:329px;">
				<input type="Text" name="cr_primary" id="cr_primary" value="" style="width:324px;" class="rounded"></td>
				<th class="left middle" style="width:83px;">Type:</th>
				<td class="frm">
				<select name="cr_type" id="cr_type" class="rounded" style="width:192px;">
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
						<th class="left middle" style="height:30px;width:100px;">Secondary Street:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:329px;">
						<input type="Text" name="cr_secondary" id="cr_secondary" value="" style="width:324px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:83px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="cr_cd" id="cr_cd" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="15">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:61px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:64px;">
						<input type="Text" name="cr_zip" id="cr_zip" value="" style="width:59px;" class="rounded">
						</td>
						</tr>
					</table>
				</td>
				
				
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:100px;">Intersection Corner:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_corner" id="cr_corner" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="#arrayLen(arrCorner)#">
							<option value="#arrCorner[i]#">#arrCorner[i]#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:100px;">Priority No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<input type="Text" name="cr_priority" id="cr_priority" value="1" style="width:55px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:89px;">Date Logged:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:100px;">
						<input type="Text" name="cr_logdate" id="cr_logdate" value="#dt#" style="width:95px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:111px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:64px;">
						<select name="cr_assessed" id="cr_assessed" class="rounded" style="width:59px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif id is 0><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:100px;">Existing Ramp:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_existing" id="cr_existing" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:100px;">ADA Compliant:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_compliant" id="cr_compliant" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:134px;">Standard Plan Applicable:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="cr_applicable" id="cr_applicable" class="rounded" style="width:53px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:111px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:64px;">
						<select name="cr_repairs" id="cr_repairs" class="rounded" style="width:59px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<th class="left middle" style="height:30px;width:100px;">Design Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_design" id="cr_design" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:100px;">Design Start Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:95px;">
						<input type="Text" name="cr_design_sdt" id="cr_design_sdt" value="" style="width:90px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:64px;">Design<br>Finish Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:90px;">
						<input type="Text" name="cr_design_fdt" id="cr_design_fdt" value="" style="width:85px;text-align:center;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:68px;">Designed By:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:107px;">
						<input type="Text" name="cr_designby" id="cr_designby" value="" style="width:102px;" class="rounded"></td>
						
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:100px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:85px;">
						<input type="Text" name="cr_assessed_dt" id="cr_assessed_dt" value="" style="width:80px;text-align:center;" class="rounded"></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:75px;">Assessed By:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:95px;">
						<input type="Text" name="cr_assessedby" id="cr_assessedby" value="" style="width:90px;" class="rounded"></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:99px;">DOT Coordination:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="cr_dotcoord" id="cr_dotcoord" class="rounded" style="width:53px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:90px;">Construction<br>Completed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:85px;">
						<input type="Text" name="cr_con_cdt" id="cr_con_cdt" value="" style="width:80px;text-align:center;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="height:30px;width:100px;">Utility Conflict:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_utility" id="cr_utility" class="rounded" style="width:55px;" onChange="setDisabled('cr_utility',0);">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:556px;">
						
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:5px;"></th>
								<th class="middle">BSL:</th>
								<th class="middle"><div style="position:relative;top:1px;"><input id="cr_bsl" name="cr_bsl" type="checkbox" disabled></div></th>
								<th style="width:10px;"></th>
								<th class="middle">DWP:</th>
								<th class="middle"><div style="position:relative;top:1px;"><input id="cr_dwp" name="cr_dwp" type="checkbox" disabled></div></th>
								<th style="width:10px;"></th>
								<th class="middle">BOS:</th>
								<th class="middle"><div style="position:relative;top:1px;"><input id="cr_bos" name="cr_bos" type="checkbox" disabled></div></th>
								<th style="width:10px;"></th>
								<th class="middle">DOT:</th>
								<th class="middle"><div style="position:relative;top:1px;"><input id="cr_dot" name="cr_dot" type="checkbox" disabled></div></th>
								<th style="width:120px;"></th>
								<th class="middle">Other:</th>
								<th style="width:2px;"></th>
								<th class="middle">
								<input type="Text" name="cr_other" id="cr_other" value="" style="width:134px;" class="rounded" disabled></th>
								</tr>
							</table>
						
						</th>
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="height:30px;width:100px;">Minor Repairs Only:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_minor" id="cr_minor" class="rounded" style="width:55px;" onChange="setDisabled('cr_minor',1);">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:368px;">
						
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:5px;"></th>
								<th class="middle">Add Truncated Domes:</th>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_truncate" name="cr_truncate" type="checkbox" disabled></div></th>
								<th style="width:10px;"></th>
								<th class="middle">Lip Grind:</th>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_lip" name="cr_lip" type="checkbox" disabled></div></th>
								<th style="width:10px;"></th>
								<th class="middle">Add Scoring Lines:</th>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_scoring" name="cr_scoring" type="checkbox" disabled></div></th>
								</tr>
							</table>
						
						</th>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:181px;">
						
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th class="left middle">ADA Compliance Exception:<br>(See Notes)</th>
								<th style="width:10px;"></th>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_excptn" name="cr_excptn" type="checkbox" onClick="toggleADANotes();"></div></th>
								</tr>
							</table>
						
						</th>
						
						</tr>
					</table>
				</td>
			</tr>
			
		
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:40px;">
				<textarea id="cr_notes" name="cr_notes" class="rounded" style="position:relative;top:0px;left:2px;width:722px;height:39px;"></textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">ADA Compliance Exception Notes:</th></tr>
			<tr>
				<td class="frm" colspan="4" style="height:40px;">
				<textarea id="cr_excptn_notes" name="cr_excptn_notes" class="rounded" style="position:relative;top:0px;left:2px;width:722px;height:39px;" disabled></textarea>
				</td>
			</tr>
			
		

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
		<cfif isdefined("url.sw_id")>
		<td style="width:15px;"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="goBack();return false;">Cancel</a>
		</td>
		</cfif>
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
<cfif isdefined("url.sw_id")>
var sw_id = #url.sw_id#;
var sid = #url.sid#;
var pid = #url.pid#;
var search = #url.search#;
</cfif>
</cfoutput>

function submitForm() {

	$('#msg').hide();
	var errors = '';var cnt = 0;
	if (trim($('#cr_primary').val()) == '')	{ cnt++; errors = errors + "- Primary Street is required!<br>"; }
	if (trim($('#cr_type').val()) == '')	{ cnt++; errors = errors + "- Type is required!<br>"; }
	
	var chk = $.isNumeric(trim($('#cr_priority').val().replace(/,/g,""))); var chk2 = trim($('#cr_priority').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Priority No. must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#cr_zip').val().replace(/,/g,""))); var chk2 = trim($('#cr_zip').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Zip Code must be numeric!<br>"; }
	
	if ($('#cr_excptn').is(':checked') && $('#cr_excptn').is(':disabled') != true) {
		if($.trim($('#cr_excptn_notes').val()) == "") { cnt++; errors = errors + "- ADA Compliance Exception Notes cannot be blank!<br>"; }
	}
	
	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	
	}
	
	$('#cr_no').removeAttr("disabled");
	$('#cr_excptn_notes').removeAttr("disabled");
	var frm = $('#form1').serializeArray();
	//frm.push({"name" : "cr_notes", "value" : trim($('#cr_notes').val()) });
	$('#cr_no').attr('disabled', true);
	$('#cr_excptn_notes').attr('disabled', true);
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=addCurbRamp&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
		
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		//Go to Projects List...
		//REDIRECT CODE HERE LATER....
		if (typeof(sw_id) != 'undefined') { 
			location.replace(url + "forms/swSiteEdit.cfm?editcr=true&sid=" + sid + "&pid=" + pid + "&search=" + search);
			return false;
		}
		
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

function goToSite(crid) {
	location.replace(url + "forms/swCurbRampEdit.cfm?crid=" + crid);
}

function goBack() {
	location.replace(url + "forms/swSiteEdit.cfm?editcr=true&sid=" + sid + "&pid=" + pid + "&search=" + search);
}

function setDisabled(ctrl,idx) {

	if ($('#'+ctrl).val() == 1) {
		if (idx == 0) {
			$('#cr_bsl').removeAttr('disabled');
			$('#cr_dwp').removeAttr('disabled');
			$('#cr_bos').removeAttr('disabled');
			$('#cr_dot').removeAttr('disabled');
			$('#cr_other').removeAttr('disabled');
		}
		else {
			$('#cr_truncate').removeAttr('disabled');
			$('#cr_lip').removeAttr('disabled');
			$('#cr_scoring').removeAttr('disabled');
		}
	}
	else {
		if (idx == 0) {
			$('#cr_bsl').attr('disabled', true);
			$('#cr_dwp').attr('disabled', true);
			$('#cr_bos').attr('disabled', true);
			$('#cr_dot').attr('disabled', true);
			$('#cr_other').attr('disabled', true);
		}
		else {
			$('#cr_truncate').attr('disabled', true);
			$('#cr_lip').attr('disabled', true);
			$('#cr_scoring').attr('disabled', true);
		}
	}
}

function toggleADANotes() {
	if ($('#cr_excptn').is(':checked')) {
		$('#cr_excptn_notes').removeAttr('disabled');
	}
	else
	{
		$('#cr_excptn_notes').attr('disabled', true);
	}
}


$( "#cr_assessed_dt" ).datepicker();
$( "#cr_design_sdt" ).datepicker();
$( "#cr_design_fdt" ).datepicker();
$( "#cr_con_cdt" ).datepicker({maxDate:0});
$( "#cr_logdate" ).datepicker();
</script>

</html>


            

				

	


