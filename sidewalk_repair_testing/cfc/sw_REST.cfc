<cfcomponent output="false" rest="true" restpath="/requests">

	<cfset dbsSpatlLoc = "sidewalk_spatial">
	
	<cffunction name="getBidItems" access="remote" returnType="any" returnFormat="JSON" produces="application/json" output="false" httpmethod="get" restpath="getBidItems">
		
		<cfheader name="Access-Control-Allow-Origin" value="*">
		
		<cfset var data = {}>

       	<cfquery name="qSpatialInOut" datasource="#dbsSpatlLoc#" dbtype="ODBC">
       	SELECT REPLACE(column_name, '_QUANTITY', '') 'name' 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = 'vwHDREngineeringEstimate' AND COLUMN_NAME like '%_QUANTITY'
        </cfquery>
		
		<cfset items = arrayNew(1)>
		<cfloop query="qSpatialInOut">
			<cfset arrayAppend(items,name)>
		</cfloop>
       
		<cfset data.emp_id = "">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn items>
		
	</cffunction>
	
	<cffunction name="getMethod" access="remote" output="false" returntype="string" httpmethod="get" description="Test">
	  <cfreturn "foo">
	 </cffunction>
	
</cfcomponent>
