

<HTML>


			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRAssessmentTracking' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfset filename = expandPath("./downloads/SidewalkRepairProgram.xls")>
			<cfspreadsheet action="write" query="getFlds" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("AssessmentTracking","no")>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRAssessmentTracking
			</cfquery>
			
			<!--- <cfset spreadsheetCreateSheet(s,"AssessmentTracking")>
			<cfset spreadsheetRemoveSheet(s,"Sheet1")> 
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRWorkOrders' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRWorkOrders
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"WorkOrders")>
			<cfset spreadsheetsetActiveSheet(s,"WorkOrders")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDREngineeringEstimate' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDREngineeringEstimate
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"EngineeringEstimate")>
			<cfset spreadsheetsetActiveSheet(s,"EngineeringEstimate")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRContractorPricing' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRContractorPricing
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ContractorPricing")>
			<cfset spreadsheetsetActiveSheet(s,"ContractorPricing")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRADACurbRamps' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRADACurbRamps
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ADACurbRamps")>
			<cfset spreadsheetsetActiveSheet(s,"ADACurbRamps")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")>
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>



</html>

