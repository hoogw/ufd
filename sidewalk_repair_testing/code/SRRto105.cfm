<!--- *********************************************** --->
<!--- myla311-CreatedDate.cfm                         --->
<!--- Data pulled from MyLA311                        --->
<!--- *********************************************** --->

<!-- Adjusted by: Nathan Neumann 09/22/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- Setup script variables --->
<cfset srrDS = "srr"> <!--- This is the datasource for the ssr_info table --->
<cfset srrTable = "srr_info"> <!--- This is the ssr_info table --->
<cfset geoDS = "geocoding_spatial"> <!--- This is the datasource for the ssr_info on 78boe105 table --->
<cfset geoTable = "srp_srr_info"> <!--- This is the ssr_info table --->

<!--- s: Check if request already exists in the database and add if not there --->
<cfquery name="checkRecords" datasource="#geoDS#">
SELECT max(srr_id) as srrid FROM #geoTable#
</cfquery>

<cfdump var="#checkRecords#">

<cfabort><!--- STOP, will update official table if continues and we don't want that on test server --->

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
,[x_coord]
,[y_coord]
,[longitude]
,[latitude]
FROM #srrTable# WHERE srr_id > #checkRecords.srrid#
ORDER BY srr_id
</cfquery>

<cfloop query="getRecords">

	<cfset adr = replace(job_address,"'","''","ALL")>
	<cfset app_cmt = replace(sr_app_comments,"'","''","ALL")>
	<cfset loc_cmt = replace(sr_location_comments,"'","''","ALL")>
	<cfset name = replace(app_name_nn,"'","''","ALL")>

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
      <cfif x_coord is not "">[x_coord],</cfif>
      <cfif y_coord is not "">[y_coord],</cfif>
      <cfif longitude is not "">[longitude],</cfif>
      <cfif latitude is not "">[latitude],</cfif>
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
      <cfif x_coord is not "">#x_coord#,</cfif>
      <cfif y_coord is not "">#y_coord#,</cfif>
      <cfif longitude is not "">#longitude#,</cfif>
      <cfif latitude is not "">#latitude#,</cfif>
	  #srr_id#
	)
	</cfquery>
	<!--- e: Insert Records into the srr_info table --->

</cfloop> 
<!--- e: Check if request already exists in the database and add if not there --->

<cfquery name="rebuidIndexes" datasource="#geoDS#">
ALTER INDEX ALL ON #geoTable# REBUILD
</cfquery>



<!--- s: Added to update the x,y coordinates --->
<cfquery name="getXYz" datasource="#srrDS#">
SELECT srr_id, x_coord, y_coord FROM #srrTable# ORDER BY srr_id
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
</cfloop> 
<!--- e: Added to update the x,y coordinates --->
