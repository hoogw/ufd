<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="srr_info" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id, ddate_submitted
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->
<cfoutput>

<form action="control.cfm?action=add_job_location3&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">


<div class="formbox" style="width:700px;">
<h1>Property Address</h1>
<table border="1"  class = "formtable" style = "width:100%;">
<tr>
<td>Property Address</td>
<td><input type="text" name="job_address" id="job_address" size="35"></td>
</tr>

<tr>
<td>City</td>
<td><input type="text" name="job_city" id="job_city" size="35"></td>
</tr>

<tr>
<td>Zip Code</td>
<td><input type="text" name="job_zip" id="job_zip" size="20"></td>
</tr>

<tr>
<td>Engineering District</td>
<td>
<select name="boe_dist" id="boe_dist">
	<option value="" SELECTED>Select One</option>
	<option value="c">Central District</option>
	<option value="v">Valley District</option>
	<option value="w">West LA District</option>
	<option value="h">Harbor District</option>
</select>
</td>
</tr>


<tr>
<td>Council District</td>
<td><input type="text" name="council_dist" id="council_dist" size="20"></td>
</tr>



<tr>
<td>Assessor Parcel Number (APN)</td>
<td><input type="text" name="bpp" id="bpp" size="20"></td>
</tr>

<tr>
<td>Unit Range (if applicable)</td>
<td><input type="text" name="unit_range1" id="unit_range1" size="20"></td>
</tr>


</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"><input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'"></div>


</cfoutput>

