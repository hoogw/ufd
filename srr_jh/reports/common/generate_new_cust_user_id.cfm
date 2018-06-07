<cfinclude template="/common/validate_referer.cfm">

<cfquery name="check_records" datasource="#request.dsn#" dbtype="ODBC">
select count(user_id) as record_count
from boe_users
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.user_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_user_id" datasource="#request.dsn#" dbtype="ODBC">
select max(user_id) as last_user_id
from boe_users
</cfquery>

<cfset request.user_id=#get_last_user_id.last_user_id#+1>
</cfif>