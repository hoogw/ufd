
<cfparam name="request.view" default="unprocessed">
<cfparam name="start_row" default="1">
<cfparam name="request.order_by" default="ddate_submitted">
<cfparam name="request.sort" default="asc">



<cfquery name="view_unprocessed" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.a_ref_no
, dbo.srr_info.ddate_submitted
, dbo.srr_info.hse_nbr
, dbo.srr_info.hse_frac_nbr
, dbo.srr_info.hse_dir_cd
, dbo.srr_info.str_nm
, dbo.srr_info.str_sfx_cd
, dbo.srr_info.str_sfx_dir_cd
, dbo.srr_info.zip_cd
, dbo.srr_info.unit_range
, dbo.srr_info.hse_id, dbo.srr_info.tbm_grid
, dbo.srr_info.boe_dist
, dbo.srr_info.council_dist
, dbo.srr_info.bpp
, dbo.srr_info.pin
, dbo.srr_info.pind
, dbo.srr_info.address_verified
, dbo.srr_info.zoningCode
, dbo.srr_info.job_address
, dbo.srr_info.x_coord
, dbo.srr_info.y_coord
, dbo.srr_info.longitude
, dbo.srr_info.latitude
, dbo.srr_info.lgd_completed_dt
, dbo.srr_info.lgd_completed_by

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   
where srr_info.lgd_completed_dt is null
order by srr_info.ddate_submitted
</cfquery>

<!-- No record are found -->
<cfif #view_unprocessed.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#view_unprocessed.recordcount# Applications are Unprocessed</div>
</cfoutput>

<!--- <cfabort>
 --->
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS ------------------------------- -->
<CFPARAM NAME="request.page_nbr" DEFAULT="1">

<cfset request.nbr_of_pages = #view_unprocessed.recordcount# / #request.max_rows#>
<cfset request.nbr_of_pages = #int(request.nbr_of_pages)# + 1>
<cfset start_row = ((#request.page_nbr# - 1) * #request.max_rows#) +1>
<cfset end_row = #start_row# + #request.max_rows# -1>

<cfif #end_row# gt #view_unprocessed.recordcount#>
<cfset end_row = #view_unprocessed.recordcount#>
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
<a href="#cgi.script_name#?action=view_unprocessed&page_nbr=#request.prev_page#&view=#request.view#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=view_unprocessed&page_nbr=#pp#&view=#request.view#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif>&nbsp;&nbsp;&nbsp;</cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=view_unprocessed&page_nbr=#request.next_page#&view=#request.view#&#request.addtoken#">Next &gt;&gt;</A>
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
<cfif #view_unprocessed.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #view_unprocessed.recordcount# lt #end_row#>
<cfset end_row=#view_unprocessed.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #view_unprocessed.recordcount# Records</div></div>
</cfoutput>
</cfif>
<cfset prev_start= #start_row# - #request.max_rows#>
<cfset next_start=#start_row# + #request.max_rows#>
<!--- Record Counter --->

<div align = "center">
<table class="datatable" id="table1" style="width:95%;">
<tr>
<th nowrap>SR<BR>Number</th>
<th nowrap>Date<BR>Submitted</th>
<th nowrap>Applicant<Br>
Applicant Email</th>
<th nowrap>Property Address</th>
<th nowrap>Zoning<br>Code</th>

<th>How Old (Days)</th>
<th>Status</th>
<!--- <th>Comments</th> --->
</tr>
</cfoutput>

<cfoutput query="view_unprocessed" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;">
#view_unprocessed.sr_number#</a>
</td>

<td style="text-align:center;">
#dateformat(view_unprocessed.Ddate_Submitted,"mm/dd/yyyy")#
</td>


<td style="text-align:center;">
#view_unprocessed.app_name_nn#<br>
#view_unprocessed.app_email_nn#
</td>

<td style="text-align:center;">
Job Address: 
<cfif #view_unprocessed.job_address# is not "">
<strong>#view_unprocessed.job_address#</strong>
<br>
<!--- #view_unprocessed.job_city#, #view_unprocessed.job_state# #view_unprocessed.job_zip# --->
</cfif> 
PIN: <strong>#view_unprocessed.Pin#</strong>
<BR>
APN: <strong>#view_unprocessed.BPP#</strong>
<BR>
Address Verified: <cfif #view_unprocessed.address_verified# is 'Y'>
<strong>YES</strong>
<cfelseif #view_unprocessed.address_verified# is 'N'>
<strong>NO</strong></cfif>
</td>



<td style="text-align:center;">
#view_unprocessed.zoningCode#
</td>



<td style="text-align:center;">
<cfif #ddate_submitted# is not "">
<cfset request.how_old=datediff("d", #ddate_submitted#, #now()#)>
#request.how_old#
</cfif>
</td>


<td style="text-align:center;">

<a href="#cgi.script_name#?action=mark_completed1&srrkey=#view_unprocessed.srrkey#&#request.addtoken#">Mark Completed</a> &nbsp;&nbsp; 

</td>

</tr>
</cfoutput>
</table>
</div>

<cfinclude template="../common/footer.cfm">