<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>(SRR) Sidewalk Repair Rebate Program - City of Los Angeles</title>
<link rel="stylesheet" type="text/css" href="/srr/css/boe_main_2015.css">
</head>
<body>

<div class="textbox" style="width:700px;">
<h1>Error Encountered!</h1>
<p>A Server Error was Ecountered</p>

<p>The Cause of the Error was emailed to administrator</p>

<p>We will fix the error as soon as possible.</p>
</div>


<!--- 


<br>
<br>

<B><FONT color="red">
Error occurred while processing:&nbsp;&nbsp;
</FONT>
</B>

<b>
#error.template#
</b>

<br><br>

<B>
<FONT color="red"> 
HTTP Referer:&nbsp;&nbsp;
</FONT>
</B>

<strong>
#error.HttpReferer# 
</strong>

<BR>
<br>


<B>
<FONT color="red">
Date and Time Error Encountered:&nbsp;&nbsp;
</FONT>
</B>

<strong>
#error.datetime#
</strong>

<br>
<BR>

<B>
<FONT color="red">
User IP Address:&nbsp;&nbsp;
</FONT>
</B>

<strong>
#error.RemoteAddress#
</strong>

<BR>
<br>

<B>
<FONT color="red"> 
User Browser: &nbsp;&nbsp;
</FONT>
</B>

<strong>
#error.Browser# 
</strong>

<BR>
<br>

<B>
<FONT color="red">
Diagnostic Message(s):&nbsp;&nbsp;
</FONT>
</B>

<b>
#error.Diagnostics#
</b> 

<br>
<br>



<B>
<FONT color="red"> 
Query String:&nbsp;&nbsp;
</FONT>
</B>

<strong>
#error.QueryString# 
</strong> --->

</body>
</html>

</cfoutput>

<cfinclude template="email_error.cfm">

<cfabort>