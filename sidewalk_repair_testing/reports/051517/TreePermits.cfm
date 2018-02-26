<!---
	Merge tree prune and removal permits for a site
	
	request query string .../treepermits.cfm?package=boe-1
--->

<cfparam name="url.site" type="string" default="" />
<cfparam name="url.package" type="string" default="" />

<cfif !IsDefined("url.package") OR url.package eq "" >
	<cfoutput>?package= ppp-nn required</cfoutput>
	<cfexit />
</cfif>

<cfquery 
	name="treepermits"
	dataSource="sidewalk">
SELECT [location_no] FROM vwHDRAssessmentTracking WHERE [package] = <cfqueryparam value=#url.package# CFSQLType = "CF_SQL_VARCHAR" />
</cfquery>

<cfset myArray = arrayNew(1)>
<cfset myOutput = "d:/sidewalk_repair/merged/merged" & #url.package# & ".pdf" /> 

<cfdump var="#treepermits#" />

<cfloop query="treepermits" >

	<cfset myDir = "d:/sidewalk_repair/pdfs/" & NumberFormat(#location_no#, "00000") />

	<cfset havePermits=DirectoryExists("#myDir#") >
	<cfif havePermits >

		<cfdirectory
			directory="#myDir#"
			name="files"
			action="list" >

		<cfif files.RecordCount le 0>
			<cfoutput>no permits</cfoutput>
			<cfexit />
		</cfif>


		<cfscript>
			for( f in files )
			{
				if ( REFindNoCase("^(tree_prune_permits|tree_removal_permits)\.\d+\.pdf$", f.Name )) {
					ArrayAppend( myArray, myDir & "/" & f.Name );
				}
			}
			
		</cfscript>
	</cfif>
</cfloop>

<cfif ArrayLen(#myArray#) gt 0 >
	<cfset myPermits = ArrayToList(myArray) />	
	<cfpdf 
		action="merge" 
		source="#myPermits#"
		destination="#myOutput#" overwrite="yes" />

	<cfcontent file="#myOutput#" ></cfcontent>
<cfelse>
<cfheader 
	statusCode = "204"
	statusText = "no permits in package (#url.package#)" />
</cfif>