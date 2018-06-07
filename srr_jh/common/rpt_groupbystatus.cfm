<cfmodule template="../common/header.cfm">		

<cfparam name="request.council_dist" default="all">

<!--- <CFQUERY NAME="find_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT        dbo.srr_status.srr_status_cd,dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
<!--- 
<cfif #request.council_dist# is not "All">
where srr_info.council_dist = #request.council_dist#
</cfif> --->
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</CFQUERY> 


<CFQUERY NAME="total_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT       COUNT(dbo.srr_info.srr_id) AS total_srr
FROM           
dbo.srr_info 

</CFQUERY>  --->


<!--- <cfoutput>#request.council_dist#</cfoutput> --->
<CFQUERY NAME="find_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
 
 SELECT        
dbo.srr_status.srr_status_cd
, dbo.srr_status.srr_status_desc
, ISNULL(COUNT(dbo.srr_info.srr_id), 0) AS Num
, dbo.srr_status.srr_list_order
<!---  ,Isnull(dbo.srr_info.council_dist,0) --->
<!---   , dbo.srr_info.prop_type  --->

FROM            dbo.srr_status LEFT OUTER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd	 		
 <cfif #request.council_dist# is not "All">
where srr_info.council_dist = #request.council_dist#
</cfif>		
			
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc,  dbo.srr_status.srr_list_order<!---  , dbo.srr_info.Prop_type  --->

order by dbo.srr_status.srr_list_order

</CFQUERY> 







<CFQUERY NAME="total_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT       COUNT(dbo.srr_info.srr_id) AS total_srr
FROM           
dbo.srr_info  

 <cfif #request.council_dist# is not "All">
where srr_info.council_dist = #request.council_dist#
</cfif>		
</CFQUERY> 







<cfquery name="find_ctotal" datasource="#request.dsn#" dbtype="ODBC">
Select 

count(dbo.srr_info.srr_id) as Total_council_srr
from
dbo.srr_info
 <cfif #request.council_dist# is not "All">
where srr_info.council_dist = #request.council_dist#
</cfif>		

</cfquery>






<!--- <!--- <!---  ---> ---> --->
<!--- <CFQUERY NAME="find_Pending" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','appealedNotEligible','appealedOfferExpired','requiredPermitsSubmitted'))
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>
 --->
 <CFQUERY NAME="find_Pending" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd IN ('appealedADACompliant','appealedConstDurationExp','appealedNotEligible','appealedNotEligible','constCompleted','appealedOfferExpired','pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','treeApprovalBPW','requiredPermitsSubmitted','appealedRequiredPermitsNotSubmitted','appealedIncompleteDocsExp','appealedPaymentIncompleteDocsExp'))
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>


<!---  <CFQUERY NAME="total_srr2" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT       COUNT(dbo.srr_info.srr_id) AS total_srNum
FROM           dbo.srr_info
WHERE        (dbo.srr_info.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','appealedNotEligible','appealedOfferExpired','requiredPermitsSubmitted'))

</CFQUERY>  --->

 <CFQUERY NAME="total_srr2" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT       COUNT(dbo.srr_info.srr_id) AS total_srNum
FROM           dbo.srr_info
<!--- WHERE        (dbo.srr_info.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','appealedNotEligible','appealedOfferExpired','requiredPermitsSubmitted')) --->
WHERE        (dbo.srr_INFO.srr_status_cd IN ('appealedADACompliant','appealedConstDurationExp','appealedNotEligible','appealedNotEligible','constCompleted','appealedOfferExpired','pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','treeApprovalBPW','requiredPermitsSubmitted','appealedRequiredPermitsNotSubmitted','appealedIncompleteDocsExp','appealedPaymentIncompleteDocsExp'))
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</CFQUERY> 


<cfquery name="total_Res_srr2" datasource="#request.dsn#" dbtype="odbc">

SELECT        COUNT(srr_id) AS total_Res_srNum
FROM            dbo.srr_info
<!--- WHERE        (srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview', 'received', 'appealedNotEligible', 'appealedOfferExpired', 'requiredPermitsSubmitted'))  --->
WHERE        (dbo.srr_INFO.srr_status_cd IN ('appealedADACompliant','appealedConstDurationExp','appealedNotEligible','appealedNotEligible','constCompleted','appealedOfferExpired','pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','treeApprovalBPW','requiredPermitsSubmitted','appealedRequiredPermitsNotSubmitted','appealedIncompleteDocsExp','appealedPaymentIncompleteDocsExp'))
AND (prop_type <> 'c' OR prop_type IS NULL)

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
						 
						 
</cfquery>



<cfquery name="total_Comm_srr2" datasource="#request.dsn#" dbtype="odbc">

SELECT        COUNT(srr_id) AS total_comm_srNum
FROM            dbo.srr_info
<!--- WHERE        (srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview', 'received', 'appealedNotEligible', 'appealedOfferExpired', 'requiredPermitsSubmitted')) --->

WHERE        (dbo.srr_INFO.srr_status_cd IN ('appealedADACompliant','appealedConstDurationExp','appealedNotEligible','appealedNotEligible','constCompleted','appealedOfferExpired','pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','treeApprovalBPW','requiredPermitsSubmitted','appealedRequiredPermitsNotSubmitted','appealedIncompleteDocsExp','appealedPaymentIncompleteDocsExp'))
 AND (prop_type <> 'R')
  <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
 
</cfquery>







<!--- 		
<cfoutput>#total_srr2.total_srNum#</cfoutput> --->

<CFQUERY NAME="total_PermitIssue" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'requiredPermitsIssued')
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>


<CFQUERY NAME="total_PermitIssue_RES" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, ISNULL(COUNT(dbo.srr_info.srr_id), 0) AS Num_Res
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'requiredPermitsIssued')and (prop_type<> 'c' or prop_type IS NULL)

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc


</cfquery>

<CFQUERY NAME="total_PermitIssue_Comm" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num_Comm
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'requiredPermitsIssued')AND (prop_type <> 'R')

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>
	
		
		 <CFQUERY NAME="total_PaymentPending" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT       COUNT(dbo.srr_info.srr_id) AS total_PaymentPendingNum
<!--- FROM           dbo.srr_info --->
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd

WHERE       <!---  (dbo.srr_info.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received','appealedNotEligible','appealedOfferExpired','requiredPermitsSubmitted')) --->
dbo.srr_status.srr_status_cd = 'paymentPending'
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</CFQUERY> 


<CFQUERY NAME="total_PaymentPending_RES" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT       COUNT(dbo.srr_info.srr_id) AS total_PaymentPendingNum
<!--- FROM           dbo.srr_info --->
FROM            dbo.srr_status INNER JOIN
						dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'paymentPending')and (prop_type<> 'c' or prop_type IS NULL)
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	


</cfquery>

<CFQUERY NAME="total_PaymentPending_Comm" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT       COUNT(dbo.srr_info.srr_id) AS total_PaymentPendingNum
<!--- FROM           dbo.srr_info --->
FROM            dbo.srr_status INNER JOIN
					dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'paymentPending')AND (prop_type <> 'R')

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</cfquery>



	
<!--- Cal_Active --->
		
<cfquery name="total_Act_Res_srr2" datasource="#request.dsn#" dbtype="odbc">

SELECT        COUNT(srr_id) AS total_Res_srNum
FROM            dbo.srr_info

WHERE        (dbo.srr_INFO.srr_status_cd IN ('received', 'appealedConstDurationExp', 'appealedNotEligible', 'appealedADACompliant', 'appealedRequiredPermitsNotSubmitted', 'appealedIncompleteDocsExp', 'appealedPaymentIncompleteDocsExp', 'incompleteDocsTemp', 'incompleteDocs',  'paymentIncompleteDocsTemp', 'pendingBcaReview', 'PendingBoeReview', 'pendingBssReview', 'offerMade', 'offerAccepted', 'requiredPermitsSubmitted', 'requiredPermitsIssued', 'constCompleted', 'paymentIncompleteDocs', 'appealApproved')
  )
AND (prop_type <> 'c' )

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>					 
						 
</cfquery>

<cfset request.total_active_Res_srr2= #total_act_res_srr2.Total_Res_srNum#>

<cfquery name="total_Act_Comm_srr2" datasource="#request.dsn#" dbtype="odbc">

SELECT        COUNT(srr_id) AS total_comm_srNum
FROM            dbo.srr_info

WHERE        (dbo.srr_INFO.srr_status_cd IN ('received', 'appealedConstDurationExp', 'appealedNotEligible', 'appealedADACompliant', 'appealedRequiredPermitsNotSubmitted', 'appealedIncompleteDocsExp', 'appealedPaymentIncompleteDocsExp', 'incompleteDocsTemp', 'incompleteDocs',  'paymentIncompleteDocsTemp', 'pendingBcaReview', 'PendingBoeReview', 'pendingBssReview', 'offerMade', 'offerAccepted', 'requiredPermitsSubmitted', 'requiredPermitsIssued', 'constCompleted', 'paymentIncompleteDocs', 'appealApproved')
  )
 AND (prop_type <> 'R' or prop_type IS NULL )
  <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
 
</cfquery>

		<cfset request.total_active_Comm_srr2= #total_act_comm_srr2.Total_comm_srNum#>
		
		<cfset request.Grand_total_active = #Request.total_active_Res_srr2# + #request.total_active_comm_srr2#>
		
<!--- Cal_Active --->
		
		
		
		
 <style>

 li
  {margin: 30px;
  padding-bottom:0px;
 }
</style>
<div style="margin-bottom:20px;"></div>
<div class="title">Rebate Application Summary</div>
	<div style="margin-bottom:10px;"></div>
<div class="title">Rebate Applications Grouped by Status</div>


	
	
<cfoutput>
<div align="center">
<form name="Form" method="post" action="rpt_groupbystatus.cfm?&council_dist=#request.council_dist#">
<!--- <div style="text-align:center;width:400px;margin-right:auto;margin-left:auto;"> --->
<div  class="warning" style="text-align:right;width:200px;margin-right:320px;margin-left:350px;">Council District&nbsp;&nbsp;&nbsp;<select name="council_dist" id="council_dist"onchange="this.form.submit()">
<option value="All" <cfif #request.council_dist# is "All">Selected</cfif>>All</option>
	<option value="1" <cfif #request.council_dist# is "1">Selected</cfif>>&nbsp; 1</option>
	<option value="2"<cfif #request.council_dist# is "2">Selected</cfif>>&nbsp; 2</option>
	<option value="3" <cfif #request.council_dist# is "3">Selected</cfif>>&nbsp; 3</option>
	<option value="4" <cfif #request.council_dist# is "4">Selected</cfif>>&nbsp; 4</option>
	<option value="5"<cfif #request.council_dist# is "5">Selected</cfif>>&nbsp; 5</option>
	<option value="6"<cfif #request.council_dist# is "6">Selected</cfif>>&nbsp; 6</option>
	<option value="7"<cfif #request.council_dist# is "7">Selected</cfif>>&nbsp; 7</option>
	<option value="8"<cfif #request.council_dist# is "8">Selected</cfif>>&nbsp; 8</option>
	<option value="9"<cfif #request.council_dist# is "9">Selected</cfif>>&nbsp; 9</option>
	<option value="10"<cfif #request.council_dist# is "10">Selected</cfif>>10</option>
	<option value="11"<cfif #request.council_dist# is "11">Selected</cfif>>11</option>
	<option value="12"<cfif #request.council_dist# is "12">Selected</cfif>>12</option>
	<option value="13"<cfif #request.council_dist# is "13">Selected</cfif>>13</option>
	<option value="14"<cfif #request.council_dist# is "14">Selected</cfif>>14</option>
	<option value="15"<cfif #request.council_dist# is "15">Selected</cfif>>15</option>
	</select></div> 
	
	<noscript><input type="submit" value="Submit"></noscript>
	</div>
	</form> 
	</div>
	</cfoutput>


<div class="textbox" style=" width: 700px;">
<h1>Rebate Application Summary</h1>
<cfoutput>
<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Total Applications </th>
<th valign="top">Residental</th>
<th valign="top">Commerical</th>
<th valign="top" >Total </th>

</tr>

<tr>
<td style="align:center;">Pending Review </td>
<td style="align:center;"><div align="center">#total_Res_srr2.total_Res_srNum#</div></td>
<td style="align:center;"><div align="center">#total_comm_srr2.total_comm_srNum#</div></td>
<td style="align:center;"><div align="center">#total_srr2.total_srNum#</div>


</td>
</tr>

<tr>
<td style="align:center;">Permits Issued </td>
<td style="align:center;"><div align="center"><cfif #total_PermitIssue_Res.Num_Res# is "">0 <cfelse>#total_PermitIssue_Res.Num_Res#</cfif></div></td>
<td style="align:center;"><div align="center"><cfif #total_PermitIssue_Comm.num_comm# is "">0 <cfelse>#total_permitIssue_comm.num_comm#</cfif></div></td>
<td style="align:center;"><div align="center"><cfif #total_PermitIssue.num# is "">0 <cfelse>#total_PermitIssue.num#</cfif></div></td>

</tr>

<tr>
<!--- <td style="align:center;">Rebates Issued </td> --->

<tr>
<td style="align:center;">Payment Pending</td>

<!--- <td style="align:center;"><div align="center">&nbsp;0</div></td> --->


<td style="align:center;"><div align="center">#total_paymentPending_Res.total_PaymentPendingNum# </td>
<td style="align:center;"><div align="center">#total_paymentPending_comm.total_PaymentPendingNum# </td>
<td style="align:center;"><div align="center">#total_paymentPending.total_PaymentPendingNum#</div></td>
</tr>

<tr>
<td style="align:center;background:yellow;"colspan="3"><strong>Total Number of Applications</strong></td>
<td style="align:center;background:yellow;"><div align="center">#total_srr.total_srr#</div></td>
</tr>
	
</cfoutput>



</table>

<div align="left" style="font-size: 12px;"> * Note: All other application have been returned to applicant or are ineligible.</div>



</div>
	</div>
	<div style="margin-bottom:20px;"></div>
	
	
	
	
	
<div class="textbox" style=" width: 700px;">
<h1>Status Report</h1>

<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Status </th>

<th valign="top" >Residental</th>
<!--- <th valign="top">Res_2</th> --->
<th valign="top" >Commerical</th>
<th valign="top" >Total Number of<br>Applications<BR>In-Queue</th>
</tr>


<cfoutput query="find_srr">


<cfquery name="find_srr_res" datasource="#request.dsn#">
Select
dbo.srr_status.srr_status_cd
, dbo.srr_status.srr_status_desc
, ISNULL(COUNT(dbo.srr_info.srr_id), 0) AS Num_res
, dbo.srr_status.srr_list_order
,dbo.srr_info.prop_type
FROM            dbo.srr_status LEFT OUTER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd	 				 
WHERE       
	dbo.srr_info.prop_type = 'r' 
<!--- 	AND
	dbo.srr_info.prop_type Is Not NULL
	and
	dbo.srr_info.prop_type <> 'c'	 --->
	and
	dbo.srr_info.srr_status_cd = '#srr_status_cd#' 
	
	 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>		

	GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc,  dbo.srr_status.srr_list_order, dbo.srr_info.prop_type		 
ORDER BY dbo.srr_status.srr_list_order 

</cfquery> 

		
<cfquery name="find_srr_com" datasource="#request.dsn#">
Select
dbo.srr_status.srr_status_cd
, dbo.srr_status.srr_status_desc
, ISNULL(COUNT(dbo.srr_info.srr_id), 0) AS Num_com 

, dbo.srr_status.srr_list_order 
,isnull(dbo.srr_info.prop_type,0) as prop_type 
FROM            dbo.srr_status LEFT OUTER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd	 				 
WHERE    


(dbo.srr_info.prop_type = 'c')
<!--- or 
(dbo.srr_info.prop_type is Null)) --->
<!--- or dbo.srr_info.prop_type <> 'r') --->

 and

dbo.srr_info.srr_status_cd = '#find_srr.srr_status_cd#'

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>		
	GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc ,  dbo.srr_status.srr_list_order, dbo.srr_info.prop_type		

ORDER BY dbo.srr_status.srr_list_order 
</cfquery>				
				
<cfquery name="find_srr_com2" datasource="#request.dsn#">
Select
dbo.srr_status.srr_status_cd
, dbo.srr_status.srr_status_desc
, ISNULL(COUNT(dbo.srr_info.srr_id), 0) AS Num_com 

, dbo.srr_status.srr_list_order 
,isnull(dbo.srr_info.prop_type,0) as prop_type 
FROM            dbo.srr_status LEFT OUTER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd	 				 
WHERE    


(dbo.srr_info.prop_type is null)
<!--- or 
(dbo.srr_info.prop_type is Null)) --->
<!--- or dbo.srr_info.prop_type <> 'r') --->

 and

dbo.srr_info.srr_status_cd = '#find_srr.srr_status_cd#'
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
	
	
	GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc ,  dbo.srr_status.srr_list_order, dbo.srr_info.prop_type		

ORDER BY dbo.srr_status.srr_list_order 
		</cfquery>
		
		


<tr>


 <td style="align:center;">
<a href="rpt_groupbyQueue.cfm?request.srr_status_cd=#srr_status_cd#&council_dist=#request.council_dist#">#find_srr.srr_status_desc#
</a></td> 

<td style="align:center;"><div align="center">


<cfif #find_srr_res.num_res# is "">
0
<cfelse>
#find_srr_res.num_res#

</cfif>


 </div></td>
 
 


<td style="align:center;"><div align="center">

<cfif #find_srr_com2.prop_type# is 0 or #find_srr_com2.prop_type# is ""  and #find_srr_com.prop_type# neq "c">
<cfif #find_srr_com2.num_com# is "">
<cfset request.c_1 = 0>
<cfelse>
<cfset request.c_1= #find_srr_com2.num_com#>
</cfif>
</cfif>


<cfif #find_srr_com.prop_type# is "c" >
<cfset request.c_2 = #find_srr_com.num_com#>
</cfif>

<cfif #find_srr_com.prop_type# is "c" and (#find_srr_com2.prop_type# is "" or #find_srr_com2.prop_type# is 0)>
<cfif #find_srr_com2.num_com# is "">
<cfset request.c_1 = 0>
<cfelse>
<cfset request.c_1= #find_srr_com2.num_com#>
</cfif> 

<cfset request.c_3 = #request.c_1# + #request.c_2#>
#request.c_3#
<!--- <cfelseif #find_srr_com2.prop_type# is "" or #find_srr_com2.prop_type# is 0> --->
<cfelseif #find_srr_com.prop_type# is "c">
#request.c_2#
<cfelse>
#request.c_1#

</cfif>



</div></td>
<td style="align:center;"><div align="center">

#num#</div></td>
</tr>
</cfoutput>


<cfoutput>
<tr>
<td style="align:center;background:Thistle;"><strong>Total Number of Active Applications</strong><br>
<div align="left" style="font-size: 12px;color:red;"> * Not Including Applications on the Wait List</div></td>
<td style="align:center;background:Thistle;"><div align="center">#request.total_active_Res_srr2#</div></td>
<td style="align:center;background:Thistle;"><div align="center">#request.total_active_Comm_srr2#</div></td>
<td style="align:center;background:Thistle;"><div align="center"><strong>#request.Grand_total_active#</strong></div></td>
</tr>
</cfoutput>	





<cfoutput>
<tr>
<td style="align:center;background:yellow;"colspan="3"><strong>Total Number of Applications</strong></td>
<td style="align:center;background:yellow;"><div align="center">#total_srr.total_srr#</div></td>
</tr>
</cfoutput>		



	
</table>




</div>

<cfinclude template="footer.cfm">		
		

		
		
		
		
		
		
		
		