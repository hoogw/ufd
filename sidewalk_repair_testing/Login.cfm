
<cfparam name="s" default="">
<cfoutput>
<HTML>
<HEAD>
<TITLE>Login</TITLE>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="css/css.cfm">
</HEAD>

<style type="text/css">
body{background-color: transparent}
</style>

<body alink="blue" vlink="blue" bottommargin="0" marginheight="0" topmargin="0" rightmargin="0">

<!--- <img src="Images/mtabouttrees.jpg" width="550" height="135" alt="" border="0"> --->

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr> 
            <td height="15"></td>
          </tr>
          <tr> 
		  	<cfif s is 1>
            	<td align="center" class="pagetitle">Create a New Repair Package or Add Sites to an Existing Package Login</td>
			<cfelseif s is 2>
				<td align="center" class="pagetitle">New Sidewalk Repair Site Login</td>
			<cfelseif s is 3>
				<td align="center" class="pagetitle">Search Sidewalk Repair Sites Login</td>
			<cfelseif s is 4>
				<td align="center" class="pagetitle">Search Sidewalk Repair Packages Login</td>
			<cfelseif s is 5>
				<td align="center" class="pagetitle">Download Sidewalk Repair Data Login</td>
			<cfelseif s is 6>
				<td align="center" class="pagetitle">Generate Sidewalk Repair Reports Login</td>
			<cfelseif s is 7>
				<td align="center" class="pagetitle">Sidewalk Repair User Rights Login</td>
			<cfelseif s is 8>
				<td align="center" class="pagetitle">SSDR Downloads</td>
			<cfelseif s is 9>
				<td align="center" class="pagetitle">SSDR Adjustors Report</td>
			<cfelseif s is 10>
				<td align="center" class="pagetitle">SSDR Uploads</td>
			<cfelse>
				<td align="center" class="pagetitle">Log On</td>
			</cfif>
          </tr>
		   <tr> 
            <td height="15"></td>
          </tr>
          <!--- <tr align="left"> 
            <td class="page">This form is utilized by authorized City of Los Angeles agencies and community organizations reporting plantings on public property within the City of Los Angeles.
              </td>
          </tr>
		  <tr> 
            <td height="10"></td>
          </tr>
          <tr> 
            <td class="page">If your agency or organization performs tree plantings on public property within the City of Los Angeles, you may call 999-9999 to request to have one or more user IDs authorized to report tree plantings.</td>
          </tr>
		  <tr> 
            <td height="10"></td>
          </tr> --->
          <tr> 
            <td class="page" align="center">Once you have an authorized user ID, you may provide information below and <strong>SUBMIT</strong>.</td>
          </tr>
		  <tr> 
            <td height="15"></td>
          </tr>
		</table>
  	</td>
  </tr>
</table>
<TABLE width="100%" cellspacing="0" cellpadding="0" border="0">
  <TR> 
    <td valign="TOP"> 
      <form id="form1" action="verifylogin.cfm" method="POST">
	  
	  	<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
		<tr>
		<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
			<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
			<tr>
				<th class="drk left middle" colspan="2" style="height:30px;">Login:</td>
			</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">User ID:</th>
					<td class="frm" style="width:180px;padding:0px 0px 0px 5px;"><INPUT type="Text" name="login" value="" style="width:170px;" class="rounded"></td>
				</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">Password:</td>
					<td class="frm" style="width:180px;">&nbsp;<input class="rounded" type="password" name="password" id="password" maxlength="10" style="width:170px;"></td>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	
	<table align=center border="0" cellpadding="0" cellspacing="0">
		<tr><td height=10></td></tr>
		<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Submit</a>
			</td>
		</tr>
	</table>
	  
        <table width="100%" cellspacing="0" cellpadding="0" border="0">
          <TR> 
            <TD width="5"></TD>
            <TD> 
              <TABLE border="0" cellspacing="0" cellpadding="2" align="center" width="100%">
				  <cfif isdefined("relog")>
		  			<cfif relog is "false">
					  <cfif chk is "log">
					  <tr>
                  		<TD height="35" colspan="3" class="page" align="center"><font color="#request.color#"><strong>User ID</strong></font> is not recognized as an authorized Login ID.</TD>
					  </tr>
					  <cfelseif chk is "pass">
					   <tr>
                  		<TD height="35" colspan="3" class="page" align="center"><font color="#request.color#"><strong>Password</strong></font> does not match <font color="#request.color#"><strong>User ID</strong></font>. For assistance with Login, Please Call: (213) 482-7124.</TD>
					  </tr>
					  <cfelse>
					   <tr>
                  		<TD height="35" colspan="3" class="page" align="center">You are <font color="#request.color#"><strong>NOT AUTHORIZED</strong></font> to view this page.<br>For assistance with Login, Please Call: (213) 482-7124.</TD>
					  </tr>
					  </cfif>
					<cfelse>
					  <TR> 
                  		<TD height="35" colspan="3" class="page" align="center"><!--- Your session has <font color="E36F1E"><strong>TIMED OUT</strong></font>. Please re-login.</font> ---></TD>
		          	  </TR>
				  	</cfif>
				  </cfif>
				</tr>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
		<input type="Hidden" name="s" value="#s#">
      </form>
    </TD>    
  </TR>
</TABLE>
</body>
</cfoutput>

<script>
function submitForm() {	$("#form1").submit(); }

$(function() {
	$(document).keyup(function (e) { 
		if (e.keyCode == 13) { submitForm(); }
	});
});



</script>

</html>

