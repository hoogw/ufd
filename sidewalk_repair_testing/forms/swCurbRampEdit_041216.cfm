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
<cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<cfparam name="url.search" default="false">

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
<cfquery name="getCurbRamp" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblCurbRamps WHERE ramp_no = #url.crid#
</cfquery>

<!--- Get Sites --->
<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT location_no as id FROM tblSites WHERE removed is null ORDER BY location_no
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



<!--- Get max curb ramp --->
<cfquery name="getMaxRamp" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(ramp_no) as ramp_no FROM tblCurbRamps WHERE ramp_no < #url.crid# AND removed is null
</cfquery>

<!--- Get min ramp --->
<cfquery name="getMinRamp" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT min(ramp_no) as ramp_no FROM tblCurbRamps WHERE ramp_no > #url.crid# AND removed is null
</cfquery>

<cfset dt = dateFormat(Now(),"mm/dd/yyyy")>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<div id="box" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15" colspan="3"></td></tr>
		  
		  <tr>
		  <td style="width:25%;text-align:right;">
		  <cfif getMaxRamp.ramp_no is not "">
		  <a href="swCurbRampEdit.cfm?crid=#getMaxRamp.ramp_no#&search=#search#"><img src="../images/arrow_left.png" width="20" height="29" title="Previous Site" id="leftarrow"></a>
		  </cfif>
		  </td>
		  
          <td align="center" class="pagetitle">Update Curb Ramp Repair</td>
		  
		  <td style="width:25%;">
		 <cfif getMinRamp.ramp_no is not "">
		  <a href="swCurbRampEdit.cfm?crid=#getMinRamp.ramp_no#&search=#search#"><img src="../images/arrow_right.png" width="20" height="29" title="Next Site" id="rightarrow"></a>
		  </cfif>
		  </td>		
		  </tr>  
		  
		  <tr><td height="15" colspan="3"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<cfset dis = ""><cfif getCurbRamp.removed is 1><cfset dis="disabled"></cfif>
<cfif session.user_level is 0><cfset dis="disabled"></cfif>
<cfif session.user_power lt 0><cfset dis="disabled"></cfif>
<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:746px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:105px;">Curb Ramp Number:</th>
						<cfset xxx = 326><cfif dis is not ""><cfset xxx = 353></cfif>
						<td class="left middle pagetitle" style="width:#xxx#px;"> <!--- was 288 --->
						<div style="position:relative;top:1px;">#getCurbRamp.ramp_no#</div>
						</td>
						
						
						<th class="drk right middle" style="width:180px;">Associated Sidewalk Repair Site:</th>
						<td class="drk right middle" style="width:80px;padding:2px 3px 0px 0px;">
						<select name="cr_sno" id="cr_sno" class="rounded" style="width:75px;border:2px #request.color# solid;" #dis# disabled>
						<option value=""></option>
						<cfloop query="getSites">
							<cfset sel = ""><cfif getCurbRamp.location_no is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#id#</option>
						</cfloop>
						</select>
						</td>
						
						<td>
						<cfif dis is "">
						<a href="" class="button buttonText" style="height:16px;width:24px;padding:2px 0px 0px 0px;" 
						onclick="toggleCRNo();return false;">Edit</a>
						</cfif>
						</td>
						
						<!--- <td align="right" style="width:41px;">
						<cfif getGeocode.recordcount gt 0>
						<a href="" onclick="openViewer();return false;" style="position:relative;top:2px;">
						<img src="../Images/MapChk.png" width="24" height="24" alt="Re-Geocode Site" title="Re-Geocode Site"></a>
						<cfelse>
						<a href="" onclick="openViewer();return false;" style="position:relative;top:0px;left:-4px;">
						<img src="../Images/Map.png" width="20" height="20" alt="Geocode Site" title="Geocode Site"></a>
						</cfif>
						</td> --->

						</tr>
					</table>
			
			
			</td>
		</tr>
			<tr>
				<th class="left middle" style="height:30px;width:100px;">Primary Street:</th>
				<cfset v = ""><cfif getCurbRamp.primary_street is not ""><cfset v = getCurbRamp.primary_street></cfif>
				<td class="frm" style="width:329px;">
				<input type="Text" name="cr_primary" id="cr_primary" value="#v#" style="width:324px;" class="rounded" #dis#></td>
				<th class="left middle" style="width:83px;">Type:</th>
				<td class="frm">
				<select name="cr_type" id="cr_type" class="rounded" style="width:192px;" #dis#>
				<cfloop query="getType">
					<cfset sel = ""><cfif getCurbRamp.type is id><cfset sel = "selected"></cfif>
					<option value="#id#" #sel#>#type#</option>
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
						<cfset v = ""><cfif getCurbRamp.secondary_street is not ""><cfset v = getCurbRamp.secondary_street></cfif>
						<td class="frm"  style="width:329px;">
						<input type="Text" name="cr_secondary" id="cr_secondary" value="#v#" style="width:324px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:83px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="cr_cd" id="cr_cd" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop index="i" from="1" to="15">
							<cfset sel = ""><cfif getCurbRamp.council_district is i><cfset sel = "selected"></cfif>
							<option value="#i#" #sel#>#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:61px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.zip_code is not ""><cfset v = getCurbRamp.zip_code></cfif>
						<td class="frm" style="width:64px;">
						<input type="Text" name="cr_zip" id="cr_zip" value="#v#" style="width:59px;" class="rounded" #dis#>
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
						<select name="cr_corner" id="cr_corner" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop index="i" from="1" to="#arrayLen(arrCorner)#">
							<cfset sel = ""><cfif getCurbRamp.intersection_corner is arrCorner[i]><cfset sel = "selected"></cfif>
							<option value="#arrCorner[i]#" #sel#>#arrCorner[i]#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:100px;">Priority No:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.priority_no is not ""><cfset v = getCurbRamp.priority_no></cfif>
						<td class="frm" style="width:60px;">
						<input type="Text" name="cr_priority" id="cr_priority" value="#v#" style="width:55px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:89px;">Date Logged:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.date_logged is not ""><cfset v = dateformat(getCurbRamp.date_logged,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:100px;">
						<input type="Text" name="cr_logdate" id="cr_logdate" value="#v#" style="width:95px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:111px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:64px;">
						<select name="cr_assessed" id="cr_assessed" class="rounded" style="width:59px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.field_assessed is id><cfset sel = "selected"></cfif>
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
						<select name="cr_existing" id="cr_existing" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.existing_ramp is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:100px;">ADA Compliant:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_compliant" id="cr_compliant" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.ada_compliant is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:134px;">Standard Plan Applicable:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="cr_applicable" id="cr_applicable" class="rounded" style="width:53px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.standard_plan_applicable is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:111px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:64px;">
						<select name="cr_repairs" id="cr_repairs" class="rounded" style="width:59px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.repairs_required is id><cfset sel = "selected"></cfif>
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
						<th class="left middle" style="height:30px;width:100px;">Design Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_design" id="cr_design" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.design_required is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:100px;">Design Start Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.design_start_date is not ""><cfset v = dateformat(getCurbRamp.design_start_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:95px;">
						<input type="Text" name="cr_design_sdt" id="cr_design_sdt" value="#v#" style="width:90px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:64px;">Design<br>Finish Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.design_finish_date is not ""><cfset v = dateformat(getCurbRamp.design_finish_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:90px;">
						<input type="Text" name="cr_design_fdt" id="cr_design_fdt" value="#v#" style="width:85px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:68px;">Designed By:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.designed_by is not ""><cfset v = getCurbRamp.designed_by></cfif>
						<td class="frm" style="width:107px;">
						<input type="Text" name="cr_designby" id="cr_designby" value="#v#" style="width:102px;" class="rounded" #dis#></td>
						
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
						<cfset v = ""><cfif getCurbRamp.assessed_date is not ""><cfset v = dateformat(getCurbRamp.assessed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:85px;">
						<input type="Text" name="cr_assessed_dt" id="cr_assessed_dt" value="#v#" style="width:80px;text-align:center;" class="rounded" #dis#></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:75px;">Assessed By:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.assessed_by is not ""><cfset v = getCurbRamp.assessed_by></cfif>
						<td class="frm"  style="width:95px;">
						<input type="Text" name="cr_assessedby" id="cr_assessedby" value="#v#" style="width:90px;" class="rounded" #dis#></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:64px;">QC Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.qc_date is not "">
						<cfset v = dateformat(getCurbRamp.qc_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:90px;">
						<input type="Text" name="cr_qc_dt" id="cr_qc_dt" value="#v#" style="width:85px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:68px;">QC By:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.qc_by is not ""><cfset v = getCurbRamp.qc_by></cfif>
						<td class="frm"  style="width:107px;">
						<input type="Text" name="cr_qcby" id="cr_qcby" value="#v#" style="width:102px;" class="rounded" #dis#></td>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:100px;">DOT Coordination:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="cr_dotcoord" id="cr_dotcoord" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.dot_coordination is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:166px;">Construction Completed Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.construction_completed_date is not "">
						<cfset v = dateformat(getCurbRamp.construction_completed_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:100px;">
						<input type="Text" name="cr_con_cdt" id="cr_con_cdt" value="#v#" style="width:95px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:89px;">Total Cost:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getCurbRamp.total_cost is not ""><cfset v = trim(numberformat(getCurbRamp.total_cost,"999,999.00"))></cfif>
						<td class="frm"  style="width:111px;">&nbsp;$&nbsp;
						<input type="Text" name="cr_totalcost" id="cr_totalcost" value="#v#" style="width:90px;text-align:center;" class="rounded" #dis#></td>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:64px;">&nbsp;</th>
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
						<select name="cr_utility" id="cr_utility" class="rounded" style="width:55px;" onchange="setDisabled('cr_utility',0);" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.utility_conflict is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						<cfset u_dis = "disabled">
						<cfif getCurbRamp.utility_conflict is 1><cfset u_dis = ""></cfif>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:556px;">
						
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:5px;"></th>
								<th class="middle">BSL:</th>
								<cfset v = ""><cfif getCurbRamp.bsl_conflict is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_bsl" name="cr_bsl" type="checkbox" #u_dis# #v# #dis#></div></th>
								<th style="width:10px;"></th>
								<th class="middle">DWP:</th>
								<cfset v = ""><cfif getCurbRamp.dwp_conflict is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_dwp" name="cr_dwp" type="checkbox" #u_dis# #v# #dis#></div></th>
								<th style="width:10px;"></th>
								<th class="middle">BOS:</th>
								<cfset v = ""><cfif getCurbRamp.bos_conflict is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_bos" name="cr_bos" type="checkbox" #u_dis# #v# #dis#></div></th>
								<th style="width:10px;"></th>
								<th class="middle">DOT:</th>
								<cfset v = ""><cfif getCurbRamp.dot_conflict is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_dot" name="cr_dot" type="checkbox" #u_dis# #v# #dis#></div></th>
								<th style="width:120px;"></th>
								<th class="middle">Other:</th>
								<th style="width:2px;"></th>
								<th class="middle">
								<cfset v = ""><cfif getCurbRamp.other_conflict is not ""><cfset v = getCurbRamp.other_conflict></cfif>
								<input type="Text" name="cr_other" id="cr_other" value="#v#" style="width:134px;" class="rounded" #u_dis# #dis#></th>
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
						<select name="cr_minor" id="cr_minor" class="rounded" style="width:55px;" onchange="setDisabled('cr_minor',1);" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getCurbRamp.minor_repair_only is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						<cfset m_dis = "disabled">
						<cfif getCurbRamp.minor_repair_only is 1><cfset m_dis = ""></cfif>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:556px;">
						
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:5px;"></th>
								<th class="middle">Add Truncated Domes:</th>
								<cfset v = ""><cfif getCurbRamp.add_truncated_domes is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_truncate" name="cr_truncate" type="checkbox" #m_dis# #v# #dis#></div></th>
								<th style="width:10px;"></th>
								<th class="middle">Lip Grind:</th>
								<cfset v = ""><cfif getCurbRamp.lip_grind is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_lip" name="cr_lip" type="checkbox" #m_dis# #v# #dis#></div></th>
								<th style="width:10px;"></th>
								<cfset v = ""><cfif getCurbRamp.add_scoring_lines is 1><cfset v = "checked"></cfif>
								<th class="middle">Add Scoring Lines:</th>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="cr_scoring" name="cr_scoring" type="checkbox" #m_dis# #v# #dis#></div></th>
								</tr>
							</table>
						
						</th>
						
						</tr>
					</table>
				</td>
			</tr>
			
		
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<cfset v = getCurbRamp.notes>
				<td class="frm" colspan="4" style="height:73px;">
				<textarea id="cr_notes" name="cr_notes" class="rounded" style="position:relative;top:0px;left:2px;width:722px;height:69px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
		

		</table>
	</td>
	</tr>
	<input type="Hidden" id="cr_no" name="cr_no" value="#getCurbRamp.ramp_no#">
	</form>
</table>

<table align=center border="0" cellpadding="0" cellspacing="0">
	<tr><td height=15></td></tr>
	<tr>
		<cfif dis is "">
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="submitForm();return false;">Update</a>
		</td>
		<td style="width:15px;"></td>
		</cfif>
		<cfif url.search is true>
		<cfset v = "Back"><cfif session.user_level is 0><cfset v = "Back"></cfif>
		<td style="width:15px;"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="cancelUpdate();return false;">#v#</a>
		</td>
		<cfelse>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="cancelUpdate();return false;">Exit</a>
		</td>
		</cfif>
	</tr>
	<tr><td height=15></td></tr>
</table>
	
	
	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
var search = #url.search#;
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
	
	var chk = $.isNumeric(trim($('#cr_totalcost').val().replace(/,/g,""))); var chk2 = trim($('#cr_totalcost').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Total Cost must be numeric!<br>"; }
	
	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	
	}
	
	$('#cr_totalcost').val(trim($('#cr_totalcost').val().replace(/,/g,"")));
	
	var frm = $('#form1').serializeArray();
	if ($('#cr_sno').prop('disabled')) { frm.push({"name" : "cr_sno", "value" : trim($('#cr_sno').val()) }); }
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateCurbRamp&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
		
			showMsg(data.RESULT,1);
			return false;	
		}
		
		showMsg("Curb Ramp Information updated successfully!",1,"Curb Ramp Information");
		
	  }
	});
	
}

function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function toggleCRNo() {
	if ($('#cr_sno').prop('disabled')) {
		$('#cr_sno').removeAttr("disabled");
	}
	else {
		$('#cr_sno').attr('disabled', true);
	}
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function goToSite(sid) {
	location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid);
}

function cancelUpdate() {
	if (search) { location.replace("../search/swCurbRampSearch.cfm"); }
	else { location.replace("../swWelcome.cfm"); }
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


$( "#cr_assessed_dt" ).datepicker();
$( "#cr_design_sdt" ).datepicker();
$( "#cr_design_fdt" ).datepicker();
$( "#cr_qc_dt" ).datepicker();
$( "#cr_con_cdt" ).datepicker({maxDate:0});
$( "#cr_logdate" ).datepicker();
</script>

</html>


            

				

	

