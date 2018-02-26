<cfcomponent output="false">

	<cffunction name="lookup_program_type" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="program_id" required="true">
		
        
        
        <cfquery name="program_type" datasource="UFD_Inventory" dbtype="ODBC">
		    Select 
	
			*
			
			from tbl_program_type
	 		
            where id = #program_id# 
            
            
		</cfquery>
        
        
        
        
		<cfset var data = {}>
	
		<cfset data.id = #program_id#>
        
        <cfloop query="program_type">
    		
             <cfset data.name = program_type.name>
		</cfloop>
        
       	

		<cfset data = serializeJSON(data)>
		
	   
	    
	    <cfreturn data>
		
	</cffunction>
	
</cfcomponent>
