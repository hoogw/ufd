<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="getCurrentSrCode" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_info.srrKey, srr_info.sr_number, srr_info.srr_status_cd, srr_status.reason_code_311, srr_status.resolution_code_311
FROM  srr_info LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   
where srr_info.srrKey = '#attributes.srrKey#'
</cfquery>

<cfset request.currentSrCode = #getCurrentSrCode.reason_code_311#>