<cfinclude template="/common/validate_referer.cfm">

<cfset current_year=DatePart("yyyy", "#now()#")>

<cfquery name="check_permit_info" DATASOURCE="#request.dsn#">
select count(ref_no) as apps_count
from permit_info where ref_no like '#current_year#%'
</cfquery>


<cfif #check_permit_info.apps_count# is "0">
<cfset new_ref_no=#current_year#&"0001">
<cfset request.ref_no=#new_ref_no#>
</cfif>

<cfif #check_permit_info.apps_count# is not "0">
<cfquery name="max_ref_no" DATASOURCE="#request.dsn#" dbtype="ODBC">
select max(ref_no) as last_ref_no
from permit_info where ref_no like '#current_year#%'
</cfquery>
<cfset new_ref_no=#max_ref_no.last_ref_no# + 1>
<cfset request.ref_no=#new_ref_no#>
</cfif>
