<!--- *********************************************** --->
<!--- myla311-CreatedDate.cfm                         --->
<!--- Data pulled from MyLA311                        --->
<!--- *********************************************** --->

<!-- Adjusted by: Nathan Neumann 09/22/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 6000>

<!--- Setup script variables --->
<cfset srrDS = "srr"> <!--- This is the datasource for the ssr_info table --->
<cfset srrTable = "srr_info"> <!--- This is the ssr_info table --->
<cfset geoDS = "geocoding_testing_spatial"> <!--- <cfset geoDS = "geocoding_spatial"> ---> <!--- This is the datasource for the ssr_info on 78boe105 table --->
<cfset geoTable = "srp_srr_info"> <!--- This is the ssr_info table --->

<!--- s: Check if request already exists in the database and add if not there --->
<cfquery name="checkRecords" datasource="#geoDS#">
SELECT max(srr_id) as srrid FROM #geoTable#
</cfquery>
<cfset cnt = checkRecords.srrid>
<cfif cnt is ""><cfset cnt = 0></cfif>

<cfdump var="#checkRecords#">

<cfquery name="getRecords" datasource="#srrDS#">
SELECT 
[srr_id]
,[sr_number]
,[sr_app_comments]
,[sr_location_comments]
,[app_name_nn]
,[prop_owned_by]
,[ddate_submitted]
,[tbm_grid]
,[council_dist]
,[bpp]
,[pin]
,[pind]
,[zoningCode]
,[job_address]
,[constCompleted_dt]
,[bca_assessment_comp_dt]
,a.first_name + ' ' + a.last_name AS bca_action_by
,[bss_assessment_comp_dt]
,b.first_name + ' ' + b.last_name AS bss_action_by
,[prop_type]
,[bca_comments]
,[bss_comments]
,[boe_invest_comments]
,[x_coord]
,[y_coord]
,[longitude]
,[latitude]
,[srr_status_cd]
FROM #srrTable# LEFT OUTER JOIN
dbo.staff as b ON dbo.srr_info.bss_action_by = b.user_id LEFT OUTER JOIN
dbo.staff AS a ON dbo.srr_info.bca_action_by = a.user_id
WHERE srr_id > #cnt#
</cfquery>

<cfloop query="getRecords">

	<cfset adr = replace(job_address,"'","''","ALL")>
	<cfset app_cmt = replace(sr_app_comments,"'","''","ALL")>
	<cfset loc_cmt = replace(sr_location_comments,"'","''","ALL")>
	<cfset name = replace(app_name_nn,"'","''","ALL")>
	<cfset stcd = replace(srr_status_cd,"'","''","ALL")>
	
	<cfset bca_cmt = replace(bca_comments,"'","''","ALL")>
	<cfset bss_cmt = replace(bss_comments,"'","''","ALL")>
	<cfset boe_cmt = replace(boe_invest_comments,"'","''","ALL")>
	
	<cfset bcaby = trim(replace(bca_action_by,"'","''","ALL"))>
	<cfset bssby = trim(replace(bss_action_by,"'","''","ALL"))>
	
	<cfset ccdt = constCompleted_dt><cfif ccdt is not ""><cfset ccdt = createODBCDateTime(constCompleted_dt)></cfif>
	<cfset bcadt = bca_assessment_comp_dt><cfif bcadt is not ""><cfset bcadt = createODBCDateTime(bca_assessment_comp_dt)></cfif>
	<cfset bssdt = bss_assessment_comp_dt><cfif bssdt is not ""><cfset bssdt = createODBCDateTime(bss_assessment_comp_dt)></cfif>

	<!--- s: Insert Records into the srr_info table --->
	<cfquery name="insertRecords" datasource="#geoDS#">
	INSERT INTO #geoTable# (
      [sr_number],
      [sr_app_comments],
      [sr_location_comments],
      [app_name_nn],
      [prop_owned_by],
      [ddate_submitted],
      [tbm_grid],
      [council_dist],
      [bpp],
      [pin],
      [pind],
      [zoningCode],
      [job_address],
	  <cfif ccdt is not "">[constCompleted_dt],</cfif>
	  <cfif bcadt is not "">[bca_assessment_comp_dt],</cfif>
	  <cfif bcaby is not "">[bca_action_by],</cfif>
	  <cfif bssdt is not "">[bss_assessment_comp_dt],</cfif>
	  <cfif bssby is not "">[bss_action_by],</cfif>
	  <cfif prop_type is not "">[prop_type],</cfif>
	  [bca_comments],
	  [bss_comments],
	  [boe_invest_comments],
      <cfif x_coord is not "">[x_coord],</cfif>
      <cfif y_coord is not "">[y_coord],</cfif>
      <cfif longitude is not "">[longitude],</cfif>
      <cfif latitude is not "">[latitude],</cfif>
	  [sr_status_cd],
	  [srr_id]
	)
	Values (
      '#sr_number#',
      '#preservesinglequotes(app_cmt)#',
      '#preservesinglequotes(loc_cmt)#',
      '#preservesinglequotes(name)#',
      '#prop_owned_by#',
      '#ddate_submitted#',
      '#tbm_grid#',
      '#council_dist#',
      '#bpp#',
      '#pin#',
      '#pind#',
      '#zoningCode#',
      '#preservesinglequotes(adr)#',
	  <cfif ccdt is not "">#ccdt#,</cfif>
	  <cfif bcadt is not "">#bcadt#,</cfif>
	  <cfif bcaby is not "">'#preservesinglequotes(bcaby)#',</cfif>
	  <cfif bssdt is not "">#bssdt#,</cfif>
	  <cfif bssby is not "">'#preservesinglequotes(bssby)#',</cfif>
	  <cfif prop_type is not "">'#prop_type#',</cfif>
	  '#preservesinglequotes(bca_cmt)#',
      '#preservesinglequotes(bss_cmt)#',
	  '#preservesinglequotes(boe_cmt)#',
      <cfif x_coord is not "">#x_coord#,</cfif>
      <cfif y_coord is not "">#y_coord#,</cfif>
      <cfif longitude is not "">#longitude#,</cfif>
      <cfif latitude is not "">#latitude#,</cfif>
	  '#stcd#',
	  #srr_id#
	)
	</cfquery>
	<!--- e: Insert Records into the srr_info table --->

</cfloop> 
<!--- e: Check if request already exists in the database and add if not there --->

<cfquery name="rebuidIndexes" datasource="#geoDS#">
ALTER INDEX ALL ON #geoTable# REBUILD
</cfquery>

<!--- s: Added to update the x,y coordinates and other updated values --->
<cfquery name="getXYz" datasource="#srrDS#">
SELECT srr_id, x_coord, y_coord, srr_status_cd, constCompleted_dt, bca_assessment_comp_dt, bss_assessment_comp_dt, bca_comments, bss_comments, boe_invest_comments,
a.first_name + ' ' + a.last_name AS bca_action_by, b.first_name + ' ' + b.last_name AS bss_action_by
FROM #srrTable# LEFT OUTER JOIN
dbo.staff as b ON dbo.srr_info.bss_action_by = b.user_id LEFT OUTER JOIN
dbo.staff AS a ON dbo.srr_info.bca_action_by = a.user_id
ORDER BY srr_id
</cfquery>

<cfloop query="getXYz">
	<cfif x_coord is not "" AND y_coord is not "">
		<cfquery name="insertRecords" datasource="#geoDS#">
		UPDATE #geoTable# SET
		x_coord = #x_coord#,
		y_coord = #y_coord#
		WHERE srr_id = #srr_id#
		</cfquery>
	</cfif>
	
	<cfquery name="getComments" datasource="#srrDS#">
	SELECT comment_txt FROM bca_comments
	WHERE srr_id = #srr_id# ORDER BY comment_id
	</cfquery>
	<cfset bca_cmt = ""><cfset cnt = 0>
	<cfloop query="getComments">
		<cfset cnt = cnt + 1>
		<cfset bca_cmt = bca_cmt & comment_txt>
		<cfif cnt neq getComments.recordcount>
			<cfset bca_cmt = bca_cmt & chr(13)>
		</cfif>
	</cfloop>
	
	<cfset stcd = replace(srr_status_cd,"'","''","ALL")>
	<cfset ccdt = constCompleted_dt><cfif ccdt is ""><cfset ccdt = "NULL"><cfelse><cfset ccdt = createODBCDateTime(constCompleted_dt)></cfif>
	<cfset bcadt = bca_assessment_comp_dt><cfif bcadt is ""><cfset bcadt = "NULL"><cfelse><cfset bcadt = createODBCDateTime(bca_assessment_comp_dt)></cfif>
	<cfset bssdt = bss_assessment_comp_dt><cfif bssdt is ""><cfset bssdt = "NULL"><cfelse><cfset bssdt = createODBCDateTime(bss_assessment_comp_dt)></cfif>
	<cfset bcaby = trim(replace(bca_action_by,"'","''","ALL"))>
	<cfset bssby = trim(replace(bss_action_by,"'","''","ALL"))>
	<cfset bca_cmt = trim(replace(bca_cmt,"'","''","ALL"))>
	<cfif bca_cmt is ""><cfset bca_cmt = trim(replace(bca_comments,"'","''","ALL"))></cfif>
	<cfset bss_cmt = trim(replace(bss_comments,"'","''","ALL"))>
	<cfset boe_cmt = trim(replace(boe_invest_comments,"'","''","ALL"))>
	
	<cfquery name="insertRecords" datasource="#geoDS#">
	UPDATE #geoTable# SET
	sr_status_cd = '#stcd#',
	constCompleted_dt = #ccdt#,
	bca_assessment_comp_dt = #bcadt#,
	bca_action_by = <cfif bcaby is "">NULL,<cfelse>'#preservesinglequotes(bcaby)#',</cfif>
	bss_assessment_comp_dt = #bssdt#,
	bss_action_by = <cfif bcaby is "">NULL,<cfelse>'#preservesinglequotes(bssby)#',</cfif>
	bca_comments = <cfif bca_cmt is "">NULL,<cfelse>'#preservesinglequotes(bca_cmt)#',</cfif>
	bss_comments = <cfif bss_cmt is "">NULL,<cfelse>'#preservesinglequotes(bss_cmt)#',</cfif>
	boe_invest_comments = <cfif boe_cmt is "">NULL<cfelse>'#preservesinglequotes(boe_cmt)#'</cfif>	
	WHERE srr_id = #srr_id#
	</cfquery>
</cfloop> 
<!--- e: Added to update the x,y coordinates and other updated values --->




<!--- s: Added to update the srp_srr_quantities table (used for the assessment form in the SRP database for Completed sites --->
<cfquery name="getQuantities" datasource="#srrDS#">
SELECT a.srr_id, a.sr_number, b.ref_no, 
case when (SELECT sum(sidewalk_qty) FROM apermits.dbo.sidewalk_details as c WHERE c.ref_no = b.ref_no) is not null then
(SELECT sum(sidewalk_qty) FROM apermits.dbo.sidewalk_details as f WHERE f.ref_no = b.ref_no) else 0 end as sidewalk_qty,
case when (SELECT sum(driveway_qty) FROM apermits.dbo.driveway_details as c WHERE c.ref_no = b.ref_no) is not null then
(SELECT sum(driveway_qty) FROM apermits.dbo.driveway_details as f WHERE f.ref_no = b.ref_no) else 0 end as driveway_qty,
case when d.conc_curb_qty is null then 0 else d.conc_curb_qty end as conc_curb_qty, 
case when d.conc_gutter_qty is null then 0 else d.conc_gutter_qty end as conc_gutter_qty, 
case when d.sidewalk_trans_qty is null then 0 else d.sidewalk_trans_qty end as sidewalk_trans_qty, 
case when d.partial_dwy_conc_qty is null then 0 else d.partial_dwy_conc_qty end as partial_dwy_conc_qty, 
case when d.access_ramp_qty is null then 0 else d.access_ramp_qty end as access_ramp_qty, 
case when d.pkwy_drain_qty is null then 0 else d.pkwy_drain_qty end as pkwy_drain_qty, 
case when d.catch_basin_lid_qty is null then 0 else d.catch_basin_lid_qty end as catch_basin_lid_qty, 
case when d.signage_no is null then 0 else d.signage_no end as signage_no, 
case when d.st_furn_no is null then 0 else d.st_furn_no end as st_furn_no, 
case when d.parking_meter_no is null then 0 else d.parking_meter_no end as parking_meter_no, 
case when d.pullbox_no is null then 0 else d.pullbox_no end as pullbox_no, 
case when d.survey_monument_no is null then 0 else d.survey_monument_no end as survey_monument_no, 
case when c.nbr_trees_pruned is null then 0 else c.nbr_trees_pruned end as nbr_trees_pruned, 
case when c.nbr_trees_removed is null then 0 else c.nbr_trees_removed end as nbr_trees_removed, 
case when c.nbr_stumps_removed is null then 0 else c.nbr_stumps_removed end as nbr_stumps_removed, 
case when c.nbr_trees_onsite is null then 0 else c.nbr_trees_onsite end as nbr_trees_onsite, 
case when c.nbr_trees_offsite is null then 0 else c.nbr_trees_offsite end as nbr_trees_offsite,
a.constCompleted_dt
FROM   dbo.srr_info AS a LEFT OUTER JOIN
apermits.dbo.permit_info AS b ON a.srr_id = b.srr_id LEFT OUTER JOIN
dbo.tree_info AS c ON a.srr_id = c.srr_id LEFT OUTER JOIN
dbo.srr_other_items AS d ON a.srr_id = d.srr_id
WHERE (a.constCompleted_dt IS NOT NULL)
ORDER BY a.srr_id, b.ref_no
</cfquery>

<!--- <cfdump var="#getQuantities#"> --->

<cfquery name="getColumns" datasource="#geoDS#">
SELECT column_name,data_type FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'srp_srr_quantities'
</cfquery>
<cfset inStr = "INSERT INTO srp_srr_quantities (" & ValueList(getColumns.column_name) & ") ">

<!--- <cfdump var="#inStr#">
<cfdump var="#getColumns#"> --->

<cfloop query="getQuantities">
	
	<cfset valStr = "VALUES (">
	<cfloop query="getColumns">
		<cfif data_type is "varchar">
			<cfset valStr = valStr & "'" & evaluate("getQuantities.#column_name#") & "',">
		<cfelseif data_type is "smalldatetime">
			<cfset valStr = valStr & createODBCDateTime(evaluate("getQuantities.#column_name#")) & ",">
		<cfelse>
			<cfset valStr = valStr & evaluate("getQuantities.#column_name#") & ",">
		</cfif> 
	</cfloop>
	<cfset valStr = left(valStr,len(valStr)-1) & ")">
	<cfset sqlStr = inStr & valStr>
	
	<!--- <cfdump var="#sqlStr#"><br> --->


	<cfquery name="checkRecords" datasource="#geoDS#">
	SELECT count(*) as cnt FROM srp_srr_quantities WHERE srr_id = #srr_id#
	</cfquery>

	<cfif checkRecords.cnt is 0>
		<cfquery name="insertQRecord" datasource="#geoDS#">
		#preservesinglequotes(sqlStr)#
		</cfquery>
	</cfif>

</cfloop>

<cfquery name="rebuidIndexes" datasource="#geoDS#">
ALTER INDEX ALL ON srp_srr_quantities REBUILD
</cfquery>
<!--- e: Added to update the srp_srr_quantities table (used for the assessment form in the SRP database for Completed sites --->