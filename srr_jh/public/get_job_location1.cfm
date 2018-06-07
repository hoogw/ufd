<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<script language="JavaScript" type="text/javascript">

function checkForm()
{

if (document.form1.hse_nbr.value == "")
{
alert ("House Number is Required!");
document.form1.hse_nbr.focus();
document.form1.hse_nbr.select();
return false;
}


if (document.form1.str_nm.value == "")
{
alert ("Street Name is Required!");
document.form1.str_nm.focus();
document.form1.str_nm.select();
return false;
}

return true;

}
</script>

<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->


<cfoutput query="find_srr">
<form action="control.cfm?action=get_job_location2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="formbox" style="width:700px;">
<h1>Address Verification</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<td colspan="2" align="center">
<strong>* = Required Field</strong>
</td>
</tr>

<tr>
<td width="40%">
House Number *
</td>
<td width="60%">
<input type="text" name="hse_nbr" size="6" maxlength="15">&nbsp;&nbsp;(Example: 650)
</td>
</tr>

<tr>
<td width="40%">
Street Name *
</td>
<td width="60%">
<input type="text" name="str_nm" size="20" maxlength="60">&nbsp;&nbsp; (Example: Spring)
</td>
</tr>

</table>
</div>

<div align = "center">
<input type="submit" name="next" id="next" value="Search" class="submit"><input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'">
</div>
</form>
</cfoutput>
