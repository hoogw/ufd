<cfif  isdefined("request.arKey")>
<cfquery name="validateAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.ar_info.ar_id
, dbo.ar_info.arKey
, dbo.ar_info.sr_number
, dbo.ar_status.ar_status_desc
, ar_info.job_address
, ar_info.ar_status_cd

FROM  dbo.ar_info LEFT OUTER JOIN
               dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd

where 
ar_info.arKey = '#request.arKey#'
</cfquery>

<cfset request.ar_id = #validateAR.ar_id#>
<cfset request.sr_number = #validateAR.sr_number#>
<!--- <cfset request.a_ref_no = #validateAR.a_ref_no#> --->
<!--- <cfset request.app_id = #validateAR.app_id#> --->
<cfset request.job_address = #validateAR.job_address#>
<cfset request.status_cd = #validateAR.ar_status_cd#>
<cfset request.status_desc = #validateAR.ar_status_desc#>

</cfif>


<link rel="stylesheet" href="/accessprogram/css/navbar.css" type="text/css" media="screen" />

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=home&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->


<li><a href="control.cfm?action=view_unprocessed&#request.addtoken#">View Unprocessed</a></li>

<!-- End I Want To Item -->



 <!--- Start Item --->
<!---<li><a href="##"<!---  class="drop" aria-haspopup="true" --->>Application</a>--->

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


<li><a href="control.cfm?action=reports&#request.addtoken#">Reports/Metrics</a></li>



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
<cfif  #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments"  or #request.action# is "record_history" or #request.action# is "process_app2" or #request.action# is "add_comment_form">

<div style="margin-left:auto;margin-right:auto;width:700px;">
<cfif #request.action# is "process_app1">
Process Application
<cfelse>
<a href="control.cfm?action=process_app1&arKey=#request.arKey#&#request.addtoken#">Process Application</a>
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
<a href="control.cfm?action=attachments&arKey=#request.arKey#&#request.addtoken#">Attachments</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "record_history">
Record History 
<cfelse>
<a href="control.cfm?action=record_history&arKey=#request.arKey#&#request.addtoken#">Record History</a>
</cfif>

</div>

</cfif>
</cfoutput>