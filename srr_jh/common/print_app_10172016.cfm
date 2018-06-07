<cfinclude template="/srr/common/validate_srrKey.cfm">
<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
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




<cfdocument  format="PDF" pagetype="letter" margintop=".5" marginbottom=".5" marginright=".5" marginleft=".5" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="No" bookmark="False" localurl="No">



<style>
* {
font-family: arial;
font-size: 14px;
}

H1 {
font-size: 16px;
font-weight: bold;
text-align: center;
}

.data 
{
color:maroon;
font-weight:bold;
}

</style>

<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">

<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  hse_nbr="#find_srr.hse_nbr#" hse_frac_nbr="#find_srr.hse_frac_nbr#" hse_dir_cd="#find_srr.hse_dir_cd#" str_nm="#find_srr.str_nm#" str_sfx_cd="#find_srr.str_sfx_cd#" zip_cd="#find_srr.zip_cd#">

</cfdocument>