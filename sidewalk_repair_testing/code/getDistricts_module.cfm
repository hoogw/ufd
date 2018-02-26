
<!-- Developed by: Nathan Neumann 12/15/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfparam name="attributes.x" default="6483532.59">				<!--- The passed x coordinate --->
<cfparam name="attributes.y" default="1816256.36">				<!--- The passed y coordinate --->

<cfset pDS = "navla_spatial">

<cfset request.get_districts_success = "Y"> 		<!--- Tells whether the insert was successful (Y/N) --->
<cfset request.rslt_boe_district = ""> 				<!--- Resulting BOE District 	--->	
<cfset request.rslt_bss_district = ""> 				<!--- Resulting BSS District	--->	
<cfset request.rslt_bss_name = "">					<!--- Resulting BSS Name		--->	
<cfset request.rslt_bss_district_office = "">		<!--- Resulting BOE District Office	 	--->				
<cfset request.rslt_bca_district = "">				<!--- Resulting BOE District	--->		
<cfset request.rslt_bca_inspect_district = "">		<!--- Resulting BOE Inspection District	--->	

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

	<cfquery name="getBOE" datasource="#pDS#">
	SELECT district FROM [navla].[dbo].[ags_boe_districts] a
	where a.shape.STIntersects(geometry::STGeomFromText('POINT(#attributes.x# #attributes.y#)', 2229)) = 1
	</cfquery>
	<cfif getBOE.recordcount gt 0><cfset request.rslt_boe_district = getBOE.district></cfif>
	
	<cfquery name="getBSS" datasource="#pDS#">
	SELECT dist_,name,dist_offic FROM [navla].[dbo].[ags_bss_maintenance_districts] a
	where a.shape.STIntersects(geometry::STGeomFromText('POINT(#attributes.x# #attributes.y#)', 2229)) = 1
	</cfquery>
	<cfif getBSS.recordcount gt 0>
		<cfset request.rslt_bss_district = getBSS.dist_>
		<cfset request.rslt_bss_name = getBSS.name>
		<cfset request.rslt_bss_district_office = getBSS.dist_offic>
	</cfif>
	
	<cfquery name="getBCA" datasource="#pDS#">
	SELECT district FROM [navla].[dbo].[ags_contract_administration_districts] a
	where a.shape.STIntersects(geometry::STGeomFromText('POINT(#attributes.x# #attributes.y#)', 2229)) = 1
	</cfquery>
	<cfif getBCA.recordcount gt 0><cfset request.rslt_bca_district = getBCA.district></cfif>
	
	<cfquery name="getBCAI" datasource="#pDS#">
	SELECT district FROM [navla].[dbo].[ags_contract_administration_inspection_districts] a
	where a.shape.STIntersects(geometry::STGeomFromText('POINT(#attributes.x# #attributes.y#)', 2229)) = 1
	</cfquery>
	<cfif getBCAI.recordcount gt 0><cfset request.rslt_bca_inspect_district = getBCAI.district></cfif>
	
	<!--- <cfdump var="#getBOE#">
	<cfdump var="#getBSS#">
	<cfdump var="#getBCA#"> --->

<cfcatch type="any">
  	<cfset request.get_districts_success = "N">
</cfcatch>

</cftry>
  
<!--- <cfoutput>#request.get_districts_success#<br></cfoutput>
<cfoutput>#request.rslt_boe_district#<br></cfoutput>
<cfoutput>#request.rslt_bss_district#<br></cfoutput>
<cfoutput>#request.rslt_bss_name#<br></cfoutput>
<cfoutput>#request.rslt_bss_district_office#<br></cfoutput>
<cfoutput>#request.rslt_bca_district#<br></cfoutput>
<cfoutput>#request.rslt_bca_inspect_district#<br></cfoutput> --->
