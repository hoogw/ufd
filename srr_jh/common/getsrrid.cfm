<cfquery name="getSrrID" datasource="#request.dsn#" dbtype="datasource">
select srr_id, a_ref_no from srr_info where srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srr_id = #getSrrID.srr_id#>
<cfset request.a_ref_no = #getSrrID.a_ref_no#>
<cfset request.ref_no = #request.a_ref_no#>