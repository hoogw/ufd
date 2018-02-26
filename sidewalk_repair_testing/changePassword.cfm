<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfif isdefined("session.userid") is false>
	<script>
	//window.close();
	top.location.reload();
	</script>
	<cfabort>
</cfif>

<script language="JavaScript" type="text/JavaScript">
function MM_validateForm() { //v4.0

  var i,p,q,nm,test,fname,num,min,max,errors='',args=MM_validateForm.arguments;
  
  //errors = chkTotal(errors);
  
  var pass1;
  var pass2;
  
  pass1 = document.form1.new_pass.value;
  pass2 = document.form1.new_pass2.value;
  
  if (pass1 != pass2)
  	errors = "- 'New Password' and 'Confirm New Password' do not match.\n";

  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]); fname=args[i+1];
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+fname+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+fname+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+fname+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+fname+' is required.\n'; }
  } if (errors) alert('The following error(s) occurred:\n'+errors);
  document.MM_returnValue = (errors == '');
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
</script>

<html>
<cfoutput>
<head>
	<title>Verify Log In</title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
	<cfinclude template="css/css.cfm">
</head>

<cfparam name="form.old_pass" default="">
<cfparam name="form.new_pass" default="">
<cfparam name="form.new_pass2" default="">

<style type="text/css">
body{background-color: transparent}
</style>

<body alink="blue" vlink="blue" bottommargin="0" marginheight="0" topmargin="0" rightmargin="0">

<cfset show = "false">
<cfif isdefined("change")>

<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM dbo.tblUsers WHERE user_name = '#session.userid#' AND user_password = '#form.old_pass#'
</cfquery>

	<cfif login_chk.recordcount is 0>
		<cfset show = "true">
	<cfelse>
		
		<cfquery name="login_update" datasource="#request.sqlconn#" dbtype="ODBC">
		UPDATE dbo.tblUsers SET user_password = '#new_pass#' WHERE user_name = '#session.userid#' AND user_password = '#form.old_pass#'
		</cfquery>
		<cfset session.password = new_pass>
		
		<!--- <img src="Images/mtabouttrees.jpg" width="550" height="138" alt="" border="0"> --->
		<table cellspacing="0" cellpadding="0" border="0"><tr><td height="40"></td></tr></table>
		<table cellspacing="0" cellpadding="0" border="0" bordercolor="#request.color#" align="center">
		<tr>
		    <td>
			<table cellspacing="0" cellpadding="0" border="0" align="center" class="frame">
				<tr>
				<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
					<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
						<tr>
							<td bgcolor="#request.bgcolor#" class=page width="300" height="25" align="center">
							<font color="#request.color#">&nbsp;&nbsp;<b>Password Changed Successfully!</b></font></td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		<cfabort>		
	</cfif>

</cfif>

<!--- <img src="Images/mtabouttrees.jpg" width="550" height="138" alt="" border="0"> --->
<table cellspacing="0" cellpadding="0" border="0"><tr><td height="40"></td></tr></table>
<table cellspacing="0" cellpadding="0" border="0" bordercolor="AF9ACC" align=center>
<form name="form1" id="form1" method="post" action="changePassword.cfm" onSubmit="MM_validateForm('old_pass','Old Password','R','new_pass','New Password','R','new_pass2','Confirm New Password','R');return document.MM_returnValue;">
<tr>
    <td>
	<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center">
		<tr>
		<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
			<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
			<tr>
				<th class="drk left middle" colspan="2" style="height:30px;">Change Password:</td>
			</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">User Name:</th>
					<td class="frm"  style="width:180px;">&nbsp;&nbsp;#session.userid#&nbsp;</td>
				</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">Old Password:</td>
					<td class="frm" style="width:180px;">&nbsp;<input class="rounded" type="password" name="old_pass" id="old_pass" value="#form.old_pass#" maxlength="15" style="width:170px;" class="formbody"></td>
				</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">New Password:</td>
					<td class="frm" style="width:180px;">&nbsp;<input class="rounded" type="password" name="new_pass" id="new_pass" value="#form.new_pass#" maxlength="15" style="width:170px;" class="formbody"></td>
				</tr>
				<tr>
					<th class="left middle" style="height:30px;width:130px;">Confirm New Password:</td>
					<td class="frm" style="width:180px;">&nbsp;<input class="rounded" type="password" name="new_pass2" id="new_pass2" value="#form.new_pass2#" maxlength="15" style="width:170px;" class="formbody"></td>
				</tr>
			</table>
		</td>
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
		<td width="15"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="javascript:self.location.replace('swWelcome.cfm'); return false;">Cancel</a>
		</td>
	</tr>
	<input type="Hidden" name="change" value="true">
	</form>
</table>

<cfif show is "true">
<table align=center border="0" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="35" colspan="3" class="page" align="center">Invalid <font color="E36F1E"><strong>Old Password</strong></font>. Please try again.</td>
	</tr>
</table>
</cfif>

<div id="msg" class="box" style="top:40px;left:1px;width:350px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg').hide();return false;"><img src="images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
	</div>
</div>

</body>
</cfoutput>

<script>
function submitForm() {

	$('#msg').hide();
	var errors = '';var cnt = 0;
	
	var pass1 = trim($('#new_pass').val());
  	var pass2 = trim($('#new_pass2').val());
  
  	if (pass1 != pass2) { cnt++; errors = "- 'New Password' and 'Confirm New Password' do not match.<br>"; }
	if (trim($('#old_pass').val()) == '')	{ cnt++; errors = errors + "- Old password is required!<br>"; }
	if (trim($('#new_pass').val()) == '')	{ cnt++; errors = errors + "- New password is required!<br>"; }
	if (trim($('#new_pass2').val()) == '')	{ cnt++; errors = errors + "- Confirm New password is required!<br>"; }

	if (errors != '') {
		$('#msg_text').html(errors);
		$('#msg').height(35+cnt*14);
		$('#msg').css({top:'25%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
		$('#msg').show();
		return false;	
	}
	
	$("#form1").submit();
	
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
</script>

</html>
