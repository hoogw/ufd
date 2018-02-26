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
<title>Sidewalk Repair Program - Edit Package</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<cfparam name="url.pid" default="1">

<!--- Get Package --->
<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackages WHERE id = #url.pid#
</cfquery>

<cfset pno = getPackage.package_no>
<cfset pgroup = getPackage.package_group>

<!--- Get Unassigned Sites --->
<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM vwSites WHERE package_no = #pno# AND package_group = '#pgroup#' ORDER BY location_no
</cfquery>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get max site --->
<cfquery name="getMaxSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(id) as id FROM tblPackages WHERE package_no < #getPackage.package_no# AND package_group = '#getPackage.package_group#' AND removed is null
</cfquery>

<!--- Get min site --->
<cfquery name="getMinSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT min(id) as id FROM tblPackages WHERE package_no > #getPackage.package_no# AND package_group = '#getPackage.package_group#' AND removed is null
</cfquery>

<cfquery name="getTotal" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT TOTAL FROM (SELECT Package_No, Package_Group, SUM(CHANGE_ORDER_COST) AS CHANGE_ORDER_COST, SUM(CONTRACTORS_COST) AS CONTRACTORS_COST, 
CASE WHEN SUM(CHANGE_ORDER_COST) IS NULL THEN 0 ELSE SUM(CHANGE_ORDER_COST) END + CASE WHEN SUM(CONTRACTORS_COST) 
IS NULL THEN 0 ELSE SUM(CONTRACTORS_COST) END AS TOTAL
FROM (SELECT dbo.tblSites.Location_No, dbo.tblSites.Package_No, dbo.tblSites.Package_Group, dbo.tblChangeOrders.CHANGE_ORDER_COST, 
dbo.tblContractorPricing.CONTRACTORS_COST FROM dbo.tblContractorPricing RIGHT OUTER JOIN
dbo.tblSites ON dbo.tblContractorPricing.Location_No = dbo.tblSites.Location_No LEFT OUTER JOIN
dbo.tblChangeOrders ON dbo.tblSites.Location_No = dbo.tblChangeOrders.Location_No
WHERE (dbo.tblSites.Package_No IS NOT NULL)) AS a GROUP BY Package_No, Package_Group) AS derivedtbl_1
WHERE (Package_Group = '#getPackage.package_group#') AND (Package_No = #getPackage.package_no#)
</cfquery>

<!--- <cfdump var="#getTotal#"> --->

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td colspan="3" height="15"></td></tr>
          <tr><td style="width:25%;text-align:right;">
		  <cfif getMaxSite.id is not "">
		  <a href="swPackageEdit.cfm?pid=#getMaxSite.id#"><img src="../images/arrow_left.png" width="20" height="29" title="Previous Package"></a>
		  </cfif>
		  </td>
		  <td align="center" class="pagetitle">Edit Package Information</td>
		  <td style="width:25%;">
		  <cfif getMinSite.id is not "">
		  <a href="swPackageEdit.cfm?pid=#getMinSite.id#"><img src="../images/arrow_right.png" width="20" height="29" title="Next Package"></a>
		  </td>
		  </cfif>
		  </tr>
		  <cfif session.user_level lt 2>
		  <tr><td colspan="3" height="15"></td></tr>
		  <cfelse>
			  <tr><td colspan="3" style="text-align:center;">
			  <a href="../reports/Estimating.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:-5px;" src="../images/report_e.png" width="20" height="20" title="Engineer Estimates Report"></a>
			  <a href="../reports/Pricing.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:5px;" src="../images/report_c.png" width="20" height="20" title="Contractor Pricing Report"></a>
			  <a href="../reports/Bidding.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:15px;" src="../images/report_b.png" width="20" height="20" title="Contractor Bid Form"></a>
			  </td></tr>
		  </cfif>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:800px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;width:800px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:55px;">Package:</th>
						<!--- <th class="drk right middle" style="width:32px;">Group:</th> --->
						<td class="left middle pagetitle" style="width:295px;padding:2px 3px 0px 0px;">#getPackage.package_group# - #getPackage.package_no#
						</td>
						<!--- <th class="drk right middle" style="width:90px;">Package Number:</th> --->
						<!--- <td class="drk right middle" style="width:40px;padding:2px 3px 0px 0px;">#getPackage.package_no#
						</td> --->
						
						<td align="left" style="width:332px;">
							<cfif session.user_level gt 1 AND session.user_power gte 0>
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm();return false;">Update</a>
							</cfif>
						</td>
						
						<td align="right" style="width:90px;">
							<cfif session.user_level gt 2>
							<a href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
							onclick="showRemove();return false;">Delete</a>
							</cfif>
						</td>
						
						</tr>
					</table>
			
			
			</th>
			
			
			</td>
		</tr>
			<cfset w1 = 130><cfset w2 = 130><cfset w3 = 116><cfset w4 = 110>
			<cfset dis = ""><cfif session.user_level lt 2 OR session.user_power lt 0><cfset dis="disabled"></cfif>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Work Order Number:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.work_order>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_wo" id="sw_wo" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">NFB Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.nfb_date is not ""><cfset v = dateformat(getPackage.nfb_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_nfb" id="sw_nfb" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Bids Due:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.bids_due_date is not ""><cfset v = dateformat(getPackage.bids_due_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_bid" id="sw_bid" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Construction Order:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.construct_order_date is not ""><cfset v = dateformat(getPackage.construct_order_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_co" id="sw_co" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Precon Meeting:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.precon_meeting_date is not ""><cfset v = dateformat(getPackage.precon_meeting_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_precon" id="sw_precon" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Notice to Proceed:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.notice_to_proceed_date is not ""><cfset v = dateformat(getPackage.notice_to_proceed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_ntp" id="sw_ntp" value="#v#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Performance Bond:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_performance" id="sw_performance" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getPackage.performance_bond is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">Payment Bond:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="sw_payment" id="sw_payment" class="rounded" style="width:55px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getPackage.payment_bond is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:71px;">Contractor:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.contractor>
						<td class="frm"  style="width:#w2+181#px;">
						<input type="Text" name="sw_contractor" id="sw_contractor" value="#v#" style="width:#w2+176#px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="height:30px;width:56px;">Total Cost:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getTotal.total is not ""><cfset v = numberformat(getTotal.total,"999,999,999.99")></cfif>
						<td class="frm"  style="width:102px;">$
						<input type="Text" name="sw_tc" id="sw_tc" value="#trim(v)#" style="width:88px;" class="center rounded" disabled>
						</td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="height:30px;width:100px;padding:1px 0px 1px 2px;">Engineers Estimate:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.engineers_estimate is not ""><cfset v = numberformat(getPackage.engineers_estimate,"999,999,999")></cfif>
						<td class="frm"  style="width:115px;">$
						<input type="Text" name="sw_est" id="sw_est" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" #dis#>
						<cfif dis is ""><a onclick="showCalc('ee');return false;" href="">
						<img style="position:relative;top:4px;" src="../images/Calculator.png" width="16" height="16" title="Recalculate Engineer's Estimate">
						</a></cfif>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:71px;">Awarded Bid:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.awarded_bid is not ""><cfset v = numberformat(getPackage.awarded_bid,"999,999,999")></cfif>
						<td class="frm"  style="width:115px;">$
						<input type="Text" name="sw_award" id="sw_award" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" #dis#>
						<cfif dis is ""><a onclick="showCalc('ab');return false;" href="">
						<img style="position:relative;top:4px;" src="../images/Calculator.png" width="16" height="16" title="Recalculate Awarded Bid">
						</a></cfif>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:68px;">Construction Manager:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.construction_manager>
						<td class="frm"  style="width:115px;">
						<input type="Text" name="sw_cm" id="sw_cm" value="#v#" style="width:110px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>			
			<cfif (session.user_power is 2 OR session.user_level is 3) OR (session.user_power is 3 AND session.user_level is 2)>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Contractor Information:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:648px;">
						<table cellpadding="0" cellspacing="0" border="0" style="padding:0px 0px 0px 0px;">
							<tr>
							<cfset v = ""><cfif getPackage.contractor_name is not ""><cfset v = getPackage.contractor_name></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:33px;">
							<span style="position:relative;top:-1px;">Name:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:215px;"><input type="Text" maxlength="50" name="sw_cname" id="sw_cname" value="#trim(v)#" style="width:205px;" class="left rounded" #dis#></td>
							<cfset v = ""><cfif getPackage.contractor_email is not ""><cfset v = getPackage.contractor_email></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:30px;">
							<span style="position:relative;top:-1px;">Email:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:216px;"><input type="Text" maxlength="50" name="sw_cemail" id="sw_cemail" value="#trim(v)#" style="width:206px;" class="left rounded" #dis#></td>
							<cfset v = ""><cfif getPackage.contractor_phone is not ""><cfset v = getPackage.contractor_phone></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:35px;">
							<span style="position:relative;top:-1px;">Phone:</span></td>	
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="20" name="sw_cphone" id="sw_cphone" value="#trim(v)#" style="width:102px;" class="left rounded" #dis#></td>
							</tr>
						</table>
						</td>
						</tr>
					</table>
				</td>
			</tr>			
			<cfelse>
				<cfset v = ""><cfif getPackage.contractor_name is not ""><cfset v = getPackage.contractor_name></cfif>
				<input type="hidden" name="sw_cname" id="sw_cname" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.contractor_email is not ""><cfset v = getPackage.contractor_email></cfif>
				<input type="hidden" name="sw_cemail" id="sw_cemail" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.contractor_phone is not ""><cfset v = getPackage.contractor_phone></cfif>
				<input type="hidden" name="sw_cphone" id="sw_cphone" value="#trim(v)#">
			</cfif>
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<cfset v = getPackage.notes>
				<td class="frm" colspan="4" style="height:75px;">
				<textarea id="sw_notes" class="rounded" style="position:relative;top:0px;left:2px;width:777px;height:67px;" #dis#>#v#</textarea>
				</td>
			</tr>

		</table>
	</td>
	</tr>
		<input type="Hidden" id="sw_id" name="sw_id" value="#url.pid#">
	</form>
</table>

<table cellspacing="0" cellpadding="0" border="0" align="center" style="width:753px;"><tr><td style="height:2px;"></td></tr></table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:800px;">
	<tr>	
		<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
			<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
				<td colspan="4" style="padding:0px 0px 0px 0px;">
				
					<div id="sites" style="border:0px red solid;height:300px;overflow-y:auto;">
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle nopad" style="height:40px;width:33px;">Edit</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:35px;">Site<br>No.</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:430px;">Facility Name</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:27px;">CD</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:60px;">Total<br>Concrete<br>(sq. ft)</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:70px;">Total Cost</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:70px;">Construction<br>Started</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:70px;">Construction<br>Completed</th>
						<!--- <td style="width:2px;"></td>
						<th class="center middle nopad" style="width:75px;">Anticipated<br>Completion<br>Date</th> --->
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:50px;">Remove</th>
						<!--- <td style="width:2px;"></td> --->
						</tr>
						<cfloop query="getSites">
							
							<tr><td style="height:2px;"></td></tr>
							<tr>
							<td class="small center frm" style="height:20px;"><a href="" onclick="goToSite(#url.pid#,#id#);return false;"><img src="../Images/rep.gif" width="13" height="16" alt="Edit Site Information" title="Edit Site Information"></a></td>
							<td style="width:2px;"></td>
							<td class="small center frm">#location_no#<!--- #site_suffix# ---></td>
							<td style="width:2px;"></td>
							<td class="small frm">#name#</td>
							<td style="width:2px;"></td>
							<td class="small center frm">#council_district#</td>
							<td style="width:2px;"></td>
							<td class="small center frm">#total_concrete#</td>
							<td style="width:2px;"></td>
							
							<!--- Get Contractor Price --->
							<cfquery name="getContract" datasource="#request.sqlconn#" dbtype="ODBC">
							SELECT contractors_cost FROM tblContractorPricing WHERE location_no = #location_no#
							</cfquery>
							<!--- Get ChangeOrder Values --->
							<cfquery name="getCOs" datasource="#request.sqlconn#" dbtype="ODBC">
							SELECT change_order_cost FROM tblChangeOrders WHERE location_no = #location_no#
							</cfquery>
							<cfset v = 0>
							<cfif getContract.recordcount gt 0>
								<cfif getContract.contractors_cost is not ""><cfset v = getContract.contractors_cost></cfif>
							</cfif>
							<cfif getCOs.recordcount gt 0>
								<cfif getCOs.change_order_cost is not ""><cfset v = v + getCOs.change_order_cost></cfif>
							</cfif>
							<cfset v = "$" & trim(numberformat(v,"999,999.00"))>
							<td class="small center frm">#v#</td>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif construction_start_date is not ""><cfset v = dateformat(construction_start_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif construction_completed_date is not ""><cfset v = dateformat(construction_completed_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td>
							<!--- <td style="width:2px;"></td>
							<cfset v = ""><cfif anticipated_completion_date is not ""><cfset v = dateformat(anticipated_completion_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td> --->
							<td style="width:2px;"></td>
							<td class="small frm center"><input type="Checkbox" id="chk_#id#" #dis#></td>
							<!--- <td style="width:2px;"></td> --->
							</tr>
						</cfloop>
						

					</table>
					
					</div>
					
				</td>
			</tr>
			

		</table>
	</td>
	</tr>
	</form>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr><td style="height:3px;"></td></tr>
  <tr>
    <td align="center">
	<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
	onclick="cancelUpdate();return false;">Cancel</a>
	</td>
  </tr>
  <tr><td style="height:5px;"></td></tr>
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

<div id="msg2" class="box" style="top:40px;left:1px;width:300px;height:90px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header2" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text2" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to delete this Package?<br>All Sites will go back to the unassigned pool.
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="submitForm(1);$('#chr(35)#msg2').hide();return false;">Continue...</a>
			</td>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>


<div id="msg3" class="box" style="top:40px;left:1px;width:220px;height:80px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg3').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header3" class="box_header"><strong>Recalculate:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text3" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to recalculate?
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="60%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="reCalculate(#url.pid#);return false;">Yes</a>
			</td>
			<td style="width:10px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg3').hide();return false;">No</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>
	
	
	
	

</body>
</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
var recs = #getSites.recordcount#;
var typ = "";
var dis = "#dis#";
</cfoutput>

function changeHeight() {
	var ht = top.getIFrameHeight();
	ht = ht - 345;
	ht2 = ((recs)*25)+42;
	if (ht2 < ht) { ht = ht2;}
	$('#sites').height(ht);
}

function submitForm(rmv) {
	
	var bypass = false;
	$('#msg').hide();
	var errors = '';var cnt = 0;
	
	var chk = $.isNumeric(trim($('#sw_est').val().replace(/,/g,""))); var chk2 = trim($('#sw_est').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Engineers Estimate must be Numeric!<br>"; }
	chk = $.isNumeric(trim($('#sw_award').val().replace(/,/g,""))); chk2 = trim($('#sw_award').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Awarded Bid must be Numeric!<br>"; }
	
	if (errors != '') {
		showMsg(errors,cnt);
		return false;	
	}
	
	var frm = $('#form1').serializeArray();
	frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });

	var idList = "";
	$('input[type=checkbox]').each(function () {
           if (this.checked) { idList = idList + this.id.replace("chk_","") + ","; }
	});
	
	if (idList != "") { idList = idList.substr(0,idList.length-1); }
	frm.push({"name" : "sw_idList", "value" : idList });
	
	if (typeof rmv != "undefined") { 
		if (rmv == 1) {	frm.push({"name" : "sw_remove", "value" : rmv }); }
		else {bypass = true;}
	}
	//console.log(rmv);
	//console.log(frm);

	if (dis == 'disabled') { return false; }
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updatePackage&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		//Refresh Package if Sites removed...
		if (data.REMOVED) { location.replace('swPackageEdit.cfm?pid=' + data.ID);	}
		else if (data.REMOVE == 1 && bypass == false) { location.replace('swPackageEntry.cfm'); }
		else { if (bypass == false) {showMsg("Package Information updated successfully!",1,"Package Information"); }}
		
	  }
	});
	
}

function goToSite(pid,sid) {
	submitForm(2);
	location.replace("swSiteEdit.cfm?pid=" + pid + "&sid=" + sid);
}

function cancelUpdate() {
	location.replace("../search/swPackageSearch.cfm");
}


$(function() {
    $( "#sw_nfb" ).datepicker();
	$( "#sw_bid" ).datepicker();
	$( "#sw_co" ).datepicker();
	$( "#sw_precon" ).datepicker();
	$( "#sw_ntp" ).datepicker();
});

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function showRemove() {
	$('#msg2').css({top:'50%',left:'50%',margin:'-'+($('#msg2').height() / 2)+'px 0 0 -'+($('#msg2').width() / 2)+'px'});
	$('#msg2').show();
}

function showCalc(t) {
	typ = t;
	$('#msg3').css({top:'270px',left:'50%',margin:'-'+($('#msg3').height() / 2)+'px 0 0 -'+($('#msg3').width() / 2)+'px'});
	$('#msg3').show();
}

function reCalculate(id) {

	var frm = [];
	frm.push({"name" : "sw_id", "value" : id });
	frm.push({"name" : "sw_type", "value" : typ });
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=reCalculateTotal&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if (typ == 'ee') {
			$('#sw_est').val(trim(data.VALUE));
		}
		else {
			$('#sw_award').val(trim(data.VALUE));
		}
		$('#msg3').hide();
	  }
	});
}



$(window).resize(function() {
	changeHeight();
});




changeHeight();
</script>

</html>


            

				

	


