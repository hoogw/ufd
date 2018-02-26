<cfcomponent output="false">

	<cffunction name="ajax_server" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="user" required="true">
		
		<cfset var data = {}>
	
		<cfset data.user = user>
        <cfset data.pass = "xxxx pass word">	

		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
</cfcomponent>
