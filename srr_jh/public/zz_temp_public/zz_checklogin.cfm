

<cfif not isdefined("request.eapp_email") or len(#request.eapp_email#) is 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg = "Invalid Request!">
</cfif>

<cfquery name="boeKey" datasource="customers" dbtype="datasource">
select boeKey from boeKey
where recordID = 1 
</cfquery>

<cfscript>
app_email=decrypt(#request.eapp_email#, #boeKey.boeKey#,  "CFMX_COMPAT", "HEX");
</cfscript>

<cfquery name="checkit" datasource="customers" dbtype="datasource">
select * from customers
where app_email = '#app_email#'
</cfquery>

<cfif #checkit.recordcount# is 1>
<cfset client.user="public">
<cfset client.app_full_name=#checkit.app_name#>
<cfset client.app_id=#checkit.app_id#>
<cfset client.app_login = 1>

<CFLOCATION URL="control.cfm?action=faqs&#request.addtoken#" ADDTOKEN="No"> 

<cfelse>

<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Login!">

</cfif>
