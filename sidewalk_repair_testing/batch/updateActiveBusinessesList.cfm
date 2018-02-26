<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- <cfif isdefined("Update") is false>
<script language="JavaScript">
location.replace("updateBSSramps.cfm?Update=1&RequestTimeout=500000")
</script>
<cfabort>
</cfif> --->

<font size="2">

<cfset ds = "navla_spatial">
<cfset frm_tbl = "ags_businesses">
<cfset to_tbl = "ags_businesses_boe_geocoded">

<!--- START UPDATE BUSINESSES LIST RECORDS ******************************************************************* --->


<cfquery name="getRecords" datasource="#ds#" dbtype="ODBC">
SELECT id FROM #to_tbl# WHERE updated is null AND id <= 500000 ORDER BY id
</cfquery>

<!--- <cfoutput>#getRecords.recordcount#</cfoutput> --->

<cfset strt = Now()>

<cfloop query="getRecords">

	<cftry>
	
		<cfquery name="getAddress" datasource="#ds#" dbtype="ODBC">
		SELECT street_address, zip_code FROM #frm_tbl# WHERE id = #id#
		</cfquery>
		<cfset loc = getAddress.street_address>
		<cfset idx = find("#chr(35)#",loc,1)>
		<cfif idx gt 0><cfset loc = left(loc,idx-1)></cfif>
		<cfset loc = replace(loc,"APARTMENT","","ALL")>
		<cfset loc = replace(loc,"UNIT","","ALL")>
		<cfset loc = replace(loc,"SUITE","","ALL")>
		<cfset loc = replace(loc,"SPACE","","ALL")>
		<cfset zip = getAddress.zip_code>
		<cfset idx = find("-",zip,1)>
		<cfif idx gt 1><cfset zip = left(zip,idx-1)></cfif>
		<cfset loc = trim(loc) & ", " & zip>
	
		<cfdump var="#id# - #loc#"><br>
		<cfflush interval=10>
		
		<cfhttp url="https://navigatela.lacity.org/rest/geocoders/geoQuery_MyLA/addressValidationService" method="post" result="rAddrs" timeout="240">
			<cfhttpparam type = "header" name = "Content-Type" value = "application/json">
			<cfhttpparam type="formfield" name="AddressSearch" value="#loc#" encoded="no"> 
		</cfhttp>
		
		<cfset addresses = deserializeJSON(rAddrs.filecontent)>
		
		<!--- <cfdump var="#addresses#"> --->
		
		<cfset data = structNew()>
		
		<cfset data.addr = "">
		<cfset data.x = "NULL">
		<cfset data.y = "NULL">
		<cfset data.lat = "NULL">
		<cfset data.lon = "NULL">
		<cfset data.shp = "NULL">
		<cfset data.hseid = "">
		<cfset data.status = addresses.status>
		<cfif addresses.status is not "No Match">
			
			<cfset data.addr = replace(addresses.locations[1].address,"'","''","ALL")>
			<cfset data.hseid = addresses.locations[1].address_elements.hse_id>
			<cfset data.x = addresses.locations[1].coordinates.x>
			<cfset data.y = addresses.locations[1].coordinates.y>
			<cfset data.lat = addresses.locations[1].coordinates.latitude>
			<cfset data.lon = addresses.locations[1].coordinates.longitude>
			<cfset data.shp = "geometry::STPointFromText('POINT (#data.x# #data.y#)', 2229)">
			
		</cfif>
		<cfif data.hseid is ""><cfset data.hseid = "NULL"></cfif>
		
		<!--- <cfdump var="#data#"> --->
		
		<cfquery name="updateTable" datasource="#ds#" dbtype="ODBC">
		UPDATE #to_tbl# SET
		[Geocoded_Address] = '#preservesinglequotes(data.addr)#',
		[LAT] = #data.lat#,
		[LON] = #data.lon#,
		[X] = #data.x#,
	    [Y] = #data.y#,
	    [STATUS] = '#data.status#',
	    [HSE_ID] = #data.hseid#,
	    [Updated] = 1,
	    [Shape] = #preservesinglequotes(data.shp)#
		WHERE id = #id#
		</cfquery>
		
	<cfcatch>
		<script language="JavaScript">
		location.replace("updateActiveBusinessesList.cfm?RequestTimeout=60000000");
		</script>
		<cfabort>
	</cfcatch>
	</cftry>

</cfloop>
	
<cfset end = Now()>

<cfoutput>
#datediff("n", strt, end)# Minutes #datediff("s", strt, end)-(60*datediff("n", strt, end))# Seconds<br><br>
Start: #strt#<br>
End: #end#
</cfoutput>


<!--- END UPDATE BUSINESSES LIST RECORDS ******************************************************************* --->






<!--- START BUILD INDEXES (all) ******************************************************************* --->

<!--- <cfquery name="rebuildIndexes" datasource="navla_spatial" dbtype="ODBC">
ALTER INDEX all ON dbo.smd_anno REBUILD
</cfquery>

<cfquery name="rebuildIndexes" datasource="navla_spatial" dbtype="ODBC">
ALTER INDEX all ON dbo.sewer_indexes REBUILD
</cfquery> --->

<!--- END BUILD INDEXES (all) ******************************************************************* --->


<cfoutput><br>Finished</cfoutput>
</font>
</body>
</html>
