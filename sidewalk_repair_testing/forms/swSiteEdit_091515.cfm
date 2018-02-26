<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
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

<cfparam name="url.sid" default="312">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">

<!--- Get Package --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>

<!--- Get Package --->
<cfset sw_pid = ""><cfset sw_grp = "">
<cfif url.pid gt 0>
<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackages WHERE id = #url.pid#
</cfquery>
<cfset sw_pid = getPackage.package_no>
<cfset sw_grp = getPackage.package_group>
<cfelse>
	<cfset sw_pid = getSite.package_no>
	<cfset sw_grp = getSite.package_group>
</cfif>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType ORDER BY type
</cfquery>


<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Check Geocode --->
<cfquery name="getGeocode" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM vwGeocoder WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get max site --->
<cfquery name="getMaxSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(location_no) as location_no FROM tblSites WHERE location_no < #getSite.location_no# AND removed is null
</cfquery>
<cfif getMaxSite.location_no is not "">
<cfquery name="getMaxSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT id FROM tblSites WHERE location_no =  #getMaxSite.location_no#
</cfquery>
</cfif>

<!--- Get min site --->
<cfquery name="getMinSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT min(location_no) as location_no FROM tblSites WHERE location_no > #getSite.location_no# AND removed is null
</cfquery>
<cfif getMinSite.location_no is not "">
<cfquery name="getMinSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT id FROM tblSites WHERE location_no =  #getMinSite.location_no#
</cfquery>
</cfif>

<!--- Get Estimates --->
<cfquery name="getEst" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblEngineeringEstimate WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Contractor Price --->
<cfquery name="getContract" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblContractorPricing WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Trees --->
<cfquery name="getTrees" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeRemovalInfo WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get ChangeOrder Values --->
<cfquery name="getCOs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblChangeOrders WHERE location_no = #getSite.location_no#
</cfquery>

<!--- <cfdump var="#getMaxSite#">
<cfdump var="#getMinSite#"> --->

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td colspan="3" height="15"></td></tr>
          <tr><td style="width:25%;text-align:right;">
		  <cfif isdefined("getMaxSite.id")>
		  <a href="swSiteEdit.cfm?sid=#getMaxSite.id#"><img src="../images/arrow_left.png" width="20" height="29" title="Previous Location"></a>
		  </cfif>
		  </td>
		  <td align="center" class="pagetitle">Update Sidewalk Repair Site</td>
		  <td style="width:25%;">
		  <cfif isdefined("getMinSite.id")>
		  <a href="swSiteEdit.cfm?sid=#getMinSite.id#"><img src="../images/arrow_right.png" width="20" height="29" title="Next Location"></a>
		  </td>
		  </cfif>
		  </tr>
		  <cfif session.user_level lt 2>
		  <tr><td colspan="3" height="15"></td></tr>
		  <cfelse>
		  	<cfif getEst.recordcount gt 0 OR getContract.recordcount gt 0>
			  <tr><td colspan="3" style="text-align:center;">
			  <cfif getEst.recordcount gt 0>
			  <a href="../reports/EstimatingByLocation.cfm?my_loc=#getSite.location_no#" target="_blank"><img style="position:relative;top:-2px;left:-5px;" src="../images/report_e.png" width="20" height="20" title="Engineer Estimate Report"></a>
			  </cfif>
			  <cfif getContract.recordcount gt 0>
			  <a href="../reports/PricingByLocation.cfm?my_loc=#getSite.location_no#" target="_blank"><img style="position:relative;top:-2px;left:5px;" src="../images/report_c.png" width="20" height="20" title="Contractor Pricing Report"></a>
			  </cfif>
			  </td></tr>
			<cfelse>
			  <tr><td colspan="3" height="15"></td></tr>
			</cfif>
		  </cfif>
		</table>
  	</td>
  </tr>
</table>

<cfset w = 700>
<cfset dis = ""><cfif getSite.removed is 1><cfset dis="disabled"></cfif>
<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:#w#px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:90px;">Location Number:</th>
						<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">#getSite.location_no#<!--- #getSite.site_suffix# --->
						</td>
						
						<cfif sw_pid is not "">						
						<th class="drk left middle" style="width:55px;">Package:</th>
						<td class="left middle pagetitle" style="width:205px;padding:1px 3px 0px 0px;"><span onmouseover="this.style.cursor='pointer';" onclick="goToPackage(#url.pid#);return false;">#sw_grp# - #sw_pid#</span>
						</td>
						<cfelse>
						<th class="drk left middle" style="width:260px;"></th>
						</td>
						</cfif>


						<td align="left" style="width:74px;"></td>
						
						
						<cfif getSite.removed is "">
						<td align="right" style="width:50px;">
						<a href="" onclick="openAssessment();return false;" style="position:relative;top:0px;">
						<img src="../images/assessment.png" width="20" height="20" title="Open Assessment Form"></a>
						</td>						
						
						<td align="right" style="width:28px;">
						<a href="" onclick="openEstimate();return false;" style="position:relative;top:0px;">
						<img src="../images/dollar.png" width="20" height="20" title="Open Engineering Estimate / Contractor Pricing Form"></a>
						</td>
						
						<td align="right" style="width:28px;">
						<a href="" onclick="openChangeOrders();return false;" style="position:relative;top:0px;">
						<img src="../images/change.png" width="20" height="20" title="Open Change Orders Form"></a>
						</td>
						
						<td align="right" style="width:42px;">
						<a href="" onclick="$('#chr(35)#box_curb').show();return false;" style="position:relative;top:0px;">
						<img src="../images/ramp.png" width="20" height="20" title="Open ADA Curb Ramp Form"></a>
						</td>
						
						<td align="right" style="width:28px;">
						<a href="" onclick="$('#chr(35)#box_tree').show();return false;" style="position:relative;top:0px;">
						<img src="../images/tree.png" width="20" height="20" title="Open Tree Removal Form"></a>
						</td>
						
						<td align="right" style="width:31px;">
						<cfif getGeocode.recordcount gt 0>
						<a href="" onclick="openViewer();return false;" style="position:relative;top:2px;">
						<img src="../Images/MapChk.png" width="24" height="24" alt="Re-Geocode Site" title="Re-Geocode Site"></a>
						<cfelse>
						<a href="" onclick="openViewer();return false;" style="position:relative;top:0px;left:-4px;">
						<img src="../Images/Map.png" width="20" height="20" alt="Geocode Site" title="Geocode Site"></a>
						</cfif>
						</td>
						</cfif>
						
						</tr>
					</table>
			
			
			</td>
		</tr>
		
			<tr>
				<th class="left middle" style="height:30px;width:80px;">Facility Name:</th>
				<cfset v = ""><cfif getSite.name is not ""><cfset v = getSite.name></cfif>
				<td class="frm"  style="width:300px;">
				<input type="Text" name="sw_name" id="sw_name" value="#v#" style="width:298px;" class="rounded" #dis#></td>
				<th class="left middle" style="width:90px;">Type:</th>
				<td class="frm"  style="width:185px;">
				<select name="sw_type" id="sw_type" class="rounded" style="width:184px;" #dis#>
				<option value=""></option>
				<cfloop query="getType">
					<cfset sel = ""><cfif getSite.type is id><cfset sel = "selected"></cfif>
					<option value="#id#" #sel#>#type#</option>
				</cfloop>
				</select>
				</td>
			</tr>
	
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th class="left middle" style="height:30px;width:81px;">Address:</th>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif getSite.address is not ""><cfset v = getSite.address></cfif>
							<td class="frm" style="width:305px;">
							<input type="Text" name="sw_address" id="sw_address" value="#v#" style="width:298px;" class="rounded" #dis#></td>
							<td style="width:2px;"></td>
							<th class="left middle" style="width:91px;">Council District:</th>
							<td style="width:2px;"></td>
							<td class="frm" style="width:60px;">
							<select name="sw_cd" id="sw_cd" class="rounded" style="width:55px;" #dis#>
							<option value=""></option>
							<cfloop index="i" from="1" to="15">
								<cfset sel = ""><cfif getSite.council_district is i><cfset sel = "selected"></cfif>
								<option value="#i#" #sel#>#i#</option>
							</cfloop>
							</select>
							</td>
							<td style="width:2px;"></td>
							<th class="left middle" style="width:57px;">Zip Code:</th>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif getSite.zip_code is not ""><cfset v = getSite.zip_code></cfif>
							<td class="frm" style="width:60px;">
							<input type="Text" name="sw_zip" id="sw_zip" value="#v#" style="width:55px;" class="rounded" #dis#>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:120px;">City Owned Property:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_cityowned" id="sw_cityowned" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.city_owned_property is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:66px;">Priority No:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.priority_no is not ""><cfset v = getSite.priority_no></cfif>
						<td class="frm" style="width:48px;">
						<input type="Text" name="sw_priority" id="sw_priority" value="1" style="width:43px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:72px;">Date Logged:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.date_logged is not ""><cfset v = dateformat(getSite.date_logged,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:130px;">
						<input type="Text" name="sw_logdate" id="sw_logdate" value="#v#" style="width:125px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:85px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_assessed" id="sw_assessed" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.field_assessed is id><cfset sel = "selected"></cfif>
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
						<th class="left middle" style="width:120px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.assessed_date is not ""><cfset v = dateformat(getSite.assessed_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:133px;">
						<input type="Text" name="sw_assdate" id="sw_assdate" value="#v#" style="width:128px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:97px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_repairs" id="sw_repairs" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.repairs_required is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:92px;">QC Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.qc_date is not ""><cfset v = dateformat(getSite.qc_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:152px;">
						<input type="Text" name="sw_qcdate" id="sw_qcdate" value="#v#" style="width:147px;text-align:center;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<!--- <tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:120px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_repairs" id="sw_repairs" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.repairs_required is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">QC'd By (Intials):</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.qc is not ""><cfset v = getSite.qc></cfif>
						<td class="frm" style="width:108px;">
						<input type="Text" name="sw_qc" id="sw_qc" value="#v#" style="width:103px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:100px;">QC Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.qc_date is not ""><cfset v = dateformat(getSite.qc_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:145px;">
						<input type="Text" name="sw_qcdate" id="sw_qcdate" value="#v#" style="width:140px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr> --->
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<!--- <th class="left middle" style="height:30px;width:82px;">Total Concrete:<br><div style="position:relative;left:20px;">(sq. ft.)</div></th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.total_concrete is not ""><cfset v = numberformat(getSite.total_concrete,"999,999,999")></cfif>
						<td class="frm" style="width:78px;">
						<input type="Text" name="sw_tcon" id="sw_tcon" value="#v#" style="width:73px;" class="rounded"></td>
						<td style="width:2px;"></td> --->
						<th class="left middle" style="height:30px;width:80px;">Construction<br>Start Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.construction_start_date is not ""><cfset v = dateformat(getSite.construction_start_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:108px;">
						<input type="Text" name="sw_con_start" id="sw_con_start" value="#v#" style="width:103px;text-align:center;" class="rounded" #dis#>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:114px;">Construction<br>Completed Date:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfif getSite.construction_completed_date is not ""><cfset v = dateformat(getSite.construction_completed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:108px;">
						<input type="Text" name="sw_con_comp" id="sw_con_comp" value="#v#" style="width:103px;text-align:center;" class="rounded" #dis#>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:92px;">Anticipated<br>Completion Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.anticipated_completion_date is not "">
						<cfset v = dateformat(getSite.anticipated_completion_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:152px;">
						<input type="Text" name="sw_antdate" id="sw_antdate" value="#v#" style="width:147px;text-align:center;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:193px;">Contractor's Price:</th>
						<td style="width:2px;"></td>
						<cfset v = 0.00>
						<cfif getContract.recordcount gt 0>
							<cfif getContract.contractors_cost is not ""><cfset v = trim(numberformat(getContract.contractors_cost,"999,999.00"))></cfif>
						</cfif>
						<td class="frm" style="width:143px;">&nbsp;$&nbsp;
						<input type="Text" name="sw_con_price" id="sw_con_price" value="#v#" style="width:122px;text-align:center;" class="rounded" disabled></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:178px;">Change Orders:</th>
						<td style="width:2px;"></td>
						<cfset v = 0.00>
						<cfif getCOs.recordcount gt 0>
							<cfif getCOs.change_order_cost is not ""><cfset v = trim(numberformat(getCOs.change_order_cost,"999999.00"))></cfif>
						</cfif>
						<td class="frm" style="width:152px;">&nbsp;$&nbsp;
						<input type="Text" name="sw_changeorder" id="sw_changeorder" value="#v#" style="width:131px;text-align:center;" class="rounded" disabled></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:193px;">No. Trees to Remove per Arborist:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfif getTrees.recordcount gt 0>
							<cfif getTrees.no_trees_to_remove_per_arborist is not ""><cfset v = getTrees.no_trees_to_remove_per_arborist></cfif>
						</cfif>
						<td class="frm" style="width:143px;">
						<input type="Text" name="sw_no_trees" id="sw_no_trees" value="#v#" style="width:138px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:178px;">Date Trees Removed:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfif getTrees.recordcount gt 0>
							<cfif getTrees.trees_removed_date is not ""><cfset v = dateformat(getTrees.trees_removed_date,"MM/DD/YYYY")></cfif>
						</cfif>
						<td class="frm" style="width:152px;">
						<input type="Text" name="sw_tree_rm_date" id="sw_tree_rm_date" value="#v#" style="width:147px;text-align:center;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<!--- <tr>
			
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:20px;width:527px;"><span style="position:relative;top:3px;">Tree Removal Notes:</span></th>
						<td style="width:2px;"></td>
						<th style="width:85px;" class="left middle">Trees Removed:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						
						<cfset dis2 = "">
						<cfif session.user_level lt 3><cfset dis2 = "disabled"></cfif>
						
						<select name="sw_tree_rmv" id="sw_tree_rmv" class="rounded" style="width:55px;height:20px;" #dis# #dis2#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.tree_removed is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
				</td>

			</tr> --->
			<tr><th class="left middle" colspan="4" style="height:20px;">Tree Removal Notes:</th></tr>
			<tr>
				<cfset v = "">
				<cfif getTrees.recordcount gt 0>
					<cfif getTrees.tree_removal_notes is not ""><cfset v = getTrees.tree_removal_notes></cfif>
				</cfif>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_tree_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<cfset v = getSite.notes>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Location Description:</th></tr>
			<tr>
				<cfset v = getSite.location_description>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_loc" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Damage Description:</th></tr>
			<tr>
				<cfset v = getSite.damage_description>
				<td class="frm" colspan="4" style="height:42px;">
				<textarea id="sw_damage" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:36px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
			

		</table>
	</td>
	</tr>
	<input type="Hidden" id="sw_id" name="sw_id" value="#url.sid#">
	</form>
</table>

<table align=center border="0" cellpadding="0" cellspacing="0">
		<cfset w2 = (w-80)/2><cfset cs = 3><cfif url.pid gt 0 OR url.search is true><cfset w2 = (w-180)/2><cfset cs = 5></cfif>
		<cfset v = getSite.removed>
		<tr><td height="22" colspan="#cs#" class="right" style="width:#w#px;">
				<cfif session.user_level gt 2>
					<cfif v is "">
					<a href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
					onclick="showRemove();return false;">Delete</a>
					<cfelse>
					<a href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
					onclick="showRemove();return false;">Restore</a>
					</cfif>
				</cfif>
		</td></tr>
		<cfif v is "">
		<tr>
			<td style="width:#w2#px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Update</a>
			</td>
			<cfif url.pid gt 0 OR url.search is true>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="cancelUpdate();return false;">Cancel</a>
			</td>
			</cfif>
			<td class="right top" style="width:#w2#px;">
				
			</td>
		</tr>
		</cfif>
	</table>
	
	
	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header" class="box_header"><strong>The Following Error(s) Occured:</strong></div>
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

<div id="msg5" class="box" style="top:40px;left:1px;width:350px;height:90px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg5').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header5" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<cfset v = getSite.removed>
		<cfif v is ""><cfset v = 0></cfif>
		<cfset msg = "Are you sure you want to delete this Site?<br>This Site will also be removed from any associated Package.">
		<cfif v is 1>
		<cfset msg = "Are you sure you want to restore this Site?<br>This Site will return to the unassigned pool.">
		</cfif>
		<div id="msg_text5" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		#msg#
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="deleteSite(#v#);$('#chr(35)#msg5').hide();return false;">Continue...</a>
			</td>
			<td style="width:0px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg5').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>
	


<!--- <cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
</cfquery> --->

<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, sort_order, sort_group
FROM vwSortOrder
ORDER BY full_sort, sort_group, sort_order
</cfquery>

<!--- Get QC Values --->
<cfquery name="getQCs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblQCQuantity WHERE location_no = #getSite.location_no#
</cfquery>


<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
	
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />
	
	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

	
	
	
<div id="box" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;display:none;z-index:500;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update Engineering Estimate / Contractor Pricing Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:795px;">

	<cfset tab1 = 1000><cfset tab2 = 2000><cfset tab3 = 3000><cfset tab4 = 4000><cfset tab5 = 5000><cfset tab6 = 6000>
	
	<form name="form3" id="form3" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="9" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:210px;"><!--- Site Number --->Engineering Estimate / Contractor Pricing:</th>
						<td class="left middle pagetitle" style="width:385px;font-size: 12px;padding:1px 3px 0px 0px;">Loc No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:87px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm2(0);return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
			<tr>
				<th class="center middle" style="height:30px;width:25px;">No</th>
				<td class="frm left middle">
				
					<table cellpadding="0" cellspacing="0" border="0"><tr>
					<td class="frm left middle" style="padding:0px;width:180px;"></td>
					<td class="frm left middle">
					
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:5px;"><tr>
						<td class="frm center middle" style="font-size:10px;width:60px;">
						Percent
						</td>
						<td class="frm center middle" style="font-size:10px;width:45px;">
						Maximum
						</td>
						</tr></table>
						
					
					</td>
					</tr></table>
				
				</td>
				<th class="center middle" style="height:30px;width:40px;">Units</th>
				<th class="center middle" style="width:50px;">Quantity</th>
				<th class="center middle" style="width:70px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:50px;">Unit Price</th>
					<td>
					<a onclick="updateDefaultPrice();return false;" href="">
					<img style="position:relative;top:0px;" src="../images/refresh.png" width="16" height="16" title="Refresh Default Unit Prices">
					</a>
					</td>
					</tr>
					</table>
				
				</th>
				<th class="center middle" style="width:80px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:60px;">Estimated<br>Price</th>
					<td>
					<a onclick="calcSubTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Engineer's Estimate">
					</a>
					</td>
					</tr>
					</table>
				
				</th>
				<!--- <cfset num = 4+(getFlds.recordcount - 4)/3> --->
				<cfset num = getFlds.recordcount+4+6>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="height:30px;width:80px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:40px;">Contractor's<br>Unit Price</th>
					<td>
					<a onclick="clearConTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/clear.png" width="16" height="16" title="Clear Contractor's Unit Prices">
					</a>
					</td>
					</tr>
					</table>
				
				
				</th>
				<th class="center middle" style="width:80px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:40px;">Contractor's<br>Price&nbsp;</th>
					<td>
					<a onclick="calcConTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Contractor's Cost">
					</a>
					</td>
					</tr>
					</table>
				
				</th>
			</tr>
		
		<cfset cnt = 0><cfset etotal = 0><cfset ctotal = 0><cfset no = 0><cfset grp = 0>
		<cfloop query="getFlds">
			<!--- <cfif cnt mod 3 is 2> --->
			<cfif right(column_name,6) is "_UNITS">
			<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			<cfset u = ""><cfset q = 0><cfset p = 0><cfset c = 0>
			<cfif getEst.recordcount gt 0>
				<cfset u=evaluate("getEst.#fld#_UNITS")>
				<cfset q=evaluate("getEst.#fld#_QUANTITY")>
				<cfset p=evaluate("getEst.#fld#_UNIT_PRICE")>
				<cfif q is ""><cfset q = 0></cfif>
				<cfif p is ""><cfset p = 0></cfif>
			<cfelse>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				<cfset u=evaluate("getDefault.UNITS")>
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>
			</cfif>
			<cfif getQCs.recordcount gt 0>
				<cfset qq=evaluate("getQCs.#fld#_QUANTITY")>
				<cfif qq is ""><cfset qq = 0></cfif>
				<cfset q = q + qq>
			</cfif>
			
			<cfif getContract.recordcount gt 0>
				<cfset c=evaluate("getContract.#fld#_UNIT_PRICE")>
				<cfif c is ""><cfset c = 0></cfif>
			</cfif>
			<cfset v = replace(column_name,"___",")_","ALL")>
			<cfset v = replace(v,"__"," (","ALL")>
			<cfset v = replace(v,"_UNITS","","ALL")>
			<cfset v = replace(v,"_l_","_/_","ALL")>
			<cfset v = replace(v,"_ll_",".","ALL")>
			<cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")>
			<cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
			<cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
			<cfset v = replace(v,"_FEET","#chr(39)#","ALL")>
			<cfset v = replace(v,"_"," ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")>
			<cfset v = replace(v," Pvc "," PVC ","ALL")>
			<cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")>
			<cfset v = replace(v,"(c","(C","ALL")>
			<cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")>
			<cfset v = replace(v,"(o","(O","ALL")>
			<cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")>
			<cfset v = replace(v," And "," & ","ALL")>
			<cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CODITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TRESS & LANDSCAPING"></cfif>
				<cfif grp is 5><cfset group = "UTILITIES"></cfif>
				<cfif grp is 6><cfset group = "MISCELLANEOUS ITEMS"></cfif>
				<tr>
				<th class="drk center middle" colspan="6" style="height:15px;">#group#</th>
				<th class="drk center middle" colspan="2"></th>
				</tr>
			</cfif>
			
			<tr>
				<cfset no = no+1>
				<cfif left(fld,5) is "EXTRA">
				<th class="center middle" style="height:30px;width:25px;">#no#</th>
				<cfelse>
				<th class="center middle" style="height:30px;width:25px;">#sort_order#</th>
				</cfif>
				<cfif cnt lt 3>
				
				
				<th class="left middle" style="height:30px;width:320px;">
				
					<table cellpadding="0" cellspacing="0" border="0"><tr>
					<th class="left middle" style="padding:0px;width:180px;">#v#:</th>
					<th class="left middle">
						<cfset per=evaluate("getEst.#fld#_PERCENT")>
						<cfset max=evaluate("getEst.#fld#_MAXIMUM")>
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle">
						<select name="#fld#_percent" id="#fld#_percent" class="roundedsmall" style="width:50px;position:relative;top:1px;" tabindex="#tab1#">
						<cfset tab1 = tab1+1>
						<cfif per is ""><cfset per = 0></cfif>
						<cfset per = (per*100)>
						
						<cfloop index="i" from="1" to="10" step="1">
							<cfset sel = ""><cfif i is per><cfset sel = "selected"></cfif>
							<cfif cnt gt 6>
								<cfif per is 0 AND i is 1><cfset sel = "selected"></cfif>
							<cfelse>
								<cfif per is 0 AND i is 5><cfset sel = "selected"></cfif>
							</cfif>
							<option value="#i/100#" #sel#>#i#%</option>
						</cfloop>
						</select>
						</th>
						<th class="left middle">
						<cfif max is "">
							<cfset max = 5000>
							<cfif cnt gt 6><cfset max = 1000></cfif>
						</cfif>
						<input type="Text" name="#fld#_maximum" id="#fld#_maximum" value="#max#" 
						style="position:relative;top:1px;width:55px;text-align:center;height:20px;" class="center roundedsmall" tabindex="#tab2#">
						</th>
						<cfset tab2 = tab2+1>
						</tr></table>
						
					
					</th>
					</tr></table>
				
				</th>
				<cfelse>
				
					<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
					
						<cfset n=evaluate("getEst.#fld#_NAME")>
						
						<th class="left middle" style="height:30px;width:320px;">
							<table cellpadding="0" cellspacing="0" border="0"><tr>
							<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
							<th class="left middle">
							<input type="Text" name="#fld#_name" id="#fld#_name" value="#n#" 
							style="position:relative;top:0px;width:220px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#" disabled>
							</th>
							<cfset tab1 = tab1+1>
							</tr></table>
						</th>
						
					<cfelse>
						<th class="left middle" style="height:30px;width:320px;">#v#:</th>
					</cfif>
				
				
				</cfif>
				
				<td class="frm left middle"><input type="Text" name="#fld#_units" id="#fld#_units" value="#u#" 
				style="width:35px;text-align:center;" class="center rounded" tabindex="#tab3#" disabled></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="#fld#_quantity" id="#fld#_quantity" value="#q#" 
				style="width:45px;text-align:center;" class="center rounded" tabindex="#tab4#" disabled></td>
				<cfset tab4 = tab4+1>
				<td class="frm left middle"><input type="Text" name="#fld#_unit_price" id="#fld#_unit_price" value="#trim(numberformat(p,"999999.00"))#" 
				style="width:65px;text-align:right;" class="rounded" tabindex="#tab5#"></td>
				<cfset tab5 = tab5+1>
				<td class="frm right middle"><span id="#fld#_total">#trim(numberformat(p*q,"999,999.00"))#</span></td>
				<!--- <th class="drk left middle"></th> --->
				<td class="frm left middle"><input type="Text" name="c_#fld#_unit_price" id="c_#fld#_unit_price" value="#trim(numberformat(c,"999999.00"))#" 
				style="width:75px;text-align:right;" class="rounded" tabindex="#tab6#"></td>
				<cfset tab6 = tab6+1>
				<td class="frm right middle"><span id="#fld#_con">#trim(numberformat(c*q,"999,999.00"))#</span></td>
			</tr>
			<cfset etotal = etotal + p*q>
			<cfset ctotal = ctotal + c*q>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
			<tr>
				<th class="left middle" style="height:30px;" colspan="4">Subtotal:</th>
				<td colspan="2" class="frm right middle"><span id="e_subtotal">#trim(numberformat(etotal,"999,999.00"))#</span></td>
				<td colspan="2" class="frm right middle"><span id="c_subtotal">#trim(numberformat(ctotal,"999,999.00"))#</span></td>
				
			</tr>
		
			<tr>
				<th class="left middle" style="height:30px;" colspan="4">
				
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr>
					<th class="left middle" style="width:70px;padding:0px;">Contingency</th>
					<td class="left middle">
						<select name="contingency_percent" id="contingency_percent" class="roundedsmall" style="width:55px;position:relative;top:1px;" tabindex="#tab1#">
						<cfloop index="i" from="0" to="30" step="5">
							<cfset v = getEst.contingency_percent><cfif v is ""><cfset v = 0></cfif>
							<cfset sel = ""><cfif i is (v*100)><cfset sel = "selected"></cfif>
							<cfif getEst.contingency_percent is "" AND i is 30><cfset sel = "selected"></cfif>
							<option value="#i/100#" #sel#>#i#%</option>
						</cfloop>
						</select>
					</td>
					<cfset tab1 = tab1+1>
					</tr>
					</table>
				
				</th>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getEst.recordcount gt 0><cfset v = getEst.contingency></cfif>
				<input type="Text" name="contingency" 
				id="contingency" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:152px;text-align:right;" class="rounded" tabindex="#tab5#">
				</td>
				<cfset tab5 = tab5+1>
				<th class="center middle" style="height:30px;" colspan="2">
				
					<table cellpadding="0" cellspacing="0" border="0" align="center">
					<td style="width:2px;"></td>
					<tr>
					<th>Contractor's Cost</th>
					<td style="width:2px;"></td>
					<td>
					<a onclick="calcConTotal();return false;" href="">
					<img style="position:relative;top:-1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Contractor's Cost">
					</a>
					</td>
					</tr>
					</table>
				
				
				</th>
			</tr>
			<tr>
				<th class="left middle" style="height:30px;" colspan="4">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th>Total Cost:</th>
					<td style="width:2px;"></td>
					<td>
					<a onclick="calcSubTotal();return false;" href="">
					<img style="position:relative;top:-1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Engineer's Estimate">
					</a>
					</td>
					</tr>
					</table>
				
				
				</th>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getEst.recordcount gt 0><cfset v = getEst.ENGINEERS_ESTIMATE_TOTAL_COST></cfif>
				<input type="Text" name="ENGINEERS_ESTIMATE_TOTAL_COST" 
				id="ENGINEERS_ESTIMATE_TOTAL_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:152px;text-align:right;" class="rounded" tabindex="#tab5#">
				</td>
				<cfset tab5 = tab5+1>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getContract.recordcount gt 0><cfset v = getContract.CONTRACTORS_COST></cfif>
				<input type="Text" name="c_CONTRACTORS_COST" 
				id="c_CONTRACTORS_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:147px;text-align:right;" class="rounded" tabindex="#tab6#">
				</td>
				<cfset tab6 = tab6+1>
			</tr>
			<!--- <tr>
				<th class="left middle" style="height:30px;width:100px;">Contractor's Cost:</th>
				<td colspan="3" class="frm left middle">
				<cfset v = 0><cfif getContract.recordcount gt 0><cfset v = getContract.CONTRACTORS_COST></cfif>
				<input type="Text" name="c_CONTRACTORS_COST" 
				id="c_CONTRACTORS_COST" value="#trim(numberformat(v,"999999.00"))#" 
				style="width:110px;text-align:right;" class="rounded"></td>
				</td>
			</tr> --->
			
			
		</table>
	</td>
	</tr>
	
	<tr>
			<th class="drk left middle" colspan="5" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:70px;"></th>
						<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
						</td>
						
						
						<td align="right" style="width:539px;">
							<a href="" id="btn2" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm2(1);return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
	
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>

<table align=center border="0" cellpadding="0" cellspacing="0">
		<tr><td height=15></td></tr>
		<!--- <tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Update</a>
			</td>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="cancelUpdate();return false;">Cancel</a>
			</td>
		</tr>
		<tr><td height=15></td></tr> --->
	</table>
	
<div id="msg2" class="box" style="top:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text2" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<div id="button2a" style="display:block;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Close</a>
				</div>
				<div id="button2b" style="display:none;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="continueUpdate(0);return false;">Continue...</a>&nbsp;&nbsp;
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Cancel</a>
				</div>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>


<div id="msg3" class="box_bottom" style="bottom:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg3').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text3" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<div id="button3a" style="display:block;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg3').hide();return false;">Close</a>
				</div>
				<div id="button3b" style="display:none;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="continueUpdate(1);return false;">Continue...</a>&nbsp;&nbsp;
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg3').hide();return false;">Cancel</a>
				</div>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>

	
</div>



<!--- Get Curbs --->
<cfquery name="getCurbs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblADACurbRamps WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Curb Fields --->
<cfquery name="getFlds2" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH as cml
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblADACurbRamps' AND TABLE_SCHEMA='dbo'
</cfquery>



<div id="box_curb" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:500;display:none;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update ADA Curb Ramps Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:320px;">
	<form name="form4" id="form4" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:320px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:112px;">ADA Curb Ramps<!--- Site Number: ---></th>
						<!--- <td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">#getSite.location_no#
						</td> --->
						
						
						<td align="right" style="width:100px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm4();return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm2();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
		<cfset cnt = 0>
		<cfloop query="getFlds2">			
			<cfif cnt gt 1>
				<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
				<cfset v = replace(column_name,"_"," ","ALL")>
				<cfset v = replace(v,"NO ","number of ","ALL")>
				<cfset v = lcase(v)>
				<cfset v = CapFirst(v)>
				<cfset v = replace(v,"Bsl","BSL","ALL")>
				<cfset v = replace(v,"Dot","DOT","ALL")>
				<cfset v = replace(v,"Bas","BAS","ALL")>
				<cfset v = replace(v," ","&nbsp;","ALL")>
				
				
				<cfset c = "">
				<cfif getCurbs.recordcount gt 0>
					<cfset c = evaluate("getCurbs.#column_name#")>
				</cfif>
				<cfif c is "" AND data_type is not "nvarchar"><cfset c = 0></cfif>
				
				<cfif data_type is not "nvarchar">
				<cfset v = replace(v,"Pullbox","Pullboxes","ALL")>
				<tr>
					<th class="left middle" style="height:30px;width:200px;">#v#:&nbsp;</th>
					<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:100px;text-align:center;" class="center rounded"></td>
				</tr>
				<cfelse>
				
					<cfif cml lt 0>
					<tr><th class="left middle" colspan="2" style="height:20px;">#v#:</th></tr>
					<tr>
						<td class="frm" colspan="2" style="height:46px;">
						<textarea id="#column_name#" class="rounded" style="position:relative;top:0px;left:2px;width:305px;height:38px;">#c#</textarea>
						</td>
					</tr>
					<cfelse>
					<tr><th class="left middle" colspan="2" style="height:20px;">#v#:</th></tr>
					<tr>
						<td class="frm" colspan="2" style="height:30px;">
						<input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:305px;text-align:left;" class="center rounded">
						</td>
					</tr>
					</cfif>
				
				</cfif>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		</table>
	</td>
	</tr>
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>
	
	
	
<div id="msg4" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg4').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text4" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg4').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>
	
	
	
</div>







<div id="box_ass" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;display:none;z-index:500;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update Engineering Estimate / Contractor Pricing Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:655px;">

	<cfset tab1 = 1000><cfset tab2 = 2000><cfset tab3 = 3000><cfset tab4 = 4000><cfset tab5 = 5000><cfset tab6 = 6000>
	
	<form name="form5" id="form5" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="9" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:100px;"><!--- Site Number --->Field Assessment:</th>
						<td class="left middle pagetitle" style="width:350px;font-size: 12px;padding:1px 3px 0px 0px;">Loc No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:87px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm5();return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm3();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
		<tr>
			<th class="left middle" style="height:20px;" colspan="9">Notes / Comments:</th>
		</tr>
		
		<tr>
			<cfset v = "">
			<cfif getQCs.recordcount gt 0>
				<cfset v = getEst.comments>
			</cfif>
			<td class="frm" colspan="9" style="height:56px;">
			<textarea id="comments" class="rounded" style="position:relative;top:0px;left:0px;width:639px;height:50px;">#v#</textarea>
			</td>
		</tr>
		
		
			<tr>
				<th class="center middle" style="height:30px;width:25px;">NO</th>
				<th class="center middle">DESCRIPTION</th>
				<th class="center middle" style="height:30px;width:40px;">UNIT</th>
				<th class="center middle" style="width:70px;">Assessment<br>Quantity</th>
				<cfset num = getFlds.recordcount+4+3>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="width:70px;">QC<br>Quantity</th>
			
				<!--- <cfset num = 4+(getFlds.recordcount - 4)/3> --->
				<cfset num = getFlds.recordcount+4+3>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="width:70px;">TOTAL</th>
			</tr>
		
		<cfset cnt = 0><cfset etotal = 0><cfset ctotal = 0><cfset no = 0><cfset grp = 0>
		<cfloop query="getFlds">
			<!--- <cfif cnt mod 3 is 2> --->
			<cfif right(column_name,6) is "_UNITS">
			<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			<cfset u = ""><cfset q = 0><cfset p = 0><cfset c = "">
			<cfif getEst.recordcount gt 0>
				<cfset u=evaluate("getEst.#fld#_UNITS")>
				<cfset q=evaluate("getEst.#fld#_QUANTITY")>
				<cfset p=evaluate("getEst.#fld#_UNIT_PRICE")>
				<cfif q is ""><cfset q = 0></cfif>
				<cfif p is ""><cfset p = 0></cfif>
			<cfelse>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				<cfset u=evaluate("getDefault.UNITS")>
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>
			</cfif>
			<cfif getQCs.recordcount gt 0>
				<cfset c=evaluate("getQCs.#fld#_QUANTITY")>
				<cfif c is ""><cfset c = ""></cfif>
			</cfif>
			<cfset v = replace(column_name,"___",")_","ALL")><cfset v = replace(v,"__"," (","ALL")><cfset v = replace(v,"_UNITS","","ALL")>
			<cfset v = replace(v,"_l_","_/_","ALL")><cfset v = replace(v,"_ll_",".","ALL")><cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")><cfset v = replace(v,"_FEET","#chr(39)#","ALL")>
			<cfset v = replace(v,"_INCH","#chr(34)#","ALL")><cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CODITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TRESS & LANDSCAPING"></cfif>
				<cfif grp is 5><cfset group = "UTILITIES"></cfif>
				<cfif grp is 6><cfset group = "MISCELLANEOUS ITEMS"></cfif>
				<tr>
				<th class="drk center middle" colspan="4" style="height:15px;">#group#</th>
				<th class="drk center middle"></th>
				<th class="drk center middle"></th>
				</tr>
			</cfif>

			<tr>
				<cfset no = no+1>
				<cfif left(fld,5) is "EXTRA">
				<th class="center middle" style="height:30px;width:25px;">#no#</th>
				<cfelse>
				<th class="center middle" style="height:30px;width:25px;">#sort_order#</th>
				</cfif>
				
				<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
				
					<cfset n=evaluate("getEst.#fld#_NAME")>
					<th class="left middle" style="height:30px;width:320px;">
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
						<th class="left middle">
						<input type="Text" name="ass_#fld#_name" id="ass_#fld#_name" value="#n#" 
						style="position:relative;top:0px;width:220px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#">
						</th>
						<cfset tab1 = tab1+1>
						</tr></table>
					</th>
					
				<cfelse>
					<th class="left middle" style="height:30px;width:320px;">#v#:</th>
				</cfif>

				<td class="frm left middle"><input type="Text" name="ass_#fld#_units" id="ass_#fld#_units" value="#u#" 
				style="width:35px;text-align:center;" class="center rounded" tabindex="#tab3#"></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="ass_#fld#_quantity" id="ass_#fld#_quantity" value="#q#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab4#" onkeyup="addTotal('#fld#');"></td>
				<cfset tab4 = tab4+1>
				
				<cfset out=""><cfif session.user_level lt 2><cfset out = "disabled"></cfif>
				<td class="frm left middle"><input type="Text" name="ass_q_#fld#_quantity" id="ass_q_#fld#_quantity" value="#c#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab5#" onkeyup="addTotal('#fld#');" #out#></td>
				<cfset tab5 = tab5+1>
				<cfset c2 = c>
				<cfif c2 is ""><cfset c2 = 0></cfif>
				<td class="frm center middle"><span id="ass_#fld#_total">#trim(numberformat(c2+q,"999,999"))#</span></td>
			</tr>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		<tr>
		<th class="drk left middle" colspan="9" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:424px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm5();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm3();return false;">Cancel</a>
					</td>
					
					</tr>
				</table>
		</td>
		</tr>
			
			
			
		</table>
	</td>
	</tr>
	
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>

</div>







<div id="box_cor" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;display:none;z-index:500;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update Engineering Estimate / Contractor Pricing Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:815px;">

	<cfset tab1 = 1000><cfset tab2 = 2000><cfset tab3 = 3000><cfset tab4 = 4000><cfset tab5 = 5000><cfset tab6 = 6000>
	
	<form name="form6" id="form6" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="10" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:100px;">Change Orders:</th>
						<td class="left middle pagetitle" style="width:350px;font-size: 12px;padding:1px 3px 0px 0px;">Loc No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:247px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm6();return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm6();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>

		<tr>
			<th class="center middle" style="height:30px;width:25px;">No</th>
			<th class="center middle">Description</th>
			<th class="center middle" style="height:30px;width:40px;">Units</th>
			<th class="center middle" style="width:50px;">Quantity</th>
			<th class="center middle" style="width:70px;">Contractor's<br>Unit Price</th>
			<th class="center middle" style="width:70px;">Contractor's<br>Price&nbsp;</th>
			<cfset num = getFlds.recordcount+4+3>
			<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
			<th class="center middle" style="width:55px;">COR<br>Quantity</th>
			<th class="center middle" style="width:55px;">Total<br>Quantity</th>
		
			<!--- <cfset num = 4+(getFlds.recordcount - 4)/3> --->
			<!--- <cfset num = getFlds.recordcount+4+3>
			<th class="drk center middle" rowspan="#num#" style="width:5px;"></th> --->
			<th class="center middle" style="width:70px;">Total&nbsp;Price</th>
		</tr>
		
		<cfset cnt = 0><cfset etotal = 0><cfset ctotal = 0><cfset no = 0><cfset grp = 0>
		<cfloop query="getFlds">
			<!--- <cfif cnt mod 3 is 2> --->
			<cfif right(column_name,6) is "_UNITS">
			<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			<cfset u = ""><cfset q = 0><cfset p = 0><cfset c = 0><cfset co = 0>
			<cfif getEst.recordcount gt 0>
				<cfset u=evaluate("getEst.#fld#_UNITS")>
				<cfset q=evaluate("getEst.#fld#_QUANTITY")>
				<cfset p=evaluate("getEst.#fld#_UNIT_PRICE")>
				<cfif q is ""><cfset q = 0></cfif>
				<cfif p is ""><cfset p = 0></cfif>
			<cfelse>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				<cfset u=evaluate("getDefault.UNITS")>
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>
			</cfif>
			
			<cfif getQCs.recordcount gt 0>
				<cfset qq=evaluate("getQCs.#fld#_QUANTITY")>
				<cfif qq is ""><cfset qq = 0></cfif>
				<cfset q = q + qq>
			</cfif>
			
			<cfif getCOs.recordcount gt 0>
				<cfset co=evaluate("getCOs.#fld#_QUANTITY")>
				<cfif co is ""><cfset co = 0></cfif>
			</cfif>
			
			<cfif getContract.recordcount gt 0>
				<cfset c=evaluate("getContract.#fld#_UNIT_PRICE")>
				<cfif c is ""><cfset c = 0></cfif>
			</cfif>
			
			<cfset v = replace(column_name,"___",")_","ALL")><cfset v = replace(v,"__"," (","ALL")><cfset v = replace(v,"_UNITS","","ALL")>
			<cfset v = replace(v,"_l_","_/_","ALL")><cfset v = replace(v,"_ll_",".","ALL")><cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")><cfset v = replace(v,"_FEET","#chr(39)#","ALL")>
			<cfset v = replace(v,"_INCH","#chr(34)#","ALL")><cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CODITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TRESS & LANDSCAPING"></cfif>
				<cfif grp is 5><cfset group = "UTILITIES"></cfif>
				<cfif grp is 6><cfset group = "MISCELLANEOUS ITEMS"></cfif>
				<tr>
				<th class="drk center middle" colspan="6" style="height:15px;">#group#</th>
				<th class="drk center middle" colspan="3"></th>
				</tr>
			</cfif>

			<tr>
				<cfset no = no+1>
				<cfif left(fld,5) is "EXTRA">
				<th class="center middle" style="height:30px;width:25px;">#no#</th>
				<cfelse>
				<th class="center middle" style="height:30px;width:25px;">#sort_order#</th>
				</cfif>
				
				<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
				
					<cfset n=evaluate("getEst.#fld#_NAME")>
					<th class="left middle" style="height:30px;width:320px;">
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
						<th class="left middle">
						<input type="Text" name="ass_#fld#_name" id="ass_#fld#_name" value="#n#" 
						style="position:relative;top:0px;width:220px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#" disabled>
						</th>
						<cfset tab1 = tab1+1>
						</tr></table>
					</th>
					
				<cfelse>
					<th class="left middle" style="height:30px;width:320px;">#v#:</th>
				</cfif>

				<td class="frm left middle"><input type="Text" name="co_#fld#_units" id="co_#fld#_units" value="#u#" 
				style="width:37px;text-align:center;" class="center rounded" tabindex="#tab3#" disabled></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="co_#fld#_quantity" id="co_#fld#_quantity" value="#q#" 
				style="width:47px;text-align:center;" class="center rounded" tabindex="#tab4#" disabled></td>
				<cfset tab4 = tab4+1>
				<td class="frm left middle"><input type="Text" name="co_#fld#_unit_price" id="co_#fld#_unit_price" value="#trim(numberformat(c,"999999.00"))#" 
				style="width:67px;text-align:right;" class="rounded" tabindex="#tab5#" disabled></td>
				<cfset tab5 = tab5+1>
				<td class="frm right middle"><span id="co_#fld#_con">#trim(numberformat(c*q,"999,999.00"))#</span></td>

				<cfset out=""><cfif session.user_level lt 3><cfset out = "disabled"></cfif>
				<td class="frm left middle"><input type="Text" name="cor_#fld#_quantity" id="cor_#fld#_quantity" value="#co#" 
				style="width:53px;text-align:center;" class="center rounded" tabindex="#tab6#" onkeyup="addCORTotal('#fld#');" #out#></td>
				<cfset tab6 = tab6+1>
				<td class="frm center middle"><span id="co_#fld#_total_qty">#trim(numberformat(co+q,"999999"))#</span></td>
				<td class="frm center middle"><span id="co_#fld#_total">#trim(numberformat(c*(co+q),"999,999.00"))#</span></td>
			</tr>
			<cfset ctotal = ctotal + c*(co+q)>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		<tr>
				<th class="left middle" style="height:30px;" colspan="3">Contractor's Cost:</th>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getContract.recordcount gt 0><cfset v = getContract.CONTRACTORS_COST></cfif>
				<input type="Text" name="co_CONTRACTORS_COST" 
				id="co_CONTRACTORS_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:122px;text-align:right;" class="rounded" tabindex="#tab5#" disabled>
				</td>
				<th class="left middle" style="height:30px;" colspan="3">&nbsp;&nbsp;Change Order Cost:</th>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getCOs.recordcount gt 0><cfset v = getCOs.CHANGE_ORDER_COST></cfif>
				<input type="Text" name="cor_CHANGE_ORDER_COST" 
				id="cor_CHANGE_ORDER_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:127px;text-align:right;" class="rounded" tabindex="#tab6#">
				</td>
				
			</tr>
		
		<tr>
		<th class="drk left middle" colspan="10" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:586px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm6();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm6();return false;">Cancel</a>
					</td>
					
					</tr>
				</table>
		</td>
		</tr>
			
			
			
		</table>
	</td>
	</tr>
	
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>

</div>





<!--- Get Trees Fields --->
<cfquery name="getFlds3" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH as cml
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
</cfquery>

<div id="box_tree" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:none;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update ADA Curb Ramps Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:420px;">
	<form name="form7" id="form7" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:420px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:212px;">Tree Removal Information</th>
					<td align="right" style="width:100px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm7();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm7();return false;">Cancel</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">
			<span class="pagetitle" style="font-size: 12px;">
			Loc No: #getSite.location_no# - #getSite.name#
			</span>
			</td>
		</tr>
		
		<cfset cnt = 0>
		<cfloop query="getFlds3">			
			<cfif cnt gt 1>
				<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
				<cfset v = replace(column_name,"_"," ","ALL")>
				<cfset v = replace(v,"NO ","number of ","ALL")>
				<cfset v = lcase(v)>
				<cfset v = CapFirst(v)>
				<cfset v = replace(v,"And","and","ALL")>
				<cfset v = replace(v," ","&nbsp;","ALL")>

				<cfset c = "">
				<cfif getTrees.recordcount gt 0>
					<cfset c = evaluate("getTrees.#column_name#")>
				</cfif>
				<cfif c is "" AND data_type is not "nvarchar" AND data_type is not "datetime"><cfset c = 0></cfif>
				
				
				<cfif data_type is "datetime">
				<cfset v = "Date&nbsp;" & replace(v,"&nbsp;Date","","ALL")>
				<tr>
					<th class="left middle" style="height:30px;width:270px;">#v#:&nbsp;</th>
					<cfif c is not ""><cfset c = dateformat(c,"MM/DD/YYYY")></cfif>
					<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
				</tr>
				<cfelseif data_type is not "nvarchar">
				<cfset v = replace(v,"Pullbox","Pullboxes","ALL")>
				<tr>
					<th class="left middle" style="height:30px;">#v#:&nbsp;</th>
					<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
				</tr>
				<cfelse>
				
					<cfif cml lt 0>
					<tr><th class="left middle" colspan="2" style="height:20px;">#v#:</th></tr>
					<tr>
						<td class="frm" colspan="2" style="height:73px;">
						<textarea id="#column_name#" class="rounded" style="position:relative;top:0px;left:2px;width:405px;height:65px;">#c#</textarea>
						</td>
					</tr>
					<cfelse>
					<tr>
						<th class="left middle" style="height:30px;">#v#:&nbsp;</th>
						<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
						style="width:130px;text-align:center;" class="center rounded"></td>
					</tr>
					</cfif>
				
				</cfif>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		</table>
	</td>
	</tr>
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>
	
	
	
<div id="msg5" class="box" style="top:40px;left:1px;width:350px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg5').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text5" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg5').hide();return false;">Close</a>
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
var pid = #url.pid#;
var sid = #url.sid#;
var search = #url.search#;
var loc = #getSite.location_no#;
var geoCnt = #getGeocode.recordcount#;
</cfoutput>
var engCalc = false;
var conCalc = false;
var estSub = false;
var adaSub = false;
var assSub = false;
var corSub = false;
var treeSub = false;

function submitForm() {

	$('#msg').hide();
	var errors = '';var cnt = 0;
	if (trim($('#sw_name').val()) == '')	{ cnt++; errors = errors + "- Facility Name is required!<br>"; }
	if (trim($('#sw_address').val()) == '')	{ cnt++; errors = errors + "- Address is required!<br>"; }
	if (trim($('#sw_type').val()) == '')	{ cnt++; errors = errors + "- Type is required!<br>"; }
	
	//var chk = $.isNumeric(trim($('#sw_tcon').val().replace(/,/g,""))); var chk2 = trim($('#sw_tcon').val());
	//if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Total Concrete must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_priority').val().replace(/,/g,""))); var chk2 = trim($('#sw_priority').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Priority No. must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_zip').val().replace(/,/g,""))); var chk2 = trim($('#sw_zip').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Zip Code must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_no_trees').val().replace(/,/g,""))); var chk2 = trim($('#sw_no_trees').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- No. Trees to Remove per Arborist must be numeric!<br>"; }

	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	
	}
	
	var frm = $('#form1').serializeArray();
	frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });
	frm.push({"name" : "sw_loc", "value" : trim($('#sw_loc').val()) });
	frm.push({"name" : "sw_damage", "value" : trim($('#sw_damage').val()) });
	frm.push({"name" : "sw_tree_notes", "value" : trim($('#sw_tree_notes').val()) });
	
	if ($('#sw_no_trees').is(':disabled')) {
		frm.push({"name" : "sw_no_trees", "value" : trim($('#sw_no_trees').val()) });
	}
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateSite&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		//Go to Referring Project...
		if (pid > 0 && search == false) {
			location.replace("swPackageEdit.cfm?pid=" + pid);
			return false;
		}
		
		$('#NO_TREES_TO_REMOVE_PER_ARBORIST').val($('#sw_no_trees').val());
		$('#TREES_REMOVED_DATE').val($('#sw_tree_rm_date').val());
		$('#TREE_REMOVAL_NOTES').val($('#sw_tree_notes').val());
		treeSub = true;
		
		showMsg("Site Information updated successfully!",1,"Site Information");
	  }
	});
	
}

function cancelUpdate() {
	if (search) { location.replace("../search/swSiteSearch.cfm"); }
	else { location.replace("swPackageEdit.cfm?pid=" + pid); }
}

function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function goToPackage(pid) {
	location.replace(url + "forms/swPackageEdit.cfm?pid=" + pid);
}


function openViewer() 
{
var search="";
if (geoCnt == 0) {
	var chk = trim($('#sw_address').val());
	if (chk != "") { search = "&search=" + escape(chk); }
}

//console.log(search);
var url = "http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRP&ref_no=" + loc + "&pin=&return_url=http%3A%2F%2Fengpermits%2Elacity%2Eorg%2Fexcavation%2Fboe%2Fgo%5Fmenu%5Fgc%2Ecfm&allow_edit=1&p_start_ddate=05-01-2003&p_end_ddate=05-30-2003" + search;
//console.log(url);

newWindow(url,'',900, 700,'no');
return false;
}

function newWindow(mypage, myname, w, h, scroll) 
{
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',menubar=no,resizable=yes,location=no';
	window.open(mypage,myname,winprops);
}

function showMsg2(txt,cnt,id) {
	$('#button2a').show();
	$('#button2b').hide();
	if (id == 1) {
		$('#button2a').hide();
		$('#button2b').show();
	}
	$('#msg_text2').html(txt);
	$('#msg2').height(35+cnt*14+30);
	$('#msg2').css({top:'50%',left:'50%',margin:'-'+($('#msg2').height() / 2)+'px 0 0 -'+($('#msg2').width() / 2)+'px'});
	$('#msg2').show();
}

function showMsg3(txt,cnt,id) {
	$('#button3a').show();
	$('#button3b').hide();
	if (id == 1) {
		$('#button3a').hide();
		$('#button3b').show();
	}
	$('#msg_text3').html(txt);
	$('#msg3').height(35+cnt*14+30);
	$('#msg3').css({top: ($('#btn2').position().top - 100) + 'px' ,left:'50%',margin:'-'+($('#msg3').height() / 2)+'px 0 0 -'+($('#msg3').width() / 2)+'px'});
	$('#msg3').show();
}

function submitForm2(id) {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	if (errors != '') {
		if (id == 0) {
			showMsg2(errors,cnt,0);	}
		else {
			showMsg3(errors,cnt,0);	
		}	
		return false;	
	}
	
	chk = chkCalculated().split(':');
	errors = chk[0];
	cnt = parseInt(chk[1]);
	if (errors != '') {
		if (id == 0) {
			showMsg2(errors,cnt,1);	}
		else {
			showMsg3(errors,cnt,1);	
		}	
		return false;	
	}
	
	
	var frm = $('#form3').serializeArray();
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateEstimate&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
			if (id == 0) {
			showMsg2(data.RESULT,1);	}
			else {
				showMsg3(data.RESULT,1);	
			}	
			return false;	
		}
		
		$('#box').hide();
		$('#msg2').hide();
		$('#msg3').hide();
		
		estSub = true;
		
		<cfoutput>
		<cfloop query="getFlds">
			<cfif right(column_name,6) is "_UNITS">
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			var fld = '#fld#';
			
			var val1 = trim($('#chr(35)##fld#_quantity').val()); if (val1 == '') { val1 = 0; }
			var val2 = trim($('#chr(35)#c_#fld#_unit_price').val()); if (val2 == '') { val2 = 0; }
			
			$('#chr(35)#co_#fld#_con').html((val1*val2).formatMoney(2));
			$('#chr(35)#co_#fld#_unit_price').val((val2*1).formatMoney(2));
			
			var cor = trim($('#chr(35)#co_' + fld + '_total_qty').html());
			if (isNaN(cor) || trim(cor) == '' ) { cor = 0; }

			$('#chr(35)#co_#fld#_total').html((parseInt(cor)*val2).formatMoney(2));

			</cfif>
		</cfloop>
		</cfoutput>
		$('#co_CONTRACTORS_COST').val($('#c_CONTRACTORS_COST').val());
		$('#sw_con_price').val($('#c_CONTRACTORS_COST').val());

		showMsg("Information updated successfully!",1,"Engineering Estimate / Contractor Pricing");
		
	  }
	});

}


function chkForm() {
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds">
		<!--- <cfif cnt mod 3 is 2> --->
		<cfif right(column_name,6) is "_UNITS">
		<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		<cfset v = replace(column_name,"___",")_","ALL")>
		<cfset v = replace(v,"__"," (","ALL")>
		<cfset v = replace(v,"_UNITS","","ALL")>
		<cfset v = replace(v,"_l_","_/_","ALL")>
		<cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
		<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")>
		<cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
		<cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
		<cfset v = replace(v,"_"," ","ALL")>
		<cfset v = lcase(v)>
		<cfset v = CapFirst(v)>
		
		<cfif cnt lt 3>
		var chk = $.isNumeric(trim($('#chr(35)##fld#_maximum').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)##fld#_maximum').val());
		if (chk2 != '' && chk == false)	{ cnt++;errors = errors + '- #v# Maximum must be numeric!<br>'; }
		</cfif>
		
		var chk = $.isNumeric(trim($('#chr(35)##fld#_quantity').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)##fld#_quantity').val());
		if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- #v# Quantity must be numeric!<br>'; }
		var chk = $.isNumeric(trim($('#chr(35)##fld#_unit_price').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)##fld#_unit_price').val());
		if (chk2 != '' && chk == false)	{ cnt++;errors = errors + '- #v# Unit Price must be numeric!<br>'; }
		var chk = $.isNumeric(trim($('#chr(35)#c_#fld#_unit_price').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)#c_#fld#_unit_price').val());
		if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- #v# Contractor\'s Unit Price must be numeric!<br>'; }
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;
}


function calcSubTotal () {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	
	if (errors != '') {
		showMsg2(errors,cnt);		
		return false;	
	}
	
	//$("#TRAFFIC_CONTROL_AND_PERMITS_quantity").val('1');
	//$("#MOBILIZATION_quantity").val('1');
	//$("#TEMPORARY_DRAINAGE_INLET_PROTECTION_quantity").val('1');

	$("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val('0');
	$("#MOBILIZATION_unit_price").val('0');
	$("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val('0');
	$("#contingency").val('0');
	
	var cnt = 0;
	while (cnt < 100) {
	
		var total = getSubTotal();
		//console.log(total);
		
		var pct1 = $("#TRAFFIC_CONTROL_AND_PERMITS_percent").val();
		var pct2 = $("#MOBILIZATION_percent").val();
		var pct3 = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_percent").val();
		
		var max1 = $("#TRAFFIC_CONTROL_AND_PERMITS_maximum").val().replace(',','')/1;
		var max2 = $("#MOBILIZATION_maximum").val().replace(',','')/1;
		var max3 = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_maximum").val().replace(',','')/1;
		
		var five1 = Math.round(total*pct1*100)/100;
		var five2 = Math.round(total*pct2*100)/100;
		var one = Math.round(total*pct3*100)/100;
		var con = Math.round(total*($("#contingency_percent").val())*100)/100;
		
		var tcp = $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val();
		var mob = $("#MOBILIZATION_unit_price").val();
		var tdip = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val();
		
		if (tcp != five1) {
			if (tcp < max1) { $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val(five1.toFixed(2)); }
			else {  $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val(max1.toFixed(2)); }
		}
		
		if (mob != five2) {
			if (mob < max2) { $("#MOBILIZATION_unit_price").val(five2.toFixed(2)); }
			else {  $("#MOBILIZATION_unit_price").val(max2.toFixed(2)); }
		}
		
		if (tdip != one) {
			if (tdip < max3) { $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val(one.toFixed(2)); }
			else {  $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val(max3.toFixed(2)); }
		}
		
		$("#e_subtotal").html(total.formatMoney(2));
		$("#contingency").val(con.formatMoney(2));		
		$("#ENGINEERS_ESTIMATE_TOTAL_COST").val((con+total).formatMoney(2));
		
	    cnt++;
	}
	engCalc = true;

}

function getSubTotal() {

	var total = 0;
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds">
		<!--- <cfif cnt mod 3 is 2> --->
		<cfif right(column_name,6) is "_UNITS">
		<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			<!--- <cfif cnt gt 3> --->
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			//console.log('#fld#');
			var val1 = trim($('#chr(35)##fld#_quantity').val().replace(',','')); if (val1 == '') { val1 = 0; }
			var val2 = trim($('#chr(35)##fld#_unit_price').val().replace(',','')); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_total').html((val1*val2).formatMoney(2));
			total = total + (val1*val2);
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	
	//total = total + (parseInt($('#contingency').val()));
	
	return total;
	
}


function calcConTotal () {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	
	if (errors != '') {
		showMsg2(errors,cnt);		
		return false;	
	}
	
	//$("#TRAFFIC_CONTROL_AND_PERMITS_quantity").val('1');
	//$("#MOBILIZATION_quantity").val('1');
	//$("#TEMPORARY_DRAINAGE_INLET_PROTECTION_quantity").val('1');

	var total = 0;
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds">
		<!--- <cfif cnt mod 3 is 2> --->
		<cfif right(column_name,6) is "_UNITS">
		<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			<!--- <cfif cnt gt 3> --->
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			//console.log('#fld#');
			var val1 = trim($('#chr(35)##fld#_quantity').val().replace(',','')); if (val1 == '') { val1 = 0; }
			var val2 = trim($('#chr(35)#c_#fld#_unit_price').val().replace(',','')); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_con').html((val1*val2).formatMoney(2));
			total = total + (val1*val2);

		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	//console.log(total);
	$('#c_subtotal').html(total.formatMoney(2));
	$('#c_CONTRACTORS_COST').val(total.formatMoney(2));
	conCalc = true;

}

function clearConTotal () {

	//var chk = chkForm().split(':');
	//var errors = chk[0];
	//var cnt = parseInt(chk[1]);
	
	//if (errors != '') {
	//	showMsg2(errors,cnt);		
	//	return false;	
	//}

	var total = 0;
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds">
		<!--- <cfif cnt mod 3 is 2> --->
		<cfif right(column_name,6) is "_UNITS">
		<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			<!--- <cfif cnt gt 3> --->
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			$('#chr(35)#c_#fld#_unit_price').val((0).formatMoney(2));
			$('#chr(35)##fld#_con').html((0).formatMoney(2));
			//total = total + (val1*val2);

		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	//console.log(total);
	$('#c_subtotal').html((0).formatMoney(2));
	$('#c_CONTRACTORS_COST').val((0).formatMoney(2));
	conCalc = true;

}

function resetForm() {
	
	if (estSub == false) { $('#form3')[0].reset(); }
	
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds">
		<!--- <cfif cnt mod 3 is 2> --->
		<cfif right(column_name,6) is "_UNITS">
		<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			var val1 = trim($('#chr(35)##fld#_quantity').val()); if (val1 == '') { val1 = 0; }
			var val2 = trim($('#chr(35)#c_#fld#_unit_price').val()); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_con').html((val1*val2).formatMoney(2));
			
			var val2 = trim($('#chr(35)##fld#_unit_price').val()); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_total').html((val1*val2).formatMoney(2));
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	
	$('#box').hide();
	$('#msg2').hide();
	$('#msg3').hide();
}

function resetForm2() {
	if (adaSub == false) { $('#form4')[0].reset(); }
	$('#box_curb').hide();
	$('#msg4').hide();
}

function openEstimate() {
	$('#box').show();
	engCalc = false;
	conCalc = false;	
}

function openAssessment() {
	$('#box_ass').show();
}

function openChangeOrders() {
	$('#box_cor').show();
}

function chkCalculated() {
	var errors = ""; cnt = 1;
	if (engCalc == false) {	errors = errors + "- You have not calculated the Engineer's Estimate.<br>"; cnt++; }
	if (conCalc == false) {	errors = errors + "- You have not calculated the Contractor's Cost.<br>"; cnt++; }
	if (errors != "") { errors = errors + "Do you want to continue?"; }
	return errors + ":" + cnt;
}

function continueUpdate(id) {
	engCalc = true;
	conCalc = true;	
	submitForm2(id)
}

function showMsg4(txt,cnt) {
	$('#msg_text4').html(txt);
	$('#msg4').height(35+cnt*14+30);
	$('#msg4').css({top:'50%',left:'50%',margin:'-'+($('#msg4').height() / 2)+'px 0 0 -'+($('#msg4').width() / 2)+'px'});
	$('#msg4').show();
}

function submitForm4() {

	var chk = chkForm4().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	if (errors != '') {
		showMsg4(errors,cnt);
		return false;	
	}
	
	var frm = $('#form4').serializeArray();
	
	<cfoutput><cfloop query="getFlds2"><cfif data_type is "nvarchar" AND cml lt 0>
	frm.push({"name" : "#column_name#", "value" : trim($('#chr(35)##column_name#').val()) });
	</cfif></cfloop></cfoutput>
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateADA&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESULT != "Success") {
			showMsg4(data.RESULT,1);
			return false;	
		}
		
		$('#box_curb').hide();
		$('#msg4').hide();
		
		adaSub = true;
				
		showMsg("ADA Curb Ramps updated successfully!",1,"ADA Curb Ramps");
		
	  }
	});
	
}

function chkForm4() {
	
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>
	<cfloop query="getFlds2">			
		<cfif cnt gt 1>
			<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
			<cfset v = replace(column_name,"_"," ","ALL")>
			<cfset v = replace(v,"NO ","number of ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v,"Bsl","BSL","ALL")>
			<cfset v = replace(v,"Dot","DOT","ALL")>
			<cfset v = replace(v,"Bas","BAS","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>

			<cfif data_type is not "nvarchar">
				var chk = $.isNumeric(trim($('#chr(35)##column_name#').val().replace(/,/g,""))); 
				var chk2 = trim($('#chr(35)##column_name#').val());
				if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- #v# must be numeric!<br>'; }
			</cfif>
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;

}

function showRemove() {
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg2').height() / 2)+'px 0 0 -'+($('#msg2').width() / 2)+'px'});
	$('#msg5').show();
}

function deleteSite(idx) {
	var frm = [];
	frm.push({"name" : "sid", "value" : sid });
	//console.log(frm);
	var typ = "deleteSite"; if (idx == 1) { typ = "restoreSite"; }
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=" + typ + "&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if(data.RESULT != "Success") {
			showMsg4(data.RESULT,1);
			return false;	
		}
		location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid);
	  }
	});
}

function updateDefaultPrice() {

	var frm = [];
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=getDefaults&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		var query = jQuery.parseJSON(data.QUERY);
		//console.log(query);
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
				//console.log(item);
				$('#' + item[0] + '_unit_price').val(item[2].formatMoney(2));
			});
		}
	  }
	});
	
}

function addTotal(fld) {

	var qc = $('#ass_q_' + fld + '_quantity').val();
	var as = $('#ass_' + fld + '_quantity').val();
	if (isNaN(qc) || trim(qc) == '' ) { qc = 0; }
	if (isNaN(as) || trim(as) == '' ) { as = 0; }
	$('#ass_' + fld + '_total').html(parseInt(qc)+parseInt(as));

}

function submitForm5() {

	<cfoutput>
	<cfloop query="getFlds">
		<cfif right(column_name,6) is "_UNITS">
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		var fld = '#fld#';
		var qc = $('#chr(35)#ass_q_' + fld + '_quantity').val();
		var as = $('#chr(35)#ass_' + fld + '_quantity').val();
		if (isNaN(qc) || trim(qc) == '' ) { $('#chr(35)#ass_q_' + fld + '_quantity').val(0); }
		if (isNaN(as) || trim(as) == '' ) { $('#chr(35)#ass_' + fld + '_quantity').val(0); }
		</cfif>
	</cfloop>
	</cfoutput>
	
	var frm = $('#form5').serializeArray();
	frm.push({"name" : "comments", "value" : trim($('#comments').val()) });
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateAssessment&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESULT != "Success") {
			showMsg("Assessment Form update failed!",1,"Assessment Form");
			return false;	
		}
		
		$('#box_ass').hide();		
		assSub = true;
		estSub = true;
		
		var total = 0;
		var c_total = 0;
		
		<cfoutput>
		<cfloop query="getFlds">
			<cfif right(column_name,6) is "_UNITS">
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			var fld = '#fld#';
			var qc = $('#chr(35)#ass_q_' + fld + '_quantity').val();
			var as = $('#chr(35)#ass_' + fld + '_quantity').val();
			if (isNaN(qc) || trim(qc) == '' ) { qc = 0; }
			if (isNaN(as) || trim(as) == '' ) { as = 0; }
			$('#chr(35)#' + fld + '_quantity').val(parseInt(qc)+parseInt(as));
			$('#chr(35)#co_' + fld + '_quantity').val(parseInt(qc)+parseInt(as));
			
			var val1 = trim($('#chr(35)##fld#_quantity').val()); if (val1 == '') { val1 = 0; }
			var val2 = trim($('#chr(35)#c_#fld#_unit_price').val()); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_con').html((val1*val2).formatMoney(2));
			$('#chr(35)#co_#fld#_con').html((val1*val2).formatMoney(2));
			$('#chr(35)#co_#fld#_unit_price').val($('#chr(35)#c_#fld#_unit_price').val());
			
			var cor = $('#chr(35)#cor_' + fld + '_quantity').val();
			if (isNaN(cor) || trim(cor) == '' ) { cor = 0; }
			$('#chr(35)#co_#fld#_total_qty').html(parseInt(qc)+parseInt(as)+parseInt(cor));
			$('#chr(35)#co_#fld#_total').html(((parseInt(qc)+parseInt(as)+parseInt(cor))*val2).formatMoney(2));
			
			c_total = c_total + (val1*val2);

			var val2 = trim($('#chr(35)##fld#_unit_price').val()); if (val2 == '') { val2 = 0; }
			$('#chr(35)##fld#_total').html((val1*val2).formatMoney(2));
			total = total + (val1*val2);

			</cfif>
		</cfloop>
		</cfoutput>
		
		$('#e_subtotal').html((total).formatMoney(2));
		$('#c_subtotal').html((c_total).formatMoney(2));
				
		showMsg("Assessment Form updated successfully!",1,"Assessment Form");
		
	  }
	});
	
}

function resetForm3() {
	if (assSub == false) { 
		$('#form5')[0].reset(); 
		<cfoutput>
		<cfloop query="getFlds">
			<cfif right(column_name,6) is "_UNITS">
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			var fld = '#fld#';
			var qc = $('#chr(35)#ass_q_' + fld + '_quantity').val();
			var as = $('#chr(35)#ass_' + fld + '_quantity').val();
			if (isNaN(qc) || trim(qc) == '' ) { qc = 0; }
			if (isNaN(as) || trim(as) == '' ) { as = 0; }
			$('#chr(35)#ass_' + fld + '_total').html(parseInt(qc)+parseInt(as));
			</cfif>
		</cfloop>
		</cfoutput>
	}
	$('#box_ass').hide();
}


function addCORTotal(fld) {

	var co = $('#co_' + fld + '_quantity').val();
	var cor = $('#cor_' + fld + '_quantity').val();
	if (isNaN(co) || trim(co) == '' ) { co = 0; }
	if (isNaN(cor) || trim(cor) == '' ) { cor = 0; }
	$('#co_' + fld + '_total_qty').html(parseInt(co)+parseInt(cor));
	var cop = $('#co_' + fld + '_unit_price').val();
	$('#co_' + fld + '_total').html(((parseInt(co)+parseInt(cor))*cop).formatMoney(2));
	
	var ttl = 0;
	<cfoutput>
	<cfloop query="getFlds">
		<cfif right(column_name,6) is "_UNITS">
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		var fld = '#fld#';
		var cor = $('#chr(35)#cor_' + fld + '_quantity').val();
		var cop = $('#chr(35)#co_' + fld + '_unit_price').val();
		if (isNaN(cor) || trim(cor) == '' ) { co = 0; }
		if (isNaN(cop) || trim(cop) == '' ) { cop = 0; }
		ttl = ttl + (cor*cop);
		</cfif>
	</cfloop>
	</cfoutput>
	
	$('#cor_CHANGE_ORDER_COST').val(ttl.formatMoney(2));
	
}

function submitForm6() {

	<cfoutput>
	<cfloop query="getFlds">
		<cfif right(column_name,6) is "_UNITS">
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		<cfset cor = 0>
		var fld = '#fld#';
		var cor = $('#chr(35)#cor_' + fld + '_quantity').val();
		if (isNaN(cor) || trim(cor) == '' ) { $('#chr(35)#cor_' + fld + '_quantity').val(0); }
		</cfif>
	</cfloop>
	</cfoutput>
	
	var frm = $('#form6').serializeArray();
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateChangeOrder&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESULT != "Success") {
			showMsg("Change Order Form update failed!",1,"Change Order Form");
			return false;	
		}
		
		$('#box_cor').hide();
		$('#sw_changeorder').val(parseFloat($('#cor_CHANGE_ORDER_COST').val()).formatMoney(2));
				
		showMsg("Change Order Form updated successfully!",1,"Change Order Form");
		
	  }
	});
	
}

function resetForm6() {
	if (corSub == false) { 
		//$('#form6')[0].reset(); 
	}
	$('#box_cor').hide();
}

 function resetForm7() {
	if (treeSub == false) { $('#form7')[0].reset(); }
	$('#box_tree').hide();
	$('#msg5').hide();
}


function chkForm7() {
	
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>	
	<cfloop query="getFlds3">			
		<cfif cnt gt 1>
			<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
			<cfset v = replace(column_name,"_"," ","ALL")>
			<cfset v = replace(v,"NO ","number of ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v,"And","and","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>

			<cfif data_type is not "nvarchar" AND data_type is not "datetime">
				var chk = $.isNumeric(trim($('#chr(35)##column_name#').val().replace(/,/g,""))); 
				var chk2 = trim($('#chr(35)##column_name#').val());
				if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'#v#\' must be numeric!<br>'; }
			</cfif>
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;

}

function submitForm7() {

	var chk = chkForm7().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	if (errors != '') {
		showMsg5(errors,cnt);
		return false;	
	}
	
	var frm = $('#form7').serializeArray();
	
	<cfoutput><cfloop query="getFlds3"><cfif data_type is "nvarchar" AND cml lt 0>
	frm.push({"name" : "#column_name#", "value" : trim($('#chr(35)##column_name#').val()) });
	</cfif></cfloop></cfoutput>
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateTrees&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESULT != "Success") {
			showMsg5(data.RESULT,1);
			return false;	
		}
		
		$('#box_tree').hide();
		$('#msg5').hide();
		
		treeSub = true;
		
		$('#sw_no_trees').val($('#NO_TREES_TO_REMOVE_PER_ARBORIST').val());
		$('#sw_tree_rm_date').val($('#TREES_REMOVED_DATE').val());
		$('#sw_tree_notes').val($('#TREE_REMOVAL_NOTES').val());
		
		showMsg("Tree Removals updated successfully!",1,"Tree Removal Form");
		
	  }
	});
	
}

function showMsg5(txt,cnt) {
	$('#msg_text5').html(txt);
	$('#msg5').height(35+cnt*14+30);
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg5').height() / 2)+'px 0 0 -'+($('#msg5').width() / 2)+'px'});
	$('#msg5').show();
}
 

<cfoutput>
<cfset cnt = 0>
<cfloop query="getFlds3">			
<cfif cnt gt 1>
<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
<cfif data_type is "datetime">
$( "#chr(35)##column_name#" ).datepicker();
</cfif>
</cfif>
<cfset cnt = cnt + 1>
</cfloop>
</cfoutput>


$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
$( "#sw_tree_rm_date" ).datepicker();


Number.prototype.formatMoney = function(c, d, t){
var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };

</script>

</html>


            

				

	


