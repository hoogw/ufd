<cfparam name="start_row" default="1">

<cfquery name="tr_view_unprocessed" datasource="#request.dsn#" dbtype="datasource">
SELECT 
Tree_removal_permit.srr_id
, Tree_removal_permit.ddate_submitted
, tree_info.nbr_trees_removed
, tree_info.nbr_trees_pruned
, tree_info.lf_trees_pruned
, srr_info.sr_number
, srr_info.sr_app_comments
, srr_info.sr_location_comments
, srr_info.sr_attachments
, srr_info.job_address
, srr_info.app_name_nn
, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.bca_comments
, srr_info.bss_comments
, srr_info.ssd_comments
, srr_info.srr_status_cd
, srr_status.srr_status_desc


FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd RIGHT OUTER JOIN
               dbo.tree_info RIGHT OUTER JOIN
               dbo.Tree_removal_permit ON dbo.tree_info.srr_id = dbo.Tree_removal_permit.srr_id ON dbo.srr_info.srr_id = dbo.Tree_removal_permit.srr_id
			   
WHERE
Tree_removal_permit.bss_ddate_issued is null
</cfquery>

<!-- No record are found -->
<cfif #tr_view_unprocessed.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#tr_view_unprocessed.recordcount# Applications are Unprocessed</div>
</cfoutput>



<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS ------------------------------- -->
<CFPARAM NAME="request.page_nbr" DEFAULT="1">

<cfset request.nbr_of_pages = #tr_view_unprocessed.recordcount# / #request.max_rows#>
<cfset request.nbr_of_pages = #int(request.nbr_of_pages)# + 1>
<cfset start_row = ((#request.page_nbr# - 1) * #request.max_rows#) +1>
<cfset end_row = #start_row# + #request.max_rows# -1>

<cfif #end_row# gt #tr_view_unprocessed.recordcount#>
<cfset end_row = #tr_view_unprocessed.recordcount#>
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
<a href="#cgi.script_name#?action=tr_view_unprocessed&page_nbr=#request.prev_page#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=tr_view_unprocessed&page_nbr=#pp#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif>&nbsp;&nbsp;&nbsp;</cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=tr_view_unprocessed&page_nbr=#request.next_page#&#request.addtoken#">Next &gt;&gt;</A>
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
<cfif #tr_view_unprocessed.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #tr_view_unprocessed.recordcount# lt #end_row#>
<cfset end_row=#tr_view_unprocessed.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #tr_view_unprocessed.recordcount# Records</div></div>
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
<th nowrap>Applicant</th>
<th nowrap>Property Address</th>
<th>Status</th>
<th>BSS Comments</th>
<th>How Old (Days)</th>
</tr>
</cfoutput>

<cfoutput query="tr_view_unprocessed" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;">
<a href="control.cfm?action=process_app1&srrKey=#tr_view_unprocessed.srrKey#&#request.addtoken#">#tr_view_unprocessed.sr_number#</a>
</td>

<td style="text-align:center;">
#dateformat(tr_view_unprocessed.ddate_submitted,"mm/dd/yyyy")#
</td>


<td style="text-align:center;">
#tr_view_unprocessed.app_name_nn#
</td>

<td style="text-align:center;">
<strong>#tr_view_unprocessed.job_address#</strong>
</td>

<td>
#srr_status_desc#&nbsp;
</td>

<td>
#bss_comments#&nbsp;
</td>

<td style="text-align:center;">
<cfif #ddate_submitted# is not "">
<cfset request.how_old=datediff("d", #ddate_submitted#, #now()#)>
#request.how_old#
</cfif>
</td>

</tr>
</cfoutput>
</table>
</div>

