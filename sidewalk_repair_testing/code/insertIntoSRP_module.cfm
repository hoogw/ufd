
<!-- Developed by: Nathan Neumann 12/19/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfparam name="attributes.sr_no" default="">				<!--- The passed sr_number (1-382648434) --->

<cfset pDS = "accessprogram">
<cfset sDS = "sidewalk_spatial">
<cfset sTable = "tblSites">
<cfset stTable = "tblTreeSiteInfo">
<cfset seTable = "tblEngineeringEstimate">
<cfset sdTable = "tblEstimateDefaults">
<cfset adTable = "bssEstimateForm">
<cfset aeTable = "BSSEstimate">

<cfset request.srp_insert_success = "Y"> 		<!--- Tells whether the insert was successful (Y/N) --->	
<cfset request.srp_insert_error_message = ""> 	<!--- Message if there's an error --->	

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

	<cfquery name="getSiteInfo" datasource="#pDS#">
	SELECT a.sr_number, a.job_address, a.council_dist, a.zip_cd, a.ddate_submitted, a.bss_assessed_dt, 
	b.first_name + ' ' + b.last_name AS bss_assessed_by, a.dod_loc_comments, a.sr_access_barrier_type, a.sr_access_comments, 
	a.bss_internal_comments, a.ufd_internal_comments, a.spd_internal_comments, 'From ' + a.from_st + ' to ' + a.to_st AS FromTo
	FROM dbo.ar_info AS a LEFT OUTER JOIN dbo.staff AS b ON a.bss_assessed_by = b.user_id
	WHERE a.sr_number = '#attributes.sr_no#'
	</cfquery>
	
	<!--- <cfdump var="#getSiteInfo#"> --->
	
	<cfif getSiteInfo.recordcount gt 0>
		
		 <cfif getSiteInfo.bss_assessed_dt is not "">
		
			<!--- Get Site Number --->
			<cfquery name="getID" datasource="#sDS#" dbtype="ODBC">
			SELECT location_no as id FROM #sTable# WHERE sr_number = '#attributes.sr_no#'
			</cfquery>
			
			<cfif getID.recordcount gt 0>
				<cfset swid = getID.id>
			<cfelse>
				<cfquery name="getNewID" datasource="#sDS#" dbtype="ODBC">
				SELECT max(location_no) as id FROM #sTable#
				</cfquery>
				<cfset swid = getNewID.id + 1> 
				
				<cfquery name="insertSRP" datasource="#sDS#">
				INSERT INTO #sTable# (location_no,sr_number) VALUES (#swid#,'#attributes.sr_no#')		
				</cfquery>
				<cfquery name="insertSRP" datasource="#sDS#">
				INSERT INTO #stTable# (location_no) VALUES (#swid#)		
				</cfquery>
				<cfquery name="insertSRP" datasource="#sDS#">
				INSERT INTO #seTable# (location_no) VALUES (#swid#)		
				</cfquery>
			</cfif>
			
			<cfif getID.recordcount is 0>
				<cfloop query="getSiteInfo">
				
					<cfset srp_damage = "#sr_access_barrier_type# #chr(13)##sr_access_comments#">
					<!--- <cfset srp_name = "Access Request: #job_address# (SRID: #sr_number#)"> --->
					<cfset srp_name = "#job_address# (SRID: #sr_number#)">
					<cfset srp_sidewalk_comments = "#bss_internal_comments#">
					
					<cfif trim(srp_sidewalk_comments) is not "">
						<cfset srp_sidewalk_comments = "BSS Comments: #chr(13)##srp_sidewalk_comments#">
					</cfif>
					<cfif trim(srp_sidewalk_comments) is not "" AND trim(spd_internal_comments) is not "">
						<cfset srp_sidewalk_comments = srp_sidewalk_comments & " #chr(13)##chr(13)#">
					</cfif>
					<cfif trim(spd_internal_comments) is not "">
						<cfset srp_sidewalk_comments = srp_sidewalk_comments & "SPD Comments: #chr(13)##spd_internal_comments#">
					</cfif>
					
					<cfset srp_loc_comments = "#dod_loc_comments#">
					<cfif trim(fromto) is not ""><cfset srp_loc_comments = "#FromTo# #chr(13)##dod_loc_comments#"></cfif>

					<cfset srp_damage = replace(srp_damage,"'","''","ALL")>
					<cfset srp_name = replace(srp_name,"'","''","ALL")>
					<cfset srp_addr = replace(job_address,"'","''","ALL")>
					<cfset srp_assessed_by = replace(bss_assessed_by,"'","''","ALL")>
					<cfset srp_sidewalk_comments = replace(srp_sidewalk_comments,"'","''","ALL")>
					<cfset srp_loc_comments = replace(srp_loc_comments,"'","''","ALL")>
					<cfset srp_tree_comments = replace(ufd_internal_comments,"'","''","ALL")>
					
					<cfset srp_cd = val(council_dist)>
					<cfset srp_zip = val(zip_cd)>
					
					<!--- s: Added Site Information --->
					<cfquery name="updateSRP" datasource="#sDS#">
					UPDATE #sTable# SET
					[Name] = '#preservesinglequotes(srp_name)#',
				    [Address] = '#preservesinglequotes(srp_addr)#',
				    [Type] = 11,
				    [Date_Logged] = #createodbcdatetime(ddate_submitted)#,
				    [Council_District] = #srp_cd#,
				    [Zip_Code] = #zip_cd#,
				    [Field_Assessed] = 1,
				    <cfif trim(srp_assessed_by) is not "">[Field_Assessor] = '#preservesinglequotes(srp_assessed_by)#',</cfif>
				    <cfif trim(bss_assessed_dt) is not "">[Assessed_Date] = '#bss_assessed_dt#',</cfif>
				    <cfif trim(srp_sidewalk_comments) is not "">[Notes] = '#preservesinglequotes(srp_sidewalk_comments)#',</cfif>
				    <cfif trim(srp_loc_comments) is not "">[Location_Description] = '#preservesinglequotes(srp_loc_comments)#',</cfif>
				    <cfif trim(srp_damage) is not "">[Damage_Description] = '#preservesinglequotes(srp_damage)#',</cfif>
				    [Traveled_By_Disabled] = 1,
				    [Complaints_No] = 1,
				    [SR_Number] = '#sr_number#',
				    [Creation_Date] = #createodbcdatetime(now())#,
				    [User_ID] = 22
					WHERE location_no = #swid#
					</cfquery>
					<!--- e: Added Site Information --->
					
					<!--- s: Added Tree Comments --->
					<cfif trim(srp_tree_comments) is not "">
						<cfquery name="updateSRPTrees" datasource="#sDS#">
						UPDATE #stTable# SET
						[TREE_REMOVAL_NOTES] = '#preservesinglequotes(srp_tree_comments)#',
					    [Creation_Date] = #createodbcdatetime(now())#,
					    [User_ID] = 22
						WHERE location_no = #swid#
						</cfquery>
					</cfif>
					<!--- e: Added Tree Comments --->
					
					<!--- s: Update Default Values in Estimate Table --->
					<cfquery name="getFlds" datasource="#sDS#" dbtype="ODBC">
					SELECT fieldname,units,price from #sdTable#
					</cfquery>
					<cfset updt_str = "UPDATE " & seTable & " SET ">
					<cfloop query="getFlds">
						<cfset updt_str = updt_str & "#fieldname#_UNITS = '#units#', #fieldname#_QUANTITY = 0, #fieldname#_UNIT_PRICE = #price#,">
					</cfloop>
					<cfset updt_str = updt_str & " Creation_Date = #createodbcdatetime(now())#, User_ID = 22 WHERE location_no = #swid#">
					<cfquery name="updateEstimates" datasource="#sDS#">
					#preservesinglequotes(updt_str)#
					</cfquery>
					<!--- e: Update Default Values in Estimate Table --->
					
					<!--- s: Update Values from Access Request to Estimate Table --->
					<cfquery name="getFlds" datasource="#pDS#" dbtype="ODBC">
					SELECT fieldname from #adTable# WHERE suspend = 'n'
					</cfquery>
					<cfquery name="getValues" datasource="#pDS#" dbtype="ODBC">
					SELECT * from #aeTable# WHERE sr_number = '#attributes.sr_no#'
					</cfquery>
					<cfif getValues.recordcount gt 0>
						<cfset updt_str = "UPDATE " & seTable & " SET ">
						<cfloop query="getFlds">
							<cfset uVal = evaluate("getValues.#fieldname#_UNITS")>
							<cfset qVal = evaluate("getValues.#fieldname#_QUANTITY")>
							<cfif qVal is ""><cfset qVal = 0></cfif>
							<cfif uVal is not "">
								<cfset updt_str = updt_str & "#fieldname#_UNITS = '#uVal#', ">
							</cfif>
							<cfset updt_str = updt_str & "#fieldname#_QUANTITY = #qVal#, ">
						</cfloop>
						<cfset updt_str = updt_str & " Creation_Date = #createodbcdatetime(now())#, User_ID = 22 WHERE location_no = #swid#">
						<cfquery name="updateEstimates" datasource="#sDS#">
						#preservesinglequotes(updt_str)#
						</cfquery>
						<!--- <cfdump var="#updt_str#"> --->
					</cfif>
					
					<!--- s: Update location_no in Access Program --->
					<cfquery name="getSiteInfo" datasource="#pDS#">
					UPDATE #aeTable# SET
					location_no = #swid#   
					WHERE sr_number = '#attributes.sr_no#'
					</cfquery>
					<!--- e: Update location_no in Access Program --->
					
				</cfloop>
			<cfelse>
				<cfset request.srp_insert_success = "N">
				<cfset request.srp_insert_error_message = "SR Number Already Exists. No Update Applied."> 
			</cfif>
		
		<cfelse>
			<cfset request.srp_insert_success = "N">
			<cfset request.srp_insert_error_message = "No Assessed Date Yet."> 
		</cfif>
	
	</cfif>
	
<cfcatch type="any">
  	<cfset request.srp_insert_success = "N">
	<cfset request.srp_insert_error_message = "Database Error."> 
</cfcatch>

</cftry>
  
<!--- <cfoutput>#request.srp_insert_success#<br></cfoutput>
<cfoutput>#request.srp_insert_error_message#</cfoutput> --->
