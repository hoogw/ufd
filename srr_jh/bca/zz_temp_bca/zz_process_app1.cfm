

<cfoutput>
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="formbox" style="width:700px;">
<h1>Application Processing</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
	<tr>
		<td>Total Sidewalk Length</td>
		<td><input type="text" name="sw_length_ft" id="sw_length_ft"></td>
	</tr>
	
		<tr>
		<td>Total Sidewalk Width</td>
		<td><input type="text" name="sw_width_ft" id="sw_width_ft"></td>
	</tr>
	
		<tr>
		<td>Rebate Eligible Sidewalk Length</td>
		<td><input type="text" name="eligible_sw_length_ft" id="eligible_sw_length_ft"></td>
	</tr>
	
		<tr>
		<td>Rebate Eligible Sidewalk Width</td>
		<td><input type="text" name="eligible_sw_width_ft" id="eligible_sw_width_ft"></td>
	</tr>
	
	
	
	
	<tr>
		<td>Is BSS Pre-Inspection Required</td>
		<td><input type="radio" name="bss_action_req" value="y"> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="bss_action_req" value="n"> No</td>
	</tr>
	<tr>
	
	
		<tr>
		<td colspan="2"><p>Selecting <strong>Yes</strong> will forward the application to BSS to perform tree pre-inspection/assessment.</p>
		<p>Selecting <strong>No</strong> will bypass BSS and will forward the application to Street and Stormwater Division (SSD) for final review and offer.</p></td>
	</tr>


</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</form>

<div style="width:700px;margin-right:auto;margin-left:auto;"><div class="highlightedDiv">Temporary Notes about required data and more information:</p>
<p>The A-permit currently capture sidewalk repairs as segments where users indicate the length and width of each segment in ft and in.</p>
<p>How should we capture the information and facilitate copying the information to an A-permit with further data entry on the A-permit side.</div></div>
</cfoutput>

