<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- <cfif isdefined("Update") is false>
<script language="JavaScript">
location.replace("updateBSSramps.cfm?Update=1&RequestTimeout=500000")
</script>
<cfabort>
</cfif> --->

<font size="2">






<cfset ds = "sidewalk_spatial_105">
<cfset frm_tbl = "tblTreeList">
<cfset to_tbl = "tblGeocodingTrees">

<!--- START UPDATE BUSINESSES LIST RECORDS ******************************************************************* --->

<!--- Get the initial deltas --->
<cfquery name="getDeltas" datasource="#ds#" dbtype="ODBC">
SELECT 'TREES' AS LAYER_NAME, b.ID, a.creationdate as CRDT, a.lastmodifieddate as MDDT, 'A' AS EDIT_TYPE
FROM tblGeocodingTrees AS a INNER JOIN tblTreeList AS b ON a.TREE_ID = b.ID
WHERE ((CASE WHEN a.creationdate IS NULL THEN CAST('01-01-1900' AS DATETIME) ELSE a.creationdate END) <> (CASE WHEN b.Creation_Date IS NULL 
THEN CAST('01-01-1900' AS DATETIME) ELSE b.Creation_Date END)) OR
((CASE WHEN a.lastmodifieddate IS NULL THEN CAST('01-01-1900' AS DATETIME) ELSE a.lastmodifieddate END) <> (CASE WHEN b.Modified_Date IS NULL 
THEN CAST('01-01-1900' AS DATETIME) ELSE b.Modified_Date END))
UNION ALL
SELECT 'TREES' AS layer_name, a.ID, a.Creation_Date as CRDT, a.Modified_Date as MDDT, 'A' AS edit_type
FROM tblTreeList AS a LEFT OUTER JOIN tblGeocodingTrees AS b ON a.ID = b.TREE_ID
WHERE (b.TREE_ID IS NULL and a.deleted <> 1)
UNION ALL
SELECT 'TREES' AS layer_name, a.tree_ID as ID, a.creationdate as CRDT, a.lastmodifieddate as MDDT, 'D' AS edit_type
FROM tblGeocodingTrees AS a LEFT OUTER JOIN tblTreeList AS b ON a.tree_ID = b.ID WHERE (b.ID IS NULL OR b.DELETED = 1)
</cfquery>

<cfquery name="getDeletes" dbtype="query">
SELECT * FROM getDeltas WHERE edit_type = 'D'
</cfquery>

<!--- Delete Records that have been removed --->
<cfquery name="getDeletes" dbtype="query">
SELECT id FROM getDeltas WHERE edit_type = 'D'
</cfquery>
<cfloop query="getDeletes">
	<cfquery name="getDeletes" datasource="#ds#" dbtype="ODBC">
	DELETE FROM #to_tbl# WHERE tree_id = #id#
	</cfquery>
</cfloop>


<!--- Add Records that have been added or modified --->
<cfset ids = ValueList(getDeltas.id)>
<cfquery name="getRecords" datasource="#ds#" dbtype="ODBC">
SELECT id,species,creation_date,modified_date,tree_removal_date,tree_planting_date,action_type FROM #frm_tbl# WHERE id IN (#ids#) AND deleted <> 1 ORDER BY id
</cfquery>

<!--- OLD Query - Gets all records --->
<!--- <cfquery name="getRecords" datasource="#ds#" dbtype="ODBC">
SELECT id,species,creation_date,modified_date,tree_removal_date,tree_planting_date,action_type FROM #frm_tbl# WHERE deleted <> 1 ORDER BY id
</cfquery> --->

<cfset strt = Now()>



<cfloop query="getRecords">

	<!--- <cftry> --->
	
		<cfset data = structNew()>
		<cfset data.treeid = getRecords.id>
		<cfset data.species = trim(getRecords.species)>
		<cfset data.action = getRecords.action_type>
		<cfset data.crdt = "NULL"><cfif getRecords.creation_date is not ""><cfset data.crdt = createODBCDateTime(getRecords.creation_date)></cfif>
		<cfset data.mddt = "NULL"><cfif getRecords.modified_date is not ""><cfset data.mddt = createODBCDateTime(getRecords.modified_date)></cfif>
		<cfset data.trdt = "NULL"><cfif getRecords.tree_removal_date is not ""><cfset data.trdt = createODBCDateTime(getRecords.tree_removal_date)></cfif>
		<cfset data.tpdt = "NULL"><cfif getRecords.tree_planting_date is not ""><cfset data.tpdt = createODBCDateTime(getRecords.tree_planting_date)></cfif>
		<cfset data.addr = "">
		<cfset data.x = "NULL">
		<cfset data.y = "NULL">
		<cfset data.lat = "NULL">
		<cfset data.lon = "NULL">
		<cfset data.shp = "NULL">
	
		<cfquery name="getAddress" datasource="#ds#" dbtype="ODBC">
		SELECT address FROM #frm_tbl# WHERE id = #id#
		</cfquery>
		<cfset loc = getAddress.address>
		<cfset idx = find("#chr(35)#",loc,1)>
		<cfif idx gt 0><cfset loc = left(loc,idx-1)></cfif>
		
		<cfset cut = "">
		<cfset idx1 = find("(",loc,1)>
		<cfset idx2 = find(")",loc,1)>
		<cfif idx1 gt 0 AND idx2 gt 0><cfset cut = mid(loc,idx1,1+(idx2-idx1))> </cfif>
		<cfset loc = replace(loc,cut,"","ALL")>
		
		<cfset cut = "">
		<cfset idx1 = find("ON ",ucase(loc),1)>
		<cfset idx2 = find("SIDE",ucase(loc),1)>
		<cfif idx1 gt 0 AND idx2 gt 0><cfset cut = mid(loc,idx1,4+(idx2-idx1))> </cfif>
		<cfset loc = replace(loc,cut,"","ALL")>
		
		<cfset cut = "">
		<cfset idx1 = find("ON ",ucase(loc),1)>
		<cfset idx2 = find("SD",ucase(loc),1)>
		<cfif idx1 gt 0 AND idx2 gt 0><cfset cut = mid(loc,idx1,2+(idx2-idx1))> </cfif>
		<cfset loc = replace(loc,cut,"","ALL")>
		
		
		<cfset cut = "">
		<cfset arrLoc = listToArray(loc," ")>
		<cfif arrayLen(arrLoc) gt 3>
			<cfset num1 = arrLoc[1]>
			<cfset hyp = arrLoc[2]>
			<cfset num2 = arrLoc[3]>
			<cfif hyp is "-">
				<cfset cut = hyp & " " & num2>
			</cfif>
			
			<cfset idx = find("-",num1,1)>
			<cfif idx gt 0><cfset cut = right(num1,len(num1)-(idx-1))></cfif>
			
		</cfif>
		<cfset loc = replace(loc,cut,"","ALL")>
		
		<cfset loc = replace(loc,"7887 W. Rosewood Ave., Los Angeles, CA 90048","7887 W. Rosewood Ave","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"La High Memorial Park,","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"SUB POSITION","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"on White Oak Av.","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"Los Angeles, CA","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"Los Angeles, Ca","","ALL")> <!--- Case Specific --->
		
		
		<cfset loc = replace(loc,"APARTMENT","","ALL")>
		<cfset loc = replace(loc,"UNIT","","ALL")>
		<cfset loc = replace(loc,"SUITE","","ALL")>
		<cfset loc = replace(loc,"SPACE","","ALL")>
		
		<cfset loc = ucase(loc)>
		<cfset loc = replace(loc,"LEEWARD AVE,  90057","LEEWARD AVE, 90005","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"201 W 107TH ST 90061","201 W 107TH ST 90003","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"CESAR CHAVEZ","CESAR E CHAVEZ","ALL")>
		<cfset loc = replace(loc,"LOS ANGELES","","ALL")>
		<cfset loc = replace(loc,"PLAYA DEL REY, CA","","ALL")>
		<cfset loc = replace(loc,"HONDURAS ST SD","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"ON 115 ST","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"SE CORNER OF","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"ACROSS FROM","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"ACROSS","","ALL")> <!--- Case Specific --->
		<cfset loc = replace(loc,"CURB MARKED ORANGE DOT","","ALL")> <!--- Case Specific --->
		
		
		<!--- <cfset loc = replace(loc,"&","/","ALL")> ---> <!--- Case Specific --->
		
		<cfset loc = trim(loc)>
		
		<cfdump var="#id# - #loc#"><br>
		<cfflush interval=10>
		
		<cfif loc is not "">
		
			<cfhttp url="https://navigatela.lacity.org/rest/geocoders/geoQuery_MyLA/addressValidationService" method="post" result="rAddrs" timeout="240">
				<cfhttpparam type = "header" name = "Content-Type" value = "application/json">
				<cfhttpparam type="formfield" name="AddressSearch" value="#loc#" encoded="no"> 
			</cfhttp>
			
			<cfset addresses = deserializeJSON(rAddrs.filecontent)>
			
			<!--- <cfdump var="#addresses#"> --->
			
			<cfset cont = true>
			<cfif isdefined("addresses.COMMENTS")>
				
				<cfif addresses.COMMENTS is "Invalid Address" Or addresses.COMMENTS is "Nothing Found">
			
					<cfset cont = false>
					<cfoutput>
					<cfsavecontent variable="addressRequestXML">
						<?xml version="1.0" encoding="UTF-8"?>
						<Address-Request>
							<qWhat>addr_int</qWhat> <!---address/int or geocode --->
							<status>new</status>
							<coordinates></coordinates>
						  	<address-geocode>#loc#</address-geocode>
							<layers>
								<layer>
									<name>merge</name>
									<fields>
										<field>district</field>
					                    <field>day</field>
					                    <field>area</field>
					                    <field>shortday</field>
									</fields>
								</layer>
							</layers>
						</Address-Request>
					</cfsavecontent> 
					</cfoutput>
					
					<cfinvoke returnvariable="strResponse" webservice="https://navigatela.lacity.org/cfc/geocode_services/geoQuery_MyLA.cfc?wsdl" method="addressValidationService" proxyserver="bcproxy.ci.la.ca.us" proxyport="8080">
		    			<cfinvokeargument name="addressSearch" value="#Trim(addressRequestXML)#" />
					</cfinvoke>
					
					<cfset thexml = xmlparse(trim(strResponse))>
					<!--- <cfdump var="#thexml#"> --->
					
					<cfset v = XmlSearch(thexml, "/Address-Response/status")>
					<cfset status = v[1].xmlText>
					
					<!--- <cfdump var="#status#"> --->
					<cfif status is not "error">
					
						<cfif status is "exactMatch">
							<cfset locs = XmlSearch(thexml, "/Address-Response/location")>
							
							<cfset loc1 = locs[1].XmlChildren>
							<cfset v = loc1[1].xmlText>
							<cfset data.addr = trim(v)>	
							<cfset coords = XmlSearch(thexml, "/Address-Response/coords")>
							<cfset xys = coords[1].XmlChildren>
							<cfset data.x = xys[1].xmlText>
							<cfset data.y = xys[2].xmlText>
							<cfset data.lon = xys[3].xmlText>
							<cfset data.lat = xys[4].xmlText>
							<cfset data.shp = "geometry::STPointFromText('POINT (#data.x# #data.y#)', 2229)">
							
						<cfelse>
							<cfset locs = XmlSearch(thexml, "/Address-Response/locations/location")>
							<cfset loc1 = locs[1].XmlChildren>
							<cfset v = loc1[1].xmlText>
							<cfset data.addr = trim(v)>	
							<cfset xys = loc1[8].XmlChildren>
							<cfset data.x = xys[1].xmlText>
							<cfset data.y = xys[2].xmlText>
							<cfset data.lon = xys[3].xmlText>
							<cfset data.lat = xys[4].xmlText>
							<cfset data.shp = "geometry::STPointFromText('POINT (#data.x# #data.y#)', 2229)">
						</cfif>
							
						<!--- <cfdump var="#data#"> --->
						
					</cfif>
					
					<!--- <font color="red"><cfdump var="#data.addr#"><br></font> --->
			
				</cfif>
			</cfif>

			<cfif cont>
			
				<!--- <cfdump var="#addresses#"> --->
				
				<cfif addresses.status is not "No Match">
					<cfif addresses.type is not "Intersection">
						<cfset data.addr = trim(replace(addresses.locations[1].address,"'","''","ALL"))>
						<cfset data.hseid = addresses.locations[1].address_elements.hse_id>
					<cfelse>
						<cfset data.addr = replace(addresses.locations[1].address,"'","''","ALL")>
					</cfif>
					<cfset data.x = addresses.locations[1].coordinates.x>
					<cfset data.y = addresses.locations[1].coordinates.y>
					<cfset data.lat = addresses.locations[1].coordinates.latitude>
					<cfset data.lon = addresses.locations[1].coordinates.longitude>
					<cfset data.shp = "geometry::STPointFromText('POINT (#data.x# #data.y#)', 2229)">
					
				</cfif>
				<!--- <cfif data.hseid is ""><cfset data.hseid = "NULL"></cfif> --->
				
				<!--- <cfdump var="#data#"> --->
				
				<!--- <font color="red"><cfdump var="#data.addr#"><br></font> --->
			
			</cfif>
		
		</cfif>
		
		<!--- <cfdump var="#data#"> --->
		
		<font color="red"><cfdump var="#data.addr#"><br></font>
		
		<cfif data.addr is not "">
		
			<!--- Check if the id exists in the table --->
			<cfquery name="chkTable" datasource="#ds#" dbtype="ODBC">
			SELECT count(*) as cnt FROM #to_tbl# WHERE tree_id = #data.treeid#
			</cfquery>
			
			<cfif chkTable.cnt is 0>
				<cfquery name="updateTable" datasource="#ds#" dbtype="ODBC">
				INSERT INTO #to_tbl# (tree_id) VALUES (#data.treeid#)
				</cfquery>
			</cfif> 
		
			<cfquery name="updateTable" datasource="#ds#" dbtype="ODBC">
			UPDATE #to_tbl# SET
			[Geocoded_Address] = '#preservesinglequotes(data.addr)#',
			[Species] = '#preservesinglequotes(data.species)#',
			[LAT] = #data.lat#,
			[LON] = #data.lon#,
			[X] = #data.x#,
		    [Y] = #data.y#,
			[Tree_Removal_Date] = #data.trdt#,
			[Tree_Planting_Date] = #data.tpdt#,
		    [CreationDate] = #data.crdt#,
			[LastModifiedDate] = #data.mddt#,
			[Action_Type] = #data.action#,
		    [Shape] = #preservesinglequotes(data.shp)#
			WHERE tree_id = #data.treeid#
			</cfquery>
			
		</cfif>
		
		
		
<!--- 	<cfcatch>
		<script language="JavaScript">
		location.replace("updateActiveBusinessesList.cfm?RequestTimeout=60000000");
		</script>
		<cfabort>
	</cfcatch>
	</cftry> --->

</cfloop>

<!--- START BUILD INDEXES (all) ******************************************************************* --->
<cfquery name="rebuildIndexes" datasource="#ds#" dbtype="ODBC">
ALTER INDEX all ON #to_tbl# REBUILD
</cfquery>
<!--- END BUILD INDEXES (all) ******************************************************************* --->

	
<cfset end = Now()>

<cfoutput>
#datediff("n", strt, end)# Minutes #datediff("s", strt, end)-(60*datediff("n", strt, end))# Seconds<br><br>
Start: #strt#<br>
End: #end#
</cfoutput>


<!--- END UPDATE BUSINESSES LIST RECORDS ******************************************************************* --->









<cfoutput><br>Finished</cfoutput>
</font>
</body>
</html>
