<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<cfif #request.status_cd# is not "pendingBcaReview">
<cfoutput>
<div class="warning">
SR Status: #request.status_desc#<br><br>
This Service Request is Locked at this time
</div>
</cfoutput>
</cfif>

<cfoutput>
<form action="add_driveway2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<!--- <div class="formbox"> --->
<div class="divSubTitle">Add Driveway</div>

<div class="field">
<input type="radio" name="driveway_category" id="driveway_category"  value="R" required="yes"> Residential
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="driveway_category" id="driveway_category"  value="C" required="yes"> Commercial
</div>

<div class="field">
<input type="radio" name="driveway_material" id="driveway_material" value="C" required="yes"> Concrete
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="driveway_material"  id="driveway_material" value="A" required="yes"> Other
</div>

<div class="field">
<label>
Case
</label>
<select name="driveway_case" id="driveway_case" required="yes">
	<option value="0" SELECTED>Select Case</option>
	<option value="1">Case 1</option>
	<option value="2">Case 2</option>
	<option value="3">Case 3</option>
	<option value="4">Case 4</option>
</select>
</div>

<div class="field">
<label>Width of Driveway Approach (W)</label>
<input type="number" name="w_ft" id="w_ft" size="10" placeholder="ft" required="yes">&nbsp;&nbsp;&nbsp;<input type="number" name="w_in" id="w_in" size="10" placeholder="in" >
</div>

<div class="field">
<label>Curb to back of sidewalk (A)</label>
<input type="number" name="a_ft" id="a_ft" size="10" placeholder="ft" required="yes">&nbsp;&nbsp;&nbsp;<input type="number" name="a_in" id="a_in" size="10" placeholder="in">
</div>

<div class="field">
<label>Width of gutter (GW)</label>
<input type="number" name="gw_in" id="gw_in" size="10" placeholder="in" required="yes">
</div>

<div class="field">
<label>Curb Height (CH)</label>
<input type="number" name="ch_in" id="ch_in" size="10" placeholder="in" required="yes">
</div>

<div class="field">
<label>Any items near driveway:</label>
<input type="radio" name="items_near_driveway" id="items_near_driveway" value="Y" required="yes"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="items_near_driveway" id="items_near_driveway" value="N" required="yes"> No
</div>

<div class="field">
<label>If Yes, Describe</label>
<textarea name="items_near_driveway_comments" id="items_near_driveway_comments" style="width:95%;height:50px;"></textarea>
</div>

<!--- </div> --->

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>

</form>
</cfoutput>

<cfinclude template="footer.cfm">
