<cfinclude template="/common/validate_referer.cfm">
<cfinclude template="/common/validate_ref_no.cfm">

<cfset current_year=DatePart("yyyy", "#now()#")>

<cfquery name="find_permit" datasource="#request.dsn#" dbtype="ODBC">
select * from permit_info
where ref_no = #request.ref_no#
</cfquery>


<cfif len(#find_permit.cust_id#) is 1>
<Cfset request.cust_id="00"&#find_permit.cust_id#>
<cfelseif len(#find_permit.cust_id#) is 2>
<Cfset request.cust_id="0"&#find_permit.cust_id#>
<cfelseif len(#find_permit.cust_id#) is 3>
<Cfset request.cust_id=#find_permit.cust_id#>
</cfif>


<cfset temp_permit_nbr = #current_year#&#request.cust_id#>


<cfquery name="count_apps" DATASOURCE="#request.dsn#">
select count(ref_no) as apps_count
from permit_info where permit_nbr like '#temp_permit_nbr#%'
</cfquery>



<cfif #count_apps.apps_count# is "0">
<cfset request.permit_nbr=#temp_permit_nbr#&"001">
</cfif>

<cfif #count_apps.apps_count# is not "0">
<cfquery name="max_permit_nbr" DATASOURCE="#request.dsn#" dbtype="ODBC">
select max(permit_nbr) as max_permit_nbr
from permit_info where permit_nbr like '#temp_permit_nbr#%'
</cfquery>
<cfset request.permit_nbr=#max_permit_nbr.max_permit_nbr# + 1>
</cfif>
