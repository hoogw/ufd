<cfif  isdefined("request.srrKey")>
<cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.a_ref_no
, dbo.srr_status.srr_status_desc
, srr_info.app_id
, srr_info.job_address
, srr_info.srr_status_cd

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srr_id = #validateSRR.srr_id#>
<cfset request.sr_number = #validateSRR.sr_number#>
<cfset request.a_ref_no = #validateSRR.a_ref_no#>
<cfset request.app_id = #validateSRR.app_id#>
<cfset request.job_address = #validateSRR.job_address#>
<cfset request.status_cd = #validateSRR.srr_status_cd#>
<cfset request.status_desc = #validateSRR.srr_status_desc#>

</cfif>


<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />

<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<!-- Start Top Menu Item -->
<li><a href="control.cfm?action=home&#request.addtoken#">Home</a></li><!-- End I Want To Item -->


<!--- <cfif #client.app_login# is 0>
<li><a href="control.cfm?action=create_profile1&#request.addtoken#">Create an Account</a></li><!-- End I Want To Item -->
</cfif>
 --->


<li><a href="control.cfm?action=view_unprocessed&#request.addtoken#">Tree Inspection</a></li>
<li><a href="control.cfm?action=tr_view_unprocessed&#request.addtoken#">Tree Removal</a></li>
<li><a href="control.cfm?action=tp_view_unprocessed&#request.addtoken#">Root Pruning</a></li>

<!-- End I Want To Item -->



 <!--- Start Item --->
<!---<li><a href="##"<!---  class="drop" aria-haspopup="true" --->>Application</a>--->

<!--- <div class="dropdown_2columns">

<div class="col_2">
<ul class="greybox2">
<li><a href="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">View Application</a></li>
<li><a href="control.cfm?action=print_app&srr_id=#request.srr_id#&#request.addtoken#" target="_blank">Print Application</a></li>
<li><a href=""><a href="control.cfm?action=process_app1&srr_id=#request.srr_id#&#request.addtoken#">Process Application</a></a></li>
<!---<li><a href="control.cfm?action=prep_docs&srr_id=#request.srr_id#&#request.addtoken#">Prepare/Print Docs</a></li>--->
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
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments"  or #request.action# is "record_history" or #request.action# is "process_app2" or #request.action# is "rebate_estimate" <!--- or #request.action# is "bss_adjustments1" or #request.action# is "bss_adjustments2" --->>

<div style="margin-left:auto;margin-right:auto;width:900px;text-align:center;">
<cfif #request.action# is "process_app1">
Process Application
<cfelse>
<a href="control.cfm?action=process_app1&srrKey=#request.srrKey#&#request.addtoken#">Process Application</a>
</cfif>



&nbsp;|&nbsp;
<cfif #request.action# is "rebate_estimate">
Rebate Estimate
<cfelse>
<a href="control.cfm?action=rebate_estimate&srrKey=#request.srrKey#&#request.addtoken#">Rebate Estimate</a>
</cfif>

<!--- &nbsp;|&nbsp;
<cfif #request.action# is "bss_adjustments1">
Rebate Adjustment(s)
<cfelse>
<a href="control.cfm?action=bss_adjustments1&srrKey=#request.srrKey#&#request.addtoken#">Rebate Adjustment(s)</a>
</cfif>
 --->

<!---<cfif #request.action# is "dsp_app">
View Application
<cfelse>
<a href="control.cfm?action=dsp_app&srrKey=#request.srrKey#&#request.addtoken#">View Application</a>
</cfif>
&nbsp;|&nbsp;--->

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
<a href="control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#">Attachments</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "record_history">
Record History 
<cfelse>
<a href="control.cfm?action=record_history&srrKey=#request.srrKey#&#request.addtoken#">Record History</a>
</cfif>

</div>

</cfif>
</cfoutput>