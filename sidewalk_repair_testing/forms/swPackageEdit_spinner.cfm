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



       <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (3) --->
	
                
    
	             <script language="JavaScript" src="../js/progressing_loading_sign.js" type="text/javascript"></script>
                
	
    
                  
	         <!--- End ---- joe hu  7/17/2018 ----- add progressing loading sign ------ (3) --->


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

<!--- Get Status Values --->
<cfquery name="getStatus" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageStatus ORDER BY id
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

<cfset getWorkEst = structNew()>
<cfset getWorkEst.cost = "">
<cfif getSites.recordcount gt 0>
<cfquery name="getWorkEst" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (#valueList(getSites.location_no)#)
</cfquery>
</cfif>

<!--- <cfdump var="#getWorkEst#"> --->
<!--- <cfdump var="#getTotal#"> --->

<cfoutput>
<body alink="#request.color#" vlink="#request.color#" link="#request.color#" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow:auto;">
</cfoutput>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td colspan="3" height="15"></td></tr>
          <tr><td style="width:25%;text-align:right;">
		  <cfif getMaxSite.id is not "">
          
          
          <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ () --->
		        <a   onclick='start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );'   href="swPackageEdit.cfm?pid=#getMaxSite.id#">
                        <img src="../images/arrow_left.png" width="20" height="29" title="Previous Package">
                </a>
                
                
		  </cfif>
		  </td>
		  <td align="center" class="pagetitle">Edit Package Information</td>
		  <td style="width:25%;">
		  <cfif getMinSite.id is not "">
          
          
          
          <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ () --->
		          <a  onclick='start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );'   href="swPackageEdit.cfm?pid=#getMinSite.id#">
                          <img src="../images/arrow_right.png" width="20" height="29" title="Next Package">
                  </a>
                  
                  
                  
                  
		  </td>
		  </cfif>
		  </tr>
		  <cfif session.user_level lt 2>
		  	<cfif session.user_level is 0 AND session.user_power is 1 AND ucase(getPackage.contractor) is "BSS"><!--- Added for BSS Power User --->
			  <tr><td colspan="3" style="text-align:center;">
			  <a href="../reports/Estimating.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:-5px;" src="../images/report_e.png" width="20" height="20" title="Engineer Estimates Report"></a>
			  <a href="../reports/Pricing.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:5px;" src="../images/report_c.png" width="20" height="20" title="Contractor Pricing Report"></a>
			  <a href="../reports/Bidding.cfm?my_package=#getPackage.package_group#-#getPackage.package_no#" target="_blank"><img style="position:relative;top:-2px;left:15px;" src="../images/report_b.png" width="20" height="20" title="Contractor Bid Form"></a>
			  </td></tr>
			<cfelse>
			<tr><td colspan="3" height="15"></td></tr>
			</cfif>
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







<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
<div id="processing_icon" align="center"></div>
<div id="result_panel"> 









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
						
                        
                        
                        
                        
                         <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
                                       <td id="small_right_update_icon">
                                        
                                        
                                        
                                        </td>
                        
                        
                                        
                                        
                        
						<td align="left" style="width:320px;">
							<cfif session.user_level gt 1 AND session.user_power gte 0>
                            
							            <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							                        onclick="submitForm();return false;">
                                                    
                                                    Update
                                                    
                                                    
                                                    </a>
                                                    
                                                    
                                                    
                                                    
                                                    
							</cfif>
							<cfif session.user_level is 0 AND session.user_power is 1 AND (ucase(getPackage.contractor) is "BSS" OR ucase(getPackage.package_group) is "BSS")><!--- Added for BSS bonus power --->
                            
                            
                            
							      <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							                        onclick="submitForm();return false;">
                                                    
                                                    Update
                                                    
                                                    
                                  </a>
                                  
                                  
                                  
                                  
                                  
                                  
							</cfif>
						</td>
                        
                        
                       
                             
                             
                             
                             
                        
						
						<td align="right" style="width:60px;">
							<cfif session.user_level gt 2>
                            
                            
							         <a href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
							                              onclick="showRemove();return false;">
                                                          
                                                          Delete
                                                          
                                     </a>
                                     
							</cfif>
						</td>
                        
                        
                         <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
                                       <td id="small_left_delete_icon">
                                        
                                        
                                        
                                        </td>
                             
                        
						
						</tr>
					</table>
			
			
			</th>
			
			
			</td>
		</tr>
			<cfset w1 = 130><cfset w2 = 90><cfset w3 = 93><cfset w4 = 110><cfset w5 = 63>
			<cfset dis = ""><cfif session.user_level lt 2 OR session.user_power lt 0><cfset dis="disabled"></cfif>
			<cfif session.user_level is 0 AND session.user_power is 1 AND (ucase(getPackage.contractor) is "BSS" OR ucase(getPackage.package_group) is "BSS")><cfset dis=""></cfif><!--- Added for BSS bonus power --->
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w3#px;">Package Status:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:256px;">
						<select name="sw_pstatus" id="sw_pstatus" class="rounded" style="width:251px;" #dis#>
						<option value=""></option>
						<cfloop query="getStatus">
							<cfset sel = ""><cfif getPackage.status is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#package_status#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:#w4#px;">Work Order Number:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.work_order>
						<td class="frm"  style="width:#w4#px;">
						<input type="Text" name="sw_wo" id="sw_wo" value="#v#" style="width:#w4-5#px;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Contract Number:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.contract_number is not ""><cfset v = getPackage.contract_number></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_cno" id="sw_cno" value="#trim(v)#" style="width:#w2-5#px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w3#px;">NFB Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.nfb_date is not ""><cfset v = dateformat(getPackage.nfb_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_nfb" id="sw_nfb" value="#v#" style="width:#w2-5#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w5#px;">Bids Due:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.bids_due_date is not ""><cfset v = dateformat(getPackage.bids_due_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_bid" id="sw_bid" value="#v#" style="width:#w2-5#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:#w4#px;">Construction Order:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.construct_order_date is not ""><cfset v = dateformat(getPackage.construct_order_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w4#px;">
						<input type="Text" name="sw_co" id="sw_co" value="#v#" style="width:#w4-5#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Precon Meeting:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.precon_meeting_date is not ""><cfset v = dateformat(getPackage.precon_meeting_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_precon" id="sw_precon" value="#v#" style="width:#w2-5#px;text-align:center;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w3#px;">Notice to Proceed:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.notice_to_proceed_date is not ""><cfset v = dateformat(getPackage.notice_to_proceed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_ntp" id="sw_ntp" value="#v#" style="width:#w2-5#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:#w4+7#px;">Performance Bond:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:70px;">
						<select name="sw_performance" id="sw_performance" class="rounded" style="width:65px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getPackage.performance_bond is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w4+6#px;">Payment Bond:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:70px;">
						<select name="sw_payment" id="sw_payment" class="rounded" style="width:65px;" #dis#>
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfset sel = ""><cfif getPackage.payment_bond is id><cfset sel = "selected"></cfif>
							<option value="#id#" #sel#>#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Fiscal Year:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:#w2#px;">
						<select name="sw_fy" id="sw_fy" class="rounded" style="width:#w2-5#px;" #dis#>
						<option value=""></option>
						<cfloop index="i" from="14" to="30">
							<cfset fy = "20#i#-#i+1#">
							<cfset sel = ""><cfif getPackage.fiscal_year is "#i#-#i+1#"><cfset sel = "selected"></cfif>
							<option value="#i#-#i+1#" #sel#>#fy#</option>
						</cfloop> 
						</select>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			<cfset bssdis = ""><cfif session.user_level is 0 AND session.user_power is 1><cfset bssdis="disabled"></cfif><!--- Added for BSS bonus power --->
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="height:30px;width:101px;">Final Package Cost:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getTotal.total is not ""><cfset v = numberformat(getTotal.total,"999,999,999.99")></cfif>
						<td class="frm"  style="width:#115-17#px;">$
						<input type="Text" name="sw_tc" id="sw_tc" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" disabled>
						</td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="height:30px;width:101px;">Engineers Estimate:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.engineers_estimate is not ""><cfset v = numberformat(getPackage.engineers_estimate,"999,999,999")></cfif>
						<td class="frm"  style="width:#115-17#px;">$
						<input type="Text" name="sw_est" id="sw_est" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" #dis# #bssdis#>
						<!--- <cfif dis is "" AND bssdis is ""><a onclick="showCalc('ee');return false;" href="">
						<img style="position:relative;top:4px;" src="../images/Calculator.png" width="16" height="16" title="Recalculate Engineer's Estimate">
						</a></cfif> --->
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:68px;">Awarded Bid:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.awarded_bid is not ""><cfset v = numberformat(getPackage.awarded_bid,"999,999,999")></cfif>
						<td class="frm"  style="width:#115-17#px;">$
						<input type="Text" name="sw_award" id="sw_award" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" #dis# #bssdis#>
						<!--- <cfif dis is "" AND bssdis is ""><a onclick="showCalc('ab');return false;" href="">
						<img style="position:relative;top:4px;" src="../images/Calculator.png" width="16" height="16" title="Recalculate Awarded Bid">
						</a></cfif> --->
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:77px;">Contingency:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.contingency is not ""><cfset v = numberformat(getPackage.contingency,"999,999,999")></cfif>
						<td class="frm"  style="width:#115-17#px;">$
						<input type="Text" name="sw_cont" id="sw_cont" value="#v#" style="width:#115-31#px;" class="center rounded" #dis# #bssdis#></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<cfif session.user_level is 3 OR session.user_power is 3> <!--- Added so only power user and above can see --->
							<th class="left middle" style="height:30px;width:101px;">Working Estimate:</th>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif getWorkEst.cost is not ""><cfset v = numberformat(getWorkEst.cost,"999,999,999.99")></cfif>
							<td class="frm"  style="width:#115-17#px;">$
							<input type="Text" name="sw_west" id="sw_west" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" disabled>
							</td>
						<cfelse>
							<th class="left middle" style="height:30px;width:205px;"></th>
						</cfif>
						
						<td style="width:2px;"></td>
						
						<th class="left middle" style="height:30px;width:101px;">Not to Exceed Amount:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.not_to_exceed_amount is not ""><cfset v = numberformat(getPackage.not_to_exceed_amount,"999,999,999")></cfif>
						<td class="frm"  style="width:#115-17#px;">$
						<input type="Text" name="sw_ntea" id="sw_ntea" value="#trim(v)#" style="width:#115-31#px;" class="center rounded" #dis# #bssdis#>
						</td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="width:68px;">Site Walk:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.site_walk_date is not ""><cfset v = dateformat(getPackage.site_walk_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w3+5#px;">
						<input type="Text" name="sw_swalk" id="sw_swalk" value="#v#" style="width:#w3#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="width:77px;">10 Day Notice:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.ten_day_notice_date is not ""><cfset v = dateformat(getPackage.ten_day_notice_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w3+5#px;">
						<input type="Text" name="sw_tdn" id="sw_tdn" value="#v#" style="width:#w3#px;text-align:center;" class="rounded" #dis#></td>


						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						<th class="left middle" style="width:101px;">Board Acceptance:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.board_acceptance_date is not ""><cfset v = dateformat(getPackage.board_acceptance_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w3+5#px;">
						<input type="Text" name="sw_bad" id="sw_bad" value="#v#" style="width:#w3#px;text-align:center;" class="rounded" #dis#></td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="width:#w1#px;">Construction Manager:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.construction_manager>
						<td class="frm"  style="width:#w2+346#px;">
						<input type="Text" name="sw_cm" id="sw_cm" value="#v#" style="width:#w2+341#px;" class="rounded" #dis#></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w1#px;">Contractor:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.contractor>
						<td class="frm"  style="width:#w2+558#px;">
						
						<input type="Text" name="sw_contractor" id="sw_contractor" value="#v#" style="width:#w2+553#px;" class="rounded" #dis# #bssdis#></td>
						</tr>
					</table>
				</td>
			</tr>
			<cfif (session.user_power is 2 OR session.user_level is 3) OR (session.user_power is 3 AND session.user_level is 2) OR (session.user_power is 1 AND session.user_level is 0 AND ucase(getPackage.contractor) is "BSS")>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:60px;width:#w1#px;">Contractor Information:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:648px;">
						<table cellpadding="0" cellspacing="0" border="0" style="padding:0px 0px 0px 0px;">
							<tr>
							<cfset v = ""><cfif getPackage.contractor_name is not ""><cfset v = getPackage.contractor_name></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:47px;">
							<span style="position:relative;top:-1px;left:5px;">Contact:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:282px;"><input type="Text" maxlength="50" name="sw_cname" id="sw_cname" value="#trim(v)#" style="width:272px;" class="left rounded" #dis#></td>
							<cfset v = ""><cfif getPackage.contractor_email is not ""><cfset v = getPackage.contractor_email></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:32px;">
							<span style="position:relative;top:-1px;">Email:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="50" name="sw_cemail" id="sw_cemail" value="#trim(v)#" style="width:275px;" class="left rounded" #dis#></td>
							<!--- <cfset v = ""><cfif getPackage.contractor_phone is not ""><cfset v = getPackage.contractor_phone></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:35px;">
							<span style="position:relative;top:-1px;">Phone:</span></td>	
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="20" name="sw_cphone" id="sw_cphone" value="#trim(v)#" style="width:102px;" class="left rounded" #dis#></td> --->
							</tr>
							<tr><td colspan="4" style="height:2px;"></td></tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" style="padding:0px 0px 0px 0px;">	
							<tr>
							<cfset v = ""><cfif getPackage.contractor_address is not ""><cfset v = getPackage.contractor_address></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:47px;">
							<span style="position:relative;top:-1px;left:2px;">Address:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:415px;"><input type="Text" maxlength="50" name="sw_caddress" id="sw_caddress" value="#trim(v)#" style="width:405px;" class="left rounded" #dis#></td>
							<!--- <cfset v = ""><cfif getPackage.contractor_email is not ""><cfset v = getPackage.contractor_email></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:30px;">
							<span style="position:relative;top:-1px;">Email:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:216px;"><input type="Text" maxlength="50" name="sw_cemail" id="sw_cemail" value="#trim(v)#" style="width:206px;" class="left rounded" #dis#></td> --->
							<cfset v = ""><cfif getPackage.contractor_phone is not ""><cfset v = getPackage.contractor_phone></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:35px;">
							<span style="position:relative;top:-1px;">Phone:</span></td>	
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="20" name="sw_cphone" id="sw_cphone" value="#trim(v)#" style="width:139px;" class="left rounded" #dis#></td>
							</tr>
						</table>
						</td>
						</tr>
					</table>
				</td>
			</tr>		
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w1#px;">Emergency Contact 1:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:648px;">
						<table cellpadding="0" cellspacing="0" border="0" style="padding:0px 0px 0px 0px;">	
							<tr>
							<cfset v = ""><cfif getPackage.emergency_contact_one_name is not ""><cfset v = getPackage.emergency_contact_one_name></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:47px;">
							<span style="position:relative;top:-1px;left:12px;">Name:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:415px;"><input type="Text" maxlength="50" name="sw_eco1name" id="sw_eco1name" value="#trim(v)#" style="width:405px;" class="left rounded" #dis#></td>
							<cfset v = ""><cfif getPackage.emergency_contact_one_phone is not ""><cfset v = getPackage.emergency_contact_one_phone></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:35px;">
							<span style="position:relative;top:-1px;">Phone:</span></td>	
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="20" name="sw_eco1phone" id="sw_eco1phone" value="#trim(v)#" style="width:139px;" class="left rounded" #dis#></td>
							</tr>
						</table>
						</td>
						</tr>
					</table>
				</td>
			</tr>	
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:#w1#px;">Emergency Contact 2:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:648px;">
						<table cellpadding="0" cellspacing="0" border="0" style="padding:0px 0px 0px 0px;">	
							<tr>
							<cfset v = ""><cfif getPackage.emergency_contact_two_name is not ""><cfset v = getPackage.emergency_contact_two_name></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:47px;">
							<span style="position:relative;top:-1px;left:12px;">Name:</span></td>
							<td class="frm" style="padding:0px 0px 0px 0px;width:415px;"><input type="Text" maxlength="50" name="sw_eco2name" id="sw_eco2name" value="#trim(v)#" style="width:405px;" class="left rounded" #dis#></td>
							<cfset v = ""><cfif getPackage.emergency_contact_two_phone is not ""><cfset v = getPackage.emergency_contact_two_phone></cfif>
							<td class="frm" style="padding:0px 0px 0px 0px;font-size:11px;width:35px;">
							<span style="position:relative;top:-1px;">Phone:</span></td>	
							<td class="frm" style="padding:0px 0px 0px 0px;"><input type="Text" maxlength="20" name="sw_eco2phone" id="sw_eco2phone" value="#trim(v)#" style="width:139px;" class="left rounded" #dis#></td>
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
				<cfset v = ""><cfif getPackage.contractor_address is not ""><cfset v = getPackage.contractor_address></cfif>
				<input type="hidden" name="sw_caddress" id="sw_caddress" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.contractor_phone is not ""><cfset v = getPackage.contractor_phone></cfif>
				<input type="hidden" name="sw_cphone" id="sw_cphone" value="#trim(v)#">
				
				<cfset v = ""><cfif getPackage.emergency_contact_one_name is not ""><cfset v = getPackage.emergency_contact_one_name></cfif>
				<input type="hidden" name="sw_eco1name" id="sw_eco1name" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.emergency_contact_one_phone is not ""><cfset v = getPackage.emergency_contact_one_phone></cfif>
				<input type="hidden" name="sw_eco1phone" id="sw_eco1phone" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.emergency_contact_two_name is not ""><cfset v = getPackage.emergency_contact_two_name></cfif>
				<input type="hidden" name="sw_eco2name" id="sw_eco2name" value="#trim(v)#">
				<cfset v = ""><cfif getPackage.emergency_contact_two_phone is not ""><cfset v = getPackage.emergency_contact_two_phone></cfif>
				<input type="hidden" name="sw_eco2phone" id="sw_eco2phone" value="#trim(v)#">
				
			</cfif>
			
			<tr>
				<th class="left middle" colspan="2" style="height:30px;">
					
					<cfset src_rmvl = "../images/pdf_icon_trans.gif"><cfset href_rmvl = "">
					
					<cfset dir2 = getPackage.package_group & getPackage.package_no>
					<cfset dir = request.dir & "\pdfs\packages\" & dir2>
					<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.pdf">
					<cfloop query="pdfdir">
						<cfif lcase(pdfdir.name) is "contractors_bid." & dir2 & ".pdf">
							<cfset src_rmvl = "../images/pdf_icon.gif">
							<cfset href_rmvl = "href = '" & request.url & "pdfs/packages/" & dir2 & "/contractors_bid." & dir2 & ".pdf' title='View Tree Removal Permits PDF'">
						</cfif>
					</cfloop>
					
					
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
						<tr>
							<cfset attvis = "hidden"><cfif href_rmvl is not ""><cfset attvis = "visible"></cfif>
							<th class="left" style="width:170px;"><a id="a_rmvl" #href_rmvl# target="_blank"><img id="img_rmvl" src="#src_rmvl#" width="17" height="17" style="position:relative;top:2px;">
							<span style="position:relative;top:-3px;">Contractor's Bid</span></a><cfif (session.user_power is 2 OR session.user_level is 3) OR (session.user_power is 3 AND session.user_level is 2) OR (session.user_power is 1 AND session.user_level is 0 AND ucase(getPackage.contractor) is "BSS")>
							<span id="rmv_rmvl" style="visibility:#attvis#;"><a href="" onClick="showRemoveAttach(0);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Contractor's Bid" style="position:relative;top:-2px;left:7px;"></a></span></cfif>
							</th>
							<cfif (session.user_power is 2 OR session.user_level is 3) OR (session.user_power is 3 AND session.user_level is 2) OR (session.user_power is 1 AND session.user_level is 0 AND ucase(getPackage.contractor) is "BSS")>
							<th><a href="" onClick="showAttach();return false;"><img src="../images/attach.png" width="9" height="15" title="Attach File" style="position:relative;top:3px;right:5px;">
							<span style="position:relative;top:0px;right:5px;" title="Attach Files">Attach File</span></a></td>
							</cfif>
						</tr>
					</table>
						
				</th>
				</tr>
			
			
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
					    <td style="width:2px;"></td>
						<th class="center middle nopad" style="width:75px;">Date<br>Added</th> 
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:50px;">Remove</th>
						<!--- <td style="width:2px;"></td> --->
						</tr>
						<cfloop query="getSites">
							
							<tr><td style="height:2px;"></td></tr>
							<tr>
							<td class="small center frm" style="height:20px;"><a href="" onClick="goToSite(#url.pid#,#id#);return false;"><img src="../Images/rep.gif" width="13" height="16" alt="Edit Site Information" title="Edit Site Information"></a></td>
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
							<td style="width:2px;"></td>
                                
							<cfset v = ""><cfif packaged_date is not ""><cfset v = dateformat(packaged_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td> 
							<td style="width:2px;"></td>
                            
                            
							<cfset bssdis = ""><!--- Added for BSS bonus power --->
							<cfif session.user_power is 1 AND session.user_level is 0 AND (ucase(getPackage.contractor) is "BSS" OR ucase(getPackage.package_group) is "BSS")>
							<cfset bssdis = "disabled"></cfif>
							<td class="small frm center"><input type="Checkbox" id="chk_#id#" #dis# #bssdis#></td>
							<cfset bssdis = "">
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

<div id="msg2" class="box" style="top:40px;left:1px;width:300px;height:90px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg3').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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


<cfoutput>
<cfset w_box = 590>
<cfset w_msg = 515><cfset h_msg = 145> <!--- 545 for testing --->
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
			onclick="attachFiles('#getPackage.package_group##getPackage.package_no#');return false;">Attach File</a>
				&nbsp;<a id="attachclose" href="" class="button buttonText" tabindex="3"
			style="height:#ht#px;width:80px;padding:#p#px 0px 2px 0px;" 
			onclick="cancelAttach();return false;">Cancel</a></td>
				</tr>
			</table>
			</div>
			
			<cfif brow is "F"><cfset p = 0><cfset ht = 16></cfif>

			<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="position:absolute;top:#f_t#px;width:100%;">
				<form id="attach_file_form" enctype="multipart/form-data" method="post" action="" target="attach_iframe">
				
				<tr><th class="left" style="padding:0px 0px 0px 17px"><strong>Contractor's Bid:</strong></th></tr>
				<tr><td align="center">
				<div id="fi_header_rmvl" class="file_header" style="position:absolute;top:15px;left:#lft#px;width:80px;display:block;">File to Upload:</div>
				<div id="fi_mask_rmvl" class="fileinputs" style="top:16px;left:#lft+90#px;display:block;">
				<div id="fi_rmvl" style="position:relative;top:1px;width:800px;display:block;text-align:left;"></div>
				</div>
				<div id="fi_div_rmvl" style="display:block;">
				<input id="file_rmvl" name="file_rmvl" type="file" class="file" style="top:15px;left:#lft+90#px;display:block;" onChange="setFileName('rmvl');return false;" onClick="$('#chr(35)#attach_msg').hide();" /></div>
				<a id="fi_btn_rmvl" href="" class="button buttonText" tabindex="3"
				style="position:absolute;top:16px;left:#lft+408#px;padding:#p#px 0px 2px 0px;height:#ht#px;width:80px;font: 10px Arial, Verdana, Helvetica, sans-serif;z-index:1;display:block;" onClick="return false;">Browse</a>
				</td></tr>

				<tr><td><iframe id="attach_iframe" name="attach_iframe" style="display:none;position:relative;top:30px;left:0px;height:400px;width:500px;border:0px red solid;"></iframe></td></tr>
				</form>
			</table>
		</div>
	</div>
</div>
</cfoutput>

	
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
	chk = $.isNumeric(trim($('#sw_ntea').val().replace(/,/g,""))); chk2 = trim($('#sw_ntea').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Not to Exceed Amount must be Numeric!<br>"; }
	chk = $.isNumeric(trim($('#sw_cont').val().replace(/,/g,""))); chk2 = trim($('#sw_cont').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Contingency must be Numeric!<br>"; }
	
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
	
	if ($('#sw_contractor').is(':disabled')) { frm.push({"name" : "sw_contractor", "value" : trim($('#sw_contractor').val()) }); }
	if ($('#sw_est').is(':disabled')) { frm.push({"name" : "sw_est", "value" : trim($('#sw_est').val()) }); }
	if ($('#sw_award').is(':disabled')) { frm.push({"name" : "sw_award", "value" : trim($('#sw_award').val()) }); }
	if ($('#sw_ntea').is(':disabled')) { frm.push({"name" : "sw_ntea", "value" : trim($('#sw_ntea').val()) }); }
	if ($('#sw_cont').is(':disabled')) { frm.push({"name" : "sw_cont", "value" : trim($('#sw_cont').val()) }); }
	
	//console.log(rmv);
	//console.log(frm);

	if (dis == 'disabled') { return false; }
	
	
	
	<!--- joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	  
	      
		   
	      console.log("hide panel ============ ") 
		  
		  // This will disable  div 
           //document.getElementById("result_panel").disabled = true;
		   var nodes = document.getElementById("result_panel").getElementsByTagName('*');
				for(var i = 0; i < nodes.length; i++){
					 nodes[i].disabled = true;
				}
		  
		  
		  
		  
		   if (rmv == 1) { 
		   
		         show_loading_img_spinner('small_left_delete_icon', 'progressing_loading_sign')
		   
		   
		   } else {
				 //$("#result_panel").hide();
				 show_loading_img_spinner('small_right_update_icon', 'progressing_loading_sign')
		   }
		  
		 // wait(3000); //failed 
		  
	  <!--- End ----joe hu  7/13/2018 ----- add progressing loading sign ------ (1) --->
	
	
	
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updatePackage&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		
		
		
		
		
		
		<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
	
	      // pause 3 sec to show loading sign
		  
		    console.log("show panel ============ ") 
			wait(3000);  //7 seconds in milliseconds
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
	$( "#sw_swalk" ).datepicker();
	$( "#sw_tdn" ).datepicker();
	$( "#sw_bad" ).datepicker();
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

function showRemoveAttach(idx) {
	$('#msg7').css({top:'50%',left:'50%',margin:'-'+($('#msg7').height() / 2)+'px 0 0 -'+($('#msg7').width() / 2)+'px'});
	$('#msg7').show();
	$('#attached_type').val(idx);
}

function doRemoveAttach() {
	
	
	<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (2) --->
		//start_processing_sign("result_panel","processing_icon","progressing_loading_sign" );
		
	 var nodes = document.getElementById("result_panel").getElementsByTagName('*');
				for(var i = 0; i < nodes.length; i++){
					 nodes[i].disabled = true;
				}
		  
		  
		  
    show_loading_img_spinner('small_center_delete_icon', 'progressing_loading_sign')	
	
	
	
	
	
	
	

	var ref = $('#a_rmvl').attr('href');
	var typ = $('#attached_type').val();
	if (typ == 1) {	ref = $('#a_arb').attr('href'); }  //Incase more are added...
	var arrRef = ref.split("/");
	ref = arrRef[arrRef.length-1];
	dir = 'packages\\' + arrRef[arrRef.length-2];
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
		
		if (typ == 1) { //Incase more are added...
			$("#a_arb").removeAttr('href');
			$("#a_arb").removeAttr('title');
			$("#img_arb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_arb").css('visibility', 'hidden');
		}
		else {
			$("#a_rmvl").removeAttr('href');
			$("#a_rmvl").removeAttr('title');
			$("#img_rmvl").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_rmvl").css('visibility', 'hidden');
		}
		
	  }
	});

}

function showAttach(txt,cnt) {
	$("#fi_rmvl").html('');
	$('#attach_file_form')[0].reset();
	$('#attach_msg').html('');
	$('#attachments').css({top:'50%',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	//$('#attachments').css({top:'200px',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	$('#attachments').show();
}

function cancelAttach()
{
	$("#fi_rmvl").html('');
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

function attachFiles(sw_id) {

	$("#attach_msg").hide();
	$('#attach_iframe').attr('src', "");
	document.getElementById("attach_file_form").action = "swUploadPK.cfm?sw_id=" + sw_id + "&r=" + Math.random();
	document.getElementById("attach_file_form").submit();
	
	var goBool = false;
	var counter = 0;
	intervalId = setInterval(function() {
    	//make this is the first thing you do in the set interval function
        counter++;
		//console.log(counter);
		if (typeof $( '#attach_iframe' ).contents().find('#response').html() != "undefined")
		 	goBool = true;
	    //make this the last check in your set interval function
	     if ( counter > 60 || goBool == true ) {
	          clearInterval(intervalId);
			  var msg = $( '#attach_iframe' ).contents().find('#response').html();
			  var doRmvl = $( '#attach_iframe' ).contents().find('#doRMVL').html();
			  var dir = $( '#attach_iframe' ).contents().find('#dir').html();
			  finishUploadFiles(msg,doRmvl,dir);
	     }
	//end setInterval
    } , 1000);

}

function finishUploadFiles(msg,doRmvl,dir){

	if (msg != "Success") {
		$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Please try again.");
		$("#attach_msg").show();
		return false;
	}
	
	if (doRmvl == "true") {
		$("#a_rmvl").attr('href', url + 'pdfs/packages/' + dir + '/Contractors_Bid.' + dir + '.pdf');
		$("#a_rmvl").attr('title', 'View Contractor\'s Bid PDF');
		$("#img_rmvl").attr('src', '../images/pdf_icon.gif');
		$("#rmv_rmvl").css('visibility', 'visible');
	}
	
	$('#attachments').hide();
}


$(window).resize(function() {
	changeHeight();
});




changeHeight();
</script>

</html>


            

				

	


