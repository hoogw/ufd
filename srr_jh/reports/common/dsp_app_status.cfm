<cfinclude template="/common/validate_referer.cfm">

<cfquery name="get_status" datasource="#request.dsn#" dbtype="datasource">
select * from status_lookup
where status_id = '#app_status#'
</cfquery>


<cfoutput>
#get_status.status_desc#&nbsp;
</cfoutput>


<!--- <cfif #app_status# is "none">	
Received
</cfif>

<cfif #app_status# is "canceled">	
Canceled
</cfif>

<cfif #app_status# is "estimate">	
Estimate Only
</cfif>

<cfif #app_status# is "incomplete">	
Incomplete Application
</cfif>

<cfif #app_status# is "approved">	
Approved Until Payment Received
</cfif>

<cfif #app_status# is "issued">	
Issued Permit
</cfif>&nbsp; --->