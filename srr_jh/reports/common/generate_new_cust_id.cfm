<cfinclude template="/common/validate_referer.cfm">

<cfquery name="check_records" datasource="#request.dsn#">
select count(cust_id) as record_count
from customers
</cfquery>

<Cfif #check_records.record_count# is "0">
<cfset request.cust_id=1>
</cfif>


<cfif #check_records.record_count# is not "0">
<cfquery name="get_last_cust_id" datasource="#request.dsn#" dbtype="ODBC">
select max(cust_id) as last_cust_id
from customers
</cfquery>

<cfset request.cust_id=#get_last_cust_id.last_cust_id#+1>
</cfif>