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

<cfif #find_srr.ddate_submitted# is not "">
<cflocation addtoken="No" url="../common/dsp_app.cfm?srr_id=#request.srr_id#&#request.addtoken#">
</cfif>

<script language="JavaScript">
<!--
function checkForm()
{

if (document.form1.prop_type[0].checked==false && document.form1.prop_type[1].checked == false)
{
alert("You must select the Property Type!");
document.form1.prop_type[0].focus();
return false;
}

if (document.form1.work_description.selectedIndex == 0)
{
alert ("You must select a valid option for Work Description!");
document.form1.work_description.focus()
return false
}

if (document.form1.tree_root_damage[0].checked==false && document.form1.tree_root_damage[1].checked == false)
{
alert("You must select Yes or No for:\n\n\Is Repair due to Tree Roots Damage?");
document.form1.tree_root_damage[0].focus();
return false;
}


return true
}

//-->

</script>

<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->
<!-- Do the following in all cases -->


<cfoutput>
<form action="control.cfm?action=edit_work_description2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm()">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="formbox" style="width:700px;">
<h1>Work Description</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr><td colspan="3" align="center"><span class="required">*</span> = Required Field</td></tr>

<tr>
<td width="40%">
Property Type <span class="required">*</span>
</td>
<td>
<input type="radio" name="prop_type" value="r" <cfif #find_srr.prop_type# is "r">checked</cfif>>&nbsp;&nbsp;Residential &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="prop_type" value="c" <cfif #find_srr.prop_type# is "c">checked</cfif>> Commercial/Industrial
</td>
</tr>

<tr>
<td width="40%">
Reason for Sidewalk Replacement <span class="required">*</span>
</td>
<td width="60%">
<select size="1" name="work_description">
<option value="" <cfif #find_srr.work_description# is "">selected</cfif>>Select One</option>
<option value="ada" <cfif #find_srr.work_description# is "ada">selected</cfif>>ADA Compliance</option>
<option value="mis" <cfif #find_srr.work_description# is "mis">selected</cfif>>Missing Segments</option>
<option value="cra" <cfif #find_srr.work_description# is "cra">selected</cfif>>Cracked Sidewalk</option>
<option value="up" <cfif #find_srr.work_description# is "up">selected</cfif>>Uplifted Segments</option>
</select>
</td>
</tr>

<tr>
<td width="40%">
Is any portion of the repair due to street tree root damage? <span class="required">*</span>
</td>
<td width="60%">
<input type="radio" name="tree_root_damage" value="Y" <cfif #find_srr.tree_root_damage# is "Y">checked</cfif>>&nbsp; Yes
&nbsp;&nbsp;&nbsp;
<input type="radio" name="tree_root_damage" value="N" <cfif #find_srr.tree_root_damage# is "N">checked</cfif>>&nbsp; No
</td>
</tr>


<tr>
<td width="100%" colspan="3" align="center">
Customer comments:
</td>
</tr>


<tr>
<td width="100%" colspan="3" align="center">
<textarea name="cust_comments" id="cust_comments" style="height:200px;width:600px;">#find_srr.cust_comments#</textarea>
</td>
</tr>

</table>
</div>

<div align = "center">
<input type="submit" name="save" id="save" value="Save" class="submit">
<input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'">
</div>

</form>

</cfoutput>
