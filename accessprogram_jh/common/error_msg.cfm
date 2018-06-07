<cfparam name="attributes.error_msg" default="An Error has Occurred!">
<cfparam name="attributes.showBackButton" default="0">

<cfoutput>
<div class="textbox" style="width:600px;">
<h1>Error Encountered!</h1>

<div style="font-weight:bold;text-align:center;">Error Message:</div>
<br>
<div align="center"><img src="/common/excalmtrans.png" alt="" width="100" height="85" border="0"></div>
<br>
<div style="color:red;font-weight:bold;text-align:center;">#attributes.error_msg#</div>
<br>
<p><u><strong>Possible Causes of Error:</strong></u></p>

<p>Required information/data is missing.</p>

<p>Returning to a bookmarked page without login.</p>

<p>Using the browser back button.  Please use the navigation links provided within the application.</p>

<p>Javascript or Cookies are disabled in your browser.</p>
</div>
</cfoutput>


<cfif #attributes.showBackButton# is 1>
<br>
<div align="center">
<form method="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfif>

<cfabort>
