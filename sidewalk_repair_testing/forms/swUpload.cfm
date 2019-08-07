<!doctype html>

<html>
<head>
	<title>Untitled</title>
</head>


<body>

<!--- <cfdump var="#form#">
<cfabort> --->

<cfset uploadFolderDestination=request.PDFlocation>

<cfset cnt = 5 - len(url.sw_id)>
<cfset dir = url.sw_id>
<cfloop index="i" from="1" to="#cnt#"><cfset dir = "0" & dir></cfloop>

<cfif isdefined("session.userid") is false>
	<div id="response">Failed</div>
	<cfabort>
</cfif>

<cfif DirectoryExists(uploadFolderDestination & dir) is false>
	<cfdirectory action="create" directory="#uploadFolderDestination##dir#">  
</cfif>

<cfset arrFlds = ListToArray(form.fieldnames,",")>
<cfset doRmvl = "false">
<cfset doArb = "false">
<cfset doCert = "false">
<cfset doCurb = "false">
<cfset doMemo = "false">
<cfset doField_Assess = "false">
<cfset doRoe = "false">
<cfset doPrn = "false">
<cfset doRCurb = "false">


<cftry>

	<cfloop index="i" from="1" to="#arrayLen(arrFlds)#">
		<cfif Evaluate("#arrFlds[i]#") is not "">
			<cffile action="UPLOAD" filefield="#arrFlds[i]#" destination="#uploadFolderDestination##dir#" nameconflict="OVERWRITE">
			<!--- <cfdump var="#cffile#"> --->
			<cfset fname = "Tree_Removal_Permits." & dir>
			<cfif right(arrFlds[i],3) is "ARB">
				<cfset fname = "Arborist_Report." & dir>
				<cfset doArb = "true">
			<cfelseif right(arrFlds[i],4) is "CERT">
				<cfset fname = "Certification_Form." & dir>
				<cfset doCert = "true">
			<cfelseif right(arrFlds[i],5) is "RCURB">
				<cfset fname = "Revised_Curb_Ramp_Plans." & dir>
				<cfset doRCurb = "true">
			<cfelseif right(arrFlds[i],4) is "CURB">
				<cfset fname = "Curb_Ramp_Plans." & dir>
				<cfset doCurb = "true">
			<cfelseif right(arrFlds[i],4) is "MEMO">
				<cfset fname = "Memos." & dir>
				<cfset doMemo = "true">
                
             <cfelseif right(arrFlds[i],12) is "FIELD_ASSESS">
				<cfset fname = "Field_Assess." & dir>
				<cfset doField_Assess = "true">   
                
                
			<cfelseif right(arrFlds[i],3) is "ROE">
				<cfset fname = "ROE_Form." & dir>
				<cfset doRoe = "true">
			<cfelseif right(arrFlds[i],3) is "PRN">
				<cfset fname = "Tree_Prune_Permits." & dir>
				<cfset doPrn = "true">
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
<div id="doARB">#doArb#</div>
<div id="doCERT">#doCert#</div>
<div id="doCURB">#doCurb#</div>
<div id="doMEMO">#doMemo#</div>


<div id="doFIELD_ASSESS">#doField_Assess#</div>

<div id="doROE">#doRoe#</div>
<div id="doPRN">#doPrn#</div>
<div id="doRCURB">#doRCurb#</div>
</cfoutput>

</body>
</html>
