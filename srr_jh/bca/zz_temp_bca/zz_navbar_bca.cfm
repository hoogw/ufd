<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=instructions1&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->

 
<!--- <cfif not isnumeric(#request.srr_id#)>--->
<li><a href="control.cfm?action=view_unprocessed&#request.addtoken#">View Unprocessed</a></li><!-- End I Want To Item -->
<!---</cfif>--->

 <cfif  isnumeric(#request.srr_id#)>
 <!--- Start Item --->
<li><a href="##" class="drop" aria-haspopup="true">Application</a>

<div class="dropdown_2columns">

<div class="col_2">
<ul class="greybox2">
<li><a href="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">View Application</a></li>
<li><a href="control.cfm?action=print_app&srr_id=#request.srr_id#&#request.addtoken#" target="_blank">Print Application</a></li>
<li><a href="control.cfm?action=edit_assessment1&srr_id=#request.srr_id#&#request.addtoken#">Field Assessment</a></li>
<li><a href=""><a href="control.cfm?action=process_app1&srr_id=#request.srr_id#&#request.addtoken#">Process Application</a></a></li>
<!---<li><a href="control.cfm?action=prep_docs&srr_id=#request.srr_id#&#request.addtoken#">Prepare/Print Docs</a></li>--->
</ul>   
</div>
			
</div>
</li>
 </cfif>


 <!---<cfif  isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">View Application</a></li><!-- End I Want To Item -->
</cfif>

 <cfif  isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=edit_assessment1&srr_id=#request.srr_id#&#request.addtoken#">Field Assessment</a></li><!-- End I Want To Item -->
</cfif>

 <cfif  isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=process_app1&srr_id=#request.srr_id#&#request.addtoken#">Process Application</a></li><!-- End I Want To Item -->
</cfif>--->

<li><a href="control.cfm?action=find_form1&#request.addtoken#">Search</a></li><!-- End I Want To Item -->

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
</cfoutput>