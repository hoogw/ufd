<link rel="stylesheet" href="../css/navbar.css" type="text/css" media="screen" />

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=home&#request.addtoken#">Home</a></li><!-- End I Want To Item -->

<li><a href="control.cfm?action=list_users&#request.addtoken#">User Management</a></li><!-- End I Want To Item -->

<!--- <li><a href="control.cfm?action=login&#request.addtoken#">Revise User Account</a></li> ---><!-- End I Want To Item -->



<!-- Start top menu Item -->
<cfif #client.admin_login# is 1>
<li onClick=”return true;”><a href="control.cfm?action=log_out&#request.addtoken#">Logout</a></li>
<cfelse>
<li onClick=”return true;”><a href="control.cfm?action=create_profile1">Login</a></li>
</cfif>
<!-- End top menu Item -->
</ul>
<div style="margin-bottom:10px;"></div>
</cfoutput>