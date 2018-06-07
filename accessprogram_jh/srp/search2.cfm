<cfset request.search_value = #trim(request.search_value)#>

<cfquery name="find_ar1" datasource="#request.dsn#" maxrows=300 dbtype="datasource">
SELECT
  ar_info.ar_id
, ar_info.arKey
, ar_info.sr_number
, ar_info.ddate_submitted

, ar_info.app_name_nn
, ar_info.app_address1_nn
, ar_info.app_address2_nn
, ar_info.app_city_nn
, ar_info.app_state_nn
, ar_info.app_zip_nn
, ar_info.app_phone_nn
, ar_info.app_email_nn
, ar_info.job_address

, ar_info.mailing_address1
, ar_info.mailing_address2
, ar_info.mailing_zip
, ar_info.mailing_city
, ar_info.mailing_state
 , ar_info.bpp
 , ar_info.pin
 , ar_info.pind
 , ar_info.zoningCode
 , ar_info.sr_email
 , ar_info.BSS_TO_SRP_DT
 ,ar_info.BSS_TO_SRP_by
 , dod_internal_comments
 , ufd_internal_comments
 , spd_internal_comments
  , bss_internal_comments
 , ar_status.ar_status_desc
 
, ar_info.SR_ACCESS_COMMENTS
 , dbo.ar_info.dod_denied_by
 , dbo.ar_info.dod_approved_dt
 , dbo.ar_info.dod_denied_dt
 , dbo.ar_info.dod_to_bss_dt
 
 
 , dateDiff("d", dbo.ar_info.ddate_submitted, getDate()) as daysInQueue
 
 FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
			   
			   
  where 
  (
ar_info.ar_id like '%#request.search_value#%'
  OR
  ar_info.sr_number like '%#request.search_value#%'
  OR
  ar_info.app_name_nn like '%#request.search_value#%'
  OR
  ar_info.job_address like '%#request.search_value#%'

  )
  </cfquery>


<cfquery name="find_ar" datasource="find_ar1" dbtype="query">
select * from find_ar1
order by daysInQueue desc
</cfquery>


<!--- <div class="divSubTitle">Unprocessed Applications</div> --->

<cfoutput>
<div class="subtitle">#find_ar.recordcount# Application(s) Found</div>
<div style="margin-left:auto;margin-right:auto;text-align:center;width:700px;">(Search results are limited to 300 records)</div>
</cfoutput>

<div align = "center">
<table class="datatable" id="table1" style="width:95%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<th nowrap>Applicant</th>
<th>Access Barrier Location <br>& Description</th>
<th>Comments</th>
<th>Status</th>
<th>How Old (Days)<br>from Date Submitted</th>
</tr>

<cfoutput query="find_ar">
<tr>
<td style="text-align:center;vertical-align:top;"><a href="control.cfm?action=process_app1&arKey=#find_ar.arKey#&#request.addtoken#">#find_ar.sr_number#<!---  (#ar_id#) ---></a></td>


<td style="text-align:center;vertical-align:top;">
#dateformat(find_ar.ddate_submitted,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#find_ar.app_name_nn#
</td>

<td style="text-align:left;vertical-align:top;">
<strong>#find_ar.job_address#</strong>
<br>
<strong>Description:</strong> <span class="data">#sr_access_comments#</span>
</td>

<td style="text-align:left;vertical-align:top;">
<cfif #dod_internal_comments# is not "">
<div align="left">
<span class="data"><strong>Dept. on Disability Comments</strong></span>
<cfloop index="xx" list="#find_ar.dod_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #spd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Special Projects Comments</strong></span>
<cfloop index="xx" list="#find_ar.spd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #ufd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Urban Forestry Comments</strong></span>
<cfloop index="xx" list="#find_ar.ufd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #bss_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Comments</strong></span>
<cfloop index="xx" list="#find_ar.bss_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>
&nbsp;
</td>

<td style="text-align:center;vertical-align:top;">
#find_ar.ar_status_desc#
</td>


<td style="text-align:center;vertical-align:top;">
<strong>#daysInQueue#</strong>
</td>

</tr>
</cfoutput>

</table>
</div>
