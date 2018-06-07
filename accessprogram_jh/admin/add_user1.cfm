<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
// This is the main function to check the form entries [start]
function checkForm()
{

// validating not blank
var fld = document.form1.first_name;
var msg = "First Name is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating not blank
var fld = document.form1.last_name;
var msg = "Last Name is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating not blank
var fld = document.form1.user_name;
var msg = "User Name is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating email
var fld = document.form1.user_email;
var msg = "Invalid Email";
if (!isEmail(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating email

// validate pull down menu option selected
var fld = document.form1.user_agency;
var msg = "User Agency is Required";
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

<cfoutput>

<form action="control.cfm?action=add_user2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">

<div class="formbox" style="width:600px;">
<h1>Add User</h1>

<table border="1"  class = "formtable" style = "width: 100%;">
<tr><td colspan="2" align="center"><span class="required">*</span> Required</td></tr>


<tr>
<td width="50%">First Name <span class="required">*</span></td>

<td width="50%">
<input type="text" name="first_name" id="first_name" size="20">
</td>
</tr>


<tr> 
<td>Last Name <span class="required">*</span></td>

<td>
<input type="text" name="last_name" id="last_name" size="20">
</td>
</tr>

<tr>
<td>Phone</td>

<td>
<input type="text" name="user_phone" id="user_phone" size="20">
</td>
</tr>

<tr> 
<td>User Name <span class="required">*</span></td>

<td>
<input type="text" name="user_name" id="user_name" size="20">
</td>
</tr>


<tr>
<td>Password</td>

<td>
newuser
</td>
</tr>


<tr> 
<td>Email <span class="required">*</span></td>

<td>
<input type="text" name="user_email" id="user_email" size="30">
</td>
</tr>


<tr>
<td>User Agency <span class="required">*</span></td>

<cfquery name="get_agency" datasource="#request.dsn#" dbtype="datasource">
select * from agency
order by agency_name
</cfquery>



<td> 
<select NAME="user_agency">
<option value="" selected>Select Agency</option>
<CFLOOP QUERY="get_agency">
<option value="#get_agency.user_agency#">#get_agency.agency_name#</option>
</cfloop>
</select>
</td>
</tr>



<tr>
<td>Administrator</td>
<td><input type="checkbox" name="administrator" id="administrator" value="1">
</td>
</tr>


</table>
</div>


<div align="center"><input type="submit" name="submit" id="submit" value="Add User" class="submit"></div>

</form>

<br><br>
<div align="center">User will be asked to change his or her password at first login.</div>

</cfoutput>
