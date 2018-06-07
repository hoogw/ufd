<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
// This is the main function to check the form entries [start]
function checkForm()
{

// validating not blank
var fld = document.form1.first_name;
var msg = "First Name is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating not blank
var fld = document.form1.last_name;
var msg = "Last Name is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating not blank
var fld = document.form1.user_name;
var msg = "User Name is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating email
var fld = document.form1.user_email;
var msg = "Invalid Email!";
if (!isEmail(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating email

// validate pull down menu option selected
var fld = document.form1.user_agency;
var msg = "User Agency is Required!";
if (!v_Pulldown(fld, msg))
{
fld.focus();
return false;
}
// validate pull down menu option selected

return true;
}
// This is the main function to check the form entries [end]

</script>


<cfquery name="get_user" datasource="#request.dsn#" dbtype="datasource">
select * from staff
where user_id=#request.user_id#
</cfquery>


<cfoutput query="get_user">

<form action="control.cfm?action=edit_user2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="user_id" value="#user_id#">

<div class="formbox" style="width:600px;">
<h1>Revise User Information</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr><td colspan="2" align="center"><div align="center"><span class="required">*</span> Required</div></td></tr>

<tr>
<td width="50%">First Name <span class="required">*</span></TD>
<td width="50%">
<input type="text" name="first_name" id="first_name" value="#first_name#" size="20">
</TD>
</tr>


<tr> 
<td>Last Name <span class="required">*</span></TD>

<td>
<input type="text" name="last_name" id="last_name" value="#last_name#" size="20">
</TD>
</tr>

<tr>
<td>Phone</TD>

<td>
<input type="text" name="user_phone" id="user_phone" value="#user_phone#" size="20">
</TD>
</tr>

<tr> 
<td>User Name <span class="required">*</span></TD>

<td>
<input type="text" name="user_name" id="user_name" value="#user_name#" size="20">
</TD>
</tr>


<tr>
<td>Password</TD>

<td>
<FONT SIZE="+1"><B>********</B></FONT>
</TD>
</tr>


<tr> 
<td>Email <span class="required">*</span></TD>

<td>
<input type="text" name="user_email" id="user_email" value="#user_email#" size="35">
</TD>
</tr>


<tr>
<td>User Agency <span class="required">*</span></TD>

<td> 
<cfquery name="get_agency" datasource="#request.dsn#" dbtype="datasource">
select * from agency
</cfquery>

<select NAME="user_agency">
<option value="0" <cfif #get_user.user_agency# is "">selected</cfif>>Select Agency</option>
<CFLOOP QUERY="get_agency">
<option value="#get_agency.user_agency#" <cfif #get_agency.user_agency# is #get_user.user_agency#>selected</cfif>>#get_agency.agency_name#</option>
</cfloop>
</select>
</TD>
</tr>



<tr>
<td>Suspend Account</TD>

<td>
<input type="checkbox" name="suspend" value="1" <cfif #suspend# is 1>checked</cfif>>
</TD>
</tr>


<tr> 
<td>Administrator</TD>

<td>
<input type="checkbox" name="administrator" id="administrator" value="1" <cfif #administrator# is 1>checked</cfif>>
</TD>
</tr>

</table>
</div>

<div align="center">
<input type="submit" name="submit" id="submit" value="Update User Information" class="submit">
</div>
</form>


<form action="control.cfm?action=resetUserPassword&#request.addtoken#" method="post" name="form2" id="form2">
<input type="hidden" name="user_id" id="user_id" value="#user_id#">
<div align="center"><input type="submit" name="submit" id="submit" value="Reset Password" class="submit"></div>
</form>




</cfoutput>

