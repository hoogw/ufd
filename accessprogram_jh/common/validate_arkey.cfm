<cfif not isdefined("request.arKey") or len(#request.arKey#) is not 50>
<div class="warning">Invalid Access Request Key!</div>
<cfabort>
</cfif>

<cfquery name="validateAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.ar_info.ar_id
, dbo.ar_info.arKey
, dbo.ar_info.sr_number
, dbo.ar_status.ar_status_desc
, ar_info.job_address
, ar_info.ar_status_cd

FROM  dbo.ar_info LEFT OUTER JOIN
               dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd

where 
ar_info.arKey = '#request.arKey#'
</cfquery>

<cfset request.ar_id = #validateAR.ar_id#>
<cfset request.sr_number = #validateAR.sr_number#>
<cfset request.job_address = #validateAR.job_address#>
<cfset request.status_cd = #validateAR.ar_status_cd#>
<cfset request.status_desc = #validateAR.ar_status_desc#>

<cfif #validateAR.recordcount# is 0>
<div class="warning">Could not Find Your Sidewalk Access Request!<br><br>Please Contact the Sidewalk Repair Program.</div>
<cfabort>
</cfif>

<!--- <cfoutput>
<div align="center">
#validateAR.sr_number#&nbsp;&nbsp;&nbsp;
#validateAR.ar_id#&nbsp;&nbsp;&nbsp;
A-Permit Ref. No. #validateAR.a_ref_no#&nbsp;&nbsp;
arKey = #request.arKey#
</div>
</cfoutput> --->