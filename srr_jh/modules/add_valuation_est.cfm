<cfabort>

<cfquery name="readSRR" datasource="#request.dsn#" dbtype="datasource">
Select srrKey, a_ref_no

from srr_info

where a_ref_no is not null and a_ref_no <> ''
</cfquery>

<cfloop query="readSRR">
<cfset request.srrKey = #readSRR.srrKey#>
<cfset request.a_ref_no = #readSRR.a_ref_no#>
<cfmodule template="calculate_rebate_amt_module.cfm" srrKey = "#readSRR.srrKey#">
</cfloop>

Done