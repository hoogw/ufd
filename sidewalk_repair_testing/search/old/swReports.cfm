<!doctype html>

<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=6");
	</script>
	<cfabort>
</cfif>



<!--- joe hu 7/31/18 report access --->
<cfif (session.user_level lt 2 AND session.user_power is not 1) AND (len(session.user_report) eq 0)>


	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Generate Sidewalk Repair Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<cfoutput>


<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT vwHDRWorkOrders.Package as pkg FROM vwHDRWorkOrders ORDER BY package_group, package_no
</cfquery>

<!--- Get EE Locations --->
<cfquery name="getLocations" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT vwHDREngineeringEstimate.location_no as loc FROM vwHDREngineeringEstimate ORDER BY location_no
</cfquery>

<!--- Get EE Locations --->
<cfquery name="getLocations2" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT vwHDRContractorPricing.location_no as loc FROM vwHDRContractorPricing ORDER BY location_no
</cfquery>

<body alink="#request.color#" vlink="#request.color#" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Generate Sidewalk Repair Reports</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
	
    
    
    <tr>
	   <td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk center middle" style="width:294px;">Select Sidewalk Repair Report</th>
						</tr>
					</table>
			</th>
		</tr>
        
        
	 	<!--- nathan neumann 1/8/19 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",1,", session.user_report) gt 0))>
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>					
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="right">
						<tr>
						<td><a id="ccr" href="../reports/CompletedCurbRamps.cfm" target="_blank" style="color:#request.color#">Completed Curb Ramps</a></td>
						<td style="width:15px;"></td>
						<td>
						To:&nbsp;
						<select name="yr1" id="yr1" class="rounded" style="position:relative;top:1px;width:60px;" onChange="setURL11();">
						<option value="">Today</option>
						<cfloop index="i" from="2018" to="2030">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:15px;"></td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
		
        </cfif>  
		 
		<!--- nathan neumann 1/8/19 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",2,", session.user_report) gt 0))>

		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>					
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="right">
						<tr>
						<td><a id="ci" href="../reports/CompletedImprovements.cfm" target="_blank" style="color:#request.color#">Completed Improvements</a></td>
						<td style="width:15px;"></td>
						<td>
						To:&nbsp;
						<select name="yr2" id="yr2" class="rounded" style="position:relative;top:1px;width:60px;" onChange="setURL12();">
						<option value="">Today</option>
						<cfloop index="i" from="2018" to="2030">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:15px;"></td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>

        </cfif> 
		
		<!--- nathan neumann 4/1/19 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",3,", session.user_report) gt 0))>

		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>					
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="right">
						<tr>
						<td><a id="car" href="../reports/CompletedAccessRequests.cfm" target="_blank" style="color:#request.color#">Completed Access Requests</a></td>
						<td style="width:15px;"></td>
						<td>
						To:&nbsp;
						<select name="yr3" id="yr3" class="rounded" style="position:relative;top:1px;width:60px;" onChange="setURL13();">
						<option value="">Today</option>
						<cfloop index="i" from="2018" to="2030">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:15px;"></td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>

        </cfif> 
	
        
    <!--- joe hu 7/31/18 report access --->
	<cfif ((len(session.user_report) eq 0) OR (FindNoCase(",10,", session.user_report) gt 0))>
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/ConstructionTracking.cfm" target="_blank" style="color:#request.color#">Construction Tracking Log</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
     </cfif>   
        
        
		<!--- <tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/Council.cfm" target="_blank" style="color:#request.color#">Council Report</a>
					</th>
					</tr>
				</table>
			</td>
		</tr> --->
		
		
        
        
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",20,", session.user_report) gt 0))>
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="cdr" href="../reports/Council.cfm" target="_blank" style="color:#request.color#">Council Report</a></td>
						<td style="width:8px;"></td>
						<td>
						<a id="btnFilter" href="" class="buttonSoft buttonText" style="height:15px;width:50px;padding:2px 0px 0px 0px;;position:relative;left:4px;" 
				onclick="showFilter();return false;">Filter</a>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",30,", session.user_report) gt 0))>
        
         
         
         
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="eer" href="../reports/Estimating.cfm?my_package=#getGroups.pkg#" target="_blank" style="color:#request.color#">Engineer Estimates Report</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg" id="pkg" class="rounded" style="position:relative;top:1px;width:85px;" onChange="setURL();">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",40,", session.user_report) gt 0))>
        
         
        
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="bf" href="../reports/Bidding.cfm?my_package=#getGroups.pkg#" target="_blank" style="color:#request.color#;position:relative;left:16px;">Contractor Bid Form</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg2" id="pkg2" class="rounded" style="position:relative;top:1px;left:16px;width:85px;" onChange="setURL2();">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",50,", session.user_report) gt 0))>
        
        
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="cp" href="../reports/Pricing.cfm?my_package=#getGroups.pkg#" target="_blank" style="color:#request.color#;position:relative;left:3px;">Contractor Pricing Report</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg3" id="pkg3" class="rounded" style="position:relative;top:1px;left:3px;width:85px;" onChange="setURL3();">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
		
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",60,", session.user_report) gt 0))>
        
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="fq" href="../reports/FinalQuantities.cfm?my_package=#getGroups.pkg#" target="_blank" style="color:#request.color#;position:relative;left:14px;">Final Quantites Form</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg5" id="pkg5" class="rounded" style="position:relative;top:1px;left:14px;width:85px;" onChange="setURL7();">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",70,", session.user_report) gt 0))>
        
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a href="" style="color:#request.color#;position:relative;left:10px;"
					onclick="downloadData();return false;">Bid Package Excel File</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg4" id="pkg4" class="rounded" style="position:relative;top:1px;left:10px;width:85px;">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",80,", session.user_report) gt 0))>
        
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="tp" href="../reports/TreePermits.cfm?package=#getGroups.pkg#" target="_blank" style="color:#request.color#;position:relative;left:2px;">Bid Package Tree Permits</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="pkg6" id="pkg6" class="rounded" style="position:relative;top:1px;left:2px;width:85px;" onChange="setURL8();">
						<cfloop query="getGroups">
							<option value="#pkg#">#pkg#</option>
						</cfloop>
						</select>
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
		
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",90,", session.user_report) gt 0))>
        
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="eel" href="../reports/EstimatingByLocation.cfm?my_loc=#getLocations.loc#" target="_blank" style="color:#request.color#;">Engineer Estimate by Site</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="loc1" id="loc1" class="rounded" style="position:relative;top:1px;width:68px;" onChange="setURL4();">
						<cfloop query="getLocations">
							<option value="#loc#">#loc#</option>
						</cfloop>
						</select>&nbsp;&nbsp;&nbsp;
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",100,", session.user_report) gt 0))>
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
						<td><a id="cpl" href="../reports/PricingByLocation.cfm?my_loc=#getLocations2.loc#" target="_blank" style="color:#request.color#;">Contractor Pricing by Site</a></td>
						<td style="width:5px;"></td>
						<td>
						<select name="loc2" id="loc2" class="rounded" style="position:relative;top:1px;width:68px;" onChange="setURL5();">
						<cfloop query="getLocations2">
							<option value="#loc#">#loc#</option>
						</cfloop>
						</select>&nbsp;&nbsp;&nbsp;
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
          </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",110,", session.user_report) gt 0))>
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/CurbRampTracking.cfm" target="_blank" style="color:#request.color#">Curb Ramp Tracking Report</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
		
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",120,", session.user_report) gt 0))>
        
        
        
        
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/TreeTracking.cfm" target="_blank" style="color:#request.color#">Tree Report</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",130,", session.user_report) gt 0))>
        
        
        
        
		
		<tr>
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/treetracking_excel.cfm" target="_blank" style="color:#request.color#">Tree Report Excel File</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
       
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",140,", session.user_report) gt 0))>
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:50px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr><td style="height:3px;"></td></tr>
						<tr>
						<td><a id="trpcup" href="../reports/TreeReadyToPlant_Excel.cfm?planting_start=2015-07-01&planting_end=#dateFormat(Now(),"yyyy-mm-dd")#" target="_blank" style="color:#request.color#;">Trees Ready To Plant Excel File
</a></td>
						</tr>
						<tr><td style="height:8px;"></td></tr>
						<tr>
						<td >
						&nbsp;&nbsp;&nbsp;&nbsp;From:&nbsp;
						<input type="Text" name="rpt_trpfrm" id="rpt_trpfrm" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onChange="setURL10();">
						&nbsp;&nbsp;&nbsp;&nbsp;To:&nbsp;
						<input type="Text" name="rpt_trpto" id="rpt_trpto" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onChange="setURL10();">
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",150,", session.user_report) gt 0))>
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/TreeTracking_Planned.cfm" target="_blank" style="color:#request.color#">Planned Tree Report</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",160,", session.user_report) gt 0))>
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/PackageStatus.cfm" target="_blank" style="color:#request.color#">Package Status Report</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
        
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",170,", session.user_report) gt 0))>
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					<a href="../reports/compliance2.cfm" target="_blank" style="color:#request.color#">Certificates of Compliance Excel File</a>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
         
         </cfif>  
         
         <!--- joe hu 7/31/18 report access --->
	    <cfif ((len(session.user_report) eq 0) OR (FindNoCase(",180,", session.user_report) gt 0))>
        
        
        
        
        
        
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:50px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr><td style="height:3px;"></td></tr>
						<tr>
						<td><a id="acup" href="../reports/PricingAnalysis.cfm" target="_blank" style="color:#request.color#;">Average Contractor Unit Prices Report
</a></td>
						</tr>
						<tr><td style="height:8px;"></td></tr>
						<tr>
						<td >
						&nbsp;&nbsp;&nbsp;&nbsp;From:&nbsp;
						<input type="Text" name="rpt_acfrm" id="rpt_acfrm" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onChange="setURL6();">
						&nbsp;&nbsp;&nbsp;&nbsp;To:&nbsp;
						<input type="Text" name="rpt_acto" id="rpt_acto" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onChange="setURL6();">
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr>
        
        
        
         <!--- joe hu 7/31/18 report access --->
       </cfif>  
	   
	    
        
        
		
		<!--- <tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:50px;width:294px;">
					<table cellpadding="0" cellspacing="0" border="0" align="center">
						<tr><td style="height:3px;"></td></tr>
						<tr>
						<td><a id="acoc" href="../reports/Compliance.cfm" target="_blank" style="color:#request.color#;">Certificates of Compliance Report
</a></td>
						</tr>
						<tr><td style="height:8px;"></td></tr>
						<tr>
						<td >
						&nbsp;&nbsp;&nbsp;&nbsp;From:&nbsp;
						<input type="Text" name="rpt_cocfrm" id="rpt_cocfrm" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onchange="setURL9();">
						&nbsp;&nbsp;&nbsp;&nbsp;To:&nbsp;
						<input type="Text" name="rpt_cocto" id="rpt_cocto" value="" style="width:67px;height:20px;padding:0px;text-align:center;" class="roundedsmall" onchange="setURL9();">
						</td>
						</tr>
					</table>
					</th>
					</tr>
				</table>
			</td>
		</tr> --->
		
		
		
		</table>
	</td>
	</tr>
</table>			


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15">
		  <a style="visibility:hidden;" id="lnk" target="_blank" href="">asdas</a>
		  </td></tr>
		</table>
  	</td>
  </tr>
</table>

<iframe NAME="download_package" id="download_package" src="" allowtransparency="true" background-color="transparent" style="height:1px;width:1px;border:0px red solid;visibility:hidden;" frameborder="0"></iframe>


</table>

<div id="filter" class="box" style="top:40px;left:400px;width:50px;height:310px;display:none;z-index:505;">
	<!--- <a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#filter').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a> --->
	<div class="box_header" style="text-align:center;margin: -1px 0px 0px -1px;position:relative;left:-5px;">Filter</div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;background-color:white;">
		<div id="filter_text" style="top:10px;left:0px;height:200px;padding:20px 0px 0px 0px;align:center;text-align:center;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="left" class="dd" id="cd0"  onclick="changeClass('cd0');">ALL</td></tr>
			<cfloop index="i" from="1" to="15">
			<tr><td align="left" class="dd" id="cd#i#"  onclick="changeClass('cd#i#');">CD #i#</td></tr>
			</cfloop>
			<tr><td height="5"></td></tr>
			<tr><td align="center">
				<a href="" class="buttonSoft buttonText" style="height:15px;width:40px;padding:2px 0px 0px 0px;" 
				onclick="applyFilter();return false;">Done</a>
			</td></tr>
		</table>
		</div>

	</div>
</div>
	
	
</body>
</cfoutput>

<script>

function setURL() {
	var pkg = $("#pkg").val();
	$("#eer").attr("href",'../reports/Estimating.cfm?my_package=' + pkg);
}

function setURL2() {
	var pkg = $("#pkg2").val();
	$("#bf").attr("href",'../reports/Bidding.cfm?my_package=' + pkg);
}

function setURL3() {
	var pkg = $("#pkg3").val();
	$("#cp").attr("href",'../reports/Pricing.cfm?my_package=' + pkg);
}

function setURL4() {
	var loc = $("#loc1").val();
	$("#eel").attr("href",'../reports/EstimatingByLocation.cfm?my_loc=' + loc);
}

function setURL5() {
	var loc = $("#loc2").val();
	$("#cpl").attr("href",'../reports/PricingByLocation.cfm?my_loc=' + loc);
}

function setURL6() {
	
	var frm = ""; var too = "";
	var sfx = "";
	if ($.trim($("#rpt_acfrm").val()) != "") {
		var arr = $("#rpt_acfrm").val().split("/");
		frm = arr[2] + "-" + arr[0] + "-" + arr[1];
		sfx = sfx + "start=" + frm;
	}
	if ($.trim($("#rpt_acto").val()) != "") {
		var arr = $("#rpt_acto").val().split("/");
		too = arr[2] + "-" + arr[0] + "-" + arr[1];
		if (sfx != "") { sfx = sfx + "&"; }
		sfx = sfx + "end=" + too;
	}
	
	if (sfx != "") { sfx = "?" + sfx; }
	$("#acup").attr("href",'../reports/PricingAnalysis.cfm' + sfx);
}

function setURL7() {
	var pkg = $("#pkg5").val();
	$("#fq").attr("href",'../reports/FinalQuantities.cfm?my_package=' + pkg);
}

function setURL8() {
	var loc = $("#pkg6").val();
	$("#tp").attr("href",'../reports/TreePermits.cfm?package=' + loc);
}

function setURL9() {
	
	var frm = ""; var too = "";
	var sfx = "";
	if ($.trim($("#rpt_cocfrm").val()) != "") {
		var arr = $("#rpt_cocfrm").val().split("/");
		frm = arr[2] + "-" + arr[0] + "-" + arr[1];
		sfx = sfx + "report_start_date=" + frm;
	}
	if ($.trim($("#rpt_cocto").val()) != "") {
		var arr = $("#rpt_cocto").val().split("/");
		too = arr[2] + "-" + arr[0] + "-" + arr[1];
		if (sfx != "") { sfx = sfx + "&"; }
		sfx = sfx + "report_end_date=" + too;
	}
	
	if (sfx != "") { sfx = "?" + sfx; }
	$("#acoc").attr("href",'../reports/Compliance.cfm' + sfx);
}

function setURL10() {
	
	var frm = ""; var too = "";
	var sfx = "";
	if ($.trim($("#rpt_trpfrm").val()) != "") {
		var arr = $("#rpt_trpfrm").val().split("/");
		frm = arr[2] + "-" + arr[0] + "-" + arr[1];
		sfx = sfx + "planting_start=" + frm;
	}
	else {
		sfx = sfx + "planting_start=" + "2015-07-01";
	}
	if ($.trim($("#rpt_trpto").val()) != "") {
		var arr = $("#rpt_trpto").val().split("/");
		too = arr[2] + "-" + arr[0] + "-" + arr[1];
		if (sfx != "") { sfx = sfx + "&"; }
		sfx = sfx + "planting_end=" + too;
	}
	else {
		if (sfx != "") { sfx = sfx + "&"; }
		<cfoutput>sfx = sfx + "planting_end=" + "#dateFormat(Now(),"yyyy-mm-dd")#";</cfoutput>
	}
	
	if (sfx != "") { sfx = "?" + sfx; }
	$("#trpcup").attr("href",'../reports/TreeReadyToPlant_Excel.cfm' + sfx);
}

function setURL11() {
	var yr = $("#yr1").val();
	$("#ccr").attr("href",'../reports/CompletedCurbRamps.cfm?report_year=' + yr);
}

function setURL12() {
	var yr = $("#yr2").val();
	$("#ci").attr("href",'../reports/CompletedImprovements.cfm?report_year=' + yr);
}

function setURL13() {
	var yr = $("#yr3").val();
	$("#car").attr("href",'../reports/CompletedAccessRequests.cfm?report_year=' + yr);
}




function showFilter() {
	$("#filter").css('top',($("#btnFilter").offset().top-1) + "px");
	$("#filter").css('left',($("#btnFilter").offset().left) + "px");
	$("#filter").show();
}

function changeClass(ctrl) {

	if ($("#" + ctrl).attr("class") == 'dd') {
		$("#" + ctrl).attr("class",'dd_select');
	}
	else {
		$("#" + ctrl).attr("class",'dd');
	}
	
	if (ctrl == 'cd0') {
		for (var i=1, il=15; i<il; i++) {
			$("#cd" + i).attr("class",'dd');
        }
	}
	else {
		$("#cd0").attr("class",'dd');
	}

}

function applyFilter() {

	$('#filter').hide();
	var arrCDs = [];
	for (var i=1, il=15; i<=il; i++) {
		if ($("#cd" + i).attr("class") == 'dd_select') { 
			arrCDs.push(i); 
			$("#cd" + i).attr("class",'dd');
		}
    }

	if (arrCDs.length == 0) {
		if ($("#cd0").attr("class") == 'dd_select') {
			$("#cd0").attr("class",'dd');
			$link = $('#cdr:first');
			$link[0].click();
		}
	}
	else {
		var strCDs = arrCDs.join(",");
		$("#lnk").attr("href",'../reports/Council.cfm?d=' + strCDs);
		$link = $('#lnk:first');
		$link[0].click();
	}
}

function downloadData() {
	<cfoutput>
	var url = "#request.url#";
	</cfoutput>
	var pk =  $('#pkg4').val();
	//console.log(pk);
	$('#download_package').prop('src',url + "reports/bid_package.cfm?pk=" + pk);
}

$( "#rpt_acfrm" ).datepicker();
$( "#rpt_acto" ).datepicker();
$( "#rpt_acfrm" ).datepicker();
$( "#rpt_acto" ).datepicker();
$( "#rpt_trpfrm" ).datepicker();
$( "#rpt_trpto" ).datepicker();

</script>

</html>


            

				

	


