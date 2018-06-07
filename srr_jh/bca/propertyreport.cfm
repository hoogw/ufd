<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<cfquery name="propReport" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.sr_number
, srr_info.app_name_nn
<!--- , srr_info.app_contact_name_nn
, srr_info.app_address1_nn
, srr_info.app_address2_nn
, srr_info.app_city_nn
, srr_info.app_state_nn
, srr_info.app_zip_nn --->
, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.job_address
<!--- , srr_info.job_city
, srr_info.job_state
, srr_info.job_zip
, srr_info.unit_range --->
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_status.agency
, srr_status.srr_list_order
, srr_status.suspend
, srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments
, srr_info.bpw1_internal_comments
, srr_info.bpw1_comments_to_app
, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd

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


			   
FROM  srr_info LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd

where 
srr_info.srr_id = #request.srr_id#
</cfquery>




<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="90%">

<cfmodule template="../modules/addressReportModule.cfm"  srrKey = "#request.srrKey#" width="90%">

<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#" width="90%">

<cfinclude template="record_history.cfm">

<cfinclude template="footer.cfm">

