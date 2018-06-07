<cfset request.search_value = #trim(request.search_value)#>

<cfquery name="find_ar1" datasource="#request.dsn#" maxrows=300 dbtype="datasource">
SELECT 
	  
	  ar_info.ar_id 				
	, ar_info.arKey 
	, ar_info.sr_number 
	, ar_info.ar_status_cd 
	, ar_info.record_history 
	, ar_info.app_name_nn 
	, ar_info.app_email_nn 
	, ar_info.app_address1_nn 
	, ar_info.app_address2_nn 
	, ar_info.app_city_nn 
	, ar_info.app_state_nn
	, ar_info.app_zip_nn 
	, ar_info.app_phone_nn 
	, ar_info.mailing_address1 
	, ar_info.mailing_address2
	, ar_info.mailing_zip
	, ar_info.mailing_city
	, ar_info.mailing_state 
	, ar_info.hse_nbr 
	, ar_info.hse_frac_nbr 
	, ar_info.hse_dir_cd 
	, ar_info.str_nm 
	, ar_info.str_sfx_cd 
	, ar_info.str_sfx_dir_cd 
	, ar_info.zip_cd 
	, ar_info.unit_range 
	, ar_info.hse_id
	, ar_info.tbm_grid
	, ar_info.boe_dist 
	, ar_info.council_dist 
	, ar_info.bpp 
	, ar_info.pin 
	, ar_info.pind 
	, ar_info.zoningCode 
	, ar_info.job_address 
	, ar_info.x_coord 
	, ar_info.y_coord
	, ar_info.longitude 
	, ar_info.latitude 
	, ar_info.DOD_INTERNAL_COMMENTS
	, ar_info.SPD_INTERNAL_COMMENTS
	, ar_info.UFD_INTERNAL_COMMENTS
	, ar_info.BSS_INTERNAL_COMMENTS
	, ar_info.sr_app_comments
	, ar_info.sr_location_comments 
	, ar_info.sr_access_comments 
	, ar_info.sr_attachments 
	, ar_info.sr_mobility_disability
	, ar_info.sr_access_barrier_type 
	, ar_info.sr_communication_method 
	, ar_info.sr_email 
	, ar_info.sr_tty_number 
	, ar_info.sr_phone 
	, ar_info.sr_video_phone 
	, ar_info.ddate_submitted 	
	, ar_info.DISABILITY_VALID			
		
		
		
 , ar_status.ar_status_desc
 , ar_info.ddate_submitted
 , ar_info.dod_approved_by
 , ar_info.dod_denied_by
 , ar_info.dod_approved_dt
 , ar_info.dod_denied_dt
 , ar_info.dod_to_bss_dt
 
 , dateDiff("d", ar_info.ddate_submitted, getDate()) as daysInQueue
 
 , ar_info.sr_access_comments		
			 , ar_info.lgd_completed_dt
	  
FROM  ar_info LEFT OUTER JOIN
               staff ON ar_info.dod_approved_by = staff.user_id LEFT OUTER JOIN
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
<!---       OR
 sr_number like '%#request.search_value#%' --->
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
<table class="datatable" id="table1" style="width:90%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<!--- <th nowrap>Date Sent to BSS</th> --->
<th nowrap>Applicant</th>
<th>Access Barrier Location <br>& Description</th>
<th>Comments</th>
<th>Status</th>
<th>How Old (Days)<br>from Date Submitted</th>
<th>LGD Completed Date</th>
</tr>

<cfoutput query="find_ar">
<tr>
<td style="text-align:center;;vertical-align:top;" nowrap>#find_ar.sr_number#</td>
<!--- <a href="control.cfm?action=sidewalks1&arKey=#find_ar.arKey#&#request.addtoken#">#find_ar.sr_number#<!---  (#ar_id#) ---></a> --->


<td style="text-align:center;vertical-align:top;">
<div align="center">#dateformat(find_ar.ddate_submitted,"mm/dd/yyyy")#</div>
<div align="center">#timeformat(find_ar.ddate_submitted,"h:mm tt")#</div>
</td>

<!--- 
<td style="text-align:center;vertical-align:top;">
<div align="center">#dateformat(find_ar.dod_to_bss_dt,"mm/dd/yyyy")#</div>
<div align="center">#timeformat(find_ar.dod_to_bss_dt,"h:mm tt")#</div>
</td>
 --->

<td style="text-align:center;vertical-align:top;" >#find_ar.app_name_nn#</td>

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
#ar_status_desc#
</td>



<td style="text-align:center;vertical-align:top;">
<strong>#daysInQueue#</strong>
</td>

<td style="text-align:center;vertical-align:top;">
<cfif isdate(#find_ar1.lgd_completed_dt#)>
#dateformat(find_ar1.lgd_completed_dt,"mm/dd/yyyy")#
<cfelse>
Not Completed
</cfif>
</td>
</tr>
</cfoutput>

</table>
</div>
