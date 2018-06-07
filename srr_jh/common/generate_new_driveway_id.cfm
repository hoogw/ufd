<cfquery name="check_records" datasource="apermits_sql" dbtype="datasource">
select count(driveway_id) as record_count
from driveway_details
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.driveway_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_driveway_id" datasource="apermits_sql" dbtype="datasource">
select max(driveway_id) as last_driveway_id
from driveway_details
</cfquery>

<cfset request.driveway_id=#get_last_driveway_id.last_driveway_id#+1>
</cfif>