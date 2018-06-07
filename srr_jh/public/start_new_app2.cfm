
<cfoutput>
<form action="control.cfm?action=app_requirements&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="textbox" style="width:700px;">
<h1>New Application Started</h1>
You just started a new Sidewalk Program Interest application.
<br><br>
<strong>Your application Reference Number is: <span style="color:red;">#request.srr_id#</span></strong>
<br><br>
Please use only the navigation buttons and links within the application.
<br><br>
At any time you can resume your application process by clicking &quot;My Application(s)&quot; and click on the above reference number.
</div>

<div align="center">
<!---<input type="submit" name="submit" value=" Next &gt;&gt; " class = "submit">--->
<input type="button" name="next" id="next" value="Next &gt;&gt;" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'">
</div>

</form>
</cfoutput>