<cfinclude template="../common/validate_srrKey.cfm">

<style>
td {
text-align:left;
}
</style>

<cfquery name="srInfo" datasource="#request.dsn#" dbtype="datasource">
select 
job_address
,hse_nbr
,hse_frac_nbr
,hse_dir_cd
,str_nm
,str_sfx_cd
,str_sfx_dir_cd
,zip_cd
,unit_range
, app_name_nn
, app_email_nn
, app_phone_nn

,sr_app_comments
,sr_location_comments
,sr_attachments
,prop_owned_by

,srr_info.cont_license_no
,srr_info.cont_name
,srr_info.cont_address
,srr_info.cont_city
,srr_info.cont_state
,srr_info.cont_zip
,srr_info.cont_phone
,srr_info.cont_lic_issue_dt
,srr_info.cont_lic_exp_dt
,srr_info.cont_lic_class

 ,srr_info.mailing_address1
      ,srr_info.mailing_address2
      ,srr_info.mailing_zip
      ,srr_info.mailing_city
      ,srr_info.mailing_state
	  , srr_info.x_coord
	  , srr_info.y_coord
	  , srr_info.council_dist



from srr_info
where 
srrKey = '#attributes.srrKey#'
</cfquery>

<cfset request.rslt_boe_district = ""> 				<!--- Resulting BOE District 	--->	
<cfset request.rslt_bss_district = ""> 				<!--- Resulting BSS District	--->	
<cfset request.rslt_bss_name = "">					<!--- Resulting BSS Name		--->	
<cfset request.rslt_bss_district_office = "">		<!--- Resulting BOE District Office	 	--->				
<cfset request.rslt_bca_district = "">				<!--- Resulting BOE District	--->
<cfset request.rslt_bca_inspect_district = "">	
		
<cfif #srInfo.x_coord# is not "" and #srInfo.y_coord# is not "">
<cfmodule template="getDistricts_module.cfm" x="#srInfo.x_coord#" y="#srInfo.y_coord#">
</cfif>

<cfoutput query="srInfo">
<div class="formbox" style="width:#attributes.width#;text-align:center;">
<h1>Service Ticket Information:</h1>
<table border="1" cellspacing="0" cellpadding="3" align="center" class="formtable" style="width: 97%;align:center;font-size:90%;">
<tr>
<td>Applicant Name</td>
<td>
<strong>#srInfo.app_name_nn#</strong>
</td>
</tr>

<tr>
<td>Applicant Phone Number</td>
<td>
#srInfo.app_phone_nn#
</td>
</tr>

<tr>
<td>Applicant Email</td>
<td>
#lcase(srInfo.app_email_nn)#
</td>
</tr>

<tr>
<td>Job Address</td>
<td>
#srInfo.HSE_NBR# #srInfo.HSE_FRAC_NBR# #srInfo.HSE_DIR_CD# #srInfo.STR_NM# #srInfo.STR_SFX_CD# #srInfo.STR_SFX_DIR_CD# #srInfo.ZIP_CD#
</td>
</tr>

<tr>
<td>Property Owned by:</td>
<td>
<cfif #srInfo.prop_owned_by# is "I">
Individual(s)
<cfelseif #srInfo.prop_owned_by# is "T">
Trust
<cfelseif #srInfo.prop_owned_by# is "B">
Business/Other
<cfelseif #srInfo.prop_owned_by# is "M">
Multiple Owners with an HOA or Management Association
</cfif>
</td>
</tr>

<tr>
<td>SR Applicant Comments</td>
<td>
#srInfo.sr_app_comments#
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
<strong>#srInfo.council_dist#</strong>
</td>
</tr>

<tr>
<td><strong>Neighborhood Council:</strong></td>
<td>
<strong>#request.rslt_nc#</strong>
</td>
</tr>

<tr>
<td>SR Location Comments</td>
<td>
#srInfo.sr_location_comments#
</td>
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

<div class="formbox" style="width:#attributes.width#;text-align:center;">
<h1>Mailing Address (for Rebate):</h1>
<table border="1" cellspacing="0" cellpadding="3" align="center" class="formtable" style="width: 97%;align:center;font-size:90%;">
<tr>
<td>Address</td>
<td>
#srInfo.mailing_address1#
<cfif #srInfo.mailing_address2# is not ""><br>#srInfo.mailing_address2#</cfif>
<br>#srInfo.mailing_city#  #srInfo.mailing_state# #srInfo.mailing_zip#
</td>
</tr>
</table>
</div>


<div class="formbox" style="width:#attributes.width#;text-align:center;">
<h1>Contractor Information:</h1>
<table border="1" cellspacing="0" cellpadding="3" align="center" class="formtable" style="width: 97%;align:center;font-size:90%;">
<tr>
<td>Contractor Name</td>
<td>
<strong>#srInfo.cont_name#</strong>
</td>
</tr>

<tr>
<td>License</td>
<td>
Number: #srInfo.cont_license_no#<br>
Issued: #dateformat(srInfo.cont_lic_issue_dt,"mm/dd/yyyy")#<br>
Expires: #dateformat(srInfo.cont_lic_exp_dt,"mm/dd/yyyy")#<br>
Class: #srInfo.cont_lic_class#
</td>
</tr>

<tr>
<td>Address</td>
<td>
#srInfo.cont_address#<br>
#srInfo.cont_city# #srInfo.cont_state# #srInfo.cont_zip#
</td>
</tr>

<tr>
<td>Phone</td>
<td>
#srInfo.cont_phone#
</td>
</tr>

</table>
</div>



</cfoutput> 