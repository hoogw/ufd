<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select 
srr_id
, ddate_submitted
, app_id
, prop_type
, work_description
, tree_root_damage
, cust_comments

from srr_info 

where 
srr_id = #request.srr_id#
</cfquery>

<cfoutput>

<div class="formbox" style="width:700px;">
<h1>Work Description</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr><td colspan="3" align="center"><span class="required">*</span> = Required Field</td></tr>

<tr>
<td width="40%">
Property Type <span class="required">*</span>
</td>
<td>
<span class="data">
<cfif #find_srr.prop_type# is "r">
Residential
<cfelseif #find_srr.prop_type# is "c">
Commercial/Industrial
<cfelse>
Not Assigned
</cfif>
</span>
</td>
</tr>

<tr>
<td width="40%">
Reason for Sidewalk Replacement <span class="required">*</span>
</td>
<td width="60%">
<span class="data">
<cfif #find_srr.work_description# is "ada">
ADA Compliance
<cfelseif #find_srr.work_description# is "mis">
Missing Segments
<cfelseif #find_srr.work_description# is "cra">
Cracked Sidewalk
<cfelseif #find_srr.work_description# is "up">
Uplifted Segments
<cfelse>
Not Assigned
</cfif>
</span>
</td>
</tr>

<tr>
<td width="40%">
Is any portion of the repair due to street tree root damage? <span class="required">*</span>
</td>
<td width="60%">
<cfif #find_srr.tree_root_damage# is "Y">
<span class="data">Yes</span>
<cfelseif #find_srr.tree_root_damage# is "N">
<span class="data">No</span>
<cfelse>
<span class="data">Not Selected</span>
</cfif>
</td>
</tr>


<tr>
<td width="100%" colspan="3" align="center">
Customer comments:<br>
<span class="data">#find_srr.cust_comments#</span>&nbsp;
</td>
</tr>



</table>
</div>

<!--- <div align = "center">
<input type="submit" name="save" id="save" value="Save" class="submit">
<input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'">
</div>

</form> --->

</cfoutput>
