<cfquery name="srr_status" datasource="#request.dsn#" dbtype="datasource">
SELECT dbo.srr_status.srr_status_desc AS srr_status, dbo.srr_info.srr_id
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   
where srr_id=#request.srr_id#
</cfquery>

<cfset request.srr_status = #srr_status.srr_status#>
<div class="warning">Status: #request.srr_status#</div>