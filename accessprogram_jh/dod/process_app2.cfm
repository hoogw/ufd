<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.disability_Valid" default="">
<cfparam name="request.residential_n" default="">
<cfparam name="request.bus_stops" default="">
<cfparam name="request.rejected_reason_code" default="">


<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>


<!--- New stuff --->


<cfif #request.rejected_reason_code# is not "">
	
	
<cfquery name="find_rejected_desc" datasource="#request.dsn#" dbtype="datasource">
select 
rejected_reason_id
,rejected_reason_code
,rejected_reason_desc
,rejected_reason_lang
from denial_reason
where rejected_reason_code = '#request.rejected_reason_code#'
</cfquery>

<cfset request.reason_denial_id = #find_rejected_desc.rejected_reason_id#>
<cfset request.reason_desc = #find_rejected_desc.rejected_reason_desc#>
<cfset request.reason_message = #find_rejected_desc.rejected_reason_lang#>


<!---Step 1--->

<cfquery name="updateARInfo" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[ar_info]
SET

fakeUpdate = 1
<cfif #request.rejected_reason_code# is not "">
, dod_to_bss_dt = null
, dod_denied_dt = #now()#
, dod_denied_by = #client.staff_user_id#
, record_history = isnull(record_history, '') + '|Application was rejected (#request.reason_desc#).  Processed by: #client.full_name# on #dnow#.' <!--- add reason Blue Curb request rejected --->
 , ar_status_cd = 'closeTicket' 
, rejected_reason_id = #request.reason_denial_id#
</cfif>

where arKey =  '#request.arKey#'
</cfquery>
<!---Step 1--->



<!---Step 2--->
<cfif #request.rejected_reason_code# is "BCR" or #request.rejected_reason_code# is "MRR" or #request.rejected_reason_code# is "TPO" or #request.rejected_reason_code# is "NPR" or #request.rejected_reason_code# is "PR" <!---or #request.rejected_reason_code# is "NEPF"---> or #request.rejected_reason_code# is "ULPF" >
<!--- Status is Updated to NOT Eligible --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"> <!--- Code 13 Not Eligible --->
<cfset request.srComment = 	 "#request.reason_message# ">

<cfelseif #request.rejected_reason_code# is "NEPF">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"> <!--- Code 13 Not Eligible --->
<cfset request.srComment = "Your Access Request is outside of the scope of the Access Request Program because the program only includes Pedestrian
 Facilities that were existing as of July 1, 2017.">
</cfif>
<!---Step 2--->


<!---Step 3--->
<cfif request.production is "p">
<cftry>
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<!--- see footer for return values --->
<cfcatch type="Any">
<!--- see footer for return values --->
</cfcatch>
</cftry>
<cfelse>
<cfmail to="jimmy.lam@lacity.org" cc="Essam.Amarragy@lacity.org"    from="jimmy.lam@lacity.org" subject="Message from Access Program_TEST">
#now()#
<br>
#request.srNum#
<br>
#request.srComment#
</cfmail>
</cfif>
<!---Step 3--->




<!--- step 4 --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "CL">
<cfset request.srComment = 	"">

<cfif request.production is "p">
<cftry>
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<!--- see footer for return values --->
<cfcatch type="Any">
<!--- see footer for return values --->
</cfcatch>
</cftry>
<cfelse>
<cfmail to="jimmy.lam@lacity.org"  cc="Essam.Amarragy@lacity.org"   from="jimmy.lam@lacity.org" subject="Message from Access Program_test">
#now()#
<br>
#request.srNum#

<br>
#request.srCode#
<br>
#request.srComment#
</cfmail>
</cfif>
<!--- step 4 --->

</cfif>
<!---Step 1--->








<!--- other selection--->

<cfquery name="updateARInfo" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[ar_info]
SET

fakeUpdate = 1

, residential_n = '#request.residential_n#'
, bus_stops = '#request.bus_stops#'

<cfif #request.disability_valid# is "Y" or #request.disability_valid# is "N" or #request.disability_valid# is "" >
, disability_Valid = '#request.disability_valid#'
</cfif>

<cfif #trim(request.dod_loc_comments)# is not "">
, dod_loc_comments = ISNULL(dod_loc_comments, '') + '|#toSqlText(request.dod_loc_comments)# <br>(By: #client.full_name# on: #dnow#)'
</cfif>

<cfif #trim(request.dod_internal_comments)# is not "">
, dod_internal_comments = ISNULL(dod_internal_comments, '') + '|#toSqlText(request.dod_internal_comments)# <br>(By: #client.full_name# on: #dnow#)'
</cfif>



<cfif #request.disability_valid# is "Y">
, dod_to_bss_dt = #now()#
, dod_approved_by = #client.staff_user_id#
, record_history = isnull(record_history, '')  + '|Application was approved by #client.full_name# on #dnow#.'
, ar_status_cd = 'pendingBSSReview'

<cfelseif #request.disability_valid# is "N">
, dod_to_bss_dt = null
, dod_denied_dt = #now()#
, dod_denied_by = #client.staff_user_id#
, record_history = isnull(record_history, '') + '|Application was denied by #client.full_name# on #dnow#.'
, ar_status_cd = 'notEligible'
</cfif>

where arKey =  '#request.arKey#'
</cfquery>


<cfif #request.disability_valid# is "Y">
<!--- Status is Updated to NOT Eligible --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 PendingBssReview --->
<cfset request.srComment = "Your Access Request has been found to be eligible by the Department on Disability. A City representative will soon assess the condition of the sidewalks at the location of the Access Request. <br><br>
Updates will be provided as the status of #request.sr_number# progresses.
">
</cfif>

<cfif #request.disability_valid# is "N">
<!--- Status is Updated to NOT Eligible --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"> <!--- Code 13 Not Eligible --->
<cfset request.srComment = "We regret to inform you that your Sidewalk Access Request has been found ineligible. Common reasons for ineligibility are incorrect locations, or requests not on behalf of someone with a Mobility Disability. <br><br>If you would like to read more about the Access Request Program Requirements, you may view the Frequently Asked Questions here: 
<br>
http://sidewalks.lacity.org
<br><br>
You may Report a Sidewalk Problem 
<br>
http://sidewalks.lacity.org/application-report-sidewalk-problem
">
</cfif>


<cfif request.production is "p">
<cfif #request.disability_valid# is "N" or #request.disability_valid# is "Y">
<cftry>
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<!--- see footer for return values --->
<cfcatch type="Any">
<!--- see footer for return values --->
</cfcatch>
</cftry>
</cfif>
<!---
 <cfelse>
<cfmail to="jimmy.lam@lacity.org" from="jimmy.lam@lacity.org" subject="Message from Access Program">
#now()#
#request.srComment#
</cfmail>
 --->
</cfif>
<!--- other selection--->








<cfoutput>
<div class="warning">
Application was Successfully Updated
</div>
</cfoutput>
<!--- 
<CFQUERY name="findARInfo" datasource="#request.dsn#" dbtype="datasource">
select				
[ar_id] 				
	,[arKey] 
	,[sr_number] 
	,[ar_status_cd] 
	,[record_history] 
	,[app_name_nn] 
	,[app_email_nn] 
	,[app_address1_nn] 
	,[app_address2_nn] 
	,[app_city_nn] 
	,[app_state_nn]
	,[app_zip_nn] 
	,[app_phone_nn] 
	,[mailing_address1] 
	,[mailing_address2]
	,[mailing_zip]
	,[mailing_city]
	,[mailing_state] 
	,[hse_nbr] 
	,[hse_frac_nbr] 
	,[hse_dir_cd] 
	,[str_nm] 
	,[str_sfx_cd] 
	,[str_sfx_dir_cd] 
	,[zip_cd] 
	,[unit_range] 
	,[hse_id]
	,[tbm_grid]
	,[boe_dist] 
	,[council_dist] 
	,[bpp] 
	,[pin] 
	,[pind] 
	,[zoningCode] 
	,[job_address] 
	,[x_coord] 
	,[y_coord]
	,[longitude] 
	,[latitude] 
	,[sr_app_comments]
	,[sr_location_comments] 
	,[sr_access_comments] 
	,[sr_attachments] 
	,[sr_mobility_disability]
	,[sr_access_barrier_type] 
	,[sr_communication_method] 
	,[sr_email] 
	,[sr_tty_number] 
	,[sr_phone] 
	,[sr_video_phone] 
	,[ddate_submitted] 	
	,[DISABILITY_VALID]			
	, dod_internal_comments
	, DOD_LOC_COMMENTS
	, residential_n
	, bus_stops

				
				FROM  dbo.ar_info
where 
ar_info.arKey = '#request.arKey#'

</cfquery>

<cfdump var="#findARInfo#"> --->