<cfinclude template="../common/html_top.cfm">
<CFPARAM NAME="request.login" DEFAULT="0">

<script language="JavaScript" type="text/javascript">
<!--
function checkForm()
{


if (document.form1.pw1.value == "")
{
alert ("New Password Cannot be Blank!");
document.form1.pw1.focus();
return false
}

if (document.form1.pw1.value.toUpperCase() == "ENG78" || document.form1.pw1.value.toUpperCase() == "NEWUSER")
{
alert ("This password is not acceptable!");
document.form1.pw1.focus();
return false
}


if (document.form1.pw2.value == "")
{
alert ("You must confirm password!");
document.form1.pw2.focus();
return false
}

if (document.form1.pw1.value.toUpperCase() != document.form1.pw2.value.toUpperCase())
{
alert ("Password and Confirmed Password do not match!");
document.form1.pw1.focus();
return false
}

return true;
}

//-->
</script>

<cfoutput>
<div class="title">You must change your password to continue</div>


<form action="edit_password2.cfm?#request.addtoken#<cfif #request.login# is 1>&login=1</cfif>" method="post" name="form1" id="form1" onSubmit="return checkForm();">


<div class="formbox" style="width:550px;">
<h1>Change Password</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<TD>
New Password:
</TD>
<TD>
<input type="password" name="pw1" id="pw1" size="12" required = "yes">
</TD>
</tr>

<tr>
<TD>
Confirm Password
</TD>
<TD>
<input type="password" name="pw2" id="pw2" size="12"  required = "yes">
</TD>
</tr>
</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Continue &gt;&gt;"></div>

</form>
</cfoutput>

