<style>
* {
font-family: arial;
font-size: 12px;
}

h1 {
font-size: 12px;
/*font-weight: bold;*/
text-align: center;
}

.data 
{
color:maroon;
font-weight:bold;
}

p {
padding-left: 20px;
margin-bottom:0px;
}



</style>

<!--- <cfinclude template="/srr/common/validate_srrKey.cfm"> --->

<cfif not isdefined("request.srrKey") or len(#request.srrKey#) is not 50>
<div class="warning">Invalid SRR Key!</div>
<cfabort>
</cfif>

<cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.a_ref_no
, dbo.srr_status.srr_status_desc
, srr_info.app_id
, srr_info.job_address
, srr_info.srr_status_cd

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srr_id = #validateSRR.srr_id#>
<cfset request.sr_number = #validateSRR.sr_number#>
<cfset request.a_ref_no = #validateSRR.a_ref_no#>
<cfset request.app_id = #validateSRR.app_id#>
<cfset request.job_address = #validateSRR.job_address#>
<cfset request.status_cd = #validateSRR.srr_status_cd#>
<cfset request.status_desc = #validateSRR.srr_status_desc#>

<cfif #validateSRR.recordcount# is 0>
<div class="warning">Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.</div>
<cfabort>
</cfif>

<cfoutput>
<div align="center">
#validateSRR.sr_number#&nbsp;&nbsp;&nbsp;
#validateSRR.srr_id#&nbsp;&nbsp;&nbsp;
A-Permit Ref. No. #validateSRR.a_ref_no#
</div>

</cfoutput>

