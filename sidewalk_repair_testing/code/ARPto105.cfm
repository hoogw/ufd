<!--- *********************************************** --->
<!--- myla311-CreatedDate.cfm                         --->
<!--- Data pulled from MyLA311                        --->
<!--- *********************************************** --->

<!-- Adjusted by: Nathan Neumann 12/28/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 6000>

<!--- Setup script variables --->
<cfset arpDS = "accessprogram"> <!--- This is the datasource for the ssr_info table --->
<cfset arpTable = "ar_info"> <!--- This is the ssr_info table --->
<cfset geoDS = "geocoding_spatial"> <!--- This is the datasource for the ssr_info on 78boe105 table --->
<cfset geoTable = "srp_arp_info"> <!--- This is the ssr_info table --->

<!--- s: Check if request already exists in the database and add if not there --->
<cfquery name="checkRecords" datasource="#geoDS#">
SELECT max(ar_id) as arid FROM #geoTable#
</cfquery>
<cfset cnt = checkRecords.arid>
<cfif cnt is ""><cfset cnt = 0></cfif>

<cfdump var="#checkRecords#">

<cfquery name="getRecords" datasource="#arpDS#">
SELECT [ar_id]
,[sr_number]
,[sr_app_comments]
,[sr_location_comments]
,[sr_access_comments]
,[sr_mobility_disability]
,[sr_access_barrier_type]
,[sr_mobility_relation]
,[ar_status_cd]
,[app_name_nn]
,[ddate_submitted]
,[tbm_grid]
,[boe_dist]
,[council_dist]
,[bpp]
,[pin]
,[pind]
,[zoningCode]
,[job_address]
,[x_coord]
,[y_coord]
,[longitude]
,[latitude]
FROM #arpTable# WHERE ar_id > #cnt#
</cfquery>

<cfloop query="getRecords">

	<cfset adr = replace(job_address,"'","''","ALL")>
	<cfset app_cmt = replace(sr_app_comments,"'","''","ALL")>
	<cfset loc_cmt = replace(sr_location_comments,"'","''","ALL")>
	<cfset acc_cmt = replace(sr_access_comments,"'","''","ALL")>
	<cfset mob_dis = replace(sr_mobility_disability,"'","''","ALL")>
	<cfset acc_bar = replace(sr_access_barrier_type,"'","''","ALL")>
	<cfset mob_rel = replace(sr_mobility_relation,"'","''","ALL")>
	<cfset name = replace(app_name_nn,"'","''","ALL")>
	<cfset stcd = replace(ar_status_cd,"'","''","ALL")>

	<!--- s: Insert Records into the srr_info table --->
	<cfquery name="insertRecords" datasource="#geoDS#">
	INSERT INTO #geoTable# (
      [sr_number],
      [sr_app_comments],
      [sr_location_comments],
	  [sr_access_comments],
	  [sr_mobility_disability],
	  [sr_access_barrier_type],
	  [sr_mobility_relation],
      [app_name_nn],
      [ddate_submitted],
      [tbm_grid],
      [council_dist],
      [bpp],
      [pin],
      [pind],
      [zoningCode],
      [job_address],
      <cfif x_coord is not "">[x_coord],</cfif>
      <cfif y_coord is not "">[y_coord],</cfif>
      <cfif longitude is not "">[longitude],</cfif>
      <cfif latitude is not "">[latitude],</cfif>
	  [ar_status_cd],
	  [ar_id]
	)
	Values (
      '#sr_number#',
      '#preservesinglequotes(app_cmt)#',
      '#preservesinglequotes(loc_cmt)#',
	  '#preservesinglequotes(acc_cmt)#',
	  '#preservesinglequotes(mob_dis)#',
	  '#preservesinglequotes(acc_bar)#',
	  '#preservesinglequotes(mob_rel)#',
      '#preservesinglequotes(name)#',
      '#ddate_submitted#',
      '#tbm_grid#',
      '#council_dist#',
      '#bpp#',
      '#pin#',
      '#pind#',
      '#zoningCode#',
      '#preservesinglequotes(adr)#',
      <cfif x_coord is not "">#x_coord#,</cfif>
      <cfif y_coord is not "">#y_coord#,</cfif>
      <cfif longitude is not "">#longitude#,</cfif>
      <cfif latitude is not "">#latitude#,</cfif>
	  '#stcd#',
	  #ar_id#
	)
	</cfquery>
	<!--- e: Insert Records into the srr_info table --->

</cfloop> 
<!--- e: Check if request already exists in the database and add if not there --->

<cfquery name="rebuidIndexes" datasource="#geoDS#">
ALTER INDEX ALL ON #geoTable# REBUILD
</cfquery>


<!--- s: Added to update the x,y coordinates --->
<cfquery name="getXYz" datasource="#arpDS#">
SELECT ar_id, x_coord, y_coord FROM #arpTable# ORDER BY ar_id
</cfquery>

<cfloop query="getXYz">
	<cfif x_coord is not "" AND y_coord is not "">
		<cfquery name="insertRecords" datasource="#geoDS#">
		UPDATE #geoTable# SET
		x_coord = #x_coord#,
		y_coord = #y_coord#
		WHERE ar_id = #ar_id#
		</cfquery>
	</cfif>
</cfloop> 
<!--- e: Added to update the x,y coordinates --->

