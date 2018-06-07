<cfinclude template="/common/validate_referer.cfm">

<cfset clientlist=#GetClientVariablesList()#>

<cfloop index="name" list="#clientList#" delimiters=",">
<cfset temp = DeleteClientVariable("#name#")>
</cfloop>