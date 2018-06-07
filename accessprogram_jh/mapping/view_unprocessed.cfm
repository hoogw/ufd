




<cfparam name="request.view" default="unprocessed">
<cfparam name="start_row" default="1">
<cfparam name="request.order_by" default="ref_no">
<cfparam name="request.sort" default="asc">



 <cfquery name="view_unprocessed1" datasource="#request.dsn#" dbtype="datasource">
 SELECT
  dbo.ar_info.ar_id
, dbo.ar_info.arKey
, dbo.ar_info.sr_number

, dbo.ar_info.app_name_nn
, dbo.ar_info.app_address1_nn
, dbo.ar_info.app_address2_nn
, dbo.ar_info.app_city_nn
, dbo.ar_info.app_state_nn
, dbo.ar_info.app_zip_nn
, dbo.ar_info.app_phone_nn
, dbo.ar_info.app_email_nn
, dbo.ar_info.job_address

, dbo.ar_info.mailing_address1
, dbo.ar_info.mailing_address2
, dbo.ar_info.mailing_zip
, dbo.ar_info.mailing_city
, dbo.ar_info.mailing_state
 , dbo.ar_info.bpp
 , dbo.ar_info.pin
 , dbo.ar_info.pind
 , dbo.ar_info.zoningCode
 
 
 , dbo.ar_status.ar_status_desc
 , dbo.ar_info.ddate_submitted
  , dbo.ar_info.dod_approved_by
 , dbo.ar_info.dod_denied_by
 , dbo.ar_info.dod_approved_dt
 , dbo.ar_info.dod_denied_dt
 , dbo.ar_info.dod_to_bss_dt 
 
 	, ar_info.DOD_INTERNAL_COMMENTS
	, ar_info.SPD_INTERNAL_COMMENTS
	, ar_info.UFD_INTERNAL_COMMENTS
	, ar_info.BSS_INTERNAL_COMMENTS
 
 , dbo.staff.first_name+' '+ dbo.staff.last_name as approved_by
 , dateDiff("d", dbo.ar_info.ddate_submitted, getDate()) as daysInQueue
 
 , dbo.ar_info.sr_access_comments

 ,  dbo.ar_info.lgd_completed_dt
,  dbo.ar_info.lgd_completed_by

FROM  dbo.ar_info LEFT OUTER JOIN
               dbo.staff ON dbo.ar_info.dod_approved_by = dbo.staff.user_id LEFT OUTER JOIN
               dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd
<!---  
 where ar_info.ar_status_cd = 'pendingBssReview' --->
 where ar_info.lgd_completed_dt is null
order by ar_info.ddate_submitted
 
 
</cfquery>



<cfquery name="view_unprocessed" datasource="view_unprocessed1" dbtype="query">
select * from view_unprocessed1
order by daysInQueue desc
</cfquery>



<cfoutput>
<div class="subtitle">#view_unprocessed.recordcount# Application(s) are Unprocessed</div>
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
<table class="datatable" id="table1" style="width:90%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<!--- <th nowrap>Date Sent to BSS</th> --->
<th nowrap>Applicant</th>
<th>Access Barrier Location <br>& Description</th>
<th>Comments</th>
<th>How Old (Days)<br>from Date Submitted</th>
<th>Status</th>

</tr>

</cfoutput>



<cfoutput query="view_unprocessed" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;vertical-align:top;" nowrap>#view_unprocessed.sr_number#
<!--- <a href="control.cfm?action=sidewalks1&arKey=#view_unprocessed.arKey#&#request.addtoken#">#view_unprocessed.sr_number#</a> --->
</td>

<td style="text-align:center;vertical-align:top;">
<div align="center">#dateformat(view_unprocessed.ddate_submitted,"mm/dd/yyyy")#</div>
<div align="center">#timeformat(view_unprocessed.ddate_submitted,"h:mm tt")#</div>
</td>

<!--- <td style="text-align:center;vertical-align:top;">
<div align="center">#dateformat(view_unprocessed.dod_to_bss_dt,"mm/dd/yyyy")#</div>
<div align="center">#timeformat(view_unprocessed.dod_to_bss_dt,"h:mm tt")#</div>
<div align="center">By: #view_unprocessed.approved_by#</div>
</td> --->


<td style="text-align:center;vertical-align:top;">
#view_unprocessed.app_name_nn#
</td>

<td style="text-align:left;vertical-align:top;">
<strong>#view_unprocessed.job_address#</strong>
<br>
<strong>Description:</strong> <span class="data">#sr_access_comments#</span>
</td>

<td style="text-align:left;vertical-align:top;">
<cfif #dod_internal_comments# is not "">
<div align="left">
<span class="data"><strong>Dept. on Disability Comments</strong></span>
<cfloop index="xx" list="#view_unprocessed.dod_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #spd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Special Projects Comments</strong></span>
<cfloop index="xx" list="#view_unprocessed.spd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #ufd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Urban Forestry Comments</strong></span>
<cfloop index="xx" list="#view_unprocessed.ufd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #bss_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Comments</strong></span>
<cfloop index="xx" list="#view_unprocessed.bss_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>
&nbsp;
</td>

<!--- <td style="text-align:center;vertical-align:top;">
#ar_status_desc#
</td> --->

<td style="text-align:center;vertical-align:top;">
<strong>#daysInQueue#</strong>
</td>

<td style="text-align:center;vertical-align:top;">

<a href="#cgi.script_name#?action=mark_completed1&arkey=#view_unprocessed.arkey#&#request.addtoken#">Mark Completed</a> &nbsp;&nbsp; 

</td>


</tr>
</cfoutput>
</table>
</div>

