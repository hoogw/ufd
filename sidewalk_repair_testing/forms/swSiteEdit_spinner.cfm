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
<!--- <cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Create New Sidewalk Repair Site</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">


              <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (3) --->
	
                
    
	             <script language="JavaScript" src="../js/progressing_loading_sign.js" type="text/javascript"></script>
                
	
    
                  
	         <!--- End ---- joe hu  7/17/2018 ----- add progressing loading sign ------ (3) --->


</head>

<style type="text/css">
body{background-color: transparent}
</style>

<cfparam name="url.sid" default="312">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">
<cfparam name="url.crid" default="0">
<cfparam name="url.crsearch" default="false">

<!--- Get Package --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>

<cfif url.search is true><cfset url.pid = 0></cfif>

<!--- Get Package --->
<cfset isBSS = false>
<cfset isCert = false>
<cfset sw_pid = ""><cfset sw_grp = "">
<cfif url.pid gt 0>
	<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
	SELECT * FROM tblPackages WHERE id = #url.pid#
	</cfquery>
	<cfset sw_pid = getPackage.package_no>
	<cfset sw_grp = getPackage.package_group>
	<cfif ucase(getPackage.contractor) is "BSS"><cfset isBSS = true></cfif>
<cfelse>
	<cfset sw_pid = getSite.package_no>
	<cfset sw_grp = getSite.package_group>
	<cfif sw_pid is not "" AND sw_grp is not "">
		<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT * FROM tblPackages WHERE package_no = #sw_pid# AND package_group = '#sw_grp#'
		</cfquery>
		<cfif getPackage.recordcount gt 0>
			<cfif ucase(getPackage.contractor) is "BSS"><cfset isBSS = true></cfif>
		</cfif>
	</cfif>
</cfif>
<cfif getSite.package_group is "BSS"><cfset isBSS = true></cfif>
<cfif isdefined("session.user_cert")>
	<cfif session.user_cert is 1><cfset isCert = true></cfif>
</cfif>


<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType ORDER BY type
</cfquery>
<cfquery name="getIsCity" dbtype="query">
SELECT id FROM getType WHERE iscity = 1 ORDER BY id
</cfquery>
<cfset isCityList = ValueList(getIsCity.id)>

<!--- Get Access Type --->
<cfquery name="getAccess" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblAccessImprovementType ORDER BY id
</cfquery>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get Complaints Type --->
<cfquery name="getComplaintType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblComplaintType ORDER BY id
</cfquery>

<!--- Get Phase Type --->
<cfquery name="getPhase" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPhaseType ORDER BY id
</cfquery>

<!--- Get Status/BIC Type --->
<cfquery name="getStatusBIC" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblStatusBICType ORDER BY id
</cfquery>


<!--- Check Geocode --->
<cfquery name="getGeocode" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM vwGeocoder WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get max site --->
<cfquery name="getMaxSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(location_no) as location_no FROM tblSites WHERE location_no < #getSite.location_no# AND removed is null
<cfif search is false><cfif url.pid gt 0>AND package_group = '#sw_grp#' AND package_no = #sw_pid#</cfif></cfif>
</cfquery>
<cfif getMaxSite.location_no is not "">
<cfquery name="getMaxSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT id FROM tblSites WHERE location_no =  #getMaxSite.location_no#
<cfif search is false><cfif url.pid gt 0>AND package_group = '#sw_grp#' AND package_no = #sw_pid#</cfif></cfif>
</cfquery>
</cfif>

<!--- Get min site --->
<cfquery name="getMinSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT min(location_no) as location_no FROM tblSites WHERE location_no > #getSite.location_no# AND removed is null
<cfif search is false><cfif url.pid gt 0>AND package_group = '#sw_grp#' AND package_no = #sw_pid#</cfif></cfif>
</cfquery>
<cfif getMinSite.location_no is not "">
<cfquery name="getMinSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT id FROM tblSites WHERE location_no =  #getMinSite.location_no#
<cfif search is false><cfif url.pid gt 0>AND package_group = '#sw_grp#' AND package_no = #sw_pid#</cfif></cfif>
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
<!--- <cfquery name="getTrees" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeRemovalInfo WHERE location_no = #getSite.location_no#
</cfquery> --->

<!--- Get Trees --->
<cfquery name="chkCert" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT has_certificate FROM vwSites WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Trees --->
<cfquery name="getTreeInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSiteInfo WHERE location_no = #getSite.location_no#
</cfquery>

<cfquery name="getTreeSIRInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSIRs WHERE location_no = #getSite.location_no# AND deleted <> 1 ORDER BY group_no
</cfquery>

<cfquery name="getTreeListInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeList WHERE location_no = #getSite.location_no# AND deleted <> 1
</cfquery>

<cfset arrDisabledTrees = arrayNew(1)>
<cfset arrDisabledTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE__">
<cfset arrDisabledTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE__">
<cfset arrDisabledTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER">
<cfset arrDisabledTrees[4] = "FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT">
<cfset arrDisabledTrees[5] = "TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER__">
<cfset arrDisabledTrees[6] = "TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER__">
<cfset arrDisabledTrees[7] = "FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE">
<cfset arrDisabledTrees[8] = "WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH">
<cfset arrDisabledTrees[9] = "EXISTING_STUMP_REMOVAL">

<!--- Get ChangeOrder Values --->
<cfquery name="getCOs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblChangeOrders WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Create Priority Check --->
<cfset pchk = getSite.Severity_Index & "|" & getSite.Access_Improvement & "|" & getSite.Cost_Effective & "|" & getSite.Within_High_Injury & "|" & getSite.Traveled_By_Disabled & "|" & getSite.Complaints_No & "|" & getSite.High_Pedestrian_Traffic>

<!--- <cfdump var="#pchk#"> --->

<!--- <cfdump var="#isBSS#"> --->

<!--- <cfdump var="#getMaxSite#">
<cfdump var="#getMinSite#"> --->

<cfoutput>
<body alink="#request.color#" vlink="#request.color#" link="#request.color#" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow:auto;">
</cfoutput>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td colspan="3" height="15"></td></tr>
          <tr><td style="width:25%;text-align:right;height:29px;">
		  <cfif isdefined("getMaxSite.id")>
		  <!--- <cfif session.user_level gt 0> --->
		  <cfset x = ""><cfif url.pid gt 0><cfset x = "&pid=" & url.pid></cfif>
          
              
          
          <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ () --->
		  <a  onclick='start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );' href="swSiteEdit.cfm?sid=#getMaxSite.id##x#&search=#search#">
                    <img src="../images/arrow_left.png" width="20" height="29" title="Previous Site" id="leftarrow">
          </a>
          
          
          
          
		  <!--- </cfif> --->
		  </cfif>
		  </td>
		  <td align="center" class="pagetitle">Update Sidewalk Repair Site</td>
		  <td style="width:25%;">
		  <cfif isdefined("getMinSite.id")>
		  <!--- <cfif session.user_level gt 0> --->
		  <cfset x = ""><cfif url.pid gt 0><cfset x = "&pid=" & url.pid></cfif>
          
          
          
          <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
		  <a  onclick='start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );'  href="swSiteEdit.cfm?sid=#getMinSite.id##x#&search=#search#">
              <img src="../images/arrow_right.png" width="20" height="29" title="Next Site" id="rightarrow">
          </a>
          
          
          
		  <!--- </cfif> --->
		  </td>
		  </cfif>
		  </tr>
		  <cfif session.user_level lt 2>
		  	<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><!--- Added for BSS Power User --->
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
			<cfelse>
			<tr><td colspan="3" height="15"></td></tr>
			</cfif>
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
<cfif session.user_level is 0><cfset dis="disabled"></cfif>
<cfif session.user_power lt 0><cfset dis="disabled"></cfif>
<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><cfset dis=""></cfif><!--- Added for BSS bonus power --->


<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
<div id="processing_icon" align="center"></div>
<div id="result_panel"> 




<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:#w#px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:80px;">Site Number:</th>
						<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">#getSite.location_no#<!--- #getSite.site_suffix# --->
						</td>
						
						<cfif sw_pid is not "">		
						
							<cfset x = url.pid>
							<cfif x is 0>
							<cfquery name="getPackageNo" datasource="#request.sqlconn#" dbtype="ODBC">
							SELECT id FROM tblPackages WHERE package_no = #sw_pid# AND package_group = '#sw_grp#'
							</cfquery>
							<cfset x = getPackageNo.id>
							</cfif>
										
						<th class="drk left middle" style="width:55px;">Package:</th>
						<td class="left middle pagetitle" style="width:190px;padding:1px 3px 0px 0px;"><span onMouseOver="this.style.cursor='pointer';" onClick="goToPackage(#x#);return false;">#sw_grp# - #sw_pid#</span>
						</td>
						<cfelse>
						<th class="drk left middle" style="width:270px;"></th>
						</td>
						</cfif>

						<cfif session.user_level gt 0><cfset w0 = 94><cfelse><cfset w0 = 242></cfif>
						<td align="left" style="width:#w0#px;"></td>
						
						
						<cfif getSite.removed is "">
						
							<cfif session.user_power gte 2 OR (isCert AND isBSS)> <!--- Right now, isCert only applies to BSS users for their projects. May need to change in future --->
								<td align="right" style="width:28px;">
								<a href="" onClick="openCertificate();return false;" style="position:relative;top:0px;">
								<img src="../images/certificate.png" width="20" height="20" title="Issue Certificates"></a>
								</td>	
							</cfif>
						
							<cfif session.user_level gte 0>
								<td align="right" style="width:50px;">
								<a href="" onClick="openAttachments();toggleArrows();return false;" style="position:relative;top:0px;">
								<img src="../images/attach_box.png" width="20" height="20" title="Open Attachments"></a>
								</td>	
							</cfif>
						
							<cfif session.user_level gt 0 OR (session.user_level is 0 AND session.user_power is 1 AND isBSS)>
								<td align="right" style="width:50px;">
								<a href="" onClick="openAssessment();toggleArrows();return false;" style="position:relative;top:0px;">
								<img src="../images/assessment.png" width="20" height="20" title="Open Assessment Form"></a>
								</td>						
								
								<td align="right" style="width:28px;">
								<a href="" onClick="openEstimate();toggleArrows();return false;" style="position:relative;top:0px;">
								<img src="../images/dollar.png" width="20" height="20" title="Open Engineering Estimate / Contractor Pricing Form"></a>
								</td>
								
								<td align="right" style="width:28px;">
								<a href="" onClick="openChangeOrders();toggleArrows();return false;" style="position:relative;top:0px;">
								<img src="../images/change.png" width="20" height="20" title="Open Change Orders Form"></a>
								</td>
								
								<td align="right" style="width:42px;">
								<a href="" onClick="$('#chr(35)#box_curb').show();toggleArrows();return false;" style="position:relative;top:0px;">
								<img src="../images/ramp.png" width="20" height="20" title="Open ADA Curb Ramp Form"></a>
								</td>
							</cfif>
							
							<td align="right" style="width:28px;">
							<a href="" onClick="openTreeForm();return false;" style="position:relative;top:0px;">
							<img src="../images/tree.png" width="20" height="20" title="Open Tree Removal Form"></a>
							</td>
							
							<!--- <cfif session.user_level gt 0 AND session.user_power gte 0> --->
								<td align="right" style="width:31px;">
								<cfif getGeocode.recordcount gt 0>
								<a href="" onClick="openViewer();return false;" style="position:relative;top:2px;">
								<img src="../Images/MapChk.png" width="24" height="24" alt="Re-Geocode Site" title="Re-Geocode Site"></a>
								<cfelse>
								<a href="" onClick="openViewer();return false;" style="position:relative;top:0px;left:-4px;">
								<img src="../Images/Map.png" width="20" height="20" alt="Geocode Site" title="Geocode Site"></a>
								</cfif>
								</td>
							<!--- </cfif> --->
						</cfif>
						
						</tr>
					</table>
			
			
			</td>
		</tr>
		
			<tr>
				<th class="left middle" style="height:30px;width:85px;">Facility Name:</th>
				<cfset v = ""><cfif getSite.name is not ""><cfset v = getSite.name></cfif>
				<td class="frm"  style="width:295px;">
				<input type="Text" name="sw_name" id="sw_name" value="#v#" style="width:293px;" class="rounded" #dis#></td>
				<th class="left middle" style="width:93px;">Subtype:</th>
				<td class="frm"  style="width:182px;">
				<select name="sw_type" id="sw_type" class="rounded" style="width:181px;" onChange="chkAccess();" #dis#>
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
							<th class="left middle" style="height:30px;width:86px;">Address:</th>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif getSite.address is not ""><cfset v = getSite.address></cfif>
							<td class="frm" style="width:300px;">
							<input type="Text" name="sw_address" id="sw_address" value="#v#" style="width:293px;" class="rounded" #dis#></td>
							<td style="width:2px;"></td>
							<th class="left middle" style="width:94px;">Council District:</th>
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
							<th class="left middle" style="width:54px;">Zip Code:</th>
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
						<th class="left middle" style="width:75px;">Priority No:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.priority_no is not ""><cfset v = getSite.priority_no></cfif>
						<td class="frm" style="width:39px;">
						<input type="Text" name="sw_priority" id="sw_priority" value="#v#" style="width:35px;text-align:center;padding:4px 1px 4px 1px;" class="rounded" <!--- #dis# ---> disabled></td>
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
						<th class="left middle" style="height:30px;width:119px;">Design Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_designreq" id="sw_designreq" class="rounded" style="width:55px;" #dis# onChange="chkDesign();">
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.design_required is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:75px;">Design<br>Start Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.design_start_date is not ""><cfset v = dateformat(getSite.design_start_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:83px;">
						<cfset distmp = dis>
						<cfif getSite.design_required is not 1><cfset dis = "disabled"></cfif>
						<input type="Text" name="sw_dsgnstart" id="sw_dsgnstart" value="#v#" style="width:79px;text-align:center;" class="rounded" #dis#></td>
						<cfset dis = distmp>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.design_finish_date is not ""><cfset v = dateformat(getSite.design_finish_date,"MM/DD/YYYY")></cfif>
						<th class="left middle" style="width:75px;">Design<br>Finish Date:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:83px;">
						<cfset distmp = dis>
						<cfif getSite.design_required is not 1><cfset dis = "disabled"></cfif>
						<input type="Text" name="sw_dsgnfinish" id="sw_dsgnfinish" value="#v#" style="width:79px;text-align:center;" class="rounded" #dis#></td>
						<cfset dis = distmp>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:85px;padding:0px 3px 0px 2px;">Curb Ramp Only:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_curbramp" id="sw_curbramp" class="rounded" style="width:55px;" #dis# onChange="chkRampOnly();">
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.curb_ramp_only is id><cfset sel = "selected"></cfif>
							<!--- <cfif getSite.curb_ramp_only is "" AND id is 0><cfset selected = "selected"></cfif> --->
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
						<th class="left middle" style="width:85px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.assessed_date is not ""><cfset v = dateformat(getSite.assessed_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:94px;">
						<input type="Text" name="sw_assdate" id="sw_assdate" value="#v#" style="width:89px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:75px;">Assessed By:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.field_assessor is not ""><cfset v = trim(getSite.field_assessor)></cfif>
						<td class="frm" style="width:83px;">
						<input type="Text" name="sw_assessor" id="sw_assessor" value="#v#" style="width:79px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:98px;">Repairs Required:</th>
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
						<th class="left middle" style="height:30px;width:50px;">Severity<br>Index:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:95px;">
						<select name="sw_severity" id="sw_severity" class="rounded" style="width:90px;" #dis#>
						<option value=""></option>
						<cfloop index="id" from="1" to="3">
							<cfset lvl = "Minor"><cfif id is 2><cfset lvl = "Medium"><cfelseif id is 3><cfset lvl = "Major"></cfif>
							<cfset sel = ""><cfif getSite.severity_index is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#id# - #lvl#</option>
						</cfloop>
						</select>
						</td>
						
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:59px;">QC Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.qc_date is not ""><cfset v = dateformat(getSite.qc_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:124px;">
						<input type="Text" name="sw_qcdate" id="sw_qcdate" value="#v#" style="width:119px;text-align:center;" class="rounded" #dis#></td> --->
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:45px;">Phase:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:135px;">
						<select name="sw_phase" id="sw_phase" class="rounded" style="width:130px;" #dis#>
						<option value=""></option>
						<cfloop query="getPhase">
							<cfset sel = ""><cfif getSite.phase is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:74px;">Status / BIC:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:115px;">
						<select name="sw_bic" id="sw_bic" class="rounded" style="width:110px;" #dis#>
						<option value=""></option>
						<cfloop query="getStatusBIC">
							<cfset sel = ""><cfif getSite.statusbic is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:290px;"></th>
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="width:45px;">SRID:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.sr_number is not ""><cfset v = trim(getSite.sr_number)></cfif>
						<td class="frm" style="width:96px;">
						<input type="Text" name="sw_srid" id="sw_srid" value="#v#" style="width:91px;text-align:center;" class="rounded" disabled></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:113px;">Associated SRIDs:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfquery name="getIDs" datasource="#request.sqlconn#">
						SELECT * FROM tblSRNumbers WHERE location_no = #getSite.location_no# AND removed IS NULL ORDER BY sr_number
						</cfquery>
						<cfif getIDs.recordcount gt 0><cfloop query="getIDs"><cfset v = v & "," & SR_Number></cfloop><cfset v = right(v,(len(v)-1))></cfif>
						<td class="frm" style="width:346px;">
						<input type="Text" name="sw_srids" id="sw_srids" value="#v#" style="width:341px;" class="rounded" disabled title="#v#" alt="#v#"></td>
						<td style="width:2px;"></td>
						<th class="right middle" style="height:30px;width:60px;">
						<span style="position:relative;top:1px;">
						<cfif dis is "">
						<a href="" onClick="showSRID(0);return false;"><img src="../images/add2.png" width="16" height="16" title="Add Associated SRID" alt="Add Associated SRID" style="position:relative;right:10px;"></a>
						<a href="" onClick="showSRID(1);return false;"><img src="../images/delete2.png" width="16" height="16" title="Remove Associated SRID" alt="Remove Associated SRID" style="position:relative;right:8px;"></a>
						</cfif>
						</span>
						</th>
						
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="width:147px;">Access Improvement Type:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:339px;">
						
						<cfset typedis = "">
						<cfif ListFindNoCase(isCityList, getSite.access_improvement) is 1>
							<cfset typedis = "disabled">
						</cfif>
						
						
						<select name="sw_ait_type" id="sw_ait_type" class="rounded" style="width:334px;" #dis# #typedis#>
						<option value=""></option>
						<cfloop query="getAccess">
							<cfset sel = ""><cfif getSite.access_improvement is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#type#</option>
						</cfloop>
						</select>
						</td>
				
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">Cost Effective:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="sw_costeffect" id="sw_costeffect" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.cost_effective is id><cfset sel = "selected"></cfif>
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
						
						<th class="left middle" style="width:85px;">Within High<br>Injury Network:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:56px;">
						<select name="sw_injury" id="sw_injury" class="rounded" style="width:51px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.within_high_injury is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
				
						<td style="width:2px;"></td>
						<th class="left middle" style="width:114px;">Traveled By<br>Disabled Person(s):</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="sw_disabled" id="sw_disabled" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.traveled_by_disabled is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Number of 311<br>Complaints:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:65px;">
						<select name="sw_complaints" id="sw_complaints" class="rounded" style="width:60px;" #dis#>
						<option value=""></option>
						<cfloop query="getComplaintType">
							<cfset sel = ""><cfif getSite.complaints_no is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">High Pedestrian Traffic:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="sw_pedestrian" id="sw_pedestrian" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getSite.high_pedestrian_traffic is id><cfset sel = "selected"></cfif>
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
						<th class="left middle" style="width:59px;">QC Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.qc_date is not ""><cfset v = dateformat(getSite.qc_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:82px;">
						<input type="Text" name="sw_qcdate" id="sw_qcdate" value="#v#" style="width:78px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:70px;">Construction<br>Start Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.construction_start_date is not ""><cfset v = dateformat(getSite.construction_start_date,"MM/DD/YYYY")></cfif>
						<!--- <cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><cfset dis=""></cfif> ---><!--- Added for BSS bonus power --->
						<td class="frm"  style="width:82px;">
						<input type="Text" name="sw_con_start" id="sw_con_start" value="#v#" style="width:78px;text-align:center;" class="rounded" #dis#>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:85px;">Construction<br>Completed Date:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfif getSite.construction_completed_date is not ""><cfset v = dateformat(getSite.construction_completed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:82px;">
						<input type="Text" name="sw_con_comp" id="sw_con_comp" value="#v#" style="width:78px;text-align:center;" class="rounded" #dis#>
						</td>
						<!--- <cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><cfset dis="disabled"></cfif> ---><!--- Added for BSS bonus power reset --->
						<td style="width:2px;"></td>
						<th class="left middle" style="width:98px;">Anticipated<br>Completion Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getSite.anticipated_completion_date is not "">
						<cfset v = dateformat(getSite.anticipated_completion_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:82px;">
						<input type="Text" name="sw_antdate" id="sw_antdate" value="#v#" style="width:78px;text-align:center;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
	 
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:59px;">Total Cost:</th>
						<td style="width:2px;"></td>
						<cfset v = 0.00>
						<cfif getContract.recordcount gt 0>
							<cfif getContract.contractors_cost is not ""><cfset v = getContract.contractors_cost></cfif>
						</cfif>
						<cfif getCOs.recordcount gt 0>
							<cfif getCOs.change_order_cost is not ""><cfset v = v + getCOs.change_order_cost></cfif>
						</cfif>
						<cfset v = trim(numberformat(v,"999,999.00"))>
						<td class="frm" style="width:120px;">&nbsp;$&nbsp;
						<input type="Text" name="sw_tc" id="sw_tc" value="#v#" style="width:100px;text-align:center;" class="rounded" disabled></td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="width:120px;">Contractor's Price:</th>
						<td style="width:2px;"></td>
						<cfset v = 0.00>
						<cfif getContract.recordcount gt 0>
							<cfif getContract.contractors_cost is not ""><cfset v = trim(numberformat(getContract.contractors_cost,"999,999.00"))></cfif>
						</cfif>
						<td class="frm" style="width:121px;">&nbsp;$&nbsp;
						<input type="Text" name="sw_con_price" id="sw_con_price" value="#v#" style="width:100px;text-align:center;" class="rounded" disabled></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:112px;">Change Orders:</th>
						<td style="width:2px;"></td>
						<cfset v = 0.00>
						<cfif getCOs.recordcount gt 0>
							<cfif getCOs.change_order_cost is not ""><cfset v = trim(numberformat(getCOs.change_order_cost,"999,999.00"))></cfif>
						</cfif>
						<td class="frm" style="width:121px;">&nbsp;$&nbsp;
						<input type="Text" name="sw_changeorder" id="sw_changeorder" value="#v#" style="width:100px;text-align:center;" class="rounded" disabled></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:185px;">No. of Trees to Remove per Arborist:</th>
						<td style="width:2px;"></td>
						<cfset v = "">
						<cfif getTreeListInfo.recordcount gt 0>
							<cfquery name="getTreeCount" dbtype="query">
							SELECT count(*) as cnt FROM getTreeListInfo WHERE action_type = 0
							</cfquery>
							<cfset v = getTreeCount.cnt>
						</cfif>
						<td class="frm" style="width:71px;">
						<cfset distmp = dis>
						<cfif getSite.curb_ramp_only is 1><cfset dis = "disabled"></cfif>
						<input type="Text" name="sw_no_trees" id="sw_no_trees" value="#v#" style="width:66px;text-align:center;" class="rounded" disabled></td>
						<cfset dis = distmp>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:244px;">
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:0px;"></th>
								<th class="middle">ADA Compliance Exceptions (See Notes):</th>
								<cfset v = ""><cfif getSite.ada_exception is 1><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="sw_excptn" name="sw_excptn" type="checkbox" #v# #dis# onClick="toggleADANotes();"></div></th>
								</tr>
							</table>
						</th>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:165px;">
							<table cellpadding="0" cellspacing="0" border="0" style="height:100%;">
								<tr>
								<th style="width:0px;"></th>
								<th class="middle">Certificate of Compliance:</th>
								<cfset v = ""><cfif chkCert.has_certificate is "Yes"><cfset v = "checked"></cfif>
								<th class="middle">
								<div style="position:relative;top:1px;"><input id="sw_has_cert" name="sw_has_cert" type="checkbox" #v# disabled></div></th>
								</tr>
							</table>
						
						</th>
						<cfset dis = distmp>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:16px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:0px 0px 0px 0px;height:14px;">Tree Removal Notes:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('sw_tree_notes',2,14);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
				</table>
			</th></tr>
			<tr>
				<cfset v = "">
				<cfif getTreeInfo.recordcount gt 0>
					<cfif getTreeInfo.tree_removal_notes is not ""><cfset v = getTreeInfo.tree_removal_notes></cfif>
				</cfif>
				<td class="frm" colspan="4" style="height:42px;">
				<cfset distmp = dis>
				<cfif getSite.curb_ramp_only is 1><cfset dis = "disabled"></cfif>
				<textarea id="sw_tree_notes" name="sw_tree_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:39px;" disabled <!--- #dis# --->>#v#</textarea>
				<cfset dis = distmp>
				</td>
			</tr>
			
			<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><cfset dis=""></cfif><!--- Added for BSS bonus power --->
			<tr><th class="left middle" colspan="4" style="height:16px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:0px 0px 0px 0px;height:14px;">Notes:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('sw_notes',2,13);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
				</table>
			</th></tr>
			<tr>
				<cfset v = getSite.notes>
				<td class="frm" colspan="4" style="height:40px;">
				<!--- <cfset distmp = dis>
				<cfif getSite.curb_ramp_only is 1><cfset dis = "disabled"></cfif> --->
				<textarea id="sw_notes" name="sw_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:39px;" #dis#>#v#</textarea>
				<!--- <cfset dis = distmp> --->
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:16px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:0px 0px 0px 0px;height:14px;">Site Description:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('sw_loc',2,13);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13" title="Expand to View All Text"></a></td></tr>
				</table>
			</th></tr>
			<tr>
				<cfset v = getSite.location_description>
				<td class="frm" colspan="4" style="height:40px;">
				<textarea id="sw_loc" name="sw_loc" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:39px;" #dis#>#v#</textarea>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:16px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:0px 0px 0px 0px;height:14px;">Damage Description:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('sw_damage',2,13);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
				</table></th></tr>
			<tr>
				<cfset v = getSite.damage_description>
				<td class="frm" colspan="4" style="height:40px;">
				<textarea id="sw_damage" name="sw_damage" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:39px;" #dis#>#v#</textarea>
				</td>
			</tr>
			<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><cfset dis="disabled"></cfif><!--- Added for BSS bonus power reset --->
			
			<tr><th class="left middle" colspan="4" style="height:16px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:0px 0px 0px 0px;height:14px;">ADA Compliance Exception Notes:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('sw_excptn_notes',2,13);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
				</table></th></tr>
			<tr>
				<cfset v = getSite.ada_exception_notes>
				<cfset ada_dis = "disabled"><cfif getSite.ada_exception is 1><cfset ada_dis = ""></cfif>
				<td class="frm" colspan="4" style="height:40px;">
				<textarea id="sw_excptn_notes" name="sw_excptn_notes" class="rounded" style="position:relative;top:0px;left:2px;width:679px;height:39px;" #dis# #ada_dis#>#v#</textarea>
				</td>
			</tr>
			

		</table>
	</td>
	</tr>
	<input type="Hidden" id="sw_id" name="sw_id" value="#url.sid#">
	</form>
</table>

   

 




<table align=center border="0" cellpadding="0" cellspacing="0">
		<cfset w2 = (w-80)/2><cfset cs = 3><cfif url.pid gt 0 OR url.search is true OR url.crid gt 0><cfset w2 = (w-180)/2><cfset cs = 5></cfif>
		<cfset v = getSite.removed>
		<tr>
             <td height="22" colspan="#cs#" class="right" style="width:#w#px;" >
             
             
             
             
             <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
               <span id="small_center_delete_icon">
                
                
                
                </span>
                
                
              <!---  
                
                 <span id="small_right_delete_icon">
                
                  <img align="center" style="height:25px;width:25px;padding:3px 0px 0px 0px;"  src="../images/preloader.gif">
                  </img>
                
                </span>
                
				
				--->
                
                
                
				<cfif session.user_level gt 2>
					<cfif v is "">
					<a  href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
					onclick="showRemove();return false;">Delete</a>
					<cfelse>
					<a  href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
					onclick="showRemove();return false;">Restore</a>
					</cfif>
				</cfif>
                
                
                 
                
		      </td>
        </tr>
        
		<cfif v is "">
		<tr>
        
             <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
			<td id="small_right_icon" style="width:#w2#px;"></td>
            
            
            
            
            
			<cfif session.user_level gt 0 AND session.user_power gte 0>
            
            
                
			<td align="center">
            
                
            
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">
                       Update
                   
            
                       
                       </a>
                       
                       
			</td>
			</cfif>
			<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><!--- Added for BSS bonus power reset --->
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Update</a>
			</td>
			</cfif>
			<cfif url.pid gt 0 OR url.search is true OR url.crid gt 0>
			<cfset v = "Back"><cfif session.user_level is 0><cfset v = "Back"></cfif>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="cancelUpdate();return false;">#v#</a>
			</td>
			</cfif>
			<td class="right top" style="width:#w2#px;">
				
			</td>
		</tr>
		</cfif>
		<tr><td height="20px;"></td></tr>
	</table>
	
	
	 
     <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
 </div> <!--- id="result_panel"   --->
    
    
    
    
    
    
    
    
    
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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

<div id="msg10" class="box" style="top:40px;left:1px;width:350px;height:90px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg10').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header10" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<cfset v = getSite.removed>
		<cfif v is ""><cfset v = 0></cfif>
		<cfset msg = "Are you sure you want to delete this Site?<br>This Site will also be removed from any associated Package.">
		<cfif v is 1>
		<cfset msg = "Are you sure you want to restore this Site?<br>This Site will return to the unassigned pool.">
		</cfif>
		<div id="msg_text10" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		#msg#
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="deleteSite(#v#);$('#chr(35)#msg10').hide();return false;">Continue...</a>
			</td>
			<td style="width:0px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg10').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>
	
	
<div id="srid_box" class="box" style="top:40px;left:1px;width:180px;height:94px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#srid_box').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="srid_header" class="box_header"><strong>Add SRID:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="srid_add" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 0px;align:center;text-align:center;">
			<input type="Text" name="sw_add_srid" id="sw_add_srid" value="" style="width:140px;text-align:left;" class="rounded">
			<div style="position:absolute;bottom:15px;width:100%;">
			<table align=center border="0" cellpadding="0" cellspacing="0" width="80%">
				<tr>
				<td align="center">
					<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
					onclick="addSRID();return false;">Add</a>
				</td>
				<td style="width:0px;"></td>
				<td align="center">
					<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
					onclick="$('#chr(35)#srid_box').hide();return false;">Cancel</a>
				</td>
				</tr>
			</table>
			</div>
		</div>
		
		<div id="srid_remove" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 0px;align:center;text-align:center;">
			
			<div id="srid_remove_text" style="width:100%;align:center;text-align:center;"></div>
		
			<div style="position:absolute;bottom:15px;width:100%;">
			<table align=center border="0" cellpadding="0" cellspacing="0" width="80%">
				<tr>
				<td align="center">
					<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
					onclick="removeSRID();return false;">Remove</a>
				</td>
				<td style="width:0px;"></td>
				<td align="center">
					<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
					onclick="$('#chr(35)#srid_box').hide();return false;">Cancel</a>
				</td>
				</tr>
			</table>
			</div>
		
		
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

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:825px;">

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
						<td class="left middle pagetitle" style="width:410px;font-size: 12px;padding:1px 3px 0px 0px;">Site No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:87px;">
							<cfif (session.user_level gt 0 AND session.user_power gte 0) OR (session.user_level is 0 AND session.user_power is 1)>
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm2(0);return false;">Update</a>
							</cfif>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm();toggleArrows();return false;">Cancel</a>
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
					<cfif session.user_level gt 0 AND session.user_power gte 0>
					<td>
					<a onClick="updateDefaultPrice();return false;" href="">
					<img style="position:relative;top:0px;" src="../images/refresh.png" width="16" height="16" title="Refresh Default Unit Prices">
					</a>
					</td>
					</cfif>
					</tr>
					</table>
				
				</th>
				<th class="center middle" style="width:80px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:60px;">Estimated<br>Price</th>
					<cfif session.user_level gt 0 AND session.user_power gte 0>
					<td>
					<a onClick="calcSubTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Engineer's Estimate">
					</a>
					</td>
					</cfif>
					</tr>
					</table>
				
				</th>
				<!--- <cfset num = 4+(getFlds.recordcount - 4)/3> --->
				<cfset num = getFlds.recordcount+4+6>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="height:30px;width:100px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<cfif sw_pid is "" OR sw_grp is "">
						<td style="width:10px;"></td>
					</cfif>
					<th class="center middle" style="width:40px;">Contractor's<br>Unit Price</th>
					<cfif (session.user_level gt 0 AND session.user_power gte 0) OR (session.user_level is 0 AND session.user_power is 1)>
					<td>
					<a onClick="clearConTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/clear.png" width="16" height="16" title="Clear Contractor's Unit Prices">
					</a>
					</td>
						<cfif sw_pid is not "" AND sw_grp is not "">
						<td style="width:5px;"></td>
						<td>
						<a onClick="showMsgAll();return false;" href="">
						<img style="position:relative;top:1px;left:0px;" src="../images/accept.png" width="14" height="14" title="Apply Contractor's Unit Prices to All Sites Within this Bid Package">
						</a>
						</td>
					
						</cfif>
					
					</cfif>
					</tr>
					</table>
				
				
				</th>
				<th class="center middle" style="width:80px;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="width:40px;">Contractor's<br>Price&nbsp;</th>
					<cfif session.user_level gt 0 AND session.user_power gte 0>
					<td>
					<a onClick="calcConTotal();return false;" href="">
					<img style="position:relative;top:1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Contractor's Cost">
					</a>
					</td>
					</cfif>
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
			<cfset v = replace(v,"FOUR_FEET","4#chr(39)#","ALL")>
			<cfset v = replace(v,"SIX_FEET","6#chr(39)#","ALL")>
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
			<cfset v = replace(v,"(u","(U","ALL")>
			<cfset v = replace(v,"(e","(E","ALL")>
			<cfset v = replace(v,"High Strength","High-Strength","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")>
			<cfset v = replace(v," And "," & ","ALL")>
			<cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CONDITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TREES & LANDSCAPING"></cfif>
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
				
				<cfset bssdis = ""><cfif session.user_level is 0 AND session.user_power is 1><cfset bssdis = "disabled"></cfif><!--- Added for BSS bonus power --->
				
				<th class="left middle" style="height:30px;width:320px;">
				
					<table cellpadding="0" cellspacing="0" border="0"><tr>
					<th class="left middle" style="padding:0px;width:180px;">#v#:</th>
					<th class="left middle">
						<cfset per=evaluate("getEst.#fld#_PERCENT")>
						<cfset max=evaluate("getEst.#fld#_MAXIMUM")>
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle">
						<select name="#fld#_percent" id="#fld#_percent" class="roundedsmall" style="width:50px;position:relative;top:1px;" tabindex="#tab1#" #bssdis#>
						<cfset tab1 = tab1+1>
						<cfif per is ""><cfset per = 0></cfif>
						<cfset per = (per*100)>
						
						<cfloop index="i" from="1" to="10" step="1">
							<cfset sel = ""><cfif i is per><cfset sel = "selected"></cfif>
							<cfif cnt gt 1>
								<cfif per is 0 AND i is 1><cfset sel = "selected"></cfif>
							<cfelse>
								<cfif per is 0 AND i is 5><cfset sel = "selected"></cfif>
							</cfif>
							<option value="#i/100#" #sel#>#i#%</option>
						</cfloop>
						<cfset sel = ""><cfif per lt 0><cfset sel = "selected"></cfif>
							<option value="-1" #sel#>Max</option>
						</select>
						</th>
						<th class="left middle">
						<cfif max is "">
							<cfset max = 5000>
							<cfif cnt gt 1><cfset max = 1000></cfif>
						</cfif>
						<input type="Text" name="#fld#_maximum" id="#fld#_maximum" value="#max#" 
						style="position:relative;top:1px;width:55px;text-align:center;height:20px;" class="center roundedsmall" tabindex="#tab2#" #bssdis#>
						</th>
						<cfset tab2 = tab2+1>
						</tr></table>
						
					
					</th>
					</tr></table>
				
				</th>
				<cfelse>
				
					<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
					
						<cfset n=evaluate("getEst.#fld#_NAME")>
						<cfset n = replace(n,'"',"&quot;","ALL")>
						<th class="left middle" style="height:30px;width:320px;">
							<table cellpadding="0" cellspacing="0" border="0"><tr>
							<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
							<th class="left middle">
							<cfset xx = 245><cfif len(column_name) is 20><cfset xx = 240></cfif>
							<input type="Text" name="#fld#_name" id="#fld#_name" value="#n#" 
							style="position:relative;top:0px;width:#xx#px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#" disabled>
							</th>
							<cfset tab1 = tab1+1>
							</tr></table>
						</th>
						
					<cfelse>
						<th class="left middle" style="height:30px;width:320px;">#v#:</th>
					</cfif>
				
				
				</cfif>
				
				<cfset styl = "">
				<cfif u is "EA SITE" OR u is "EA TREE">
					<cfset styl = "font-size:7px;padding:7px 0px 7px 0px;">
				</cfif>

				<td class="frm left middle"><input type="Text" name="#fld#_units" id="#fld#_units" value="#u#" 
				style="width:35px;text-align:center;#styl#" class="center rounded" tabindex="#tab3#" disabled></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="#fld#_quantity" id="#fld#_quantity" value="#q#" 
				style="width:45px;text-align:center;" class="center rounded" tabindex="#tab4#" disabled></td>
				<cfset tab4 = tab4+1>
				<td class="frm left middle"><input type="Text" name="#fld#_unit_price" id="#fld#_unit_price" value="#trim(numberformat(p,"999999.00"))#" 
				style="width:65px;text-align:right;" class="rounded" tabindex="#tab5#" #bssdis#></td>
				<cfset tab5 = tab5+1>
				<td class="frm right middle"><span id="#fld#_total">#trim(numberformat(p*q,"999,999.00"))#</span></td>
				<!--- <th class="drk left middle"></th> --->
				<td class="frm left middle"><input type="Text" name="c_#fld#_unit_price" id="c_#fld#_unit_price" value="#trim(numberformat(c,"999999.00"))#" 
				style="width:95px;text-align:right;" class="rounded" tabindex="#tab6#"></td>
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
						<select name="contingency_percent" id="contingency_percent" class="roundedsmall" style="width:55px;position:relative;top:1px;" tabindex="#tab1#" #bssdis#>
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
				style="width:152px;text-align:right;" class="rounded" tabindex="#tab5#" #bssdis#>
				</td>
				<cfset tab5 = tab5+1>
				<th class="center middle" style="height:30px;" colspan="2">
				
					<table cellpadding="0" cellspacing="0" border="0" align="center">
					<td style="width:2px;"></td>
					<tr>
					<th>Contractor's Cost</th>
					<td style="width:2px;"></td>
					<cfif session.user_level gt 0 AND session.user_power gte 0>
					<td>
					<a onClick="calcConTotal();return false;" href="">
					<img style="position:relative;top:-1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Contractor's Cost">
					</a>
					</td>
					</cfif>
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
					<cfif session.user_level gt 0 AND session.user_power gte 0>
					<td>
					<a onClick="calcSubTotal();return false;" href="">
					<img style="position:relative;top:-1px;" src="../images/Calculator.png" width="16" height="16" title="Calculate Engineer's Estimate">
					</a>
					</td>
					</cfif>
					</tr>
					</table>
				
				
				</th>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getEst.recordcount gt 0><cfset v = getEst.ENGINEERS_ESTIMATE_TOTAL_COST></cfif>
				<input type="Text" name="ENGINEERS_ESTIMATE_TOTAL_COST" 
				id="ENGINEERS_ESTIMATE_TOTAL_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:152px;text-align:right;" class="rounded" tabindex="#tab5#" #bssdis#>
				</td>
				<cfset tab5 = tab5+1>
				<td colspan="2" class="frm left middle">
				<cfset v = 0><cfif getContract.recordcount gt 0><cfset v = getContract.CONTRACTORS_COST></cfif>
				<input type="Text" name="c_CONTRACTORS_COST" 
				id="c_CONTRACTORS_COST" value="#trim(numberformat(v,"999,999.00"))#" 
				style="width:182px;text-align:right;" class="rounded" tabindex="#tab6#">
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
						
						<cfif (session.user_level gt 0 AND session.user_power gte 0) OR (session.user_level is 0 AND session.user_power is 1)>
						<td align="right" style="width:599px;">
							<a href="" id="btn2" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm2(1);return false;">Update</a>
						</td>
						<cfelse>
						<td align="right" style="width:600px;"></td>
						</cfif>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm();toggleArrows();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
	
	<cfset sw_user = ""><cfif session.user_level is 0 AND session.user_power is 1><cfset sw_user = "BSS"></cfif>
	<input type="Hidden" id="sw_user" name="sw_user" value="#sw_user#">
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>

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
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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

<div id="msg_all" class="box" style="top:40px;left:1px;width:480px;height:154px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg_all').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text_all" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		This will update the Contractor Pricing data for ALL sites in this Bid Package (#sw_grp#-#sw_pid#).
		<br>All existing data will be overwritten. This cannot be undone. 
		<br><br>However, the Contractor Cost for each location WILL NOT be updated. 
		<br>You will need to go to each individual Site to calculate the cost.
		<br><br>Do you want to continue?  
		</div>
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="applyConValuesAll();return false;">Continue...</a>&nbsp;&nbsp;
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg_all').hide();return false;">Cancel</a>
			</td></tr>
		</table>
		</div>
	</div>
</div>


<div id="msg3" class="box_bottom" style="bottom:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg3').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
<!--- joe hu 7/20/2018 exclude removed=1 ---     ----->
SELECT * FROM tblCurbRamps WHERE location_no = #getSite.location_no# AND Removed IS NULL ORDER BY ramp_no
</cfquery>


<cfset crvis = "none"><cfif isdefined("url.editcr")><cfset crvis = "block"></cfif>
<div id="box_curb" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:500;display:#crvis#;">

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
						<td align="right" style="width:100px;">
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm2();toggleArrows();return false;">Close</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		<cfloop query="getCurbs">	
		<tr>	
			<th colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:30px;width:170px;">
					<a href="../reports/ConstructionTracking.cfm" target="_blank" style="color:#request.color#">Curb Ramp No. #ramp_no#</a>
					</th>
					<th class="left middle" style="width:100px;">
					<a href="../reports/ConstructionTracking.cfm" target="_blank" style="color:#request.color#">#intersection_corner# Corner</a>
					</th>
					<th class="right middle" style="height:30px;width:100px;">
					<a id="btnFilter" href="" class="buttonSoft buttonText" style="height:15px;width:80px;padding:2px 0px 0px 0px;position:relative;right:5px;" 
				onclick="editRamp(#ramp_no#);return false;">View / Edit</a>
					</th>
					</tr>
				</table>
			</th>
		</tr>
		</cfloop>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:30px;width:320px;">
					<cfif session.user_power gte 0>
					<a id="btnFilter" href="" class="buttonSoft buttonText" style="height:15px;width:100px;padding:2px 0px 0px 0px;position:relative;top:1px;left:0px;" 
				onclick="addRamp(#getSite.location_no#);return false;">Add Curb Ramp</a>
					</cfif>
					</th>
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
	
<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>
	
<div id="msg4" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg4').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:685px;">

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
						<td class="left middle pagetitle" style="width:380px;font-size: 12px;padding:1px 3px 0px 0px;">Site No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:87px;">
							<cfif session.user_level gt 0 AND session.user_power gte 0>
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm5();return false;">Update</a>
							</cfif>
							<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><!--- Added for BSS Power User --->
								<!--- <cfif getSite.package_group is "BSS"> --->
								<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
								onclick="submitForm5();return false;">Update</a>
								<!--- </cfif> --->
							</cfif>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm3();toggleArrows();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
		<!--- <tr>
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
		</tr> --->
		
		
			<tr>
				<th class="center middle" style="height:30px;width:25px;">NO</th>
				<th class="center middle">DESCRIPTION</th>
				<th class="center middle" style="height:30px;width:70px;">UNIT</th>
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
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
			<cfset v = replace(v,"FOUR_FEET","4#chr(39)#","ALL")><cfset v = replace(v,"SIX_FEET","6#chr(39)#","ALL")>
			<cfset v = replace(v,"_FEET","#chr(39)#","ALL")><cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
			<cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(u","(U","ALL")><cfset v = replace(v,"(e","(E","ALL")><cfset v = replace(v,"High Strength","High-Strength","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CONDITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TREES & LANDSCAPING"></cfif>
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
				
				<cfset bssdis = "">
				<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><!--- Added for BSS Power User --->
					<!--- <cfset bssdis = "disabled">
					<cfif getSite.package_group is "BSS">
						<cfset bssdis = "">
					</cfif> --->
				</cfif>
				
				<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
				
					<cfset n=evaluate("getEst.#fld#_NAME")>
					<cfset n = replace(n,'"',"&quot;","ALL")>
					<th class="left middle" style="height:30px;width:320px;">
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
						<th class="left middle">
						<cfset xx = 245><cfif len(column_name) is 20><cfset xx = 240></cfif>
						<input type="Text" name="ass_#fld#_name" id="ass_#fld#_name" value="#n#" 
						style="position:relative;top:0px;width:#xx#px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#" #bssdis#>
						</th>
						<cfset tab1 = tab1+1>
						</tr></table>
					</th>
					
				<cfelse>
					<th class="left middle" style="height:30px;width:320px;">#v#:</th>
				</cfif>

				<td class="frm left middle"><input type="Text" name="ass_#fld#_units" id="ass_#fld#_units" value="#u#" 
				style="width:65px;text-align:center;" class="center rounded" tabindex="#tab3#" maxlength="7" #bssdis#></td>
				<cfset tab3 = tab3+1>
				
				<cfset treedis = "">
				<cfloop index="t" from="1" to="#arrayLen(arrDisabledTrees)#">
					<cfif fld is arrDisabledTrees[t]><cfset treedis = "disabled"></cfif>
				</cfloop>
				
				
				<td class="frm left middle"><input type="Text" name="ass_#fld#_quantity" id="ass_#fld#_quantity" value="#q#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab4#" onKeyUp="addTotal('#fld#');" #treedis# #bssdis#></td>
				<cfset tab4 = tab4+1>
				
				<cfset out=""><cfif session.user_level lt 2><cfset out = "disabled"><cfelse><cfset treedis = ""></cfif>
				<td class="frm left middle"><input type="Text" name="ass_q_#fld#_quantity" id="ass_q_#fld#_quantity" value="#c#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab5#" onKeyUp="addTotal('#fld#');" #out# #treedis#></td>
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
					<th class="drk left middle" style="width:75px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:454px;">
						<cfif session.user_level gt 0 AND session.user_power gte 0>
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm5();return false;">Update</a>
						</cfif>
						<cfif session.user_level is 0 AND session.user_power is 1 AND isBSS><!--- Added for BSS Power User --->
							<!--- <cfif getSite.package_group is "BSS"> --->
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm5();return false;">Update</a>
							<!--- </cfif> --->
						</cfif>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm3();toggleArrows();return false;">Cancel</a>
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

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>

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

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:871px;">

	<cfset tab1 = 1000><cfset tab2 = 2000><cfset tab3 = 3000><cfset tab4 = 4000><cfset tab5 = 5000><cfset tab6 = 6000>
	
	<form name="form6" id="form6" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="11" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:100px;">Change Orders:</th>
						<td class="left middle pagetitle" style="width:550px;font-size: 12px;padding:1px 3px 0px 0px;">Site No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:107px;">
							<!--- <cfif session.user_level gt 0 AND session.user_power gte 0> --->
							<cfif (session.user_power is 3) OR (session.user_level is 0 AND session.user_power is 1)>
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm6();return false;">Update</a>
							</cfif>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm6();toggleArrows();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>

		<tr>
			<th class="center middle" style="height:30px;width:20px;">No</th>
			<th class="center middle">Description</th>
			<th class="center middle" style="height:30px;width:40px;">Units</th>
			<th class="center middle" style="width:50px;">Quantity</th>
			<th class="center middle" style="width:70px;">Contractor's<br>Unit Price</th>
			<th class="center middle" style="width:70px;">Contractor's<br>Price&nbsp;</th>
			<cfset num = getFlds.recordcount+4+3>
			<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
			<th class="center middle" style="width:55px;">COR<br>Quantity</th>
			<th class="center middle" style="width:50px;">Total<br>Quantity</th>
			<th class="center middle" style="width:60px;">Change<br>Order Price</th>
		
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
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
			<cfset v = replace(v,"FOUR_FEET","4#chr(39)#","ALL")><cfset v = replace(v,"SIX_FEET","6#chr(39)#","ALL")>
			<cfset v = replace(v,"_FEET","#chr(39)#","ALL")><cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
			<cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(u","(U","ALL")><cfset v = replace(v,"(e","(E","ALL")><cfset v = replace(v,"High Strength","High-Strength","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>
			
			<cfif grp lt sort_group>
				<cfset grp = sort_group>
				<cfif grp is 1><cfset group = "GENERAL CONDITIONS / GENERAL REQUIREMENTS"></cfif>
				<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
				<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
				<cfif grp is 4><cfset group = "TREES & LANDSCAPING"></cfif>
				<cfif grp is 5><cfset group = "UTILITIES"></cfif>
				<cfif grp is 6><cfset group = "MISCELLANEOUS ITEMS"></cfif>
				<tr>
				<th class="drk center middle" colspan="6" style="height:15px;">#group#</th>
				<th class="drk center middle" colspan="4"></th>
				</tr>
			</cfif>

			<tr>
				<cfset no = no+1>
				<cfif left(fld,5) is "EXTRA">
				<th class="center middle" style="height:30px;">#no#</th>
				<cfelse>
				<th class="center middle" style="height:30px;">#sort_order#</th>
				</cfif>
				
				<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
				
					<cfset n=evaluate("getEst.#fld#_NAME")>
					<cfset n = replace(n,'"',"&quot;","ALL")>
					<th class="left middle" style="height:30px;width:315px;">
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
						<th class="left middle">
						<cfset xx = 240><cfif len(column_name) is 20><cfset xx = 235></cfif>
						<input type="Text" name="co_#fld#_name" id="co_#fld#_name" value="#n#" 
						style="position:relative;top:0px;width:#xx#px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#" disabled>
						</th>
						<cfset tab1 = tab1+1>
						</tr></table>
					</th>
					
				<cfelse>
					<th class="left middle" style="height:30px;width:315px;">#v#:</th>
				</cfif>
				
				<cfset styl = "">
				<cfif u is "EA SITE" OR u is "EA TREE">
					<cfset styl = "font-size:7px;padding:7px 0px 7px 0px;">
				</cfif>

				<td class="frm left middle"><input type="Text" name="co_#fld#_units" id="co_#fld#_units" value="#u#" 
				style="width:37px;text-align:center;#styl#" class="center rounded" tabindex="#tab3#" disabled></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="co_#fld#_quantity" id="co_#fld#_quantity" value="#q#" 
				style="width:47px;text-align:center;" class="center rounded" tabindex="#tab4#" disabled></td>
				<cfset tab4 = tab4+1>
				<td class="frm left middle"><input type="Text" name="co_#fld#_unit_price" id="co_#fld#_unit_price" value="#trim(numberformat(c,"999999.00"))#" 
				style="width:67px;text-align:right;" class="rounded" tabindex="#tab5#" disabled></td>
				<cfset tab5 = tab5+1>
				<td class="frm right middle"><span id="co_#fld#_con">#trim(numberformat(c*q,"999,999.00"))#</span></td>

				<cfset out=""><cfif session.user_level lt 3><cfset out = "disabled"></cfif>
				<cfif session.user_level is 0 AND session.user_power is 1><cfset out=""></cfif>
				<cfif session.user_power is 3><cfset out = ""></cfif>
				<td class="frm left middle"><input type="Text" name="cor_#fld#_quantity" id="cor_#fld#_quantity" value="#co#" 
				style="width:53px;text-align:center;" class="center rounded" tabindex="#tab6#" onKeyUp="addCORTotal('#fld#');" #out#></td>
				<cfset tab6 = tab6+1>
				
				<cfset arrCOQ = listToArray(co+q,".")>
				<cfset nfrmt = "999999">
				<cfif arrayLen(arrCOQ) gt 1>
					<cfset nfrmt = nfrmt & ".">
					<cfloop index="i" from="1" to="#len(arrCOQ[2])#">
						<cfset nfrmt = nfrmt & "9">
					</cfloop>
				</cfif>
				<td class="frm center middle"><span id="co_#fld#_total_qty">#trim(numberformat(co+q,nfrmt))#</span></td>
				<td class="frm right middle"><span id="cop_#fld#_total">#trim(numberformat(c*(co),"999,999.00"))#</span></td>
				<td class="frm right middle"><span id="co_#fld#_total">#trim(numberformat(c*(co+q),"999,999.00"))#</span></td>
			</tr>
			<cfset ctotal = ctotal + c*(co+q)>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		<tr>
				<th class="drk center middle" colspan="11" style="height:2px;"></th>
				</tr>
		
		<tr>
				<td style="height:30px;padding:0px;" colspan="11">
				
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:197px;">&nbsp;&nbsp;Contractor's Cost:</th>
						<td style="width:2px;"></td>
						<td class="frm left middle" style="width:134px;">
						<cfset v = 0>
						<cfif getContract.recordcount gt 0>
							<cfif getContract.CONTRACTORS_COST is not ""><cfset v = getContract.CONTRACTORS_COST></cfif>
						</cfif>
						<cfset v2 = v>
						<input type="Text" name="co_CONTRACTORS_COST" 
						id="co_CONTRACTORS_COST" value="#trim(numberformat(v,"999,999.00"))#" 
						style="width:131px;text-align:right;" class="rounded" tabindex="#tab5#" disabled>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:112px;">&nbsp;&nbsp;Change Order Cost:</th>
						<td style="width:2px;"></td>
						<td class="frm left middle" style="width:134px;">
						<cfset v = 0>
						<cfif getCOs.recordcount gt 0>
							<cfif getCOs.CHANGE_ORDER_COST is not ""><cfset v = v + getCOs.CHANGE_ORDER_COST></cfif>
						</cfif>
						
						<input type="Text" name="cor_CHANGE_ORDER_COST" 
						id="cor_CHANGE_ORDER_COST" value="#trim(numberformat(v,"999,999.00"))#" 
						style="width:131px;text-align:right;" class="rounded" tabindex="#tab6#" #out#>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:108px;">&nbsp;&nbsp;Total Price:</th>
						<td style="width:2px;"></td>
						<td class="frm left middle" style="width:139px;">
						<cfset v = v + v2>
						<input type="Text" name="co_TOTAL" 
						id="co_TOTAL" value="#trim(numberformat(v,"999,999.00"))#" 
						style="width:135px;text-align:right;" class="rounded" tabindex="#tab5#" disabled>
						</td>
						</tr>
					
					</table>
				
				</td>

			</tr>
		
		<tr>
		<th class="drk left middle" colspan="11" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:646px;">
						<!--- <cfif session.user_level gt 0 AND session.user_power gte 0> --->
						<cfif (session.user_power is 3) OR (session.user_level is 0 AND session.user_power is 1)>
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm6();return false;">Update</a>
						</cfif>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm6();toggleArrows();return false;">Cancel</a>
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

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>

</div>




<!--- Create Diameter Array --->
<cfset arrDia = arrayNew(1)>
<cfloop index="i" from="6" to="48" step="2"><cfset go = arrayAppend(arrDia,i)></cfloop>

<!--- Get Species List --->
<cfquery name="getSpecies" datasource="navla_spatial" dbtype="ODBC">
SELECT DISTINCT common FROM dbo.ags_bss_tree_inventory WHERE common is not null ORDER BY common
</cfquery>
<!--- <cfset lstSpecies = ValueList(getSpecies.common,""",""")>
<cfdump var="#lstSpecies#"> --->

<!--- Get ChangeOrder Values --->
<cfquery name="getTreeTypes" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeTypes ORDER BY id
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

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:1082px;">
	<form name="form7" id="form7" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:1082px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:312px;">Tree Information</th>
					<td align="right" style="width:662px;">
						<cfif session.user_level gte 0 AND session.user_power gte 0>
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm7();return false;">Update</a>
						</cfif>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm7();toggleArrows();return false;">Cancel</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">

			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
				<td class="right" style="width:55px;">
				<td class="center"><span class="pagetitle" style="position:relative;top:0px;font-size: 12px;">Site No: #getSite.location_no# - #getSite.name#</span></td>
				<td class="right" style="width:55px;"><span style="position:relative;top:1px;right:-5px;">
				<cfif session.user_level gte 0 AND session.user_power gte 0>
				<a href="" onClick="addSIR();return false;"><img src="../images/add_sir.png" width="24" height="24" title="Add New SIR" style="position:relative;right:0px;"></a>
				<a href="" onClick="delSIR();return false;"><img src="../images/remove_sir.png" width="24" height="24" title="Remove Last SIR" style="position:relative;right:0px;"></a>
				</cfif>
				</span>
				</td></tr>
			</table>

			</td>
		</tr>
		
	<cfset lngth1 = 5>
	<cfset lngth2 = 100>
	<cfloop index="j" from="1" to="#lngth1#">
		<cfset scnt = j>
		
		<cfquery name="chkSIRs" dbtype="query">
		SELECT max(group_no) as mx FROM getTreeSIRInfo
		</cfquery>
		<cfset max_scnt = 1><cfif chkSIRs.recordcount gt 0><cfset max_scnt = chkSIRs.mx></cfif>
		
		<cfset tvis = "block"><cfset sirdis = "">
		<cfif j gt max_scnt><cfset tvis = "none"><cfset sirdis = "disabled"></cfif>
		<tr>
		<td colspan="2" style="padding:0px;">
			<div id="trees_div_#scnt#" style="display:#tvis#;">
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
			
			<tr>
				<th class="drk left middle" colspan="2" style="height:12px;padding:0px 0px 0px 0px;">
				</th>
			</tr>
			<cfif scnt is 1>
			<tr><td style="height:2px;"></td></tr>
			<cfelse>
			<tr><td style="height:20px;"></td></tr>
			</cfif>
			<tr>
				<th class="left middle" colspan="2" style="height:1px;padding:0px 0px 0px 0px;">
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<th class="drk left middle" colspan="2" style="height:3px;padding:0px 0px 0px 0px;">
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				
				<td colspan="2" style="padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
			
					<cfquery name="getSIRs" dbtype="query">
					SELECT * FROM getTreeSIRInfo WHERE group_no = #scnt#
					</cfquery>
					<cfset v = ""><cfif trim(getSIRs.sir_no) is not "">
					<cfset v = trim(getSIRs.sir_no)></cfif>
					<th class="left middle" style="height:22px;width:48px;">SIR #chr(35)#:</th>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:83px;"><input type="Text" name="sir_#scnt#" id="sir_#scnt#" value="#v#" 
					style="width:78px;height:20px;padding:0px 0px 0px 4px;" maxlength="10" class="roundedsmall" #sirdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getSIRs.sir_date) is not "">
					<cfset v = dateformat(trim(getSIRs.sir_date),"mm/dd/yyyy")></cfif>
					<th class="left middle" style="width:70px;">&nbsp;SIR Date:</th>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:100px;"><input type="Text" name="sirdt_#scnt#" id="sirdt_#scnt#" value="#v#" 
					style="width:95px;height:20px;padding:0px;" class="center roundedsmall" #sirdis#></td>
					<td style="width:2px;"></td>
					<th class="left middle"></th>			
				</table>
				</td>
				
			</tr>
			<tr><td style="height:2px;"></td></tr>
			
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 0 AND group_no = #scnt#
				</cfquery>
				
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
			
			<tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="drk left middle"><span style="position:relative;top:0px;">Tree Removals</span>
					<span style="position:relative;top:0px;left:20px;">(Total: <strong><span id="tr_tot_#scnt#" style="color:red;">#max_trcnt#</span></strong> )</span></th>
					<th class="drk right middle"><span style="position:relative;top:1px;">
					<cfif session.user_level gte 0 AND session.user_power gte 0>
					<a href="" onClick="addTree('rmv',#scnt#);return false;"><img src="../images/add.png" width="16" height="16" title="Add Tree Removal" style="position:relative;right:4px;"></a>
					<a href="" onClick="delTree('rmv',#scnt#);return false;"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Removal" style="position:relative;right:2px;"></a>
					</cfif>
					</span>
					</th></tr>
				</table>
			</th></tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<td colspan="2" style="padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<th class="left middle" style="height:22px;width:48px;">Tree No:</th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:57px;"><span style="font-size:10px;">Size<br>(Diameter):</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:75px;"><span style="font-size:10px;">Permit Issuance<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:70px;"><span style="font-size:10px;">Tree Removal<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:240px;">Address:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:189px;">Species:</th>	
					<td style="width:2px;"></td>
					<th class="left middle" style="width:112px;">Type:</th>	
					<td style="width:2px;"></td>
					<th class="left middle" style="">Note:</th>
				</table>
				
				<cfloop index="i" from="1" to="#lngth2#">
				<cfset trcnt = i>
				
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 0 AND group_no = #scnt#
				</cfquery>
				
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
				
				<cfset vis = "block"><cfset trdis = ""><cfif i gt max_trcnt><cfset vis = "none"><cfset trdis = "disabled"></cfif>
				<div id="tr_rmv_div_#scnt#_#trcnt#" style="display:#vis#;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<cfquery name="getList" dbtype="query">
					SELECT * FROM getTreeListInfo WHERE action_type = 0 AND group_no = #scnt# AND tree_no = #trcnt#
					</cfquery>
					<td class="frm left middle" style="width:49px;height:26px;">
					<cfset v = 24><cfif trim(getList.tree_size) is not "">
					<cfset v = trim(getList.tree_size)></cfif>
					<input type="Text" name="trcnt_#scnt#_#trcnt#" id="trcnt_#scnt#_#trcnt#" value="#trcnt#" 
					style="width:46px;height:20px;padding:0px;" class="center roundedsmall" disabled></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:56px;">
					<select name="trdia_#scnt#_#trcnt#" id="trdia_#scnt#_#trcnt#" class="roundedsmall" style="width:54px;height:20px;" #trdis#>
					<cfloop index="i" from="1" to="#arrayLen(arrDia)#">
						<cfset sel = ""><cfif arrDia[i] is v><cfset sel = "selected"></cfif>
						<option value="#arrDia[i]#" #sel#>#arrDia[i]# In.</option>
					</cfloop>
					</select>
					</td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.permit_issuance_date) is not "">
					<cfset v = dateformat(trim(getList.permit_issuance_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:74px;"><input type="Text" name="trpidt_#scnt#_#trcnt#" id="trpidt_#scnt#_#trcnt#" value="#v#" 
					style="width:71px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.tree_removal_date) is not "">
					<cfset v = dateformat(trim(getList.tree_removal_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:69px;"><input type="Text" name="trtrdt_#scnt#_#trcnt#" id="trtrdt_#scnt#_#trcnt#" value="#v#" 
					style="width:66px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = "">
					<cfif trim(getList.address) is not ""><cfset v = trim(getList.address)></cfif>
					<cfif getList.recordcount is 0><cfset v = getSite.address></cfif>
					<td class="frm left middle" style="width:241px;"><input type="Text" name="traddr_#scnt#_#trcnt#" id="traddr_#scnt#_#trcnt#" value="#v#" 
					style="width:238px;height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:190px;">
					<div class="ui-widget">
					<cfset v = ""><cfif trim(getList.species) is not ""><cfset v = trim(getList.species)></cfif>
  					<label for="tr_species_#scnt#_#trcnt#"></label>
					<input type="Text" name="trspecies_#scnt#_#trcnt#" id="trspecies_#scnt#_#trcnt#" value="#v#" 
					style="width:187px;height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" #trdis#>
					</div>
					</td>	
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:113px;">
					<select name="trtype_#scnt#_#trcnt#" id="trtype_#scnt#_#trcnt#" class="roundedsmall" style="width:110px;height:20px;" #trdis#>
					<!--- <option value=""></option> --->
					<cfloop query="getTreeTypes">
						<cfset sel = ""><cfif getList.type is id><cfset sel = "selected"></cfif>
						<option value="#id#" #sel#>#value#</option>
					</cfloop>
					</select>
					</td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.note) is not ""><cfset v = trim(getList.note)></cfif>
					<td class="frm left middle"><input type="Text" name="trnote_#scnt#_#trcnt#" id="trnote_#scnt#_#trcnt#" value="#v#" 
					style="width:237px;height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" #trdis#></td>
				</table>
				</div>
				</cfloop>
				<cfset tr_rmv_cnt = max_trcnt>
				<input type="Hidden" id="tr_rmv_cnt_#scnt#" name="tr_rmv_cnt_#scnt#" value="#tr_rmv_cnt#" #sirdis#>
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 1  AND group_no = #scnt#
				</cfquery>
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
			
			<tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="drk left middle"><span style="position:relative;top:0px;">Tree Plantings</span>
					<span style="position:relative;top:0px;left:25px;">(Total: <strong><span id="tp_tot_#scnt#" style="color:red;">#max_trcnt#</span></strong> )</span></th>
					<th class="drk right middle"><span style="position:relative;top:1px;">
					<cfif session.user_level gte 0 AND session.user_power gte 0>
					<a href="" onClick="addTree('add',#scnt#);return false;"><img src="../images/add.png" width="16" height="16" title="Add Tree Planting" style="position:relative;right:4px;"></a>
					<a href="" onClick="delTree('add',#scnt#);return false;"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Planting" style="position:relative;right:2px;"></a>
					</cfif>
					</span>
					</th></tr>
				</table>
			</th></tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<td colspan="2" style="padding:0px;">
				
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<th class="center middle" style="height:28px;width:30px;"><span style="font-size:10px;">Tree<br>No:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:47px;"><span style="font-size:10px;">Box<br>Size:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:61px;"><span style="font-size:10px;">Permit<br>Issuance<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:61px;"><span style="font-size:10px;">Tree<br>Planting<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:61px;"><span style="font-size:10px;">Start<br>Watering<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:61px;"><span style="font-size:10px;">End<br>Watering<br>Date:</span></th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:190px;"><span style="font-size:10px;">Address:</span></th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:118px;"><span style="font-size:10px;">Species:</span></th>		
					<td style="width:2px;"></td>
					<th class="center middle" style="width:53px;"><span style="font-size:10px;">Parkway or<br>Tree Well<br>Size:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:46px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;">Overhead<br>Wires:</span></th>	
					<td style="width:2px;"></td>
					<th class="center middle" style="width:40px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;">Sub<br>Position:</span></th>	
					<td style="width:2px;"></td>
					<th class="center middle" style="width:48px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;">Post<br>Inspected:</span></th>	
					<td style="width:2px;"></td>
					<th class="left middle" ><span style="font-size:10px;">Type:</span></th>	
					<td style="width:2px;"></td>
					<th class="left middle" style="width:32px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;">Offsite:</span></th>	
					<td style="width:2px;"></td>
					<th class="center middle" style="width:28px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;">Note:</span></th>
					<td style="width:2px;"></td>
					<th class="center middle" style="width:16px;padding: 1px 1px 1px 3px;"><span style="font-size:10px;"></span></th>

				</table>
				
				<cfloop index="i" from="1" to="#lngth2#">
				<cfset trcnt = i>
				
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 1  AND group_no = #scnt#
				</cfquery>
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
				
				<cfset vis = "block"><cfset trdis = ""><cfif i gt max_trcnt><cfset vis = "none"><cfset trdis = "disabled"></cfif>
				<div id="tr_add_div_#scnt#_#trcnt#" style="display:#vis#;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<cfquery name="getList" dbtype="query">
					SELECT * FROM getTreeListInfo WHERE action_type = 1 AND group_no = #scnt# AND tree_no = #trcnt#
					</cfquery>
					<td class="frm left middle" style="width:29px;height:26px;">
					<cfset v = 24><cfif trim(getList.tree_box_size) is not "">
					<cfset v = trim(getList.tree_box_size)></cfif>
					<input type="Text" name="tpcnt_#scnt#_#trcnt#" id="tpcnt_#scnt#_#trcnt#" value="#trcnt#" 
					style="width:26px;height:20px;padding:0px;" class="center roundedsmall" disabled></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:46px;">
					<select name="tpdia_#scnt#_#trcnt#" id="tpdia_#scnt#_#trcnt#" class="roundedsmall" style="width:45px;height:20px;font-size:9px;" onChange="calcTrees();" #trdis#>
					<cfloop index="i" from="1" to="#arrayLen(arrDia)#">
						<cfset sel = ""><cfif arrDia[i] is v><cfset sel = "selected"></cfif>
						<option value="#arrDia[i]#" #sel#>#arrDia[i]# In.</option>
					</cfloop>
					</select>
					</td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.permit_issuance_date) is not "">
					<cfset v = dateformat(trim(getList.permit_issuance_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:60px;"><input type="Text" name="tppidt_#scnt#_#trcnt#" id="tppidt_#scnt#_#trcnt#" value="#v#" 
					style="width:57px;height:20px;padding:0px;font-size:10px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.tree_planting_date) is not "">
					<cfset v = dateformat(trim(getList.tree_planting_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:60px;"><input type="Text" name="tptrdt_#scnt#_#trcnt#" id="tptrdt_#scnt#_#trcnt#" value="#v#" 
					style="width:57px;height:20px;padding:0px;font-size:10px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.start_watering_date) is not "">
					<cfset v = dateformat(trim(getList.start_watering_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:60px;"><input type="Text" name="tpswdt_#scnt#_#trcnt#" id="tpswdt_#scnt#_#trcnt#" value="#v#" 
					style="width:57px;height:20px;padding:0px;font-size:10px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.end_watering_date) is not "">
					<cfset v = dateformat(trim(getList.end_watering_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:60px;"><input type="Text" name="tpewdt_#scnt#_#trcnt#" id="tpewdt_#scnt#_#trcnt#" value="#v#" 
					style="width:57px;height:20px;padding:0px;font-size:10px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = "">
					<cfif trim(getList.address) is not ""><cfset v = trim(getList.address)></cfif>
					<cfif getList.recordcount is 0><cfset v = getSite.address></cfif>
					<td class="frm left middle" style="width:191px;"><input type="Text" name="tpaddr_#scnt#_#trcnt#" id="tpaddr_#scnt#_#trcnt#" value="#v#" 
					style="width:188px;height:20px;padding:0px 2px 0px 4px;font-size:10px;" class="roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:119px;">
					<div class="ui-widget">
					<cfset v = ""><cfif trim(getList.species) is not ""><cfset v = trim(getList.species)></cfif>
  					<label for="tp_species_#scnt#_#trcnt#"></label>
					<input type="Text" name="tpspecies_#scnt#_#trcnt#" id="tpspecies_#scnt#_#trcnt#" value="#v#" 
					style="width:116px;height:20px;padding:0px 2px 0px 4px;font-size:9px;" class="roundedsmall" #trdis#>
					</div>
					</td>	

					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.parkway_treewell_size) is not ""><cfset v = trim(getList.parkway_treewell_size)></cfif>
					<td class="frm left middle" style="width:52px;"><input type="Text" name="tpparkway_#scnt#_#trcnt#" id="tpparkway_#scnt#_#trcnt#" value="#v#" 
					style="width:49px;height:20px;padding:0px 2px 0px 4px;font-size:10px;" maxlength="20" class="roundedsmall" #trdis#></td>
					
					<td style="width:2px;"></td>
					<cfset v = ""><cfif getList.overhead_wires is 1><cfset v = "checked"></cfif>
					<td class="frm left middle" style="width:46px;">
					<div style="position:relative;left:12px;"><input id="tpoverhead_#scnt#_#trcnt#" name="tpoverhead_#scnt#_#trcnt#" type="checkbox" #v# #trdis#></div>
					</td>
					
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.sub_position) is not ""><cfset v = trim(getList.sub_position)></cfif>
					<td class="frm left middle" style="width:40px;"><input type="Text" name="tpsubpos_#scnt#_#trcnt#" id="tpsubpos_#scnt#_#trcnt#" value="#v#" 
					style="width:36px;height:20px;padding:0px 2px 0px 4px;font-size:10px;" maxlength="3" class="center roundedsmall" #trdis#></td>
					
					<td style="width:2px;"></td>
					<cfset v = ""><cfif getList.post_inspected is 1><cfset v = "checked"></cfif>
					<td class="frm left middle" style="width:48px;">
					<div style="position:relative;left:12px;"><input id="tppostinspect_#scnt#_#trcnt#" name="tppostinspect_#scnt#_#trcnt#" type="checkbox" #v# #trdis#></div>
					</td>
					
					<td style="width:2px;"></td>
					<td class="frm left middle">
					<select name="tptype_#scnt#_#trcnt#" id="tptype_#scnt#_#trcnt#" class="roundedsmall" style="width:95px;height:20px;font-size:9px;" #trdis#>
					<!--- <option value=""></option> --->
					<cfloop query="getTreeTypes">
						<cfset sel = ""><cfif getList.type is id><cfset sel = "selected"></cfif>
						<option value="#id#" #sel#>#value#</option>
					</cfloop>
					</select>
					</td>
					
					<td style="width:2px;"></td>
					<cfset v = ""><cfif getList.offsite is 1><cfset v = "checked"></cfif>
					<td class="frm left middle" style="width:32px;">
					<div style="position:relative;left:5px;"><input id="tpoffsite_#scnt#_#trcnt#" name="tpoffsite_#scnt#_#trcnt#" type="checkbox" #v# #trdis#></div>
					</td>
					
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:28px;">
					<div style="position:relative;left:7px;top:-1px">
					<a href="" onClick="$('#chr(35)#tpnotediv_#scnt#_#trcnt#').toggle();return false;"><img src="../images/rep.gif" width="12" height="14" alt="Note" title="Note"></a>
					</div>
					</td>
					
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:16px;">
					<cfset img = "map_small.png"><cfset msg = "Map Tree ID: #getList.id#">
					<cfif getList.id is "">
						<cfset img = "map_small_x.png"><cfset msg = ""><cfset fuctn = "">
					<cfelse>
						<cfquery name="getCnt" datasource="ufd_inventory_spatial" dbtype="ODBC">
						SELECT count(*) as cnt FROM #request.tree_tbl# WHERE srp_tree_id = #getList.id#
						</cfquery>
						<cfif getCnt.cnt gt 0><cfset img = "map_small_chk.png"></cfif>
						<cfset fuctn = "geocodeTree(#scnt#,#trcnt#,#getList.id#);">
					</cfif>
					<div style="position:relative;left:0px;top:-1px">
					<a id="tplink_#scnt#_#trcnt#" href="" onClick="#fuctn#return false;"><img id="tpicon_#scnt#_#trcnt#" name="tpicon_#scnt#_#trcnt#" src="../images/#img#" width="16" height="16" alt="#msg#" title="#msg#"></a>
					</div>
					</td>
					
					<td style="width:0px;position:absolute;">
					<div id="tpnotediv_#scnt#_#trcnt#" style="position:absolute;height:30px;width:400px;top:-2px;left:-456px;border:0px red solid;background:white;display:none;">
						<table cellpadding="0" cellspacing="0" border="0" class="frame" style="width:100%;position:relative;top:0px;border-width:1px;">
						<tr><td colspan="2" style="height:1px;"></td></tr>
						<tr>
						<td style="width:1px;"></td>
						<th class="left middle" style="width:28px;height:24px;"><span style="font-size:10px;">Note:</span></th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif trim(getList.note) is not ""><cfset v = trim(getList.note)></cfif>
						<td class="frm left middle" style=""><input type="Text" name="tpnote_#scnt#_#trcnt#" id="tpnote_#scnt#_#trcnt#" value="#v#" 
					style="width:354px;height:20px;padding:0px 2px 0px 4px;font-size:10px;top:-1px;position:relative;" class="roundedsmall" #trdis#></td>
						<td style="width:1px;"></td>
						</tr>
						<tr><td colspan="2" style="height:1px;"></td></tr>
						</table>
					</div>
					</td>
					
				</table>
				</div>
				</cfloop>
				<cfset tr_add_cnt = max_trcnt>
				<input type="Hidden" id="tr_add_cnt_#scnt#" name="tr_add_cnt_#scnt#" value="#tr_add_cnt#" #sirdis#>
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr><th class="drk" style="height:0px;"></th></tr>
			</table>
			<!--- <input type="Hidden" id="tr_add_cnt_#scnt#" name="tr_add_cnt_#scnt#" value="#tr_add_cnt#"> --->
			</div>
		</td>
		</tr>
		
	</cfloop>
		
		<cfset arrTrees = arrayNew(1)>
		<cfset arrTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___">
		<cfset arrTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE___">
		<cfset arrTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER_">
		<cfset arrTrees[4] = "EXISTING_STUMP_REMOVAL_">
		<cfset arrTrees[5] = "FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_">
		<cfset arrTrees[6] = "WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH_">
	
		<tr>
			<td style="padding:0px;" colspan="2">
			
			<div>
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
					<th class="drk left middle" colspan="11" style="height:12px;padding:0px 0px 0px 0px;">
					</th>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="center middle" style="height:20px;">DESCRIPTION</th>
					<td style="width:2px;"></td>
					<th class="center middle">UNIT</td>
					<td style="width:2px;"></td>
					<th class="center middle">Assessment Quantity</td>
					<td style="width:2px;"></td>
					<th class="center middle" style="height:20px;">DESCRIPTION</th>
					<td style="width:2px;"></td>
					<th class="center middle">UNIT</td>
					<td style="width:2px;"></td>
					<th class="center middle">Assessment Quantity</td>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="drk left middle" colspan="11" style="height:2px;padding:0px 0px 0px 0px;">
					</th>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;width:220px;">Tree Root Pruning / Shaving (Per Tree):&nbsp;</th>
					<td style="width:2px;"></td>
					<cfset tr_fld = arrTrees[1]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[1]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[1]#UNITS")></cfif>
					<td class="frm left middle" style="width:43px;"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[1]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[1]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					
					<td style="width:2px;"></td>
					
					<th class="left middle" style="height:30px;">Existing Stump Removal:&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[4]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[4]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[4]#UNITS")></cfif>
					<td class="frm left middle" style="width:43px;"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[4]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[4]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;">Tree Canopy Pruning (Per Tree):&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[2]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[2]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[2]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[2]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[2]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					
					<td></td>
					
					<th class="left middle" style="height:30px;">Furnish & Plant 24" Box Size Tree:&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[5]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[5]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[5]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[5]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[5]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded" disabled></td>
					
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
						<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
						<tr>
						<th class="left middle">Install Root Control Barrier:</th>
						
						<th class="right middle"><div style="position:relative;right:-4px;">Locked</div></th>
						
						<cfset v = ""><cfif getTreeInfo.root_barrier_lock is 1><cfset v = "checked"></cfif>						
						<th style="width:16px;"><div style="position:relative;left:0px;"><input id="tree_lock" name="tree_lock" type="checkbox" #v#></div></th>
						</tr>
						</table>
						
					</th>
					<td></td>
					<cfset tr_fld = arrTrees[3]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[3]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[3]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[3]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[3]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded" onKeyUp="autoLock();"></td>
					
					<td></td>
					
					<th class="left middle" style="height:30px;">Water Tree (Up To 30 Gallons / Week) For One Month:&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[6]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[6]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[6]#UNITS")></cfif>
					
					<cfset styl = ""><cfif v is "EA TREE" OR v is "EA SITE"><cfset styl = "font-size:7px;padding:7px 0px 7px 0px;"></cfif>

					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;#styl#" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[6]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[6]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded" disabled></td>
					
				</tr>
				
				<tr><td style="height:2px;"></td></tr>
				
				<tr>
					<td colspan="11">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th class="left middle" style="height:30px;width:220px;">Arborist Name:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.arborist_name) is not "">
								<cfset v = trim(getTreeInfo.arborist_name)></cfif>
								<td class="frm left middle" style="width:375px;"><input type="Text" name="tree_arbname" id="tree_arbname" value="#v#" 
								style="width:370px;" class="rounded"></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:120px;">Pre-Inspection By:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.pre_inspection_by) is not "">
								<cfset v = trim(getTreeInfo.pre_inspection_by)></cfif>
								<td class="frm left middle" style="width:149px;"><input type="Text" name="tree_preinspby" id="tree_preinspby" value="#v#" 
								style="width:144px;" class="rounded"></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:183px;">
									<table cellpadding="0" cellspacing="0" border="0">
									<tr>
									
									<th class="left middle" style="width:80px;"><span style="position:relative;left:0px;top:1px;">Ready to Plant</span></th>
									<cfset v = ""><cfif getTreeInfo.ready_to_plant is 1><cfset v = "checked"></cfif>		
									<th style="width:16px;"><div style="position:relative;left:-5px;top:1px;"><input id="tree_readytp" name="tree_readytp" type="checkbox" #v#></div></th>			
									</tr>
									</table>
								</th>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr><td style="height:2px;"></td></tr>
				
				<tr>
					<td colspan="11">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th class="left middle" style="height:30px;width:220px;">Tree Removal Contractor:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.tree_removal_contractor) is not "">
								<cfset v = trim(getTreeInfo.tree_removal_contractor)></cfif>
								<td class="frm left middle" style="width:375px;"><input type="Text" name="tree_trc" id="tree_trc" value="#v#" 
								style="width:370px;" class="rounded"></td>
								<td></td>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif getTreeInfo.pre_inspection_date is not ""><cfset v = dateformat(getTreeInfo.pre_inspection_date,"MM/DD/YYYY")></cfif>
								<th class="left middle" style="height:30px;width:120px;">Pre-Inspection Date:&nbsp;</th>
								<td style="width:2px;"></td>
								<td class="frm left middle" style="width:149px;"><input type="Text" name="tree_preinspdt" id="tree_preinspdt" value="#v#" 
								style="width:144px;text-align:center;" class="rounded"></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:183px;"></th>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<td colspan="11">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th class="left middle" style="height:30px;width:220px;">Tree Planting Contractor:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.tree_planting_contractor) is not "">
								<cfset v = trim(getTreeInfo.tree_planting_contractor)></cfif>
								<td class="frm left middle" style="width:375px;"><input type="Text" name="tree_tpc" id="tree_tpc" value="#v#" 
								style="width:370px;" class="rounded"></td>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.post_inspection_by) is not "">
								<cfset v = trim(getTreeInfo.post_inspection_by)></cfif>
								<th class="left middle" style="height:30px;width:120px;">Post-Inspection By:&nbsp;</th>
								<td style="width:2px;"></td>
								<td class="frm left middle" style="width:149px;"><input type="Text" name="tree_postinspby" id="tree_postinspby" value="#v#" 
								style="width:144px;" class="rounded"></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:183px;"></th>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr><td style="height:2px;"></td></tr>
				<tr>
				
					<td colspan="11">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th class="left middle" style="height:30px;width:220px;">Tree Watering Contractor:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif trim(getTreeInfo.tree_watering_contractor) is not "">
								<cfset v = trim(getTreeInfo.tree_watering_contractor)></cfif>
								<td class="frm left middle" style="width:375px;"><input type="Text" name="tree_twc" id="tree_twc" value="#v#" 
								style="width:370px;" class="rounded" disabled></td>
								<td></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:120px;">Post-Inspection Date:&nbsp;</th>
								<td style="width:2px;"></td>
								<cfset v = ""><cfif getTreeInfo.post_inspection_date is not ""><cfset v = dateformat(getTreeInfo.post_inspection_date,"MM/DD/YYYY")></cfif>
								<td class="frm left middle" style="width:149px;"><input type="Text" name="tree_postinspdt" id="tree_postinspdt" value="#v#" 
								style="width:144px;text-align:center;" class="rounded"></td>
								<td style="width:2px;"></td>
								<th class="left middle" style="height:30px;width:183px;"></th>
							</tr>
						</table>
					</td>
				</tr>
				
				
				<tr><td style="height:2px;"></td></tr>
				<tr><th class="left middle" colspan="11" style="height:20px;">
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:1px 0px 0px 0px">Tree Removal Notes:</th>
					<td class="right" style="padding:0px;"><a href="" onClick="expandTextArea('tree_trn',4,14);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
					</table>
				</th></tr>
				<tr><td style="height:2px;"></td></tr>
				
				
				
				
				<tr>
					<cfset v = ""><cfif trim(getTreeInfo.tree_removal_notes) is not "">
					<cfset v = trim(getTreeInfo.tree_removal_notes)></cfif>
					<td class="frm" colspan="11" style="height:73px;">
					<textarea id="tree_trn" class="rounded" style="position:relative;top:0px;left:2px;width:1068px;height:69px;">#v#</textarea>
					</td>
				</tr>
				
				
				
			</table>
			
			</div>
			
			
			</td>
		</tr>
		
		
		<!--- <cfif session.user_power gte 0>
		<tr>
		<th class="left middle" colspan="2" style="height:30px;">
			
			<cfset src_arb = "../images/pdf_icon_trans.gif"><cfset href_arb = "">
			<cfset src_rmvl = "../images/pdf_icon_trans.gif"><cfset href_rmvl = "">
			
			<cfset cnt = 5 - len(getSite.location_no)><cfset dir2 = getSite.location_no><cfloop index="i" from="1" to="#cnt#"><cfset dir2 = "0" & dir2></cfloop>
			<cfset dir = request.dir & "\pdfs\" & dir2>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.pdf">
			<cfloop query="pdfdir">
				<cfif lcase(pdfdir.name) is "tree_removal_permits." & dir2 & ".pdf">
					<cfset src_rmvl = "../images/pdf_icon.gif">
					<cfset href_rmvl = "href = '" & request.url & "pdfs/" & dir2 & "/tree_removal_permits." & dir2 & ".pdf' title='View Tree Removal Permits PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "arborist_report." & dir2 & ".pdf">
					<cfset src_arb = "../images/pdf_icon.gif">
					<cfset href_arb = "href = '" & request.url & "pdfs/" & dir2 & "/arborist_report." & dir2 & ".pdf' title='View Arborist Report PDF'">
				</cfif>
			</cfloop>
			
			
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
					<cfset attvis = "hidden"><cfif href_rmvl is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_rmvl" #href_rmvl# target="_blank"><img id="img_rmvl" src="#src_rmvl#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Tree Removal Permits</span></a>
					<span id="rmv_rmvl" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(0);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Tree Removal Permits" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
					<cfset attvis = "hidden"><cfif href_arb is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:120px;"><a id="a_arb" #href_arb# target="_blank"><img id="img_arb" src="#src_arb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Arborist Report</span></a>
					<span id="rmv_arb" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(1);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Arborist Report" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
					<th><a href="" onclick="showAttach();return false;"><img src="../images/attach.png" width="9" height="15" title="Attach Files" style="position:relative;top:3px;right:5px;">
					<span style="position:relative;top:0px;right:5px;" title="Attach Files">Attach Files</span></a></td>
				</tr>
			</table>
				
		</th>
		</tr>
		</cfif> --->
		
		
	
		
		</table>
	</td>
	</tr>
	<cfset trees_sir_cnt = max_scnt>
	<input type="Hidden" id="trees_sir_cnt" name="trees_sir_cnt" value="#trees_sir_cnt#">
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>
	
	
	
<div id="msg5" class="box" style="top:40px;left:1px;width:380px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg5').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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

<div id="box_attachments" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:none;overflow:auto;">

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:400px;position:relative;top:100px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:400px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:212px;">Uploaded Files</th>
					<td style="width:90px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm8();toggleArrows();return false;">Close</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
				<td class="center"><span class="pagetitle" style="position:relative;top:0px;font-size: 12px;">Loc No: #getSite.location_no# - #getSite.name#</span></td>
				</tr>
			</table>
			</td>
		</tr>
		
		<!--- <cfif session.user_power gte 0> --->
		<tr>
		<th class="left middle" colspan="2" style="height:30px;">
			
			<cfset src_arb = "../images/pdf_icon_trans.gif"><cfset href_arb = "">
			<cfset src_rmvl = "../images/pdf_icon_trans.gif"><cfset href_rmvl = "">
			<cfset src_cert = "../images/pdf_icon_trans.gif"><cfset href_cert = "">
			<cfset src_curb = "../images/pdf_icon_trans.gif"><cfset href_curb = "">
			<cfset src_memo = "../images/pdf_icon_trans.gif"><cfset href_memo = "">
			<cfset src_roe = "../images/pdf_icon_trans.gif"><cfset href_roe = "">
			<cfset src_prn = "../images/pdf_icon_trans.gif"><cfset href_prn = "">
			<cfset src_rcurb = "../images/pdf_icon_trans.gif"><cfset href_rcurb = "">
			
			<cfset cnt = 5 - len(getSite.location_no)><cfset dir2 = getSite.location_no><cfloop index="i" from="1" to="#cnt#"><cfset dir2 = "0" & dir2></cfloop>
			<cfset dir = request.dir & "\pdfs\" & dir2>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.pdf">
			<cfloop query="pdfdir">
				<cfif lcase(pdfdir.name) is "tree_removal_permits." & dir2 & ".pdf">
					<cfset src_rmvl = "../images/pdf_icon.gif">
					<cfset href_rmvl = "href = '" & request.url & "pdfs/" & dir2 & "/tree_removal_permits." & dir2 & ".pdf' title='View Tree Removal Permits PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "arborist_report." & dir2 & ".pdf">
					<cfset src_arb = "../images/pdf_icon.gif">
					<cfset href_arb = "href = '" & request.url & "pdfs/" & dir2 & "/arborist_report." & dir2 & ".pdf' title='View Arborist Report PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "certification_form." & dir2 & ".pdf">
					<cfset src_cert = "../images/pdf_icon.gif">
					<cfset href_cert = "href = '" & request.url & "pdfs/" & dir2 & "/certification_form." & dir2 & ".pdf' title='View Certification Form PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "curb_ramp_plans." & dir2 & ".pdf">
					<cfset src_curb = "../images/pdf_icon.gif">
					<cfset href_curb = "href = '" & request.url & "pdfs/" & dir2 & "/curb_ramp_plans." & dir2 & ".pdf' title='View Curb Ramp Plans PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "memos." & dir2 & ".pdf">
					<cfset src_memo = "../images/pdf_icon.gif">
					<cfset href_memo = "href = '" & request.url & "pdfs/" & dir2 & "/memos." & dir2 & ".pdf' title='View Memos PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "roe_form." & dir2 & ".pdf">
					<cfset src_roe = "../images/pdf_icon.gif">
					<cfset href_roe = "href = '" & request.url & "pdfs/" & dir2 & "/roe_form." & dir2 & ".pdf' title='View ROE Form PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "tree_prune_permits." & dir2 & ".pdf">
					<cfset src_prn = "../images/pdf_icon.gif">
					<cfset href_prn = "href = '" & request.url & "pdfs/" & dir2 & "/tree_prune_permits." & dir2 & ".pdf' title='View Tree Prune Permits PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "revised_curb_ramp_plans." & dir2 & ".pdf">
					<cfset src_rcurb = "../images/pdf_icon.gif">
					<cfset href_rcurb = "href = '" & request.url & "pdfs/" & dir2 & "/revised_curb_ramp_plans." & dir2 & ".pdf' title='View Revised Curb Ramp Plans PDF'">
				</cfif>
			</cfloop>
			
			
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_cert is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<cfif session.user_level is 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_cert" #href_cert# target="_blank"><img id="img_cert" src="#src_cert#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Certification Form</span></a>
					<span id="rmv_cert" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(2);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Certification Form" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_roe is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<cfif session.user_level is 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_roe" #href_roe# target="_blank"><img id="img_roe" src="#src_roe#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">ROE Form</span></a>
					<span id="rmv_roe" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(3);return false;"><img src="../images/grey_x.png" width="8" height="8" title="ROE Form" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_memo is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<cfif session.user_level is 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_memo" #href_memo# target="_blank"><img id="img_memo" src="#src_memo#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Memos</span></a>
					<span id="rmv_memo" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(4);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Memos" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_curb is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<cfif session.user_level is 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_curb" #href_curb# target="_blank"><img id="img_curb" src="#src_curb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Curb Ramp Plans</span></a>
					<span id="rmv_curb" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(5);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Curb Ramp Plans" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_rcurb is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<cfif session.user_level is 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_rcurb" #href_rcurb# target="_blank"><img id="img_rcurb" src="#src_rcurb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Revised Curb Ramp Plans</span></a>
					<span id="rmv_rcurb" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(7);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Revised Curb Ramp Plans" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_rmvl is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_rmvl" #href_rmvl# target="_blank"><img id="img_rmvl" src="#src_rmvl#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Tree Removal Permits</span></a>
					<span id="rmv_rmvl" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(0);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Tree Removal Permits" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_prn is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:170px;"><a id="a_prn" #href_prn# target="_blank"><img id="img_prn" src="#src_prn#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Tree Prune Permits</span></a>
					<span id="rmv_prn" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(6);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Tree Prune Permits" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_arb is not ""><cfset attvis = "visible"></cfif>
					<cfif session.user_power lt 0><cfset attvis = "hidden"></cfif>
					<th class="left" style="width:120px;"><a id="a_arb" #href_arb# target="_blank"><img id="img_arb" src="#src_arb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Arborist Report</span></a>
					<span id="rmv_arb" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(1);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Arborist Report" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr>
					<th><cfif session.user_power gte 0><a href="" onClick="showAttach();return false;"><img src="../images/attach.png" width="9" height="15" title="Attach Files" style="position:relative;top:3px;right:5px;">
					<span style="position:relative;top:0px;right:5px;" title="Attach Files">Attach Files</span></a></cfif></td>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
			</table>
				
		</th>
		</tr>
		<!--- </cfif> --->
		</table>
	</td>
	</tr>
</table>

<cfset w_box = 590>
	<cfset w_msg = 515><cfset h_msg = 425> <!--- 775 for testing --->
	<cfif session.user_level is 0><cfset h_msg = 215></cfif> <!--- added for BSS adding uploads --->
	<cfset l_msg = (w_box - w_msg)/2>
	<div id="attachments" class="box" style="top:1px;left:#l_msg-5#px;width:#w_msg#px;height:#h_msg#px;display:none;z-index:910;">
		<div class="box_header">Attachments</div>
		<div class="box_body" style="margin: 4px 0px 0px 0px;overflow:hidden;">
			<div id="attach_form" class="mn_toolbox" style="top:-3px;left:1px;height:#h_msg-30#px;width:#w_msg-10#px;overflow:hidden;">
			
				<div style="position:relative;top:0px;left:0px;height:200px;padding:20px 0px 0px 5px;align:center;text-align:center;">
				<strong>DO NOT</strong> use the pound (#chr(35)#) or ampersand (&) sign in the file name. Click "Browse" to upload file(s).
				</div>
				<table align=center border="0" cellpadding="0" cellspacing="0" style="position:absolute;top:35px;width:100%;">
					<tr><th class="drk left middle" style="height:2px;width:100%;"></th></tr>	
				</table>

				<cfset f_t = 45><cfset p = 2><cfset ht = 14><cfset lft = 12><cfset pd = 35><cfset dt = 42>
				<cfif brow is "M"><cfset pd = 35></cfif>
				<cfif brow is "F"><cfset p = 1><cfset ht = 15></cfif>
				
				<div style="position:absolute;bottom:15px;width:100%;">
				<div id="attach_msg" style="color:#request.color#;font: 11px Arial, Verdana, Helvetica, sans-serif;width:300px;height:15px;z-index:500;text-align:left;position:absolute;bottom:0px;left:20px;">
				<span style="color:red;">Attachment Failed:</span> Files must not be more than 10MB!
				</div>
				<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr><td style="text-align:right;padding:0px 13px 0px 0px">
						<a id="attachfiles" href="" class="button buttonText" tabindex="3"
				style="height:#ht#px;width:80px;padding:#p#px 0px 2px 0px;" 
				onclick="attachFiles(#getSite.location_no#);return false;">Attach Files</a>
					&nbsp;<a id="attachclose" href="" class="button buttonText" tabindex="3"
				style="height:#ht#px;width:80px;padding:#p#px 0px 2px 0px;" 
				onclick="cancelAttach();return false;">Cancel</a></td>
					</tr>
				</table>
				</div>
				
				<cfif brow is "F"><cfset p = 0><cfset ht = 16></cfif>

				<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="position:absolute;top:#f_t#px;width:100%;">
					<form id="attach_file_form" enctype="multipart/form-data" method="post" action="" target="attach_iframe">
					
					<cfif session.user_level gt 0>
					<tr><th class="left" style="padding:0px 0px 0px 17px"><strong>Certification Form PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_cert" class="file_header" style="position:absolute;top:15px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_cert" class="fileinputs" style="top:16px;left:#lft+90#px;display:block;">
					<div id="fi_cert" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_cert" style="display:block;">
					<input id="file_cert" name="file_cert" type="file" class="file" style="top:15px;left:#lft+90#px;display:block;" onChange="setFileName('cert');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_cert" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:16px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>

					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-8px;">ROE Form PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_roe" class="file_header" style="position:absolute;top:#15+dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_roe" class="fileinputs" style="position:absolute;top:#16+dt#px;left:#lft+90#px;display:block;">
					<div id="fi_roe" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_roe" style="display:block;">
					<input id="file_roe" name="file_roe" type="file" class="file" style="top:#15+dt#px;left:#lft+90#px;display:block;" onChange="setFileName('roe');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_roe" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:58px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-13px;">Memos PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_memo" class="file_header" style="position:absolute;top:#15+2*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_memo" class="fileinputs" style="position:absolute;top:#16+2*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_memo" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_memo" style="display:block;">
					<input id="file_memo" name="file_memo" type="file" class="file" style="top:#15+2*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('memo');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_memo" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+2*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-18px;">Curb Ramp Plans PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_curb" class="file_header" style="position:absolute;top:#15+3*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_curb" class="fileinputs" style="position:absolute;top:#16+3*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_curb" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_curb" style="display:block;">
					<input id="file_curb" name="file_curb" type="file" class="file" style="top:#15+3*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('curb');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_curb" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+3*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-23px;">Revised Curb Ramp Plans PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_rcurb" class="file_header" style="position:absolute;top:#15+4*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_rcurb" class="fileinputs" style="position:absolute;top:#16+4*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_rcurb" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_rcurb" style="display:block;">
					<input id="file_rcurb" name="file_rcurb" type="file" class="file" style="top:#15+4*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('rcurb');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_rcurb" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+4*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-28px;">Tree Removal Permit PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_rmvl" class="file_header" style="position:absolute;top:#15+5*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_rmvl" class="fileinputs" style="top:#16+5*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_rmvl" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_rmvl" style="display:block;">
					<input id="file_rmvl" name="file_rmvl" type="file" class="file" style="top:#15+5*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('rmvl');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_rmvl" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+5*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-33px;">Tree Prune Permit PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_prn" class="file_header" style="position:absolute;top:#15+6*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_prn" class="fileinputs" style="top:#16+6*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_prn" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_prn" style="display:block;">
					<input id="file_prn" name="file_prn" type="file" class="file" style="top:#15+6*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('prn');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_prn" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+6*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-38px;">Arborist Report PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_arb" class="file_header" style="position:absolute;top:#15+7*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_arb" class="fileinputs" style="position:absolute;top:#16+7*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_arb" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_arb" style="display:block;">
					<input id="file_arb" name="file_arb" type="file" class="file" style="top:#15+7*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('arb');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_arb" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+7*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<cfelse> <!--- Added for just BSS adding data  --->
					
					<tr><th class="left" style="padding:0px 0px 0px 17px"><strong>Tree Removal Permit PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_rmvl" class="file_header" style="position:absolute;top:#15#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_rmvl" class="fileinputs" style="top:#16#px;left:#lft+90#px;display:block;">
					<div id="fi_rmvl" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_rmvl" style="display:block;">
					<input id="file_rmvl" name="file_rmvl" type="file" class="file" style="top:#15#px;left:#lft+90#px;display:block;" onChange="setFileName('rmvl');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_rmvl" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-8px;">Tree Prune Permit PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_prn" class="file_header" style="position:absolute;top:#15+dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_prn" class="fileinputs" style="top:#16+dt#px;left:#lft+90#px;display:block;">
					<div id="fi_prn" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_prn" style="display:block;">
					<input id="file_prn" name="file_prn" type="file" class="file" style="top:#15+dt#px;left:#lft+90#px;display:block;" onChange="setFileName('prn');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_prn" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>
					
					<tr><th class="left" style="padding:#pd#px 0px 0px 17px"><strong style="position:relative;top:-13px;">Arborist Report PDF:</strong></th></tr>
					<tr><td align="center">
					<div id="fi_header_arb" class="file_header" style="position:absolute;top:#15+2*dt#px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
					<div id="fi_mask_arb" class="fileinputs" style="position:absolute;top:#16+2*dt#px;left:#lft+90#px;display:block;">
					<div id="fi_arb" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
					</div>
					<div id="fi_div_arb" style="display:block;">
					<input id="file_arb" name="file_arb" type="file" class="file" style="top:#15+2*dt#px;left:#lft+90#px;display:block;" onChange="setFileName('arb');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
					<a id="fi_btn_arb" href="" class="button buttonText" tabindex="3"
					style="position:absolute;top:#15+2*dt#px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
					</td></tr>

					</cfif>
					
					
					<tr><td><iframe id="attach_iframe" name="attach_iframe" style="display:none;position:relative;top:30px;left:0px;height:400px;width:500px;border:0px red solid;"></iframe></td></tr>
					</form>
				</table>
			</div>
		</div>
	</div>
	
	<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>
	
	<div id="msg7" class="box" style="top:40px;left:1px;width:350px;height:80px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg7').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header5" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text7" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to remove this Attachment?
		</div>
		<input type="Hidden" id="attached_type" name="attached_type" value="">
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="doRemoveAttach();$('#chr(35)#msg7').hide();return false;">Continue...</a>
			</td>
			<td style="width:0px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg7').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>

</div>
	
	

</body>
</cfoutput>

<cfset ro = 0>
<cfif session.user_level gt 0 AND session.user_power gte 0><cfset ro = 1></cfif>

<script>

<cfoutput>
var url = "#request.url#";
var pid = #url.pid#;
var sid = #url.sid#;
var search = #url.search#;
var crid = #url.crid#;
var crsearch = #url.crsearch#;
var loc = #getSite.location_no#;
var geoCnt = #getGeocode.recordcount#;
var ro = #ro#;
var lgth1 = #lngth1#;
var lgth2 = #lngth2#;
var arrIsCity = [#isCityList#];
var pchk = '#pchk#';
</cfoutput>
var engCalc = false;
var conCalc = false;
var estSub = false;
var adaSub = false;
var assSub = false;
var corSub = false;
var treeSub = false;

var arrSpecies = [];
<cfloop query="getSpecies">
<cfoutput>arrSpecies.push("#common#");</cfoutput>
</cfloop>

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
	
	var chk = $.isNumeric(trim($('#sw_no_trees').val().replace(/,/g,""))); var chk2 = trim($('#sw_no_trees').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- No. Trees to Remove per Arborist must be numeric!<br>"; }
	
	if ($('#sw_excptn').is(':checked') && $('#sw_excptn').is(':disabled') != true) {
		if($.trim($('#sw_excptn_notes').val()) == "") { cnt++; errors = errors + "- ADA Compliance Exception Notes cannot be blank!<br>"; }
	}

	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	
	}
	

	var frm = $('#form1').serializeArray();
	//frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });
	//frm.push({"name" : "sw_loc", "value" : trim($('#sw_loc').val()) });
	//frm.push({"name" : "sw_damage", "value" : trim($('#sw_damage').val()) });
	//frm.push({"name" : "sw_tree_notes", "value" : trim($('#sw_tree_notes').val()) });
	
	//if ($('#sw_no_trees').is(':disabled')) { frm.push({"name" : "sw_no_trees", "value" : trim($('#sw_no_trees').val()) }); }
	
	//if ($('#sw_dsgnstart').is(':disabled')) { frm.push({"name" : "sw_dsgnstart", "value" : trim($('#sw_dsgnstart').val()) }); }
	//if ($('#sw_dsgnfinish').is(':disabled')) { frm.push({"name" : "sw_dsgnfinish", "value" : trim($('#sw_dsgnfinish').val()) }); }
	//if ($('#sw_tree_rm_date').is(':disabled')) { frm.push({"name" : "sw_tree_rm_date", "value" : trim($('#sw_tree_rm_date').val()) }); }
	
	frm = frm.filter(function(item) { return item.name !== "sw_excptn"; }); //Remove checkbox because will add in element loop
	
	for(var i=0; i < form1.elements.length; i++){
    	var e = form1.elements[i];
    	//console.log(e.name+"="+e.id);
		if (e.type != "checkbox") {
			if ($('#' + e.id).is(':disabled')) { frm.push({"name" : e.id, "value" : trim($('#' + e.id).val()) }); }
		}
		else {
			//console.log(e.id + "="+e.type);
			var v = "";
			if ($('#' + e.id).is(':checked')) { v = "1"; }
			frm.push({"name" : e.id, "value" : v });
		}
	}
	
	//REMOVED because new priority will be set up
	var pchk_new = trim($('#sw_severity').val()) + "|" + trim($('#sw_ait_type').val()) + "|" + trim($('#sw_costeffect').val()) + "|" + trim($('#sw_injury').val()) + "|" + trim($('#sw_disabled').val()) + "|" + trim($('#sw_complaints').val()) + "|" + trim($('#sw_pedestrian').val());
	if (pchk != pchk_new) { frm.push({"name" : "do_priority", "value" : 1 });     }

	//console.log(frm);
	
	  
	
	<!--- joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	  
	       
	      console.log("hide panel ============ ") 
		  
		  // This will disable  div 
           //document.getElementById("result_panel").disabled = true;
		   var nodes = document.getElementById("result_panel").getElementsByTagName('*');
				for(var i = 0; i < nodes.length; i++){
					 nodes[i].disabled = true;
				}
		  
		  
		  
	     //$("#result_panel").hide();
		 show_loading_img_spinner('small_right_icon', 'progressing_loading_sign')
		  
		 // wait(3000); //failed 
		  
	  <!--- End ----joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	
	
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateSite&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
	
	      // pause 3 sec to show loading sign
		  
		    console.log("show panel ============ ") 
			//wait(3000);  //7 seconds in milliseconds
			//console.log('after');
		  
		 remove_loading_img_spinner('progressing_loading_sign');
		 
		 
		 // disable div
		  //document.getElementById("result_panel").disabled = false;
		 //$("#result_panel").show();
		   var nodes = document.getElementById("result_panel").getElementsByTagName('*');
				for(var i = 0; i < nodes.length; i++){
					 nodes[i].disabled = false;
				}
		 
		
	   <!--- End ---- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
		
		
		
		
		
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		//REMOVED because new priority will be set up
		if (pchk != pchk_new) {
			if(data.PRIORITY != 0) { $('#sw_priority').val(data.PRIORITY); } else { $('#sw_priority').val(''); }
			pchk = pchk_new;
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
	else if (crid > 0) { location.replace("swCurbRampEdit.cfm?crid=" + crid + "&search=" + crsearch); }
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


function chkAccess() {

	var idx = $('#sw_type').val();
	var trig = false;
	
	$.each(arrIsCity, function(i, item) {
		if (idx == item) { trig = true; return false; }
	});

	if (trig) {
		$('#sw_ait_type').val(1);
		$('#sw_ait_type').attr('disabled', true);
	}
	else {
		$('#sw_ait_type').removeAttr('disabled');
	}	
}


function openViewer() 
{
var search="";
if (geoCnt == 0) {
	var chk = trim($('#sw_address').val());
	if (chk != "") { search = "&search=" + escape(chk); }
}

//console.log(search);
var url = "http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRP&ref_no=" + loc + "&pin=&return_url=http%3A%2F%2Fengpermits%2Elacity%2Eorg%2Fexcavation%2Fboe%2Fgo%5Fmenu%5Fgc%2Ecfm&allow_edit=" + ro + "&p_start_ddate=05-01-2003&p_end_ddate=05-30-2003" + search;
//console.log(url);

newWindow(url,'',900, 700,'no');
return false;
}

function openCertificate() 
{
var search="";
if (geoCnt == 0) {
	var chk = trim($('#sw_address').val());
	if (chk != "") { search = "&search=" + escape(chk); }
}

//console.log(search);
<cfoutput>
var url = "https://navigatela.lacity.org/compliance/geocoder.cfm?user_name=#session.userid#&user_agency=#session.agency#&site_no=" + loc + search;
</cfoutput>

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
		toggleArrows();
		
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
		
		var tc =  parseFloat($('#c_CONTRACTORS_COST').val().replace(/,/g,"")) + parseFloat($('#sw_changeorder').val().replace(/,/g,""));
		$('#sw_tc').val(tc.formatMoney(2));
		
		addCORTotal('');

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
		
		if (pct1 < 0) { five1 = max1; }
		if (pct2 < 0) { five2 = max2; }
		if (pct3 < 0) { one = max3; }
		
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
	
	//if (estSub == false) { $('#form3')[0].reset(); }
	
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
	$('#msg').hide();
	$('#msg2').hide();
	$('#msg3').hide();
	$('#msg_all').hide();
}

function resetForm2() {
	if (adaSub == false) { $('#form4')[0].reset(); }
	$('#box_curb').hide();
	$('#msg4').hide();
}


function addRamp(sw_id) {
	location.replace(url + "forms/swCurbRampEntry.cfm?sw_id=" + sw_id + "&sid=" + sid + "&pid=" + pid + "&search=" + search);
}
 
function editRamp(crid) {
	location.replace(url + "forms/swCurbRampEdit.cfm?crid=" + crid + "&sid=" + sid + "&pid=" + pid + "&search=" + search + "&editcr=true");
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

function showRemove() {
	
	
	
	
	$('#msg10').css({top:'50%',left:'50%',margin:'-'+($('#msg10').height() / 2)+'px 0 0 -'+($('#msg10').width() / 2)+'px'});
	$('#msg10').show();
}

function deleteSite(idx) {
	
	
	<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
		//start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );
		
	 var nodes = document.getElementById("result_panel").getElementsByTagName('*');
				for(var i = 0; i < nodes.length; i++){
					 nodes[i].disabled = true;
				}
		  
		  
		  
    show_loading_img_spinner('small_center_delete_icon', 'progressing_loading_sign')	
	<!--- ---- end ------- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
	
	
	
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
	//frm.push({"name" : "comments", "value" : trim($('#comments').val()) });
	
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
		toggleArrows();	
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
		
		<cfloop index="i" from="1" to="10">
			var as = $('#chr(35)#ass_EXTRA_FIELD_#i#_name').val();
			$('#chr(35)#EXTRA_FIELD_#i#_name').val(as);
			$('#chr(35)#co_EXTRA_FIELD_#i#_name').val(as);
			var as = $('#chr(35)#ass_EXTRA_FIELD_#i#_units').val();
			$('#chr(35)#EXTRA_FIELD_#i#_units').val(as);
			$('#chr(35)#co_EXTRA_FIELD_#i#_units').val(as);
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
		//$('#form5')[0].reset(); 
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

	if (fld != '') {
		var co = $('#co_' + fld + '_quantity').val();
		var cor = $('#cor_' + fld + '_quantity').val();
		if (isNaN(co) || trim(co) == '' ) { co = 0; }
		if (isNaN(cor) || trim(cor) == '' ) { cor = 0; }
	
		var dpts = 0; var lgth = cor.length;
		if (cor != 0) {
			arrDpts = cor.split(".");
			if (arrDpts.length > 1) { dpts = arrDpts[1].length; }
		}
		if (dpts > 0) { lgth = lgth-1; }
		
		var tmp = parseInt(co)+parseFloat(cor);
		tmp = Math.round(tmp*(Math.pow(10,dpts)))/Math.pow(10,dpts);
	
		$('#co_' + fld + '_total_qty').html(tmp);	
		var cop = $('#co_' + fld + '_unit_price').val();
		$('#cop_' + fld + '_total').html((parseFloat(cor)*cop).formatMoney(2));
		$('#co_' + fld + '_total').html(((parseInt(co)+parseFloat(cor))*cop).formatMoney(2));
	}
	
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
	
	var coc = parseFloat($('#co_CONTRACTORS_COST').val().replace(/,/g,""));
	$('#co_TOTAL').val((ttl+coc).formatMoney(2));
	
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
		toggleArrows();
		
		var tc =  parseFloat($('#cor_CHANGE_ORDER_COST').val().replace(/,/g,"")) + parseFloat($('#sw_con_price').val().replace(/,/g,""));
		$('#sw_tc').val(tc.formatMoney(2));
		$('#sw_changeorder').val(parseFloat($('#cor_CHANGE_ORDER_COST').val().replace(/,/g,"")).formatMoney(2));
				
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
	$('#attachments').hide();
}


function chkForm7() {
	
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>	
	<cfloop index="i" from="1" to="#arrayLen(arrTrees)#">			
	
		<cfset v = replace(arrTrees[i],"_"," ","ALL")>
		<cfset v = replace(v,"FOUR FEET","4\'","ALL")>
		<cfset v = replace(v,"SIX FEET","6\'","ALL")>
		<cfset v = lcase(v)>
		<cfset v = CapFirst(v)>
		<cfset v = replace(v," Quantity","","ALL")>
		<cfset v = replace(v,"6 Inch To 24 Inch Diameter","(6 Inch To 24 Inch Diameter)","ALL")>
		<cfset v = replace(v,"Over 24 Inch Diameter","(Over 24 Inch Diameter)","ALL")>
		<cfset v = replace(v," Inch","#chr(34)#","ALL")>
		<cfset v = replace(v,"Per Tree","(Per Tree)","ALL")>
		<cfset v = replace(v,"And","and","ALL")>
		<cfset v = replace(v,"Up To 30 Gallons L Week","(Up To 30 Gallons L Week)","ALL")>
		<cfset v = replace(v,"and","&","ALL")>
		<cfset v = replace(v," ","&nbsp;","ALL")>
		<cfset v = replace(v,"&nbsp;L&nbsp;","&nbsp;/&nbsp;","ALL")>		

		var chk = $.isNumeric(trim($('#chr(35)#tree_#arrTrees[i]#QUANTITY').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)#tree_#arrTrees[i]#QUANTITY').val());
		if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'#v#\' must be numeric!<br>'; }
		
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	
	for (var i = 1; i < lgth1+1; i++) {
		if ($('#trees_div_' + i).is(':visible')) {
		
			//console.log(i);
			//var chk = $.isNumeric(trim($('#sir_' + i).val().replace(/,/g,""))); 
			//var chk2 = trim($('#sir_' + i).val());
			//if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'SIR #\' for Entry ' + i + ' must be numeric!<br>'; }
		
			/* for (var j = 1; j < lgth2+1; j++) {
				if ($('#tr_rmv_div_' + i + '_' + j).is(':visible')) {
					var v = $('#trspecies_' + i + '_' + j).val();
					if (v != '') {
						var ok = false;
						$.each(arrSpecies, function(i, item) {
							if (v == item) { ok = true; return;}
						});
						if (ok == false) { cnt++; errors = errors + '- \'Species\' for Tree Removal ' + j + ' for entry ' + i + ' must be from the dropdown list!<br>'; }
					}
				}
				if ($('#tr_add_div_' + i + '_' + j).is(':visible')) {
					var v = $('#tpspecies_' + i + '_' + j).val();
					if (v != '') {
						var ok = false;
						$.each(arrSpecies, function(i, item) {
							if (v == item) { ok = true; return;}
						});
						if (ok == false) { cnt++; errors = errors + '- \'Species\' for Tree Planting ' + j + ' for entry ' + i + 'must be from the dropdown list!<br>'; }
					}
				}
			} */
		}
	}

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
	frm.push({"name" : "tree_trn", "value" : trim($('#tree_trn').val()) });
	<cfoutput>
	<cfloop index="i" from="1" to="#arrayLen(arrTrees)#">
	frm.push({"name" : "tree_#arrTrees[i]#UNITS", "value" : trim($('#chr(35)#tree_#arrTrees[i]#UNITS').val()) });
	</cfloop>
	<cfloop index="i" from="5" to="6">
	frm.push({"name" : "tree_#arrTrees[i]#QUANTITY", "value" : trim($('#chr(35)#tree_#arrTrees[i]#QUANTITY').val()) }); //Added because is now disabled in form
	</cfloop>
	</cfoutput>
	
	if ($('#tree_lock').is(':checked') == false) {	
		frm.push({"name" : "tree_lock", "value" : ""});
	}
	
	if ($('#tree_readytp').is(':checked') == false) {	
		frm.push({"name" : "tree_readytp", "value" : ""});
	}
	
	<cfoutput>
	<cfloop index="i" from="1" to="#lngth1#">
		<cfloop index="j" from="1" to="#lngth2#">
		if ($("#chr(35)#tpoffsite_#i#_#j#").is(':visible')) {	
			if ($('#chr(35)#tpoffsite_#i#_#j#').is(':checked') == false) {	
				frm.push({"name" : "tpoffsite_#i#_#j#", "value" : "off"});
			}
		}
		if ($("#chr(35)#tpoverhead_#i#_#j#").is(':visible')) {	
			if ($('#chr(35)#tpoverhead_#i#_#j#').is(':checked') == false) {	
				frm.push({"name" : "tpoverhead_#i#_#j#", "value" : "off"});
			}
		}
		if ($("#chr(35)#tppostinspect_#i#_#j#").is(':visible')) {	
			if ($('#chr(35)#tppostinspect_#i#_#j#').is(':checked') == false) {	
				frm.push({"name" : "tppostinspect_#i#_#j#", "value" : "off"});
			}
		}
		</cfloop>
	</cfloop>
	</cfoutput>
	
	//console.log(frm);

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateTrees2&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	
		
		console.log(data);
		

		if(data.RESULT != "Success") {
			showMsg5(data.RESULT,1);
			return false;	
		}
		
		$('#box_tree').hide();
		$('#msg5').hide();
		$('#attachments').hide();
		toggleArrows();
		
		treeSub = true;
		
		
		//$('#sw_tree_rm_date').val($('#TREES_REMOVED_DATE').val());
		var cnt = data.TREE_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY + data.TREE_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY;
		$('#sw_no_trees').val(cnt);
		$('#sw_tree_notes').val($('#tree_trn').val());
		
		for ( property in data ) {
			var v = 'ass_' + property.replace("QUANTITY","quantity");
			var v = v.replace("_L_","_l_");
			var x = eval("data."+property);
			$('#'+v).val(x);
  			//console.log( property );
			//console.log( x );
		}
		
		if (data.ADDS.length > 0) {
		
			//rest icons
			for (i = 1; i <= lgth1; i++) { 
				for (j = 1; j <= lgth2; j++) { 
					$('#tpicon_' + i + '_' + j).attr("src","../images/map_small_x.png");
					$('#tpicon_' + i + '_' + j).attr("alt","");
					$('#tpicon_' + i + '_' + j).attr("title","");
					$('#tplink_' + i + '_' + j).attr("onclick","return false;");
				}
			}
			
			//update icons and urls
			$.each(data.ADDS, function(i, item) {
				arrItem = item.split("|");
				//console.log(arrItem);
				var icon = "../images/map_small.png";
				if (arrItem[4] == "1") { icon = "../images/map_small_chk.png"; }
				$('#tpicon_' + arrItem[1] + '_' + arrItem[2]).attr("src",icon);
				$('#tpicon_' + arrItem[1] + '_' + arrItem[2]).attr("alt","Map Tree ID: " + arrItem[3]);
				$('#tpicon_' + arrItem[1] + '_' + arrItem[2]).attr("title","Map TreeID: " + arrItem[3]);
				$('#tplink_' + arrItem[1] + '_' + arrItem[2]).attr("onclick","geocodeTree(" + arrItem[1] + "," + arrItem[2] + "," + arrItem[3] + ");return false;");
				
			});

		}
		
		//Added for after Updating the Assessment Form fropm Trees Form
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
			$('#chr(35)#ass_' + fld + '_total').html(parseInt(qc)+parseInt(as));
			
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
		
		<cfloop index="i" from="1" to="10">
			var as = $('#chr(35)#ass_EXTRA_FIELD_#i#_name').val();
			$('#chr(35)#EXTRA_FIELD_#i#_name').val(as);
			$('#chr(35)#co_EXTRA_FIELD_#i#_name').val(as);
			var as = $('#chr(35)#ass_EXTRA_FIELD_#i#_units').val();
			$('#chr(35)#EXTRA_FIELD_#i#_units').val(as);
			$('#chr(35)#co_EXTRA_FIELD_#i#_units').val(as);
		</cfloop>
		
		</cfoutput>
		
		$('#e_subtotal').html((total).formatMoney(2));
		$('#c_subtotal').html((c_total).formatMoney(2));
		
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

function addTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	$('#tr_' + typ + '_div_' + scnt + '_' + (cnt+1)).show();
	
	var pfx = "tr";
	if (typ == "add") { pfx = "tp"; }
	$("#" + pfx + "dia_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "pidt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "trdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "swdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "ewdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "addr_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "species_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "type_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "note_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "parkway_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "overhead_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "subpos_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "postinspect_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "offsite_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	if ( cnt < lgth2) { 
		$('#' + pfx + '_tot_' + scnt).html(cnt+1); 
		$('#tr_' + typ + '_cnt_' + scnt).val(cnt+1); 
		if (typ == "add") { calcTrees(); } 
	}
}

function delTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	if (cnt != 0) {	
		$('#tr_' + typ + '_div_' + scnt + '_' + (cnt)).hide();
		$('#tr_' + typ + '_cnt_' + scnt).val(cnt-1); 
		var pfx = "tr";
		if (typ == "add") { pfx = "tp"; }
		$("#" + pfx + "dia_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "pidt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "trdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "swdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "ewdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "addr_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "species_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "type_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "note_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "overhead_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "subpos_" + scnt + "_" + (cnt)).attr('disabled', true);
		$('#' + pfx + '_tot_' + scnt).html(cnt-1);
		if (typ == "add") { calcTrees(); }
	}
}

function calcTrees() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	var tot = 0; var tot2 = 0;
	for (var i = 1; i < cnt+1; i++) {
		var cnt2 = parseInt($('#tr_add_cnt_' + i).val());
		
		for (var j = 1; j < cnt2+1; j++) {
			var v = parseInt($("#tpdia_" + i + "_" + j).val());
			if (v == 24) {
				tot++;
				//console.log("tot=" + tot);
			}
		}
		tot2 = tot2 + cnt2;
	}
	$('#tree_FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY').val(tot);
	
	if ($('#tree_lock').is(':checked') == false) {	
		$('#tree_INSTALL_ROOT_CONTROL_BARRIER_QUANTITY').val(tot2*14);
	}
}

function autoLock() {
	if ($('#tree_lock').is(':checked') == false) {	
		$('#tree_lock').prop('checked', true);
	}
}


function addSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	$('#trees_div_' + (cnt+1)).show();
	$('#trees_sir_cnt').val(cnt+1);
	$('#sir_' + (cnt+1)).removeAttr('disabled');
	$('#sirdt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_rmv_cnt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_add_cnt_' + (cnt+1)).removeAttr('disabled');
}

function delSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	if (cnt != 1) {	
		$('#trees_div_' + cnt).hide();
		$('#trees_sir_cnt').val(cnt-1); 
		$('#sir_' + cnt).attr('disabled', true);	
		$('#sirdt_' + cnt).attr('disabled', true);	
		$('#tr_rmv_cnt_' + cnt).attr('disabled', true);	
		$('#tr_add_cnt_' + cnt).attr('disabled', true);	
	}
}


function applyConValuesAll() {

	var frm = $('#form3').serializeArray();
	var frm2 = [];
	$.each(frm, function(i, item) {
		if (item.name.substr(0,2) == "c_") {
			if (item.name != "c_CONTRACTORS_COST") { frm2.push(item); }
		}
		if (item.name == "sw_id") { frm2.push(item); }
	});
	
	/* $.each(frm2, function(i, item) {
		console.log(item);
	}); */
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateContractorAll&callback=",
	  data: frm2,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		$('#msg_all').hide();
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1,"Contractor Pricing Update");
			return false;	
		}
		showMsg("Information updated successfully!",1,"Contractor Pricing Update");
	  }
	});
	

}
 
function showMsgAll() {
	$('#msg_all').css({top:'50%',left:'50%',margin:'-'+($('#msg_all').height() / 2)+'px 0 0 -'+($('#msg_all').width() / 2)+'px'});
	$('#msg_all').show();
}

function chkDesign() {
	if ($('#sw_designreq').val() == 1) {
		$("#sw_dsgnstart").removeAttr('disabled');
		$("#sw_dsgnfinish").removeAttr('disabled');
	}
	else {
		$("#sw_dsgnstart").attr('disabled', true);
		$("#sw_dsgnfinish").attr('disabled', true);
	}
}

function chkRampOnly() {
	if ($('#sw_curbramp').val() == 0) {
		//$("#sw_no_trees").removeAttr('disabled');
		//$("#sw_tree_rm_date").removeAttr('disabled');
		//$("#sw_tree_notes").removeAttr('disabled');
		
		
		//$("#sw_notes").removeAttr('disabled');
	}
	else {
		//$("#sw_no_trees").attr('disabled', true);
		//$("#sw_tree_rm_date").attr('disabled', true);
		//$("#sw_tree_notes").attr('disabled', true);
		
		
		//$("#sw_notes").attr('disabled', true);
	}
}

function openTreeForm() {

	//console.log($('#sw_curbramp').val());
	//if ($('#sw_curbramp').val() == 0) { 
		$('#box_tree').show(); toggleArrows(); calcTrees(); 
	//}

}

function cancelAttach()
{
	$("#fi_rmvl").html('');
	$("#fi_arb").html('');
	$('#attach_file_form')[0].reset();
	$("#attachments").hide();
}

function setFileName (idx)
{
	var f = $("#file_" + idx ).val();
	if (f != '') {
		if (document.getElementById("file_" + idx).files[0].size > (1048576 * 10)) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Files must not be more than 10MB!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("&") >= 0)	{
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have the \"&\" character!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("#") >= 0) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have the \"#\" character!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("'") >= 0) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have a single quote!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
	}
	
	$("#fi_" + idx ).html(f.replace(/C:\\fakepath\\/g,""));
}

function showAttach(txt,cnt) {
	$("#fi_rmvl").html('');
	$("#fi_arb").html('');
	$("#fi_cert").html('');
	$("#fi_curb").html('');
	$("#fi_memo").html('');
	$("#fi_roe").html('');
	$("#fi_prn").html('');
	$("#fi_rcurb").html('');
	$('#attach_file_form')[0].reset();
	$('#attach_msg').html('');
	$('#attachments').css({top:'50%',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	//$('#attachments').css({top:'200px',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	$('#attachments').show();
}

function attachFiles(sw_id) {

	$("#attach_msg").hide();
	$('#attach_iframe').attr('src', "");
	document.getElementById("attach_file_form").action = "swUpload.cfm?sw_id=" + sw_id + "&r=" + Math.random();
	document.getElementById("attach_file_form").submit();
	
	var goBool = false;
	var counter = 0;
	intervalId = setInterval(function() {
    	//make this is the first thing you do in the set interval function
        counter++;
		if (typeof $( '#attach_iframe' ).contents().find('#response').html() != "undefined")
		 	goBool = true;
		//console.log(counter);
	    //make this the last check in your set interval function
	     if ( counter > 60 || goBool == true ) {
	          clearInterval(intervalId);
			  var msg = $( '#attach_iframe' ).contents().find('#response').html();
			  var doArb = $( '#attach_iframe' ).contents().find('#doARB').html();
			  var doRmvl = $( '#attach_iframe' ).contents().find('#doRMVL').html();
			  var doCert = $( '#attach_iframe' ).contents().find('#doCERT').html();
			  var doCurb = $( '#attach_iframe' ).contents().find('#doCURB').html();
			  var doMemo = $( '#attach_iframe' ).contents().find('#doMEMO').html();
			  var doRoe = $( '#attach_iframe' ).contents().find('#doROE').html();
			  var doPrn = $( '#attach_iframe' ).contents().find('#doPRN').html();
			  var doRCurb = $( '#attach_iframe' ).contents().find('#doRCURB').html();
			  var dir = $( '#attach_iframe' ).contents().find('#dir').html();
			  finishUploadFiles(msg,doArb,doRmvl,doCert,doCurb,doMemo,doRoe,doPrn,doRCurb,dir);
	     }
	//end setInterval
    } , 1000);

}

function finishUploadFiles(msg,doArb,doRmvl,doCert,doCurb,doMemo,doRoe,doPrn,doRCurb,dir){

	if (msg != "Success") {
		$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Please try again.");
		$("#attach_msg").show();
		return false;
	}
	
	if (doArb == "true") {
		$("#a_arb").attr('href', url + 'pdfs/' + dir + '/Arborist_Report.' + dir + '.pdf');
		$("#a_arb").attr('title', 'View Arborist Report PDF');
		$("#img_arb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_arb").css('visibility', 'visible');
	}
	if (doRmvl == "true") {
		$("#a_rmvl").attr('href', url + 'pdfs/' + dir + '/Tree_Removal_Permits.' + dir + '.pdf');
		$("#a_rmvl").attr('title', 'View Tree Removal Permits PDF');
		$("#img_rmvl").attr('src', '../images/pdf_icon.gif');
		$("#rmv_rmvl").css('visibility', 'visible');
	}
	if (doCert == "true") {
		$("#a_cert").attr('href', url + 'pdfs/' + dir + '/Certification_Form.' + dir + '.pdf');
		$("#a_cert").attr('title', 'View Certification Form PDF');
		$("#img_cert").attr('src', '../images/pdf_icon.gif');
		$("#rmv_cert").css('visibility', 'visible');
	}
	if (doCurb == "true") {
		$("#a_curb").attr('href', url + 'pdfs/' + dir + '/Curb_Ramp_Plans.' + dir + '.pdf');
		$("#a_curb").attr('title', 'Curb Ramp Plans PDF');
		$("#img_curb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_curb").css('visibility', 'visible');
	}
	if (doMemo == "true") {
		$("#a_memo").attr('href', url + 'pdfs/' + dir + '/Memos.' + dir + '.pdf');
		$("#a_memo").attr('title', 'Memo\'s PDF');
		$("#img_memo").attr('src', '../images/pdf_icon.gif');
		$("#rmv_memo").css('visibility', 'visible');
	}
	if (doRoe == "true") {
		$("#a_roe").attr('href', url + 'pdfs/' + dir + '/ROE_Form.' + dir + '.pdf');
		$("#a_roe").attr('title', 'View Tree Removal Permits PDF');
		$("#img_roe").attr('src', '../images/pdf_icon.gif');
		$("#rmv_roe").css('visibility', 'visible');
	}
	if (doPrn == "true") {
		$("#a_prn").attr('href', url + 'pdfs/' + dir + '/Tree_Prune_Permits.' + dir + '.pdf');
		$("#a_prn").attr('title', 'View Tree Prune Permits PDF');
		$("#img_prn").attr('src', '../images/pdf_icon.gif');
		$("#rmv_prn").css('visibility', 'visible');
	}
	if (doRCurb == "true") {
		$("#a_rcurb").attr('href', url + 'pdfs/' + dir + '/Revised_Curb_Ramp_Plans.' + dir + '.pdf');
		$("#a_rcurb").attr('title', 'Revised Curb Ramp Plans PDF');
		$("#img_rcurb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_rcurb").css('visibility', 'visible');
	}
	
	$('#attachments').hide();
}

function showRemoveAttach(idx) {
	$('#msg7').css({top:'50%',left:'50%',margin:'-'+($('#msg7').height() / 2)+'px 0 0 -'+($('#msg7').width() / 2)+'px'});
	$('#msg7').show();
	$('#attached_type').val(idx);
}

function doRemoveAttach() {

	var ref = $('#a_rmvl').attr('href');
	var typ = $('#attached_type').val();
	if (typ == 1) {	ref = $('#a_arb').attr('href'); }
	else if (typ == 2) { ref = $('#a_cert').attr('href'); }
	else if (typ == 3) { ref = $('#a_roe').attr('href'); }
	else if (typ == 4) { ref = $('#a_memo').attr('href'); }
	else if (typ == 5) { ref = $('#a_curb').attr('href'); }
	else if (typ == 6) { ref = $('#a_prn').attr('href'); }
	else if (typ == 7) { ref = $('#a_rcurb').attr('href'); }
	
	var arrRef = ref.split("/");
	ref = arrRef[arrRef.length-1];
	dir = arrRef[arrRef.length-2];
	//console.log(ref);
	
	var frm = [];
	frm.push({"name" : "file_name", "value" : ref });
	frm.push({"name" : "dir", "value" : dir });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=doDeleteAttachment&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESPONSE != "Success") {
			$('#msg7').hide();
			return false;	
		}
		
		if (typ == 1) {
			$("#a_arb").removeAttr('href');
			$("#a_arb").removeAttr('title');
			$("#img_arb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_arb").css('visibility', 'hidden');
		}
		else if (typ == 2) {
			$("#a_cert").removeAttr('href');
			$("#a_cert").removeAttr('title');
			$("#img_cert").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_cert").css('visibility', 'hidden');
		}
		else if (typ == 3) {
			$("#a_roe").removeAttr('href');
			$("#a_roe").removeAttr('title');
			$("#img_roe").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_roe").css('visibility', 'hidden');
		}
		else if (typ == 4) {
			$("#a_memo").removeAttr('href');
			$("#a_memo").removeAttr('title');
			$("#img_memo").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_memo").css('visibility', 'hidden');
		}
		else if (typ == 5) {
			$("#a_curb").removeAttr('href');
			$("#a_curb").removeAttr('title');
			$("#img_curb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_curb").css('visibility', 'hidden');
		}
		else if (typ == 6) {
			$("#a_prn").removeAttr('href');
			$("#a_prn").removeAttr('title');
			$("#img_prn").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_prn").css('visibility', 'hidden');
		}
		else if (typ == 7) {
			$("#a_rcurb").removeAttr('href');
			$("#a_rcurb").removeAttr('title');
			$("#img_rcurb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_rcurb").css('visibility', 'hidden');
		}
		else {
			$("#a_rmvl").removeAttr('href');
			$("#a_rmvl").removeAttr('title');
			$("#img_rmvl").attr('src', '../images/pdf_icon_trans.gif');
			$("#img_arb").attr('title', 'View Arborist Report PDF');
			$("#rmv_rmvl").css('visibility', 'hidden');
		}
		
	  }
	});

}

function expandTextArea(tarea,rows,dy) {
	var l = $('#' + tarea).val().split("\n").length;
	var dht = (rows*dy)+5;
	$('#' + tarea).height(dht);
	var nht = $('#' + tarea)[0].scrollHeight-6;
	if (nht > dht) {	$('#' + tarea).height(nht); }
}

function toggleArrows() {

	if ($('#leftarrow').is(':visible')) {
		$("#leftarrow").hide();
		$("#rightarrow").hide();
	}
	else {
		$("#leftarrow").show();
		$("#rightarrow").show();
	}

}

function openAttachments() {
	//$('#box_attachments').css({top:'50%',left:'50%',margin:'-'+($('#box_attachments').height() / 2)+'px 0 0 -'+($('#box_attachments').width() / 2)+'px'});
	$('#box_attachments').show();
}


function resetForm8() {
	$('#box_attachments').hide();
	$('#msg5').hide();
	$('#attachments').hide();
}

function toggleADANotes() {
	if ($('#sw_excptn').is(':checked')) {
		$('#sw_excptn_notes').removeAttr('disabled');
	}
	else
	{
		$('#sw_excptn_notes').attr('disabled', true);
	}
}

function showSRID(typ) {

	$('#srid_header').html("<strong>Add SRID:</strong>");
	$('#srid_add').show();
	$('#srid_remove').hide();
	$('#srid_box').height(94);
	if (typ == 1) { 
		if ($('#sw_srids').val() == "") { return false;	}
		$('#srid_header').html("<strong>Remove SRIDs:</strong>"); 
		$('#srid_add').hide();
		$('#srid_remove').show();
		var arrSRIDs = $('#sw_srids').val().split(",");
		var cnt = arrSRIDs.length;
		var items = [];
		items.push(["<table align=center border='0' cellpadding='0' cellspacing='0' width='70%'>"]);
		$.each(arrSRIDs, function(i, item) {
			items.push(["<tr><th><input id='chk_srid_" + i + "' name='chk_srid'" + i + " type='checkbox' value='" + item + "'></th><th class='left middle'>SRID: " + item + "</th></tr>"]);
		});
		items.push("</table>");
		$('#srid_remove_text').html(items.join(''));
		$('#srid_box').height(66+cnt*21);
	}
	
	$('#srid_box').css({top:'50%',left:'50%',margin:'-'+($('#srid_box').height() / 2)+'px 0 0 -'+($('#srid_box').width() / 2)+'px'});
	$('#srid_box').show();
}

function removeSRID () {

	var arrSRIDs = $('#sw_srids').val().split(",");
	var cnt = arrSRIDs.length;
	var sridStr = "";
	$.each(arrSRIDs, function(i, item) {
		if ($('#chk_srid_' + i).is(':checked')) {
			sridStr = sridStr + "," + $('#chk_srid_' + i).val();
		}
	});
	if (sridStr == "") { return false; }
	sridStr = sridStr.substring(1,sridStr.length);
	//console.log(sridStr);
	var frm = [];
	frm.push({"name" : "sridStr", "value" : sridStr });
	frm.push({"name" : "sw_id", "value" : loc });
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=RemoveSRID&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if(data.RESULT != "Success") {
			top.location.reload();
			return false;	
		}
		$('#sw_srids').val(data.SR_NUMBERS);
		$('#sw_srids').attr('alt', data.SR_NUMBERS);
		$('#sw_srids').attr('title', data.SR_NUMBERS);
		$('#sw_add_srid').val('');
		$('#srid_box').hide();
	  }
	});
}

function addSRID() {

	var frm = [];
	if (trim($('#sw_add_srid').val()) == "") { $('#srid_box').hide(); return false; }
	frm.push({"name" : "sw_add_srid", "value" : trim($('#sw_add_srid').val()) });
	frm.push({"name" : "sw_id", "value" : loc });
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=addSRID&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if(data.RESULT != "Success") {
			top.location.reload();
			return false;	
		}
		$('#sw_srids').val(data.SR_NUMBERS);
		$('#sw_srids').attr('alt', data.SR_NUMBERS);
		$('#sw_srids').attr('title', data.SR_NUMBERS);
		$('#sw_add_srid').val('');
		$('#srid_box').hide();
	  }
	});
}


function geocodeTree(grp,tr,id) 
{
var search="";
var chk = trim($('#tpaddr_' + grp + '_' + tr).val());
if (chk != "") { search = "&search=" + escape(chk); }

//console.log(search);
<cfoutput>
var url = "#request.server#/treeinventory/geocoder.cfm?token=#session.token#&treeid=" + id + search;
</cfoutput>
//console.log(url);

newWindow(url,'',900, 700,'no');
return false;
}



<cfoutput>
$(function() {
<cfloop index="i" from="1" to="#lngth1#">
	<cfloop index="j" from="1" to="#lngth2#">
	    $( "#chr(35)#trspecies_#i#_#j#" ).autocomplete({ source: arrSpecies });
		$( "#chr(35)#trpidt_#i#_#j#" ).datepicker();
		$( "#chr(35)#trtrdt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tpspecies_#i#_#j#" ).autocomplete({ source: arrSpecies });
		$( "#chr(35)#tppidt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tptrdt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tpswdt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tpewdt_#i#_#j#" ).datepicker();
	</cfloop>
		$( "#chr(35)#sirdt_#i#" ).datepicker();
</cfloop>

<cfif isdefined("url.editcr")>
toggleArrows();
</cfif>

 });
</cfoutput>

$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
$( "#sw_tree_rm_date" ).datepicker();
$( "#sw_dsgnstart" ).datepicker();
$( "#sw_dsgnfinish" ).datepicker();

$( "#tree_preinspdt" ).datepicker();
$( "#tree_postinspdt" ).datepicker();


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


            

				

	


