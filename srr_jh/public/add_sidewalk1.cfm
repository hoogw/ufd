<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

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



<cfoutput>
<form action="add_sidewalk2.cfm" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="ref_no" id="ref_no" value="#request.a_ref_no#">

<div class="formbox" style="width:600px;">
<h1>Add Sidewalk Segment</h1>

<div class="field">
<label>Segment Length</label>
<input type="number" name="sw_length_ft" id="sw_length_ft" size="10" placeholder="ft">&nbsp;&nbsp;&nbsp;<input type="number" name="sw_length_in" id="sw_length_in" size="10" placeholder="in">
</div>

<div class="field">
<label>Segment Width</label>
<input type="number" name="sw_width_ft" id="sw_width_ft" size="10" placeholder="ft">&nbsp;&nbsp;&nbsp;<input type="number" name="sw_width_in" id="sw_width_in" size="10" placeholder="in">
</div>

<!--- <div class="field">
<label>Eligible</label>
<input type="radio" name="dwy_type" value="r"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="dwy_type" value="c"> No
</div> --->

</div>

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>

</form>
</cfoutput>

<cfinclude template="footer.cfm">

