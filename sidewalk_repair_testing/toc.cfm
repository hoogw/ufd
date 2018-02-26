<HTML>
<HEAD>
<TITLE>Million Trees LA</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<!-- ImageReady Preload Script (mtmenu.psd) -->

<cfif isdefined("logout")>
	<cflock timeout=20 scope="Session" type="Exclusive">
  		<cfset StructDelete(Session, "userid")>
		<cfset StructDelete(Session, "password")>
		<cfset StructDelete(Session, "agency")>
		<cfset StructDelete(Session, "user_level")>
		<cfset StructDelete(Session, "user_power")>
		<cfset StructDelete(Session, "user_num")>
		<cfset StructDelete(Session, "arrSUMAll")>
		<cfset StructDelete(Session, "arrWWUsers")>
		<cfset StructDelete(Session, "siteQuery")>
		<cfinclude template="deleteClientVariables.cfm">
	</cflock>
	<cfoutput>
	<script>
	window.parent.location.replace('#request.url#');
	</script>
	</cfoutput>
</cfif>

<SCRIPT TYPE="text/javascript">
function changeFrame(source){
var rand = Math.random();
url = source + "?r=" + rand;
parent.document.getElementById('FORM').src = url
}
</SCRIPT>

<cfoutput>
<cfinclude template="css/css.cfm">
</HEAD>

<style type="text/css">
body{background-color: transparent}
</style>

<body bottommargin="0" marginheight="0" topmargin="0" rightmargin="0" marginwidth="0" leftmargin="0">

<cfif isdefined("session.userid") is true>
<table border="0" cellspacing="0" cellpadding="0" width="#request.width#px;">	
	<tr><td colspan="2" height="80"></td></tr>
	<cfif session.agency is not "Outside">
	<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
	<tr><td colspan="2" style="height:3px;width:100%;"></td></tr>	    
	<tr> 
	<td class="page" height="#request.height#">&nbsp;&nbsp;</td>
  	<td style="width:100%" class="pad"><a href="" onclick="javascript:changeFrame('changePassword.cfm');return false;"><font color="#request.color#">Change Password</font></a></td>
	</tr>		
	</cfif>	
	<tr><td colspan="2" style="height:3px;width:100%;"></td></tr>
	<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>    
	<tr> 
	<tr><td colspan="2" style="height:1px;width:100%;"></td></tr>
	<td class="page" height="#request.height#">&nbsp;&nbsp;</td>
  	<td style="width:100%" class="pad"><a href="" onclick="javascript:self.location.replace('toc.cfm?logout=true');return false;" target="_blank"><font color="#request.color#"><b>Log Off</b></font></a></td>
	</tr>
	<tr><td colspan="2" style="height:3px;width:100%;"></td></tr>
	<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
</table>
</cfif>
  
</BODY>
</cfoutput>
</HTML>