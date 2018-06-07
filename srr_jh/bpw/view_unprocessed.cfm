<cfparam name="request.view" default="unprocessed">
<cfparam name="start_row" default="1">
<cfparam name="request.order_by" default="ref_no">
<cfparam name="request.sort" default="asc">
<cfparam name="request.show" default="received">


<cfquery name="view_unprocessed" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_contact_name_nn
<!--- , dbo.srr_info.app_address1_nn
, dbo.srr_info.app_address2_nn
, dbo.srr_info.app_city_nn
, dbo.srr_info.app_state_nn
, dbo.srr_info.app_zip_nn
, dbo.srr_info.app_phone_nn --->
, dbo.srr_info.app_email_nn
<!--- , dbo.srr_info.job_address
, dbo.srr_info.job_city
, dbo.srr_info.job_state
, dbo.srr_info.job_zip
, dbo.srr_info.unit_range --->
, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
, dbo.srr_info.bpw1_ownership_verified
, dbo.srr_info.bpw1_tax_verified
<!--- , dbo.srr_info.zoning_verified --->
, srr_info.srrKey

, srr_info.job_address
, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd
, srr_info.address_verified
, srr_info.prop_type
, srr_info.prop_data_checked
, srr_info.anyLiens
, srr_info.liensText
, srr_info.app_last_update_dt
	   
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
(1=1)
and 
srr_info.srr_status_cd = '#request.show#'

order by ddate_submitted
</cfquery>

<!-- No record are found -->
<cfif #view_unprocessed.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<!--- <cfabort> --->
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">Unprocessed Applications</div>
<div class="subtitle">#view_unprocessed.recordcount# Applications are Unprocessed</div>
</cfoutput>



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

<div style="margin-left:auto;margin-right:auto;width:80%;">
<cfif #request.show# is "received">
Pending Review
<cfelse>
<a href="control.cfm?action=view_unprocessed&type=u&show=received&#request.addtoken#">Pending Review</a>
</cfif>
 | 
 <cfif #request.show# is "incompleteDocsTemp">
Incomplete
 <cfelse>
  <a href="control.cfm?action=view_unprocessed&type=u&show=incompleteDocsTemp&#request.addtoken#">Incomplete</a>
 </cfif>
</div>

<cfif #request.nbr_of_pages# gt 1>
<div align="center">
<table width="700" border="0" cellspacing="3" cellpadding="3" align="center">
<tr>
<td style="text-align:center;">
<cfif #request.prev_page# gt 0>
<a href="#cgi.script_name#?action=view_unprocessed&type=u&page_nbr=#request.prev_page#&view=#request.view#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=view_unprocessed&type=u&page_nbr=#pp#&view=#request.view#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif>&nbsp;&nbsp;&nbsp;</cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=view_unprocessed&type=u&page_nbr=#request.next_page#&view=#request.view#&#request.addtoken#">Next &gt;&gt;</A>
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
<div style="margin-right:auto;margin-left:auto;width:80%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #view_unprocessed.recordcount# Records</div></div>
</cfoutput>
</cfif>
<cfset prev_start= #start_row# - #request.max_rows#>
<cfset next_start=#start_row# + #request.max_rows#>
<!--- Record Counter --->

<div align = "center">
<table class="datatable" id="table1" style="width:80%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<th nowrap>Applicant</th>
<th nowrap>Applicant Email</th>
<th nowrap>Property Address</th>
<th>Status</th>
<!--- <th>Comments</th> --->
<th>How Old (Days)</th>
</tr>
</cfoutput>

<cfoutput query="view_unprocessed" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;white-space: nowrap;">
<a href="control.cfm?action=process_app1&type=u&srrKey=#view_unprocessed.srrKey#&#request.addtoken#">#view_unprocessed.sr_number#</a>
</td>

<td style="text-align:center;">
<div align="center">#dateformat(view_unprocessed.Ddate_Submitted,"mm/dd/yyyy")#</div>
<div align="center">#timeformat(view_unprocessed.Ddate_Submitted,"h:mm tt")#</div>
</td>


<td style="text-align:center;">
#view_unprocessed.app_name_nn#
</td>

<td style="text-align:center;">
#view_unprocessed.app_email_nn#
</td>

<td style="text-align:left;width:35%;">
<!---#view_unprocessed.HSE_NBR# #view_unprocessed.HSE_FRAC_NBR# #view_unprocessed.HSE_DIR_CD# #view_unprocessed.STR_NM# #view_unprocessed.STR_SFX_CD# #view_unprocessed.STR_SFX_DIR_CD# #view_unprocessed.ZIP_CD#--->
#view_unprocessed.job_address#
<cfif #view_unprocessed.address_verified# is not "Y">
<br>
<span style="color:red;">Invalid Address (Forward to Engineering)</span>
</cfif>
<cfif #view_unprocessed.address_verified# is "Y" and #view_unprocessed.prop_type# is "">
<br>
<span style="color:red;">Could not determine Zoning<br>(Forward to Engineering)</span>
</cfif>
<cfif #view_unprocessed.anyLiens# is "Y">
<br>
<span style="color:red;font-size:12px;">Has Lien(s):  #view_unprocessed.liensText#</span>
</cfif>
</td>

<td>
<p>#view_unprocessed.srr_status_desc#</p>
<cfif #view_unprocessed.app_last_update_dt# is not "">
<p><span style="color:red;">Applicant added attachment(s) on: #dateformat(view_unprocessed.app_last_update_dt,"mm/dd/yyyy")#</span></p>
</cfif>
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

