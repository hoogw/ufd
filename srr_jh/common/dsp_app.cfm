<cfinclude template="/srr/common/validate_srrKey.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
<!--- , dbo.srr_info.app_contact_name_nn
, dbo.srr_info.app_address1_nn
, dbo.srr_info.app_address2_nn
, dbo.srr_info.app_city_nn
, dbo.srr_info.app_state_nn
, dbo.srr_info.app_zip_nn --->
, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
<!--- , dbo.srr_info.job_city
, dbo.srr_info.job_state
, dbo.srr_info.job_zip
, dbo.srr_info.unit_range --->
, dbo.srr_info.srr_status_cd



, dbo.srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, dbo.srr_info.bpw1_tax_verified
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

FROM  dbo.srr_info 			   

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>


<!--- <cfinclude template="get_srr_status.cfm">

<div class="warning">Status: #request.srr_status#</div> --->

<!--- <cfoutput>
<div style="margin-left:auto;margin-right:auto;width:700px;margin-bottom:5px;"><a href="/srr/common/print_app.cfm?srr_id=#request.srr_id#" target="_blank">Print a copy</a></div>
</cfoutput> --->
<!--- <cfinclude template="dsp_srr_id.cfm"> --->

<div align="center">
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td width="500" valign="top">
	<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">


<!--- <br>
<cfinclude template="/srr/common/dsp_work_description.cfm"> --->
</td>

<td width="10">&nbsp;</td>
<td valign="top"><!--- outer cell --->

	<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  hse_nbr="#find_srr.hse_nbr#" hse_frac_nbr="#find_srr.hse_frac_nbr#" hse_dir_cd="#find_srr.hse_dir_cd#" str_nm="#find_srr.str_nm#" str_sfx_cd="#find_srr.str_sfx_cd#" zip_cd="#find_srr.zip_cd#">

</td><!-- outer cell -->
</tr>
</table>
</div>