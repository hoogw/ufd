<cfinclude template="header.cfm">
<cfinclude template="navbar2.cfm">

<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="propReport" datasource="#request.dsn#" dbtype="datasource">
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
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
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


			   
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srr_id = #request.srr_id#
</cfquery>

<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">



<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#" hse_nbr="#propReport.hse_nbr#" hse_frac_nbr="#propReport.hse_frac_nbr#" hse_dir_cd="#propReport.hse_dir_cd#" str_nm="#propReport.str_nm#" str_sfx_cd="#propReport.str_sfx_cd#" zip_cd="#propReport.zip_cd#">



<!--- <style>
p {
margin-left: 15px;
margin-bottom: 5px;
}

label {
margin-left: 10px;
font-weight: bold;
}
</style>

<div class="textbox" style="width:95%;">
<h1>Property Information</h1>

<table style="width: 100%" class="datatable" >
	<tr>
		<td>Property Address</td>
		<td><strong>839 S MULLEN AVE 90005</strong></td>
	</tr>
	<tr>
		<td>Zoning</td>
		<td>R1-1</td>
	</tr>
	<tr>
		<td>Commercial/Residential</td>
		<td><strong>Residential</strong></td>
	</tr>
	<tr>
		<td>Council District</td>
		<td>4 - David Ryu </td>
	</tr>
	<tr>
		<td>Engineering District</td>
		<td>Central </td>
	</tr>
	<tr>
		<td>PIN</td>
		<td>132B185-218 </td>
	</tr>
	<tr>
		<td>APN</td>
		<td>5090010008</td>
	</tr>
	<tr>
		<td>Owner</td>
		<td><strong>ITO, TADAO H</strong></td>
	</tr>
	<tr>
		<td>Mailing Address</td>
		<td>839 S MULLEN AVE<br>LOS ANGELES CA 90005 3840</td>
	</tr>
</table> --->

<cfinclude template="footer.cfm">

