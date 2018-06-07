<cfinclude template="validate_arKey.cfm">

<style>
hr {
margin-top:5px;
margin-bottom:5px;
}
</style>

<cfquery name="getH" datasource="#request.dsn#" dbtype="datasource">
SELECT record_history
from ar_info
where arKey = '#request.arKey#'
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

