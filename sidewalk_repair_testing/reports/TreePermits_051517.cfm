<!---
	Merge tree prune and removal permits for a site
	
	request query string .../tree_permits.cfm?site=5
--->

<cfparam name="url.site" type="string" default="" />

<cfif !IsDefined("url.site") OR url.site eq "" >
	<cfoutput>?site=nn required</cfoutput>
	<cfexit />
</cfif>
	
<cfset myDir = "d:/sidewalk_repair/pdfs/" & NumberFormat(url.site, "00000") />
<cfset myOutput = "d:/sidewalk_repair/merged/merged" & NumberFormat( url.site, "00000") & ".pdf" /> 

<cfset havePermits=DirectoryExists("#myDir#") >
<cfif !havePermits >
	<cfoutput>no folder</cfoutput>
	<cfexit />
</cfif>

<cfdirectory
	directory="#myDir#"
	name="files"
	action="list" >

<cfif files.RecordCount le 0>
	<cfoutput>no permits</cfoutput>
	<cfexit />
</cfif>

<cfset var="myPermits">
<cfscript>
	myArray = ArrayNew(1);	
	for( f in files )
	{
		if ( REFindNoCase("^(tree_prune_permits|tree_removal_permits)\.\d+\.pdf$", f.Name )) {
			ArrayAppend( myArray, myDir & "/" & f.Name );
		}
	}
	
	myPermits = ArrayToList(myArray);	
</cfscript>

<cfpdf 
	action="merge" 
	source="#myPermits#"
	destination="#myOutput#" overwrite="yes" />

<cfcontent file="#myOutput#" ></cfcontent>