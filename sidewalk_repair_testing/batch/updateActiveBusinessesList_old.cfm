<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- <cfif isdefined("Update") is false>
<script language="JavaScript">
location.replace("updateBSSramps.cfm?Update=1&RequestTimeout=500000")
</script>
<cfabort>
</cfif> --->

<font size="2">

<cfset ds = "geocoding_spatial">
<cfset tbl = "srp_active_businesses">

<!--- START UPDATE BUSINESSES LIST RECORDS ******************************************************************* --->



<cfhttp url="https://data.lacity.org/resource/ngkp-kqkn.json" method="GET"  proxyserver="bcproxy.ci.la.ca.us" proxyport="8080" timeout="1000"> 
	<cfhttpparam name="$limit" type="URL" value="500">
	<!--- <cfhttpparam name="$order" type="URL" value=":id"> --->
</cfhttp>

<!--- <cfdump var="#cfhttp.FileContent#"> --->

<cfset data = deserializeJSON(cfhttp.FileContent)>

<cfdump var="#data#">

<cfloop index="i" from="1" to="#arrayLen(data)#">

	<cfset rec = data[i]>
	
	<cfset location_account = "">
	<cfset business_name = "">
	<cfset dba_name = "">
	<cfset street_address = "">
	<cfset city = "">
	<cfset zip_code = "">
	<cfset location_description = "">
	<cfset mailing_address = "">
	<cfset mailing_city = "">
	<cfset mailing_zip_code = "">
	<cfset naics = "">
	<cfset primary_naics_description = "">
	<cfset council_district = "">
	<cfset location_start_date = "">
	<cfset location_end_date = "">
	<cfset lat = "">
	<cfset lon = "">
	
	<cfif isdefined("rec.location_account")><cfset location_account = rec.location_account></cfif> 
	<cfif isdefined("rec.business_name")><cfset business_name = replace(rec.business_name,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.dba_name")><cfset dba_name = replace(rec.dba_name,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.street_address")><cfset street_address = replace(rec.street_address,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.city")><cfset city = replace(rec.city,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.zip_code")><cfset zip_code = rec.zip_code></cfif> 
	<cfif isdefined("rec.location_description")><cfset location_description = replace(rec.location_description,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.mailing_address")><cfset mailing_address = replace(rec.mailing_address,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.mailing_city")><cfset mailing_city = replace(rec.mailing_city,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.mailing_zip_code")><cfset mailing_zip_code = rec.mailing_zip_code></cfif> 
	<cfif isdefined("rec.naics")><cfset naics = rec.naics></cfif> 
	<cfif isdefined("rec.primary_naics_description")><cfset primary_naics_description = replace(rec.primary_naics_description,"'","''","ALL")></cfif> 
	<cfif isdefined("rec.council_district")><cfset council_district = rec.council_district></cfif> 
	<cfif isdefined("rec.location_start_date")>
		<cfset idx = findnocase("T",rec.location_start_date)>
		<cfset location_start_date = createODBCDate(left(rec.location_start_date,idx-1))>
	</cfif> 
	<cfif isdefined("rec.location_end_date")>
		<cfset idx = findnocase("T",rec.location_end_date)>
		<cfset location_end_date = createODBCDate(left(rec.location_end_date,idx-1))>
	</cfif> 
	
	<!--- <cfif isdefined("rec.council_district")><cfset council_district = rec.council_district></cfif>  --->
	
	
	
	<cfquery name="insertRecord" datasource="#ds#" dbtype="ODBC">
	INSERT INTO #tbl# (
	
	<cfif business_name is not "">business_name,</cfif>
	<cfif dba_name is not "">dba_name,</cfif>
	<cfif street_address is not "">street_address,</cfif>
	<cfif city is not "">city,</cfif>
	<cfif zip_code is not "">zip_code,</cfif>
	<cfif location_description is not "">location_description,</cfif>
	<cfif mailing_address is not "">mailing_address,</cfif>
	<cfif mailing_city is not "">mailing_city,</cfif>
	<cfif mailing_zip_code is not "">mailing_zip_code,</cfif>
	<cfif naics is not "">naics,</cfif>
	<cfif primary_naics_description is not "">primary_naics_description,</cfif>
	<cfif council_district is not "">council_district,</cfif>
	<cfif location_start_date is not "">location_start_date,</cfif>
	<cfif location_end_date is not "">location_end_date,</cfif>
	location_account

	)
	VALUES (
	
	
	<cfif business_name is not "">'#preservesinglequotes(business_name)#',</cfif>
	<cfif dba_name is not "">'#preservesinglequotes(dba_name)#',</cfif>
	<cfif street_address is not "">'#preservesinglequotes(street_address)#',</cfif>
	<cfif city is not "">'#preservesinglequotes(city)#',</cfif>
	<cfif zip_code is not "">'#zip_code#',</cfif>
	<cfif location_description is not "">'#preservesinglequotes(location_description)#',</cfif>
	<cfif mailing_address is not "">'#preservesinglequotes(mailing_address)#',</cfif>
	<cfif mailing_city is not "">'#preservesinglequotes(mailing_city)#',</cfif>
	<cfif mailing_zip_code is not "">'#mailing_zip_code#',</cfif>
	<cfif naics is not "">#naics#,</cfif>
	<cfif primary_naics_description is not "">'#preservesinglequotes(primary_naics_description)#',</cfif>
	<cfif council_district is not "">#council_district#,</cfif>
	<cfif location_start_date is not "">#location_start_date#,</cfif>
	<cfif location_end_date is not "">#location_end_date#,</cfif>
	'#location_account#'
	
	)
	</cfquery>
	
	

</cfloop>


<!--- <cfset arrHTML = listToArray(cfhttp.FileContent,"<")> --->




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
