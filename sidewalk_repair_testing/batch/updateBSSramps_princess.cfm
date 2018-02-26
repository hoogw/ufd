<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfif isdefined("Update") is false>
<script language="JavaScript">
location.replace("updateBSSramps.cfm?Update=1&RequestTimeout=500000")
</script>
<cfabort>
</cfif>

<font size="2">

<!--- START UPDATE RAMP RECORDS ******************************************************************* --->

<cfset ds = "sidewalk">
<cfset ds_bss = "BSS_accessramps">

<cfset start_dt = "{d '2016-07-01'}">
<!--- <cfset end_dt = "{d '2017-06-30'}"> --->

<!--- <cfquery name="getRamps" datasource="BSS_accessramps" dbtype="ODBC">
SELECT * FROM [accessramp].[dbo].[Accessramp]
WHERE date_submitted between {d '2016-07-01'} and {d '2017-06-30'}  AND 
( ne_date_completed between {d '2016-07-01'} and {d '2017-06-30'} OR
nw_date_completed between {d '2016-07-01'} and {d '2017-06-30'} OR
sw_date_completed between {d '2016-07-01'} and {d '2017-06-30'} OR
se_date_completed between {d '2016-07-01'} and {d '2017-06-30'} 	OR
mid_block_alley_date_completed between {d '2016-07-01'} and {d '2017-06-30'} ) AND
( accessramp.ramp_fund = 'Meas. R' or accessramp.ramp_fund = 'DOD')	
</cfquery> --->

<cfquery name="getRamps" datasource="#ds_bss#" dbtype="ODBC">
SELECT * FROM [accessramp].[dbo].[Accessramp]
WHERE date_submitted >= #start_dt# AND 
( ne_date_completed >= #start_dt# OR
nw_date_completed >= #start_dt# OR
sw_date_completed >= #start_dt# OR
se_date_completed >= #start_dt# OR
mid_block_alley_date_completed >= #start_dt#) AND
( accessramp.ramp_fund = 'Meas. R' or accessramp.ramp_fund = 'DOD')	
</cfquery>

<!--- <cfdump var="#getRamps#"> --->

<cfoutput>Total Record Count: #getRamps.recordcount#<br></cfoutput>
<!--- 
<cfabort> --->

<cfset cnt = 0>
<cfset cnt2 = 0>
<cfloop query="getRamps">
	<cfset cnt = cnt + ne_quantity_constructed + nw_quantity_constructed + se_quantity_constructed + sw_quantity_constructed + mid_block_alley_quantity_constructed>
	
	<cfset bss_workid = accessramp_id>
	<cfset notes = "BSS Work Order No: " & work_order_no>
	<cfset notes_cr = "BSS Access Ramp ID: " & accessramp_street_id>
	<cfset facility = street_intersection & " & " & street2><cfset facility = replace(facility,"'","''","ALL")>
	<cfset address = street_intersection & " & " & street2><cfset address = replace(address,"'","''","ALL")>
	<cfset pstreet = street_intersection><cfset pstreet = replace(pstreet,"'","''","ALL")>
	<cfset sstreet = street2><cfset sstreet = replace(sstreet,"'","''","ALL")>
	<cfset type = 25> <!--- Measure R - Program Access Improvement --->
	<cfset type_cr = 5> <!--- Measure R --->
	<cfset cd = council_district>
	
	<cfquery name="getRamps" datasource="#ds#" dbtype="ODBC">
	SELECT count(*) as chk FROM tblSites
	WHERE bss_work_id = #bss_workid#
	</cfquery>
	
	<!--- Add the record to tblSites --->
	<cfif getRamps.chk is 0>
	
		<cfquery name="getLocNo" datasource="#ds#" dbtype="ODBC">
		SELECT max(location_no) as loc_no FROM tblSites
		</cfquery>
		<cfset lno = getLocNo.loc_no + 1>
	
		<cfquery name="insertSite" datasource="#ds#" dbtype="ODBC">
		INSERT INTO tblSites (
		[Location_No],
		[Name],
		[Address],
		[Type],
		[Notes],
		[Council_District],
		[BSS_Work_ID])
		VALUES (
		#lno#,
		'#preservesinglequotes(facility)#',
		'#preservesinglequotes(address)#',
		#type#,
		'#notes#',
		#cd#,
		#bss_workid#)
		</cfquery>
	
	</cfif> 
	
	<!--- Get New or Existing Location No for BSS Work ID --->
	<cfquery name="getLocNo" datasource="#ds#" dbtype="ODBC">
	SELECT location_no FROM tblSites WHERE bss_work_id = #bss_workid#
	</cfquery>
	
	<cfset lno = getLocNo.location_no>
	
	<!--- Check each curb ramp --->
	<cfset arrDir = arrayNew(1)>
	<cfset arrCnt = arrayNew(1)>
	<cfset arrDate = arrayNew(1)>
	<cfif ne_quantity_constructed gt 0 AND ne_date_completed is not "">	
		<!--- Do a second check --->
		<cfquery name="doubleChk" datasource="#ds_bss#" dbtype="ODBC">
		SELECT count(*) as rec_cnt FROM accessramp WHERE accessramp_id = #bss_workid# AND ne_date_completed >= #start_dt#
		</cfquery>
		<cfif doubleChk.rec_cnt gt 0>
			<cfset go = arrayAppend(arrDir,"NE")><cfset go = arrayAppend(arrCnt,ne_quantity_constructed)><cfset go = arrayAppend(arrDate,"ne_date_completed")>
		</cfif>
	</cfif>
	<cfif nw_quantity_constructed gt 0 AND nw_date_completed is not "">
		<!--- Do a second check --->
		<cfquery name="doubleChk" datasource="#ds_bss#" dbtype="ODBC">
		SELECT count(*) as rec_cnt FROM accessramp WHERE accessramp_id = #bss_workid# AND nw_date_completed >= #start_dt#
		</cfquery>
		<cfif doubleChk.rec_cnt gt 0>
			<cfset go = arrayAppend(arrDir,"NW")><cfset go = arrayAppend(arrCnt,nw_quantity_constructed)><cfset go = arrayAppend(arrDate,"nw_date_completed")>
		</cfif>
	</cfif>
	<cfif se_quantity_constructed gt 0 AND se_date_completed is not "">
		<!--- Do a second check --->
		<cfquery name="doubleChk" datasource="#ds_bss#" dbtype="ODBC">
		SELECT count(*) as rec_cnt FROM accessramp WHERE accessramp_id = #bss_workid# AND se_date_completed >= #start_dt#
		</cfquery>
		<cfif doubleChk.rec_cnt gt 0>
			<cfset go = arrayAppend(arrDir,"SE")><cfset go = arrayAppend(arrCnt,se_quantity_constructed)><cfset go = arrayAppend(arrDate,"se_date_completed")>
		</cfif>
	</cfif>
	<cfif sw_quantity_constructed gt 0 AND sw_date_completed is not "">
		<!--- Do a second check --->
		<cfquery name="doubleChk" datasource="#ds_bss#" dbtype="ODBC">
		SELECT count(*) as rec_cnt FROM accessramp WHERE accessramp_id = #bss_workid# AND sw_date_completed >= #start_dt#
		</cfquery>
		<cfif doubleChk.rec_cnt gt 0>
			<cfset go = arrayAppend(arrDir,"SW")><cfset go = arrayAppend(arrCnt,sw_quantity_constructed)><cfset go = arrayAppend(arrDate,"sw_date_completed")>
		</cfif>
	</cfif>
	<cfif mid_block_alley_quantity_constructed gt 0 AND mid_block_alley_date_completed is not "">
		<!--- Do a second check --->
		<cfquery name="doubleChk" datasource="#ds_bss#" dbtype="ODBC">
		SELECT count(*) as rec_cnt FROM accessramp WHERE accessramp_id = #bss_workid# AND mid_block_alley_date_completed >= #start_dt#
		</cfquery>
		<cfif doubleChk.rec_cnt gt 0>
			<cfset go = arrayAppend(arrDir,"")><cfset go = arrayAppend(arrCnt,mid_block_alley_quantity_constructed)><cfset go = arrayAppend(arrDate,"mid_block_alley_date_completed")>
		</cfif>
	</cfif>
	
	<cfif arrayLen(arrDir) gt 0>
		<cfset cdt = "">
		<cfloop index="i" from="1" to="#arrayLen(arrDir)#">
			
			<!--- Check if it exists --->
			<cfset v = "= '" & arrDir[i] & "'">
			<cfif arrDir[i] is ""><cfset v = "IS NULL"></cfif>
			
			<cfset dt = evaluate("#arrDate[i]#")>
			<cfif dt is "">
				<cfset dt = "NULL">
			<cfelse>
				<cfset dt = createODBCDateTime(dt)>
			</cfif>
			
			<cfif cdt is "" AND dt is not "NULL"><cfset cdt = dt></cfif>
			
			<cfif dt is not "">
				<cfif dt gt cdt><cfset cdt = dt></cfif>
			</cfif>
			
			<cfquery name="chkRamps" datasource="#ds#" dbtype="ODBC">
			SELECT count(*) as chk FROM [tblCurbRamps] WHERE [BSS_Work_ID] = #bss_workid# AND [Intersection_Corner] #preservesinglequotes(v)#
			</cfquery>
			
			<!--- <cfoutput>#bss_workid#: #arrDir[i]# - #chkRamps.chk# - #dt#<br></cfoutput> --->
			
			<!--- Insert if it doesn't exist --->
			<cfif chkRamps.chk is 0>
			
				<!--- In case curb ramp count gt 1 --->
				<cfloop index="j" from="1" to="#arrCnt[i]#">
				
					<cfset cnt2 = cnt2 + 1>
			
					<cfquery name="getMax" datasource="#ds#">
					SELECT (max(ramp_no)+1) as num FROM tblCurbRamps
					</cfquery>
					<cfset cr_no = getMax.num>
					
					<cfquery name="insertSite" datasource="#ds#" dbtype="ODBC">
					INSERT INTO tblCurbRamps (
					[Ramp_No],
					[Location_No],
					[Primary_Street],
					[Secondary_Street],
					<cfif arrDir[i] is not "">[Intersection_Corner],</cfif>
					[Type],
					[Notes],
					[Council_District],
					[BSS_Work_ID],
					[Construction_Completed_Date])
					VALUES (
					#cr_no#,
					#lno#,
					'#preservesinglequotes(pstreet)#',
					'#preservesinglequotes(sstreet)#',
					<cfif arrDir[i] is not "">'#arrDir[i]#',</cfif>
					#type_cr#,
					'#notes_cr#',
					#cd#,
					#bss_workid#,
					#dt#)
					</cfquery>
				
				</cfloop>
				
			<cfelse>
			
				<cfquery name="updateCurbs" datasource="#ds#" dbtype="ODBC">
				UPDATE tblCurbRamps SET 
				construction_completed_date = #dt#
				WHERE [BSS_Work_ID] = #bss_workid# AND [Intersection_Corner] #preservesinglequotes(v)#
				</cfquery>
			
			</cfif>
			
			
			
		
		</cfloop> 
	
	</cfif>
	
	<!--- <cfoutput>#cdt#<br></cfoutput> --->
	<cfif cdt is ""><cfset cdt = "NULL"></cfif>
	
	<cfquery name="updateSite" datasource="#ds#" dbtype="ODBC">
	UPDATE tblSites SET 
	construction_completed_date = #cdt#
	WHERE location_no = #lno# AND bss_work_id = #bss_workid#
	</cfquery>
	
</cfloop>

<br>

<cfoutput>Total Ramps: #cnt2#<br></cfoutput>

<!--- <cfoutput>#cnt#<br></cfoutput> --->

<!--- END UPDATE RAMP RECORDS ******************************************************************* --->






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
