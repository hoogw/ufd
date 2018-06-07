<cfquery name="check_records" datasource="apermits_sql" dbtype="datasource">
select count(record_id) as record_count
from other_items
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.record_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_record_id" datasource="apermits_sql" dbtype="datasource">
select max(record_id) as last_record_id
from other_items
</cfquery>

<cfset request.record_id=#get_last_record_id.last_record_id#+1>
</cfif>