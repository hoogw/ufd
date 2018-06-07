<cfquery name="getApplicant" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, app_name_nn
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<form action="control.cfm?action=override_applicant2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Overriding Applicant Name</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td>Old Applicant Name:</td>
	<td><strong>#getApplicant.app_name_nn#</strong></td>
</tr>

<tr>
	<td>New Applicant Name:</td>
	<td><input type="text" name="new_app_name" id="new_app_name" size="30" required></td>
</tr>

<tr>
	<td colspan="2" valign="top">Justification:<br>
	<textarea style="width:90%;height:100px;" name="justification" id="justification" required></textarea>
	</td>
</tr>
</table>



  


</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save" class="submit"></div>

</FORM>

</cfoutput>





