<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Program">
<cfinclude template="../common/validate_srrKey.cfm">

<cfinclude template="../common/include_sr_job_address.cfm">

<cfinclude template="add_to_scope_menu.cfm">

<cfoutput>
<form action="add_driveway2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<div class="formbox" style="width:600px;">
<h1>Add Driveway</h1>

<div class="field">
<input type="radio" name="driveway_category" id="driveway_category"  value="R" required="Yes"> Residential
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="driveway_category" id="driveway_category"  value="C" required="Yes"> Commercial
</div>

<div class="field">
<input type="radio" name="driveway_material" id="driveway_material" value="C" required="Yes"> Concrete
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="driveway_material"  id="driveway_material" value="A" required="Yes"> Other
</div>

<div class="field">
<label>
Case
</label>
<select name="driveway_case" id="driveway_case" required="Yes">
	<option value="0" SELECTED>Select Case</option>
	<option value="1">Case 1</option>
	<option value="2">Case 2</option>
	<option value="3">Case 3</option>
	<option value="4">Case 4</option>
</select>
</div>

<div class="field">
<label>Width of Driveway Approach (W)</label>
<input type="number" name="w_ft" id="w_ft" size="10" placeholder="ft" required="Yes">&nbsp;&nbsp;&nbsp;<input type="number" name="w_in" id="w_in" size="10" placeholder="in">
</div>

<div class="field">
<label>curb to back of sidewalk (A)</label>
<input type="number" name="a_ft" id="a_ft" size="10" placeholder="ft" required="Yes">&nbsp;&nbsp;&nbsp;<input type="number" name="a_in" id="a_in" size="10" placeholder="in">
</div>

<div class="field">
<label>Width of gutter (GW)</label>
<input type="number" name="gw_in" id="gw_in" size="10" placeholder="in" required="Yes">
</div>

<div class="field">
<label>Curb Height (CH)</label>
<input type="number" name="ch_in" id="ch_in" size="10" placeholder="in" required="Yes">
</div>

<div class="field">
<label>Any items near driveway:</label>
<input type="radio" name="items_near_driveway" id="items_near_driveway" value="Y" required="Yes"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="items_near_driveway" id="items_near_driveway" value="N" required="Yes"> No
</div>

<div class="field">
<label>If Yes, Describe</label>
<textarea name="items_near_driveway_comments" id="items_near_driveway_comments" style="width:95%;height:50px;"></textarea>
</div>

</div>

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>

</form>
</cfoutput>

<cfinclude template="footer.cfm">
