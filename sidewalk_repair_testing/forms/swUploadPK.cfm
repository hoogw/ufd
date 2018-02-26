<!doctype html>

<html>
<head>
	<title>Untitled</title>
</head>


<body>

<!--- <cfdump var="#form#">
<cfabort> --->

<cfset uploadFolderDestination=request.PDFlocation & "packages\">

<cfset cnt = 5 - len(url.sw_id)>
<cfset dir = url.sw_id>
<!--- <cfloop index="i" from="1" to="#cnt#"><cfset dir = "0" & dir></cfloop> --->

<cfif isdefined("session.userid") is false>
	<div id="response">Failed</div>
	<cfabort>
</cfif>

<cfif DirectoryExists(uploadFolderDestination & dir) is false>
	<cfdirectory action="create" directory="#uploadFolderDestination##dir#">  
</cfif>

<cfset arrFlds = ListToArray(form.fieldnames,",")>
<cfset doRmvl = "false">

<!--- <cfdump var="#uploadFolderDestination#"> --->

<cftry>

	<cfloop index="i" from="1" to="#arrayLen(arrFlds)#">
		<cfif Evaluate("#arrFlds[i]#") is not "">
			<cffile action="UPLOAD" filefield="#arrFlds[i]#" destination="#uploadFolderDestination##dir#" nameconflict="OVERWRITE">
			<!--- <cfdump var="#cffile#"> --->
			<cfset fname = "Contractors_Bid." & dir>
			<cfif right(arrFlds[i],3) is "ARB">
				<!--- <cfset fname = "Arborist_Report." & dir>
				<cfset doArb = "true"> --->
			<cfelseif right(arrFlds[i],4) is "RMVL">
				<cfset doRmvl = "true">
			</cfif>
			
			<cffile action="RENAME" destination="#fname#.#cffile.clientfileext#" source="#cffile.serverdirectory#\#cffile.serverfile#" nameconflict="OVERWRITE">

		</cfif>
	</cfloop>

	<div id="response">Success</div>
<cfcatch>
	<div id="response">Failed</div>
</cfcatch>
</cftry>

<cfoutput>
<div id="dir">#dir#</div>
<div id="doRMVL">#doRmvl#</div>
</cfoutput>

</body>
</html>
