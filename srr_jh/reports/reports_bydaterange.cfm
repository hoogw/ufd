<cfparam name="header_message" default="">
<cfparam name="request.date_from" default="">
<cfparam name="request.date_to" default="">
<cfparam name="listsort" default="address">
<cfparam name="request.sort" default="address">
<style>
* {
font-size: 14px;
}

.myButton {
  -webkit-border-radius: 50;
  -moz-border-radius: 50;
  border-radius: 50px;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  background: #596b8d;
  padding: 5px 7px 4px 4px;
  border: solid #090a0a 0px;
  text-decoration: none;
  text-align:center;
}
.myButton:link {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:visited {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:hover {
  background: #596a8d;
  background-image: -webkit-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -moz-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -ms-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -o-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: linear-gradient(to bottom, #596a8d, #9cc8e6);
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}

.myButton a:hover {
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}
  
.myButton:active {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}
</style>
<cfoutput>


<cfif #request.date_to# is "">
		<cfoutput>
		<BR>
		<div align="center"><FONT COLOR="Red"><B>DATE TO IS EMPTY!</B></font></div>
		<br><br>
		<div align="center">
		<form method="post">
		<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
		</form>
		</div>
		</cfoutput>
		<cfabort>
</cfif>

<cfif #request.date_from# is "">
		<cfoutput>
		<BR>
		<div align="center"><FONT COLOR="Red"><B>DATE FROM IS EMPTY!</B></font></div>
		<br><br>
		<div align="center">
		<form method="post">
		<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
		</form>
		</div>
		</cfoutput>
		<cfabort>
</cfif>

<cfif isdefined("request.date_to")>
	<cfif #request.date_to# is not "">
		<cfif isdate(#request.date_to#)>
		<cfelse>
			<cfoutput>
			<div align="center"><FONT COLOR="Red"><B>DATE TO IS NOT a date!</B></font></div>
			<br><br>
			<div align="center">
			<form method="post">
			<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
			</form>
			</div>
			</cfoutput>
			<cfabort>
		</cfif>
	</cfif>
</cfif>
<cfif isdefined("request.date_from")>
	<cfif #request.date_from# is not "">
		<cfif isdate(#request.date_from#)>
		<cfelse>
			<cfoutput>
			<div align="center"><FONT COLOR="Red"><B>DATE from IS NOT a date!</B></font></div>
			<br><br>
			<div align="center">
			<form method="post">
			<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
			</form>
			</div>
			</cfoutput>
			<cfabort>
		</cfif>
	</cfif>
</cfif>
</cfoutput>
<cfif #request.date_from# is not "" and #request.date_to# is not"">
<cfif #datediff("d",request.date_from,date_to)# LT 0>

<cfoutput>

<div align="center"><FONT COLOR="Red"><B>From date needs to be before the To date!</B></font></div>
<br><br>
<div align="center">
<form method="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfoutput>
<cfabort>
</cfif>
</cfif>
<cfoutput>
<cfset datefrom=#dateadd("d",0,request.date_from)#>
<cfset datefrom=#dateformat(datefrom,"yyyy-mm-dd")#>
<cfset dateto=#dateadd("d",1,request.date_to)#>
<cfset dateto=#dateformat(dateto,"yyyy-mm-dd")#>


<cfquery name="get_bysubmitted" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.ddate_submitted > '#datefrom#') AND (srr_info.ddate_submitted < '#dateto#')
</cfquery>

<cfquery name="get_appbyBPW" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.eligibility_dt > '#datefrom#') AND (srr_info.eligibility_dt < '#dateto#')
</cfquery>

<cfquery name="get_denbyBPW" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.noteligible_dt > '#datefrom#') AND (srr_info.noteligible_dt < '#dateto#')
</cfquery>

<cfquery name="get_sent2BOE" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.bpw_to_boe_dt > '#datefrom#') AND (srr_info.bpw_to_boe_dt < '#dateto#')
</cfquery>

<cfquery name="get_incDocs" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.incompleteDocs_dt > '#datefrom#') AND (srr_info.incompleteDocs_dt < '#dateto#')
</cfquery>

<cfquery name="get_BCA2BSS" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.bca_to_bss_dt > '#datefrom#') AND (srr_info.bca_to_bss_dt < '#dateto#')
</cfquery>

<cfquery name="get_BCA2BOE" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.bca_to_boe_dt > '#datefrom#') AND (srr_info.bca_to_boe_dt < '#dateto#')
</cfquery>

<cfquery name="get_ADAOk" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.AdaCompliant_dt > '#datefrom#') AND (srr_info.AdaCompliant_dt < '#dateto#')
</cfquery>

<cfquery name="get_BSS2BOE" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.bss_to_boe_dt > '#datefrom#') AND (srr_info.bss_to_boe_dt < '#dateto#')
</cfquery>

<cfquery name="get_BSSAssessComp" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.bss_assessment_comp_dt > '#datefrom#') AND (srr_info.bss_assessment_comp_dt < '#dateto#')
</cfquery>

<cfquery name="get_OfferMadeComp" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.offermade_dt > '#datefrom#') AND (srr_info.offermade_dt < '#dateto#')
</cfquery>

<cfquery name="get_OffersAccept" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.offeraccepted_dt > '#datefrom#') AND (srr_info.offeraccepted_dt < '#dateto#')
</cfquery>

<cfquery name="get_GISComp" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.gis_completed_dt > '#datefrom#') AND (srr_info.gis_completed_dt < '#dateto#')
</cfquery>

<cfquery name="get_ConstComp" datasource="#request.dsn#" dbtype="ODBC">
SELECT COUNT(srr_info.srr_id) AS count
FROM     srr_info LEFT OUTER JOIN
                  srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
WHERE  (srr_info.constCompleted_dt > '#datefrom#') AND (srr_info.constCompleted_dt < '#dateto#')
</cfquery>

<center>
<table>
<tr>
<td align="right">Period:</TD>
<td align="left">#dateformat(request.date_from,"m/d/yyyy")#&nbsp;&nbsp;to&nbsp;&nbsp;#dateformat(request.date_to,"m/d/yyyy")#</td>
<td align="center"></TD>
</TR>
</table>

<table border="1" class= "datatable" style= "width:800px;">
<tr>
<th style="width:16.67%;">Action</th>
<th style="width:16.67%;">No of Application</th>
</tr>


<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Received from applicants
</td>
<td align="center" colspan="1">
#get_bysubmitted.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Approved by BPW
</td>
<td align="center" colspan="1">
#get_appbyBPW.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Found Not Eligible by BPW
</td>
<td align="center" colspan="1">
#get_denbyBPW.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Sent to BOE for Investigation
</td>
<td align="center" colspan="1">
#get_sent2BOE.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Found Incomplete by BPW
</td>
<td align="center" colspan="1">
#get_incDocs.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Sent from BCA to BSS for Tree Assessment
</td>
<td align="center" colspan="1">
#get_BCA2BSS.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Sent from BCA to BOE for Investigation
</td>
<td align="center" colspan="1">
#get_BCA2BOE.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Found to be ADA Compliant by BCA
</td>
<td align="center" colspan="1">
#get_ADAOk.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Sent from BSS to BOE for Investigation
</td>
<td align="center" colspan="1">
#get_BSS2BOE.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Tree Assessment Completed by BSS
</td>
<td align="center" colspan="1">
#get_BSSAssessComp.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Offers Made Complete
</td>
<td align="center" colspan="1">
#get_OfferMadeComp.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Offers Accepted
</td>
<td align="center" colspan="1">
#get_OffersAccept.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
GIS Completed</td>
<td align="center" colspan="1">
#get_GISComp.count#
</td>
</tr>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
Construction Completed
</td>
<td align="center" colspan="1">
#get_ConstComp.count#
</td>
</tr>

</table>

</cfoutput>

