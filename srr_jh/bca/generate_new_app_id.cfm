<cfquery name="check_records" datasource="customers" dbtype="datasource">
select count(app_id) as record_count
from customers
</cfquery>

<cfif #check_records.record_count# is "0">
<cfset request.app_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_app_id" datasource="customers" dbtype="datasource">
select max(app_id) as last_app_id
from customers
</cfquery>

<cfset request.app_id=#get_last_app_id.last_app_id#+1>
</cfif>