<cfinclude template="../common/validate_arKey.cfm">

<cfparam name="attributes.width" default="350px">


<cfquery name="arInfo" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[ar_id]
      ,[arKey]
      ,[sr_number]
      ,[sr_311_cd]
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
      ,[from_st]
      ,[to_st]
      ,[section_id]
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
      ,[sr_mobility_name]
      ,[sr_mobility_relation]
      ,[ddate_submitted]
      ,[disability_valid]
      ,[dod_loc_comments]
      ,[dod_internal_comments]
      ,[dod_approved_by]
      ,[dod_denied_by]
      ,[dod_approved_dt]
      ,[dod_denied_dt]
      ,[dod_to_bss_dt]
      ,[bss_to_srp_dt]
      ,[bss_to_srp_by]
      ,[bss_assessed_dt]
      ,[bss_assessed_by]
      ,[fakeUpdate]
      ,[bss_internal_comments]
      ,[ufd_internal_comments]
      ,[spd_internal_comments]
      ,[ufd_update_dt]
      ,[ufd_update_by]
      ,[spd_update_dt]
      ,[spd_update_by]
      ,[boe_invest_comments]
      ,[boe_invest_response_to_app]
  FROM [accessprogram].[dbo].[ar_info]
  
  where 
arKey = '#attributes.arKey#'
</cfquery>


<cfset request.rslt_boe_district = ""> 				<!--- Resulting BOE District 	--->	
<cfset request.rslt_bss_district = ""> 				<!--- Resulting BSS District	--->	
<cfset request.rslt_bss_name = "">					<!--- Resulting BSS Name		--->	
<cfset request.rslt_bss_district_office = "">		<!--- Resulting BOE District Office	 	--->				
<cfset request.rslt_bca_district = "">				<!--- Resulting BOE District	--->
<cfset request.rslt_bca_inspect_district = "">	
		
<cfif #arInfo.x_coord# is not "" and #arInfo.y_coord# is not "">
<cfmodule template="getDistricts_module.cfm" x="#arInfo.x_coord#" y="#arInfo.y_coord#">
</cfif>

 


<cfoutput query="arInfo">
<div class="formbox" style="width:#attributes.width#;text-align:center;">
<h1>Service Ticket Information:</h1>
<table border="1" cellspacing="0" cellpadding="3" align="center" class="formtable" style="width: 97%;align:center;font-size:90%;">
<tr>
<td>Applicant Name</td>
<td>
#arInfo.app_name_nn#
</td>
</tr>

<tr>
<td>Applicant Phone Number</td>
<td>
#arInfo.app_phone_nn#
</td>
</tr>

<tr>
<td>Applicant Email</td>
<td>
#lcase(arInfo.app_email_nn)#
</td>
</tr>

<tr>
<td>Job Address</td>
<td>
#arInfo.HSE_NBR# #arInfo.HSE_FRAC_NBR# #arInfo.HSE_DIR_CD# #arInfo.STR_NM# #arInfo.STR_SFX_CD# #arInfo.STR_SFX_DIR_CD# #arInfo.ZIP_CD#
</td>
</tr>

<tr>
<td><strong>Street Name:</strong></td>
<td>
<strong>#arInfo.str_nm#</strong>
</td>
</tr>

<tr>
<td><strong>From:</strong></td>
<td>
<strong><br>#arInfo.from_st#</strong>
</td>
</tr>

<tr>
<td><strong>To:</strong></td>
<td>
<strong>#arInfo.to_st#</strong>
</td>
</tr>

<tr>
<td><strong>Section ID:</strong></td>
<td>
<strong>#arInfo.section_id#</strong>
</td>
</tr>

<tr>
<td><strong>Thomas Guide:</strong></td>
<td>
<strong>#arInfo.tbm_grid#</strong>
</td>
</tr>

<tr>
<td><strong>BOE District:</strong></td>
<td>
<strong>#request.rslt_boe_district#</strong>
</td>
</tr>

<tr>
<td><strong>BSS District:</strong></td>
<td>
<strong>#request.rslt_bss_name# - #request.rslt_bss_district# - #request.rslt_bss_district_office#</strong>
</td>
</tr>

<tr>
<td><strong>BCA District:</strong></td>
<td>
<strong>#request.rslt_bca_district# - #request.rslt_bca_inspect_district#</strong>
</td>
</tr>

<tr>
<td><strong>Council District:</strong></td>
<td>
<strong>#arInfo.council_dist#</strong>
</td>
</tr>


<tr>
<td>SR Applicant Comments</td>
<td>
#arInfo.sr_app_comments#
</td>
</tr>

<tr>
<td>SR Location Comments</td>
<td>
#arInfo.sr_location_comments#
</td>
</tr>


<tr>
<td>SR Mobility Disablility</td>
<td> #arInfo.sr_mobility_disability#</td>
</tr>

<tr>
<td>Mobility Person (if not applicant)</td>
<td> #arInfo.sr_mobility_name#</td>
</tr>

<tr>
<td>Relation to Mobility Person</td>
<td> #arInfo.sr_mobility_relation#</td>
</tr>


<tr>
<td>SR Access Barrier Type</td>
<td> #arInfo.sr_access_barrier_type#</td>
</tr>


<tr>
<td>SR Communication Method</td>
<td> #arInfo.sr_communication_method#</td>
</tr>

<tr>
<td>SR Mail</td>
<td>#arInfo.mailing_address1# <br>#arInfo.mailing_address2# <br>#arInfo.mailing_city# #arInfo.mailing_state# #arInfo.mailing_zip#</td>
</tr>


<tr>
<td>SR Email</td>
<td> #lcase(arInfo.sr_email)#</td>
</tr>


<tr>
<td>SR TTY Number</td>
<td> #arInfo.sr_tty_number#</td>
</tr>


<tr>
<td>SR Phone</td>
<td> #arInfo.sr_phone#</td>
</tr>

<tr>
<td>SR Video Phone</td>
<td> #arInfo.sr_video_phone#</td>
</tr>

	




<tr>
<td>SR Attachments</td>
<td>
<Cfset nn = 1>
<cfloop index="xx" list="#sr_attachments#" delimiters="|">
<div align="left"><a href="#xx#" target="_blank">Attachment No. #nn#</a></div>
<cfset nn = #nn# + 1>
</cfloop>
</td>
</tr>

</table>
</div>
</cfoutput>