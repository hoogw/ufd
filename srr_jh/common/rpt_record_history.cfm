<cfinclude template="header.cfm">

<cfinclude template="validate_srrKey.cfm">


<style>
hr {
margin-top:5px;
margin-bottom:5px;
}
</style>


<body onload="window.open('', '_self', '');">
<div align="center">
<div align="right" style="width:750px; padding-bottom:10px; font-size:105%;">
<form>
<input type="button" name="Close" value="Close" onClick="window.close();" class="submit">
</form>
</div>
</div>

<cfquery name="getH" datasource="#request.dsn#" dbtype="datasource">
SELECT record_history
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>


<div class="textbox" style="width:700px;">
<h1>Record History</h1>
<cfloop index="xx" list="#getH.record_history#" delimiters="|">
<cfoutput>
#xx#
</cfoutput>
<hr>
</cfloop>
</div>

<cfinclude template="footer.cfm">

