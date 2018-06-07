<cfif  isdefined("request.srrKey")>
<cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
select srr_id, srrKey, a_ref_no, sr_number from srr_info
where 
srrKey = '#request.srrKey#'
</cfquery>
<cfset request.srr_id = #validateSRR.srr_id#>
<cfelse>
<cfset request.srr_id = "">
</cfif>

<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />
<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=instructions1&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->

 
<cfif not isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=view_unprocessed&#request.addtoken#">Unprocessed</a></li>
<li><a href="control.cfm?action=view_ready_to_pay&#request.addtoken#">Ready-to-Pay</a></li>
</cfif>


 <cfif  isnumeric(#request.srr_id#)>
 <!--- Start Item --->
<li><a href="##" <!--- class="drop" aria-haspopup="true" --->>Application</a>

<!--- <div class="dropdown_2columns">

<div class="col_2">
<ul class="greybox2">
<li><a href="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">View Application</a></li>
<li><a href="control.cfm?action=print_app&srr_id=#request.srr_id#&#request.addtoken#" target="_blank">Print Application</a></li>
<li><a href=""><a href="control.cfm?action=process_app1&srr_id=#request.srr_id#&#request.addtoken#">Process Application</a></a></li>
<li><a href="control.cfm?action=prep_docs&srr_id=#request.srr_id#&#request.addtoken#">Prepare/Print Docs</a></li>
</ul>   
</div>
			
</div> --->
</li>
 </cfif>
 
<!---  <cfif  isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=process_app1&srr_id=#request.srr_id#&#request.addtoken#">Process Application</a></li>

<li><a href="control.cfm?action=prep_docs&srr_id=#request.srr_id#&#request.addtoken#">Prepare Docs</a></li>
</cfif> --->


<li><a href="control.cfm?action=find_srr1&#request.addtoken#">Search</a></li>

 <cfif  not isnumeric(#request.srr_id#)>
<li><a href="control.cfm?action=reports&#request.addtoken#">Reports/Metrics</a></li>
</cfif>

<li onClick=”return true;”><a href="control.cfm?action=log_out&#request.addtoken#">Logout</a></li>

</ul>

<div style="margin-bottom:10px;"></div>
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments">

<div style="margin-left:auto;margin-right:auto;width:700px;">
<cfif #request.action# is "process_app1">
Process Application
<cfelse>
<a href="control.cfm?action=process_app1&srrKey=#request.srrKey#&#request.addtoken#">Process Application</a>
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