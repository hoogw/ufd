

<!--- <HTML>


		<cfset dbsSpatlLoc = "sidewalk_spatial">
	

       	<cfquery name="qSpatialInOut" datasource="#dbsSpatlLoc#" dbtype="ODBC">
       	SELECT REPLACE(column_name, '_QUANTITY', '') 'name' 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = 'vwHDREngineeringEstimate' AND COLUMN_NAME like '%_QUANTITY'
        </cfquery>
		
		<cfset items = arrayNew(1)>
		<cfloop query="qSpatialInOut">
			<cfset arrayAppend(items,name)>
		</cfloop>

		<cfdump var="#items#">

</html> --->

<!--- Get Species List --->
<cfquery name="getSpecies" datasource="treeinventory" dbtype="ODBC">
SELECT DISTINCT common FROM [TreeInventory].[dbo].trees WHERE common is not null ORDER BY common
</cfquery>
<cfset lstSpecies = ValueList(getSpecies.common,""",""")>
<cfdump var="#getSpecies#">