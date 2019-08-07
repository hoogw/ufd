
<!-- Developed by: Nathan Neumann 10/26/17 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->


<cfset pDS = "geocoding_spatial">
<cfset sDS = "sidewalk_spatial">
<cfset sTable = "tblSites">
<cfset stTable = "tblTreeSiteInfo">
<cfset seTable = "tblEngineeringEstimate">
<cfset sdTable = "tblEstimateDefaults">
<cfset aeTable = "srp_srr_quantities">

<cftry>

	<cfquery name="getSiteInfo" datasource="#pDS#">
	SELECT 'Rebate - ' + job_address + ' (SRID: ' + sr_number + ')' AS Name, 
	CASE WHEN prop_type = 'R' THEN 27 ELSE 28 END AS Type, 
	job_address as Address,
	council_dist AS Council_District, 
	CASE WHEN CHARINDEX('-', job_address) = 0 THEN NULL ELSE rtrim(ltrim(RIGHT(job_address, LEN(job_address) - CHARINDEX('-', job_address)))) END AS Zip_Code,
	sr_number, ddate_submitted AS Date_Logged, 1 AS Field_Assessed, 
	CASE WHEN bca_assessment_comp_dt IS NOT NULL THEN bca_assessment_comp_dt ELSE bss_assessment_comp_dt END AS Assessed_Date, 
	CASE WHEN bca_action_by IS NOT NULL THEN bca_action_by ELSE bss_action_by END AS Field_Assessor,
	1 AS Repairs_Required, 0 AS Curb_Ramp_Only, bss_comments AS Tree_Removal_Notes, 
	CASE WHEN sr_app_comments = '' THEN '' ELSE sr_app_comments + CHAR(13) END + 
	CASE WHEN sr_location_comments = '' THEN '' ELSE sr_location_comments + CHAR(13) END +
	CASE WHEN bca_comments is null THEN '' ELSE bca_comments + CHAR(13) END +
	CASE WHEN boe_invest_comments is null THEN '' ELSE boe_invest_comments + CHAR(13) END AS Notes
	FROM dbo.srp_srr_info
	WHERE (constCompleted_dt IS NOT NULL)
	</cfquery>
	
	<!--- <cfdump var="#getSiteInfo#"> --->
	
	<cfset cList = getSiteInfo.columnList>
	<cfset cList = replace(cList,"TREE_REMOVAL_NOTES,","","ALL")>
	
	<cfset inStr = "INSERT INTO " & sTable & " (location_no," & cList & ",Creation_Date) ">
	
	<!--- <cfdump var="#inStr#"><br> --->
	
	<cfquery name="getColumns" datasource="#sDS#">
	SELECT upper(column_name) as column_name,data_type FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '#sTable#'
	</cfquery>
	
	<cfloop query="getSiteInfo">
	
		<cfquery name="checkRecords" datasource="#sDS#">
		SELECT count(*) as cnt FROM #sTable# WHERE sr_number = '#getSiteInfo.sr_number#'
		</cfquery>
	
		<cfif checkRecords.cnt is 0> <!--- Check to make sure record doesn't already exist --->
		
			<cfquery name="getNewID" datasource="#sDS#" dbtype="ODBC">
			SELECT max(location_no) as id FROM #sTable#
			</cfquery>
			<cfset swid = getNewID.id + 1> 
		
		
			<cfset valStr = "VALUES (#swid#,">
			<cfloop index="val" list="#cList#" delimiters=",">
				
				<cfquery name="getColumn" dbtype="query">
				SELECT data_type FROM getColumns WHERE column_name = '#val#'
				</cfquery>
				
				<!--- <cfdump var="#getColumn.data_type#"> --->
				
				<cfset dtype = getColumn.data_type>
				
		
				<cfif dtype is "nvarchar">
					<cfset v = evaluate("getSiteInfo.#val#")>
					<cfset v = replace(v,"'","''","ALL")>
					<cfif v is "">
						<cfset valStr = valStr & "NULL,">
					<cfelse>
						<cfset valStr = valStr & "'" & preservesinglequotes(v) & "',">
					</cfif>
				<cfelseif dtype is "datetime">
					<cfif evaluate("getSiteInfo.#val#") is "">
						<cfset valStr = valStr & "NULL,">
					<cfelse>
						<cfset valStr = valStr & createODBCDateTime(evaluate("getSiteInfo.#val#")) & ",">
					</cfif>
				<cfelse>
					<cfif evaluate("getSiteInfo.#val#") is "">
						<cfset valStr = valStr & "NULL,">
					<cfelse>
						<cfset valStr = valStr & evaluate("getSiteInfo.#val#") & ",">
					</cfif>
				</cfif> 
		
			</cfloop>
			
			<cfset valStr = valStr & createODBCDate(Now()) & ")">
			<cfset sqlStr = inStr & valStr>
			
			<!--- <cfdump var="#sqlStr#"><br><br> --->
		
			<cfquery name="insertQRecord" datasource="#sDS#">
			#preservesinglequotes(sqlStr)#
			</cfquery>
			
			<!--- s: Added Tree Comments --->
			<cfquery name="ChkSNO" datasource="#sDS#" dbtype="ODBC">
			SELECT count(*) as cnt FROM #stTable# WHERE location_no = #swid#
			</cfquery>
			<cfif ChkSNO.cnt is 0>
				<cfset trnotes = replace(getSiteInfo.tree_removal_notes,"'","''","ALL")>
				<cfquery name="insertSRP" datasource="#sDS#">
				INSERT INTO #stTable# (location_no,tree_removal_notes,creation_date) VALUES (#swid#,'#preservesinglequotes(trnotes)#',#createODBCDate(Now())#)		
				</cfquery>
			</cfif>
			<!--- e: Added Tree Comments --->
			
			
			<cfquery name="insertSRP" datasource="#sDS#">
			INSERT INTO #seTable# (location_no) VALUES (#swid#)		
			</cfquery>
			
			<!--- s: Update Default Values in Estimate Table --->
			<cfquery name="getFlds" datasource="#sDS#" dbtype="ODBC">
			SELECT fieldname,units,price from #sdTable#
			</cfquery>
			<cfset updt_str = "UPDATE " & seTable & " SET ">
			<cfloop query="getFlds">
				<cfset updt_str = updt_str & "#fieldname#_UNITS = '#units#', #fieldname#_QUANTITY = 0, #fieldname#_UNIT_PRICE = #price#,">
			</cfloop>
			<cfset updt_str = updt_str & " Creation_Date = #createodbcdatetime(now())# WHERE location_no = #swid#">
			<cfquery name="updateEstimates" datasource="#sDS#">
			#preservesinglequotes(updt_str)#
			</cfquery>
			<!--- e: Update Default Values in Estimate Table --->
			
			<cfquery name="getValues" datasource="#pDS#" dbtype="ODBC">
			SELECT * from #aeTable# WHERE sr_number = '#getSiteInfo.sr_number#'
			</cfquery>
			
			<!--- <cfdump var="#getValues#"> --->
			
			<cfloop query="getValues">
				<cfset remove_sw = SIDEWALK_QTY + SIDEWALK_TRANS_QTY>
				<cfset remove_dr = DRIVEWAY_QTY + PARTIAL_DWY_CONC_QTY>
				<cfset add_sw_dr = SIDEWALK_QTY + DRIVEWAY_QTY + SIDEWALK_TRANS_QTY + PARTIAL_DWY_CONC_QTY>
				<cfset remove_cb = CONC_CURB_QTY>
				<cfset add_cb = CONC_CURB_QTY>
				<cfset gutter = CONC_GUTTER_QTY> <!--- *** --->
				<cfset curb_ramp = ACCESS_RAMP_QTY>
				<cfset pkwy_drain = PKWY_DRAIN_QTY>
				<cfset pullbox = PULLBOX_NO> <!--- *** --->
				<cfset signage = SIGNAGE_NO>
				<cfset furniture = ST_FURN_NO> <!--- *** --->
				<cfset meters = PARKING_METER_NO>
				<cfset cb_cover = CATCH_BASIN_LID_QTY> <!--- *** --->
				<cfset monuments = SURVEY_MONUMENT_NO> <!--- *** --->
				<cfset root_pruned = NBR_TREES_PRUNED>
				<cfset tree_removal = NBR_TREES_REMOVED>
				<cfset stump_removal = NBR_STUMPS_REMOVED>
				<cfset tree_onsite = NBR_TREES_ONSITE><cfif tree_onsite lt 0><cfset tree_onsite = 0></cfif>
				<cfset tree_offsite = NBR_TREES_OFFSITE><cfif tree_offsite lt 0><cfset tree_offsite = 0></cfif>
				<cfset tree_plantings = tree_onsite + tree_offsite>
				
				
				<!--- s: Added Engineering Estimate Information --->
				<cfquery name="updateSRP" datasource="#sDS#">
				UPDATE #seTable# SET
				
				[REMOVE_SIDEWALK_QUANTITY] = #remove_sw#,
				[REMOVE_DRIVEWAY_QUANTITY] = #remove_dr#,
				[FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY] = #add_sw_dr#,
				[REMOVE_CURB_QUANTITY] = #remove_cb#,
				[CONCRETE_CURB_QUANTITY] = #add_cb#,
				[CURB_RAMP__ADA_COMPLIANT___QUANTITY] = #curb_ramp#,
				[PARKWAY_CULVERT_SIDEWALK_DRAIN_QUANTITY] = #pkwy_drain#,
				[STREET_SIGN__REMOVE_AND_REINSTALL___QUANTITY] = #signage#,
				[PARKING_METER__REMOVE_AND_REINSTALL___QUANTITY] = #meters#,
				[TREE_ROOT_PRUNING_l_SHAVING__PER_TREE___QUANTITY] = #root_pruned#,
				[TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY] = #tree_removal#,
				[EXISTING_STUMP_REMOVAL_QUANTITY] = #stump_removal#,
				[FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY] = #tree_plantings#,
				
				<cfset cnt = 1>
				<cfif gutter gt 0>
					[EXTRA_FIELD_#cnt#_NAME] = 'Gutter (Remove and Replace)',
					[EXTRA_FIELD_#cnt#_UNITS] = 'LF',
					[EXTRA_FIELD_#cnt#_QUANTITY] = #gutter#,
					<cfset cnt = cnt + 1>
				</cfif>
				<cfif pullbox gt 0>
					[EXTRA_FIELD_#cnt#_NAME] = 'Pullbox(es)',
					[EXTRA_FIELD_#cnt#_UNITS] = 'EA',
					[EXTRA_FIELD_#cnt#_QUANTITY] = #pullbox#,
					<cfset cnt = cnt + 1>
				</cfif>
				<cfif furniture gt 0>
					[EXTRA_FIELD_#cnt#_NAME] = 'Street Furniture',
					[EXTRA_FIELD_#cnt#_UNITS] = 'EA',
					[EXTRA_FIELD_#cnt#_QUANTITY] = #furniture#,
					<cfset cnt = cnt + 1>
				</cfif>
				<cfif cb_cover gt 0>
					[EXTRA_FIELD_#cnt#_NAME] = 'Catch Basin Conc. Cover (Remove and Replace)',
					[EXTRA_FIELD_#cnt#_UNITS] = 'EA',
					[EXTRA_FIELD_#cnt#_QUANTITY] = #cb_cover#,
					<cfset cnt = cnt + 1>
				</cfif>
				<cfif monuments gt 0>
					[EXTRA_FIELD_#cnt#_NAME] = 'Survey Monuments',
					[EXTRA_FIELD_#cnt#_UNITS] = 'EA',
					[EXTRA_FIELD_#cnt#_QUANTITY] = #monuments#,
					<cfset cnt = cnt + 1>
				</cfif>
	
			    [Creation_Date] = #createodbcdatetime(now())#
			    <!--- [User_ID] = 22 --->
				WHERE location_no = #swid#
				</cfquery>
				<!--- e: Added Engineering Estimate Information --->
				
			</cfloop>
			
			<cfmodule template="updateTreeList_module.cfm" sr_no="#getSiteInfo.sr_number#">

		</cfif>
		
	</cfloop>
	
	<h4>Process Successful</h4>

<cfcatch type="any">
		<h4>An unknown error occured.  An email notification has been sent out to nathan.neumann@lacity.org</h4>
	<!--- Send an email on application errors. --->
	<cfmail to="nathan.neumann@lacity.org" from="srp@lacity.org" type="html"
					subject="SRP - #cgi.http_host# - ERROR">
	  <table border="1" cellpadding="0">
	   <tr>
				<td>Comments</td>
				<td>
					This error was generated from the try/catch.
				</td>
			</tr>
	   <tr>
	     <td>Template</td>
	     <td>#CGI.SERVER_NAME##CGI.SCRIPT_NAME#</td>
	   </tr>
	   <tr>
	    	<td>Date/Time</td>
	   		<td>#DateFormat(now(),"mm/dd/yyyy")#/#TimeFormat(now(),"HH:mm:ss")#</td>
	 		</tr>
			<tr>
	      <td>CFCatch</td>
	      <td><cfdump var="#cfcatch#" label="CFCatch"></td>
	    </tr>
	    <tr>
	      <td>CGI Scope</td>
	      <td><cfdump var="#CGI#" label="CGI Scope"></td>
	    </tr>
			<tr>
				<td>Local variables</td>
				<td><cfdump var="#variables#" label="Local variables"></td>
			</tr>
	  </table>
	</cfmail>
</cfcatch>

</cftry>

