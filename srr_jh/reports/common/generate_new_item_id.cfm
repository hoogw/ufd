<cfinclude template="/common/validate_referer.cfm">

<cfquery name="check_records" datasource="#request.revenue_distribution#" dbtype="ODBC">
select count(item_id) as record_count
from revenue_distribution
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.item_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_item_id" datasource="#request.revenue_distribution#" dbtype="ODBC">
select max(item_id) as last_item_id
from revenue_distribution
</cfquery>

<cfset request.item_id=#get_last_item_id.last_item_id#+1>
</cfif>