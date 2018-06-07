<cfparam name="start_row" default="1">

<style>
.pageNbr {
text-align:center;
border :1px solid silver;
padding-left:10px;
padding-right:10px;
padding-top:4px;
padding-bottom:4px;
display:inline-block;
}
</style>

<cfquery name="list_expired" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
,srr_info.srrKey
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
<!---, dbo.srr_info.app_contact_name_nn--->
, dbo.srr_info.app_address1_nn
, dbo.srr_info.app_address2_nn
, dbo.srr_info.app_city_nn
, dbo.srr_info.app_state_nn
, dbo.srr_info.app_zip_nn
, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
, srr_info.address_verified
, dbo.srr_info.zip_cd
<!---, dbo.srr_info.job_state
, dbo.srr_info.job_zip--->
, dbo.srr_info.unit_range
, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
, dbo.srr_info.bpw1_ownership_verified
, dbo.srr_info.bpw1_tax_verified
<!---, dbo.srr_info.zoning_verified--->
, case 
when isdate(bca_to_boe_dt)=1  THEN bca_to_boe_dt
when isdate(bpw_to_boe_dt)=1  THEN bpw_to_boe_dt
when isdate(bss_to_boe_dt) = 1 THEN bss_to_boe_dt
End AS received_dt

, case 
when isdate(bca_to_boe_dt)=1  THEN 'Bureau of Contract Administration'
when isdate(bpw_to_boe_dt)=1  THEN 'Board of Public Works'
when isdate(bss_to_boe_dt) = 1 THEN 'Urban Forestry Division/BSS'
End AS received_from

, case  
when isdate(bca_to_boe_dt)=1 THEN bca_action_by
when isdate(bpw_to_boe_dt)=1 THEN bpw1_action_by
when isdate(bss_to_boe_dt)=1 THEN bss_action_by
END AS staff_user_id


, srr_info.bca_comments
, srr_info.bss_comments
, srr_info.bpw1_internal_comments

, srr_info.valuation_est
			   
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   
where 
(1=1)
and 
(
dbo.srr_info.srr_status_cd = 'incompleteDocs'
or 
dbo.srr_info.srr_status_cd = 'offerExpired'
<!--- or 
dbo.srr_info.srr_status_cd = 'offerDeclined' --->
or 
dbo.srr_info.srr_status_cd = 'requiredPermitsNotSubmitted'

or 
dbo.srr_info.srr_status_cd = 'constDurationExp'

or 
dbo.srr_info.srr_status_cd = 'paymentIncompleteDocs'
)
<!--- and
(bca_action is null or bca_action = '') --->
</cfquery>

<!-- No record are found -->
<cfif #list_expired.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently Expired</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#list_expired.recordcount# Applications are Expired</div>
</cfoutput>



<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS ------------------------------- -->
<CFPARAM NAME="request.page_nbr" DEFAULT="1">

<cfset request.nbr_of_pages = #list_expired.recordcount# / #request.max_rows#>
<cfset request.nbr_of_pages = #int(request.nbr_of_pages)# + 1>
<cfset start_row = ((#request.page_nbr# - 1) * #request.max_rows#) +1>
<cfset end_row = #start_row# + #request.max_rows# -1>

<cfif #end_row# gt #list_expired.recordcount#>
<cfset end_row = #list_expired.recordcount#>
</cfif>

<cfset request.next_page = #request.page_nbr# + 1>
<cfset request.prev_page = #request.page_nbr# - 1>

<cfoutput>
<cfif #request.nbr_of_pages# gt 1>
<div align="center">
<cfif #request.prev_page# gt 0>
<a href="#cgi.script_name#?action=list_expired&page_nbr=#request.prev_page#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><div style="text-align:center;border :1px solid silver;padding-left:10px;padding-right:10px;padding-top:4px;padding-bottom:4px;display:inline-block;"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=list_expired&page_nbr=#pp#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif></div></cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=list_expired&page_nbr=#request.next_page#&#request.addtoken#">Next &gt;&gt;</A>
</cfif>
</div>
</cfif>
</cfoutput>
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS  ------------------------------- -->

<cfoutput>

<!--- Record Counter --->
<cfif #list_expired.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #list_expired.recordcount# lt #end_row#>
<cfset end_row=#list_expired.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #list_expired.recordcount# Records</div></div>
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
<th nowrap>Date to BOE</th>
<th nowrap>Applicant</th>
<th nowrap>Property Address</th>
<th>Status</th>
<th>Rebate Valuation</th>
<th>Comments</th>
<!--- <th>How Old (Days)</th> --->
</tr>
</cfoutput>

<cfoutput query="list_expired" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;white-space: nowrap;" nowrap>
<a href="control.cfm?action=process_expired1&type=i&srrKey=#list_expired.srrKey#&#request.addtoken#">#list_expired.sr_number#</a>
</td>

<td style="text-align:center;">
#dateformat(list_expired.ddate_submitted,"mm/dd/yyyy")#
</td>

<td style="text-align:center;">
<p>#dateformat(list_expired.received_dt,"mm/dd/yyyy")#</p>
<p>Referred by: #received_from#</p>

<cfif #list_expired.staff_user_id# is not "">
<cfquery name="getStaffName" datasource="#request.dsn#" dbtype="datasource">
select first_name, last_name from staff 
where user_id = #list_expired.staff_user_id#
</cfquery>
<p>#getStaffName.first_name# #getStaffName.last_name#</p>
</cfif>
</td>



<td style="text-align:center;">
#list_expired.app_name_nn#
</td>

<td style="text-align:center;">
<strong>#list_expired.job_address#</strong>
<cfif #list_expired.address_verified# is "N">
<div align="center"><span style="color:red;">Invalid Address</span></div>
<!--- <div align="center"><a href="../common/reCheck_Address.cfm?srrKey=#srrKey#&#request.addtoken#" target="_blank">Re-Validate Address</a></div> --->
</cfif>
</td>

<td>
#srr_status_desc#&nbsp;
</td>

<td align="right">
#dollarformat(valuation_est)#&nbsp;
</td>


<td>
<cfif #bpw1_internal_comments# is not "">
<p>BPW Comments: #bpw1_internal_comments#</p>
<cfelseif #bca_comments# is not "">
<p>BCA Comments: #bca_comments#</p>
<cfelseif #bss_comments# is not "">
<p>BSS/UFD Comments: #bss_comments#</p>
</cfif>
&nbsp;
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

