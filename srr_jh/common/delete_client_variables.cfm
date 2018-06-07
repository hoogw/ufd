<cfset clientlist=#GetClientVariablesList()#>

<cfloop index="name" list="#clientList#" delimiters=",">
<cfset temp = DeleteClientVariable("#name#")>
</cfloop>