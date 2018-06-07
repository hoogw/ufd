<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>::: Maintenance Hole Cover Opening Permit :::</title>
</head>


<body>
<div align="center">
<b>
<font face="Arial" size="3" color="red">
APPLICATION ERROR!
</font>
</B>
</div>
<HR size="2" noshade>
<p><B><font face="Arial, Helvetica, sans-serif" size="2" color="Red">Please highlight 
  all text below the following line and e-mail it to:&nbsp;</FONT> </B> <A href="mailto:#error.mailto#">Essam.Amarragy@lacity.org</A></p>
<HR size="2" noshade>
<B><FONT color="red" size="2" face="Arial, Helvetica, sans-serif"> Date and Time 
Error Encountered:</FONT></B>&nbsp;&nbsp;#error.datetime# <br>
<BR>

<B><FONT size="2" face="Arial, Helvetica, sans-serif" color="red">
User IP Address:</FONT></B>&nbsp;&nbsp;#error.RemoteAddress#
<BR>
<B><FONT face="Arial, Helvetica, sans-serif" size="2" color="red"> <br>
User Browser:</FONT></B>&nbsp;&nbsp;#error.Browser# <BR>
<B><FONT face="Arial, Helvetica, sans-serif" size="2" color="red"> <br>
Diagnostic Message(s):</FONT></B>&nbsp;&nbsp;<b>#error.Diagnostics#</b> <B><FONT face="Arial, Helvetica, sans-serif" size="2" color="red"> 
<br>
<br>
HTTP Referer:</FONT></B>&nbsp;&nbsp;#error.HttpReferer# <BR>
<B><FONT face="Arial, Helvetica, sans-serif" size="2" color="red"> <br>
Query String:</FONT></B>&nbsp;&nbsp;#error.QueryString# <BR>
<B><FONT face="Arial, Helvetica, sans-serif" size="2" color="red"> <br>
Error occured while processing:</FONT></B>&nbsp;&nbsp;<b>#error.template#</b>
</body>
</html>

</cfoutput>

<cfinclude template="email_error.cfm">

<cfabort>
