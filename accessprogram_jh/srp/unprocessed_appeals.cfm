<cfparam name="start_row" default="1">

<cfquery name="getReasons" datasource="#request.dsn#" dbtype="datasource">
SELECT
appealReason
from 
appealReason
</cfquery>

<cfset reasonList = #ValueList(getReasons.appealReason)#>
<!---<cfset reasonList = listQualify(reasonList, "#chr(39)#")>--->

<cfquery name="unprocessed_appeals" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.address_verified
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, appeals.appealID
, dbo.appealReason.appealDesc
, dbo.appealReason.suspend
, dbo.appeals.appealDate
, dbo.appeals.appealReason
, dbo.appeals.appealCommentsApp
, dbo.appeals.appealDecision
, dbo.appeals.appealDecisionComments
, dbo.appeals.appealDecision_dt
, dbo.appeals.appealDecision_by
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
, dbo.srr_info.srr_status_cd
,  dbo.srr_status.srr_status_desc

FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd RIGHT OUTER JOIN
               dbo.staff RIGHT OUTER JOIN
               dbo.appeals ON dbo.staff.user_id = dbo.appeals.appealDecision_by LEFT OUTER JOIN
               dbo.appealReason ON dbo.appeals.appealReason = dbo.appealReason.appealReason ON dbo.srr_info.srr_id = dbo.appeals.srr_id
			   
where 
(1=1)
<!--- and 
appeals.appealReason in (#listQualify(reasonList, "#chr(39)#")#) --->
and
(appeals.appealDecision is null or appeals.appealDecision = '')
</cfquery>


<!-- No record are found -->
<cfif #unprocessed_appeals.recordcount# is 0>
<cfoutput>
<div class="warning">No Appeals are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#unprocessed_appeals.recordcount# Applications are Unprocessed</div>
</cfoutput>



<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS ------------------------------- -->
<CFPARAM NAME="request.page_nbr" DEFAULT="1">

<cfset request.nbr_of_pages = #unprocessed_appeals.recordcount# / #request.max_rows#>
<cfset request.nbr_of_pages = #int(request.nbr_of_pages)# + 1>
<cfset start_row = ((#request.page_nbr# - 1) * #request.max_rows#) +1>
<cfset end_row = #start_row# + #request.max_rows# -1>

<cfif #end_row# gt #unprocessed_appeals.recordcount#>
<cfset end_row = #unprocessed_appeals.recordcount#>
</cfif>

<cfset request.next_page = #request.page_nbr# + 1>
<cfset request.prev_page = #request.page_nbr# - 1>

<cfoutput>
<cfif #request.nbr_of_pages# gt 1>
<div align="center">
<table width="700" border="0" cellspacing="3" cellpadding="3" align="center">
<tr>
<td style="text-align:center;">
<cfif #request.prev_page# gt 0>
<a href="#cgi.script_name#?action=unprocessed_appeals&type=i&page_nbr=#request.prev_page#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=unprocessed_appeals&page_nbr=#pp#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif>&nbsp;&nbsp;&nbsp;</cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=unprocessed_appeals&page_nbr=#request.next_page#&#request.addtoken#">Next &gt;&gt;</A>
</cfif>
</td>
</tr>
</table>
</div>
</cfif>
</cfoutput>
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS  ------------------------------- -->

<cfoutput>

<!--- Record Counter --->
<cfif #unprocessed_appeals.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #unprocessed_appeals.recordcount# lt #end_row#>
<cfset end_row=#unprocessed_appeals.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #unprocessed_appeals.recordcount# Records</div></div>
</cfoutput>
</cfif>
<cfset prev_start= #start_row# - #request.max_rows#>
<cfset next_start=#start_row# + #request.max_rows#>
<!--- Record Counter --->

<div align = "center">
<table class="datatable" id="table1" style="width:95%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<th nowrap>Appeal Date</th>
<th nowrap>Appeal Reason</th>
<th nowrap>Applicant</th>
<th nowrap>Property Address</th>
<th>Status</th>
<th>Appeal Comments</th>
<!--- <th>How Old (Days)</th> --->
</tr>
</cfoutput>

<cfoutput query="unprocessed_appeals" startrow="#start_row#" maxrows="#request.max_rows#">


<td nowrap style="text-align:center;white-space: nowrap;">
<a href="control.cfm?action=process_appeal1&appealID=#unprocessed_appeals.appealID#&type=a&srrKey=#unprocessed_appeals.srrKey#&#request.addtoken#">#unprocessed_appeals.sr_number#</a>
</td>

<td style="text-align:center;">
#dateformat(unprocessed_appeals.ddate_submitted,"mm/dd/yyyy")#
</td>

<td style="text-align:center;">
#dateformat(unprocessed_appeals.appealDate,"mm/dd/yyyy")#
</td>

<td style="text-align:center;">
#appealDesc#
</td>


<td style="text-align:center;">
#unprocessed_appeals.app_name_nn#
</td>

<td style="text-align:center;">
<strong>#unprocessed_appeals.job_address#</strong>
</td>

<td>
#srr_status_desc#&nbsp;
</td>

<td>
#appealCommentsApp#&nbsp;
</td>
<!--- 
<td style="text-align:center;">
<cfif #bca_action_dt# is not "">
<cfset request.how_old=datediff("d", #bca_action_dt#, #now()#)>
#request.how_old#
</cfif>
</td> --->

</tr>
</cfoutput>
</table>
</div>

