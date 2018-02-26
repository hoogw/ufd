<!doctype html>

<cfparam name="s" default="">
<cfoutput>
<HTML>
<HEAD>
<TITLE>Welcome</TITLE>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
    <!-- Sets whether a web application runs in full-screen mode. -->
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
	<!-- Sets the style of the status bar for a web application. -->
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	
	<META http-EQUIV="Pragma" CONTENT="no-cache">  
	<META http-EQUIV="cache-control" CONTENT="no-cache, no-store, must-revalidate">
	<META http-EQUIV="Expires" CONTENT="Mon, 01 Jan 1970 23:59:59 GMT">
	
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
</HEAD>

<style type="text/css">
body{background-color: transparent}
</style>

<cfinclude template="css/css.cfm">
<cfparam name="lno" default="00046">

<cfset f = lno>
<cfset arrA[1] = "A1.jpg">
<cfset arrB[1] = "B1.jpg">

<cfset w = 450>
<cfset h = int((0.75*w))>

<style>
.border {
	<cfoutput>
	border:2px #request.color# solid;
	</cfoutput>
}
td.small { font: 14px Arial, Verdana, Helvetica, sans-serif; }
</style>

<cfset dt = now()>
<cfset dt = dateformat(dt,"mmmm d, yyyy")>

<body>

<div style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">
<!--- <img src="Images/mtabouttrees.jpg" width="550" height="138" alt="" border="0"> --->

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr> 
            <td height="10"></td>
          </tr>
          <tr> 
            <td align="center" class="formtitle"><font color="#request.color#">Welcome to the<br>SIDEWALK REPAIR PROGRAM</font></td>
          </tr>
		   <tr> 
            <td height="10"></td>
          </tr>
		  <!---  <tr> 
            <td align="center"><!--- <img src="Images\broken-sidewalk.png" width="640" height="480" alt="" style="border:2px #request.color# solid;"> ---><!--- <img src="images/sidewalk_fix.png" width="717" height="460" alt="" style="border:2px #request.color# solid;"> ---><img src="images/sidewalk_new.png" width="555" height="500" alt="" style="border:2px #request.color# solid;"></td>
          </tr> --->
		</table>
  	</td>
  </tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="text-align:center;" align="center">
<tr>
	<td class="center small" style="vertical-align:top;">
		<cfif arrayLen(arrB) gt 0>
		<table cellpadding="0" cellspacing="0" border="0">
			<cfloop index="i" from="1" to="#arrayLen(arrB)#">
			<tr>
			<td class="center small"><img id="b#i#" src="http://navigatela.lacity.org/srp/NavLA_Photos/#f#/#arrB[i]#" class="border" width="#w#" height="#h#" alt=""></td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			</cfloop>
		</table>
		</cfif>
	</td>
	
	<td></td>
	
	<td class="center small" style="vertical-align:top;">
	
		<cfif arrayLen(arrA) gt 0>
		<table cellpadding="0" cellspacing="0" border="0">
			<cfloop index="i" from="1" to="#arrayLen(arrA)#">
			<tr>
			<td class="center small"><img id="a#i#" src="http://navigatela.lacity.org/srp/NavLA_Photos/#f#/#arrA[i]#" class="border" width="#w#" height="#h#" alt=""></td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			</cfloop>
		</table>
		</cfif>
	
	</td>
</tr>
<tr>
	<td id="spc2" colspan="3" style="height:10px;"></td>
</tr>
<tr>
	<td class="center small" style="color:#request.color#;"><div id="before"><strong>BEFORE</strong></div></td>
	<td style="width:10px;"></td>
	<td class="center small" style="color:#request.color#;"><div id="after"><strong>AFTER</strong></div></td>
</tr>
<tr>
	<td id="spc2" colspan="3" style="height:10px;"></td>
</tr>

</table>

<cfquery name="getAssessed" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE assessed_date is not null
</cfquery>

<cfquery name="getAllSites" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE removed is null
</cfquery>

<cfquery name="getRepairs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE repairs_required = 1
</cfquery>

<cfquery name="getNoRepairs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE repairs_required = 0
</cfquery>

<cfquery name="getNTP" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COUNT(*) AS cnt
FROM (SELECT dbo.tblSites.Location_No, dbo.tblPackages.Notice_To_Proceed_Date
FROM dbo.tblSites INNER JOIN dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND 
dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group
WHERE (NOT (dbo.tblPackages.Notice_To_Proceed_Date IS NULL)) <!--- AND 
(dbo.tblSites.Construction_Start_Date IS NULL) AND (dbo.tblSites.Construction_Completed_Date IS NULL) --->) AS derivedtbl_1
</cfquery>

<cfquery name="getEst" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT SUM(est) AS total
FROM (SELECT dbo.tblSites.Location_No, dbo.tblPackages.Notice_To_Proceed_Date, dbo.tblEngineeringEstimate.ENGINEERS_ESTIMATE_TOTAL_COST AS est
FROM dbo.tblSites INNER JOIN dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND 
dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group LEFT OUTER JOIN
dbo.tblEngineeringEstimate ON dbo.tblSites.Location_No = dbo.tblEngineeringEstimate.Location_No
WHERE (NOT (dbo.tblPackages.Notice_To_Proceed_Date IS NULL))) AS derivedtbl_1
</cfquery>

<cfquery name="getPricing" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT SUM(Awarded_Bid) AS total FROM dbo.tblPackages WHERE (Notice_To_Proceed_Date IS NOT NULL)
<!--- SELECT SUM(est) AS total 
FROM (SELECT dbo.tblSites.Location_No, dbo.tblPackages.Notice_To_Proceed_Date, dbo.tblContractorPricing.CONTRACTORS_COST AS est
FROM dbo.tblSites INNER JOIN dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND 
dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group LEFT OUTER JOIN
dbo.tblContractorPricing ON dbo.tblSites.Location_No = dbo.tblContractorPricing.Location_No
WHERE (NOT (dbo.tblPackages.Notice_To_Proceed_Date IS NULL))) AS derivedtbl_1 --->
</cfquery>

<cfquery name="getCost" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT CASE WHEN SUM(co) IS NULL THEN 0 ELSE SUM(co) END + CASE WHEN SUM(cor) IS NULL THEN 0 ELSE SUM(cor) END AS cost
FROM (SELECT dbo.tblSites.Location_No, dbo.tblContractorPricing.CONTRACTORS_COST AS co, dbo.tblChangeOrders.CHANGE_ORDER_COST AS cor
FROM dbo.tblSites LEFT OUTER JOIN dbo.tblChangeOrders ON dbo.tblSites.Location_No = dbo.tblChangeOrders.Location_No LEFT OUTER JOIN
dbo.tblContractorPricing ON dbo.tblSites.Location_No = dbo.tblContractorPricing.Location_No
WHERE (dbo.tblSites.Construction_Completed_Date IS NOT NULL)) AS derivedtbl_1
</cfquery>

<cfquery name="getTrees" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT dbo.tblSites.Location_No, dbo.tblPackages.Notice_To_Proceed_Date, dbo.tblTreeList.TREE_REMOVAL_DATE, 
dbo.tblTreeList.TREE_PLANTING_DATE, dbo.tblTreeList.ACTION_TYPE, dbo.tblTreeList.TYPE
FROM dbo.tblSites LEFT OUTER JOIN dbo.tblTreeList ON dbo.tblSites.Location_No = dbo.tblTreeList.Location_No LEFT OUTER JOIN
dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group
WHERE (dbo.tblPackages.Notice_To_Proceed_Date IS NOT NULL) AND (dbo.tblTreeList.DELETED = 0) AND (dbo.tblTreeList.TYPE = 1)
</cfquery>

<cfquery name="getTRC" dbtype="query">SELECT count(*) as cnt FROM getTrees WHERE TREE_REMOVAL_DATE is not null AND TYPE <> 5</cfquery>
<cfquery name="getTPC" dbtype="query">SELECT count(*) as cnt FROM getTrees WHERE TREE_PLANTING_DATE is not null</cfquery>
<cfquery name="getTTBRC" dbtype="query">SELECT count(*) as cnt FROM getTrees WHERE TREE_REMOVAL_DATE is null AND ACTION_TYPE = 0 AND TYPE <> 5</cfquery>
<cfquery name="getTTBPC" dbtype="query">SELECT count(*) as cnt FROM getTrees WHERE TREE_PLANTING_DATE is null AND ACTION_TYPE = 1</cfquery>
<cfset trc = getTRC.cnt>
<cfset tpc = getTPC.cnt>
<cfset ttbrc = getTTBRC.cnt>
<cfset ttbpc = getTTBPC.cnt>

<cfquery name="getConcrete" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT e4 + e6 + e8 + + ep + eb + q4 + q6 + q8 + qp + qb + c4 + c6 + c8 + cp + cb AS total FROM (SELECT 
SUM(dbo.tblEngineeringEstimate.FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY) AS e4, 
SUM(dbo.tblEngineeringEstimate.SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY) AS e6, 
SUM(dbo.tblEngineeringEstimate.EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY) AS e8, 
SUM(dbo.tblEngineeringEstimate.SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY) AS ep, 
SUM(dbo.tblEngineeringEstimate.FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY) AS eb, 
SUM(dbo.tblQCQuantity.FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY) AS q4, 
SUM(dbo.tblQCQuantity.SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY) AS q6, 
SUM(dbo.tblQCQuantity.EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY) AS q8, 
SUM(dbo.tblQCQuantity.SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY) AS qp, 
SUM(dbo.tblQCQuantity.FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY) AS qb, 
CASE WHEN SUM(dbo.tblChangeOrders.FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY) IS NULL 
THEN 0 ELSE SUM(dbo.tblChangeOrders.FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY) END AS c4, 
CASE WHEN SUM(dbo.tblChangeOrders.SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY) IS NULL 
THEN 0 ELSE SUM(dbo.tblChangeOrders.SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY) END AS c6, 
CASE WHEN SUM(dbo.tblChangeOrders.EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY) IS NULL 
THEN 0 ELSE SUM(dbo.tblChangeOrders.EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY) END AS c8, 
CASE WHEN SUM(dbo.tblChangeOrders.SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY) IS NULL 
THEN 0 ELSE SUM(dbo.tblChangeOrders.SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY) END AS cp, 
CASE WHEN SUM(dbo.tblChangeOrders.FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY) IS NULL 
THEN 0 ELSE SUM(dbo.tblChangeOrders.FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY) END AS cb
FROM dbo.tblChangeOrders RIGHT OUTER JOIN dbo.tblSites ON dbo.tblChangeOrders.Location_No = dbo.tblSites.Location_No LEFT OUTER JOIN
dbo.tblQCQuantity ON dbo.tblSites.Location_No = dbo.tblQCQuantity.Location_No LEFT OUTER JOIN
dbo.tblEngineeringEstimate ON dbo.tblSites.Location_No = dbo.tblEngineeringEstimate.Location_No
WHERE (dbo.tblSites.Construction_Completed_Date IS NOT NULL)) 
AS derivedtbl_1
</cfquery>

<!--- <cfquery name="getNoRepairs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT sum(contrators_cost) FROM tblContractorPricing WHERE repairs_required = 0
</cfquery> --->

<cfquery name="getStarted" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE Construction_Start_Date IS NOT NULL AND Construction_Completed_Date IS NULL
</cfquery>

<cfquery name="getCompleted" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT count(*) as cnt FROM tblSites WHERE Construction_Completed_Date IS NOT NULL
</cfquery>

<cfset ht = 18>
<cfset wth = 140>
<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:410px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:21px;padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk center middle" style="width:250px;"><strong>Progress as of #dt#</strong></th>
						<th class="drk center middle" style="width:#wth#px;">&nbsp;&nbsp;&nbsp;<strong>Totals</strong></th>
						</tr>
					</table>
			</th>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Number of Sites
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getAllSites.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites Assessed
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getAssessed.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>	
			<th class="drk" colspan="4" style="padding:0px 0px 0px 0px;height:2px;">
			</th>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites Requiring Repairs
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getRepairs.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites Not Requiring Repairs
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getNoRepairs.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<cfif isdefined("session.userid") is true>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Estimated Construction Cost
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">$#trim(numberformat(getEst.total,"9,999,999,999.00"))#</td>
					</tr>
				</table>
			</td>
		</tr>
		</cfif>
		
		<tr>	
			<th class="drk" colspan="4" style="padding:0px 0px 0px 0px;height:2px;">
			</th>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites with Notice to Proceed (NTP) Issued
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getNTP.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<cfif isdefined("session.userid") is true>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Awarded Bid Amount
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">$#trim(numberformat(getPricing.total,"9,999,999,999.00"))#</td>
					</tr>
				</table>
			</td>
		</tr>
		</cfif>
		
		<!--- <tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites Under Construction
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getStarted.cnt#</td>
					</tr>
				</table>
			</td>
		</tr> --->
		
		
		<tr>	
			<th class="drk" colspan="4" style="padding:0px 0px 0px 0px;height:2px;">
			</th>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Sites Completed Construction
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#getCompleted.cnt#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<cfif isdefined("session.userid") is true>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Cost for Completed Sites
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">$#trim(numberformat(getCost.cost,"9,999,999,999.00"))#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Sq. Ft. of Concrete For Completed Sites
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#trim(numberformat(getConcrete.total,"9,999,999,999"))#</td>
					</tr>
				</table>
			</td>
		</tr>
		</cfif>
		
		<cfif isdefined("session.userid") is true>
		<tr>	
			<th class="drk" colspan="4" style="padding:0px 0px 0px 0px;height:2px;">
			</th>
		</tr>
		
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Number of Trees Removed
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#trc#</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Number of Trees Planted
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#tpc#</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Number of Trees to be Removed
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#ttbrc#</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:#ht#px;width:250px;">
					Total Number of Trees to be Planted
					</th>
					<td style="width:2px;"></td>
					<td class="center frm" style="width:#wth#px;">#ttbpc#</td>
					</tr>
				</table>
			</td>
		</tr>
		
		
		
		
		</cfif>
		
		
		</table>
	</td>
	</tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;"><tr><td style="height:10px;"></td></tr></table>
</div>

</body>
</html>
</cfoutput>

<script>
<cfoutput>
var h = #h#;
var w = #w#;
</cfoutput>

function changeSize() {

	var dw = $(document).width();
	//console.log(dw);
	if (dw < (w*2+20)) { 
		for (var i=1, il=5; i<il; i++) {
			$("#a" + i).width((dw/2-30));
			$("#a" + i).height(((dw/2-30)*0.75));
			$("#b" + i).width((dw/2-30));
			$("#b" + i).height(((dw/2-30)*0.75));
		}
	}
	else {
		for (var i=1, il=5; i<il; i++) {
			$("#a1").width(w);
			$("#a1").height(h);
			$("#b1").width(w);
			$("#b1").height(h);
		}
	}
	
}
	
$(window).resize(function() {
	changeSize();
});


changeSize();

</script>