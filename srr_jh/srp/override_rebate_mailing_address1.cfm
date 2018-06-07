<cfinclude template="../common/validate_SrrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="getAddress" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
      ,mailing_address1
      ,mailing_address2
      ,mailing_zip
      ,mailing_city
      ,mailing_state
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<form action="control.cfm?action=override_rebate_mailing_address2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Overriding Mailing Address (for Rebate)</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td>Old Mailing Address (for Rebate):</td>
	<td>
	
	<strong>#getAddress.mailing_address1#</strong><br>
	<cfif #getAddress.mailing_address2# is not "">
	<strong>#getAddress.mailing_address2#</strong><br>
	</cfif>
	<strong>#getAddress.mailing_city#</strong> <strong>#getAddress.mailing_state#</strong> <strong>#getAddress.mailing_zip#</strong>
 
	
	
	</td>
</tr>

<tr>
	<td>Mailing Address (line 1):</td>
	<td><input type="text" name="mailing_address1" id="mailing_address1" size="30" required></td>
</tr>

<tr>
	<td>Mailing Address (line 2):</td>
	<td><input type="text" name="mailing_address2" id="mailing_address2" size="30"></td>
</tr>

<tr>
	<td>City:</td>
	<td><input type="text" name="mailing_city" id="mailing_city" size="30" required></td>
</tr>

<tr>
	<td>State:</td>
	<td><input type="text" name="mailing_state" id="mailing_state" size="30" required></td>
</tr>

<tr>
	<td>Zip Code:</td>
	<td><input type="text" name="mailing_zip" id="mailing_zip" size="30" required></td>
</tr>

</table>



  


</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save" class="submit"></div>

</FORM>

</cfoutput>





