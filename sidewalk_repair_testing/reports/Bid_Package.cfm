<cfsetting enablecfoutputonly="yes" />
<cfheader name="Content-Disposition" value="filename=bid_package.xlsx" />

<cfset pk = url.pk>
<cfset sfx = timeformat(now(),"HHmmss")>
<cfset f = "BidPackage_" & sfx>

<cftry>
	<cfset dir = request.dir & "\downloads">
	<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.xls">
	<cfoutput query="pdfdir">
		<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
			<cffile action="DELETE" file="#dir#\#pdfdir.name#">
		</cfif>
	</cfoutput>
	<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.zip">
	<cfoutput query="pdfdir">
		<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
			<cffile action="DELETE" file="#dir#\#pdfdir.name#">
		</cfif>
	</cfoutput>
<cfcatch>
</cfcatch>
</cftry>

<cfset export=createobject("component", "Bid_Package").init( "sidewalk", pk) />
<cfinvoke component="#export#" method="Export" returnvariable="filewritten" >
    <cfinvokeargument name="FilePath" value="#request.dir#\downloads\#f#.xlsx" />
</cfinvoke>

<cfcontent file="#filewritten#" type="application/msexcel" />

