<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
// This is the main function to check the form entries [start]
function checkForm()
{

// validating not blank
var fld = document.form1.license_no;
var msg = "Contractor License Number is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;
}
// This is the main function to check the form entries [end]

</script>

<cfoutput>
<form action="validate_contractor_license.cfm?srrKey=#request.srrKey#" method="post" name="form1" id="form1" onSubmit="return checkForm();">

<div class="formbox" style="width:550px;">
<h1>Contractor Verification</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td>Contractor's License Number (California)</td>
<td><input type="text" name="license_no" id="license_no" size="20" value=""></td>
</tr>

</table>
</div>

<br>
<div align="center"><input type="submit" name="submit" id="submit" value="Validate" class="submit">

&nbsp;&nbsp;
<input type="button" name="toReq" id="toReq" value="Back to Requirements"  onClick="location.href='app_requirements.cfm?srrKey=#request.srrKey#'" class="submit">
</div>
</form>
 
</cfoutput> 

</body>
</html>