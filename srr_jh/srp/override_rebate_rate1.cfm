<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="last_rate_nbr" datasource="#request.dsn#" dbtype="datasource">
select max(rate_nbr) as last_rate_nbr
from rebate_rates
</cfquery>

<cfquery name="current_rate_nbr" datasource="#request.dsn#" dbtype="datasource">
select rate_nbr as current_rate_nbr
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfif #last_rate_nbr.last_rate_nbr# is #current_rate_nbr.current_rate_nbr#>
<div class = "warning">This application is already using the latest rate/cap.</div>
<cfabort>
</cfif>

<cfoutput>
<form action="control.cfm?action=override_rebate_rate2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Overriding Rebate Rate/Cap</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td><strong>Apply the latest rate/cap to this application</strong></td>
</tr>


</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Apply Latest Rate/Cap" class="submit"></div>
</FORM>
</cfoutput>





