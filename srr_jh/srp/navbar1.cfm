<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />

<cfparam name="request.type" default="i">
<cfparam name="request.appealID" default="">

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=home&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->

<li><a href="control.cfm?action=unprocessed_investigations&type=i&#request.addtoken#">Investigations</a></li>
<li><a href="control.cfm?action=unprocessed_appeals&type=a&#request.addtoken#">Appeals</a></li>

<li><a href="control.cfm?action=may_be_closed&type=a&#request.addtoken#">Cancel/Close</a></li>

<li><a href="control.cfm?action=list_expired&type=a&#request.addtoken#">Extensions</a></li>

<!-- End I Want To Item -->


 
 


<li><a href="control.cfm?action=search1&#request.addtoken#">Search</a></li><!-- End I Want To Item -->


<li><a href="control.cfm?action=reports&user=boe&#request.addtoken#">Reports</a></li>



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
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments"  or #request.action# is "record_history" or #request.action# is "process_app2" or #request.action# is "process_appeal1" or #request.action# is "process_appeal2" or #request.action# is "rebate_estimate" or #request.action# is "override" or #request.action# is "override_applicant1" or #request.action# is "override_applicant2" or #request.action# is "remove_contractor1" or #request.action# is "remove_contractor2"
or #request.action# is "override_address1" 
or #request.action# is "override_address2"
or #request.action# is "override_address3"
or #request.action# is "override_status1"
or #request.action# is "override_status2"
or #request.action# is "process_expired1"
or #request.action# is "process_expired2"
or #request.action# is "override_rebate_mailing_address1" 
or #request.action# is "override_rebate_mailing_address2"
or #request.action# is "close_app1"  
or #request.action# is "close_app2"
or #request.action# is "override_rebate_rate1"
or #request.action# is "override_rebate_rate2"
>

<div style="margin-left:auto;margin-right:auto;width:800px;">
<cfif #request.action# is "process_app1" and  #request.type# is "i">
Process Application
<cfelseif #request.type# is "i">
<a href="control.cfm?action=process_app1&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Process Application</a>
</cfif>

<cfif #request.action# is "process_appeal1" and #request.type# is  "a">
Process Appeal
<cfelseif #request.type# is "a">
<a href="control.cfm?action=process_appeal1&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Process Appeal</a>
</cfif>


&nbsp;|&nbsp;
<cfif #request.action# is "rebate_estimate">
Rebate Estimate
<cfelse>
<a href="control.cfm?action=rebate_estimate&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Rebate Estimate</a>
</cfif>

<!--- &nbsp;|&nbsp;
<cfif #request.action# is "dsp_app">
View Application
<cfelse>
<a href="control.cfm?action=dsp_app&srrKey=#request.srrKey#&#request.addtoken#">View Application</a>
</cfif> --->

&nbsp;|&nbsp;
<cfif #request.action# is "print_app">
Print Application 
<cfelse>
<a href="control.cfm?action=print_app&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#" target="_blank">Print Application</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "attachments">
Attachments 
<cfelse>
<a href="control.cfm?action=attachments&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Attachments</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "record_history">
Record History 
<cfelse>
<a href="control.cfm?action=record_history&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Record History</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "override">
Override
<cfelse>
<a href="control.cfm?action=override&appealID=#request.appealID#&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Override</a>
</cfif>

</div>

</cfif>
</cfoutput>