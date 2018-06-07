<cfquery name="max_ref_no" datasource="#request.dsn#" dbtype="datasource">
select max(ref_no) as last_ref_no
from permit_info
</cfquery>

<cfset new_ref_no=#MAX_ref_no.last_ref_no# + 1>

<cfset ref_no=#new_ref_no#>
<cfset request.ref_no=#new_ref_no#>
