<link rel="stylesheet" href="/accessprogram/css/navbar.css" type="text/css" media="screen" />

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=home&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->

 
<!---  <cfif not isnumeric(#request.ar_id#)>
<li><a href="control.cfm?action=view_unprocessed&#request.addtoken#">View Unprocessed</a></li><!-- End I Want To Item -->
</cfif> --->


 <!--- Start Item --->
<li><a href="control.cfm?action=process_app1&arKey=#request.arKey#&#request.addtoken#">Application</a>

<!--- <div class="dropdown_2columns">

<div class="col_2">
<ul class="greybox2">
<li><a href="control.cfm?action=dsp_app&ar_id=#request.ar_id#&#request.addtoken#">View Application</a></li>
<li><a href="control.cfm?action=print_app&ar_id=#request.ar_id#&#request.addtoken#" target="_blank">Print Application</a></li>
<li><a href=""><a href="control.cfm?action=process_app1&ar_id=#request.ar_id#&#request.addtoken#">Process Application</a></a></li>
<!---<li><a href="control.cfm?action=prep_docs&ar_id=#request.ar_id#&#request.addtoken#">Prepare/Print Docs</a></li>--->
</ul>   
</div>
			
</div> --->
</li>

 
 


<li><a href="control.cfm?action=search1&#request.addtoken#">Search</a></li><!-- End I Want To Item -->

 <cfif  not isnumeric(#request.ar_id#)>
<li><a href="control.cfm?action=reports&#request.addtoken#">Reports/Metrics</a></li>
</cfif>


<!-- Start top menu Item -->
<li onClick=”return true;”><a href="control.cfm?action=log_out&#request.addtoken#">Logout</a></li>
<!---<cfelse>
<li onClick=”return true;”><a href="control.cfm?action=create_profile1">Register/Create an Account</a></li>
<li onClick=”return true;”><a href="control.cfm?action=login">Login</a></li>--->

<!-- End top menu Item -->



<!---<cfif #request.iphone# is 1 or #request.android# is 1 or #request.blackberry# is 1 or #request.ipad# is 1>
<!-- Start top menu Item -->
<li onClick=”return true;”><a href="#">Esc</a></li>
<!-- End top menu Item -->
</cfif>--->



</ul>

<div style="margin-bottom:10px;"></div>
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments">

<div style="margin-left:auto;margin-right:auto;width:700px;">
<cfif #request.action# is "process_app1">
Process Application
<cfelse>
<a href="control.cfm?action=process_app1&arKey=#request.arKey#&#request.addtoken#">Process Application</a>
</cfif>
&nbsp;|&nbsp;
<cfif #request.action# is "dsp_app">
View Application
<cfelse>
<a href="control.cfm?action=dsp_app&arKey=#request.arKey#&#request.addtoken#">View Application</a>
</cfif>
&nbsp;|&nbsp;
<cfif #request.action# is "print_app">
Print Application 
<cfelse>
<a href="control.cfm?action=print_app&arKey=#request.arKey#&#request.addtoken#" target="_blank">Print Application</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "attachments">
Attachments 
<cfelse>
<a href="control.cfm?action=attachments&arKey=#request.arKey#&#request.addtoken#" target="_blank">Attachments</a>
</cfif>

</div>

</cfif>
</cfoutput>