<cfsetting enablecfoutputonly="yes" />
<cfheader name="Content-Disposition" value="filename=bid_package.xlsx" />

<cfset pk = url.pk>

<cfset export=createobject("component", "Bid_Package").init( "sidewalk", pk) />
<cfinvoke component="#export#" method="Export" returnvariable="filewritten" >
    <cfinvokeargument name="FilePath" value="D:\sidewalk_repair\test\xxx.xlsx" />
</cfinvoke>

<cfcontent file="#filewritten#" type="application/msexcel" />