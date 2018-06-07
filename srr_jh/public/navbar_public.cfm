<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />
<cfparam name="client.app_login" default="0">

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="/srr/public/control.cfm?action=faqs&#request.addtoken#">FAQs</a></li><!-- End I Want To Item -->

<cfif #client.app_login# is 1><!-- 1 -->
<cfif isdefined("request.srr_id")><!-- 2 --><!--- and isnumeric(#request.srr_id#)--->
<cfquery name="find_screen_dates_nav" datasource="#request.dsn#" dbtype="datasource">
select * from screen_dates
where srr_id = #request.srr_id#
</cfquery>
<cfif #find_screen_dates_nav.start_app_dt# is  not "">
<li><a href="control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#">Complete Application</a></li>
</cfif>
<cfelseif not isdefined("request.srr_id")><!-- 2 -->
<li><a href="control.cfm?action=app_requirements&#request.addtoken#">Start Application</a></li>
</cfif>

<!---<li><a href="control.cfm?action=app_requirements&#request.addtoken#">Start Application</a></li>---><!-- End I Want To Item -->
<li><a href="control.cfm?action=my_applications&#request.addtoken#">My Applications</a></li><!-- End I Want To Item -->
</cfif><!-- 1 -->





<!-- Start top menu Item -->

<!-- End top menu Item -->



<!---<cfif #request.iphone# is 1 or #request.android# is 1 or #request.blackberry# is 1 or #request.ipad# is 1>
<!-- Start top menu Item -->
<li onClick=”return true;”><a href="#">Esc</a></li>
<!-- End top menu Item -->
</cfif>--->

<li><a href="/public/control.cfm?action=services&#request.addtoken#">Permits/Services</a></li><!-- End I Want To Item -->

<cfif #client.app_login# is 0>
<li onClick=”return true;”><a href="/public/control.cfm?action=create_profile1">Create an Account</a></li>
<li onClick=”return true;”><a href="/public/control.cfm?action=login">Login</a></li>
</cfif>

<cfif #client.app_login# is 1>
<li onClick=”return true;”><a href="control.cfm?action=logout&#request.addtoken#">Logout</a></li>
</cfif>

</ul>
<div style="margin-bottom:10px;"></div>
</cfoutput>