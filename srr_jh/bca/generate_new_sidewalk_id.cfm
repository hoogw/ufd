<cfquery name="check_records" datasource="apermits_sql" dbtype="datasource">
select count(sidewalk_id) as record_count
from sidewalk_details
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.sidewalk_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_sidewalk_id" datasource="apermits_sql" dbtype="datasource">
select max(sidewalk_id) as last_sidewalk_id
from sidewalk_details
</cfquery>

<cfset request.sidewalk_id=#get_last_sidewalk_id.last_sidewalk_id#+1>
</cfif>