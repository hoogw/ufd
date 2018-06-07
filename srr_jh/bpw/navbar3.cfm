<cfinclude template="../common/validate_srrKey.cfm">
<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />
<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=instructions1&#request.addtoken#">Home</a></li><!-- End I Want To Item -->

<!--- class="drop" aria-haspopup="true" --->
<li><a href="control.cfm?action=process_payment1&srrKey=#request.srrKey#&#request.addtoken#">Application</a></li>
 
<li><a href="control.cfm?action=search1&#request.addtoken#">Search</a></li>

<li><a href="control.cfm?action=reports&#request.addtoken#">Reports/Metrics</a></li>


<li onClick=”return true;”><a href="control.cfm?action=log_out&#request.addtoken#">Logout</a></li>

</ul>

<div style="margin-bottom:10px;"></div>
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_payment1" or #request.action# is "attachments">

<div style="margin-left:auto;margin-right:auto;width:700px;">
<cfif #request.action# is "process_payment1">
Process Payment
<cfelse>
<a href="control.cfm?action=process_payment1&srrKey=#request.srrKey#&#request.addtoken#">Process Payment</a>
</cfif>
&nbsp;|&nbsp;
<cfif #request.action# is "dsp_app">
View Application
<cfelse>
<a href="control.cfm?action=dsp_app&srrKey=#request.srrKey#&#request.addtoken#">View Application</a>
</cfif>
&nbsp;|&nbsp;
<cfif #request.action# is "print_app">
Print Application 
<cfelse>
<a href="control.cfm?action=print_app&srrKey=#request.srrKey#&#request.addtoken#" target="_blank">Print Application</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "attachments">
Attachments 
<cfelse>
<a href="control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#" target="_blank">Attachments</a>
</cfif>

</div>

</cfif>
</cfoutput>