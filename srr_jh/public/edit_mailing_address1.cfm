<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">

<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
function checkForm()
{

// validating not blank
var fld = document.form1.sw_length_ft;
var msg = "Length of Sidewalk (ft) field is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating positive integer (unsigned integer)
var fld = document.form1.sw_length_ft;
var msg = "Length of Sidewalk (ft)\n \nmust be an integer!";
if (fld.value != "")
{
if (!isPositiveInteger(fld, msg))
{
fld.focus();
fld.select();
return false;
}
}
// validating positive integer (unsigned integer)


// validating positive integer (unsigned integer)
var fld = document.form1.sw_length_in;
var msg = "Length of Sidewalk (in)\n \nmust be an integer!";
if (fld.value != "")
{
if (!isPositiveInteger(fld, msg))
{
fld.focus();
fld.select();
return false;
}
}
// validating positive integer (unsigned integer)

// validating not blank
var fld = document.form1.sw_width_ft;
var msg = "Width of Sidewalk (ft) field is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank


// validating positive integer (unsigned integer)
var fld = document.form1.sw_width_ft;
var msg = "Width of Sidewalk (ft)\n \nmust be an integer!";
if (fld.value != "")
{
if (!isPositiveInteger(fld, msg))
{
fld.focus();
fld.select();
return false;
}
}
// validating positive integer (unsigned integer)


// validating positive integer (unsigned integer)
var fld = document.form1.sw_width_in;
var msg = "Width of Sidewalk (in)\n \nmust be an integer!";
if (fld.value != "")
{
if (!isPositiveInteger(fld, msg))
{
fld.focus();
fld.select();
return false;
}
}
// validating positive integer (unsigned integer)

document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;
}
</script>

<cfinclude template="../common/include_sr_job_address.cfm">

<cfoutput>
<form action="edit_mailing_address2.cfm" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Your Mailing Address</h1>

<div class="field">
<label>Address</label>
<input type="text" name="mailing_address1" id="mailing_address1" size="30" placeholder"Required">
</div>

<div class="field">
<label>Address (line 2)</label>
<input type="text" name="mailing_address2" id="mailing_address2" size="30" placeholder"Optional">
</div>

<div class="field">
<label>City</label>
<input type="text" name="mailing_city" id="mailing_city" size="30" placeholder"Required">
</div>


<cfquery name="states" datasource="common" dbtype="datasource">
select * from state_lookup
order by state_name
</cfquery>
<div class="field">
<label>State (Required)</label>
&nbsp;&nbsp;<select name="mailing_state" id="mailing_state">
	<option value="" SELECTED>Select State</option>
	<cfloop query="states">
	<option value="#states.state#">#states.state_name#</option>
	</cfloop>
</select>
</div>


<div class="field">
<label>Zip</label>
<input type="text" name="mailing_zip" id="mailing_zip" size="20">
</div>


</div>

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save"> &nbsp;&nbsp;
<input type="button" name="toReq" id="toReq" value="Back to Requirements"  onClick="location.href='app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'" class="submit">
</div>

</form>
</cfoutput>

<cfinclude template="footer.cfm">

