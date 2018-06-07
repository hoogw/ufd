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

<cfparam name="request.type" default="u">

<link rel="stylesheet" href="/srr/css/navbar.css" type="text/css" media="screen" />
<cfoutput>
<ul id="menu" style="padding-top:0px;margin-top:10px;">

<li><a href="control.cfm?action=instructions1&#request.addtoken#">Home</a></li><!-- End I Want To Item -->
<li><a href="control.cfm?action=view_unprocessed&type=u&#request.addtoken#">Unprocessed</a></li>
<li><a href="control.cfm?action=view_ready_to_pay&type=p&#request.addtoken#">Ready-to-Pay</a></li>
<li><a href="control.cfm?action=search1&#request.addtoken#">Search</a></li>
<li><a href="control.cfm?action=reports&#request.addtoken#">Reports/Metrics</a></li>
<li onClick=”return true;”><a href="control.cfm?action=log_out&#request.addtoken#">Logout</a></li>

</ul>

<div style="margin-bottom:10px;"></div>
<cfif #request.action# is "dsp_app" or #request.action# is "print_app" or #request.action# is "process_app1" or #request.action# is "attachments"  or #request.action# is "record_history" or #request.action# is "process_app2" or #request.action# is "process_payment1" or #request.action# is "process_payment2" or #request.action# is "rebate_estimate">

<div style="margin-left:auto;margin-right:auto;width:700px;">
<cfif #request.action# is "process_app1"  and  #request.type# is "u">
Process Application
<cfelseif #request.type# is "u">
<a href="control.cfm?action=process_app1&type=u&srrKey=#request.srrKey#&#request.addtoken#">Process Application</a>
</cfif>

<cfif #request.action# is "process_payment1"  and  #request.type# is "p">
Process Payment
<cfelseif #request.type# is "p">
<a href="control.cfm?action=process_payment1&type=p&srrKey=#request.srrKey#&#request.addtoken#">Process Payment</a>
</cfif>

<!--- &nbsp;|&nbsp;
<cfif #request.action# is "dsp_app">
View Application
<cfelse>
<a href="control.cfm?action=dsp_app&srrKey=#request.srrKey#&#request.addtoken#">View Application</a>
</cfif> --->

<cfif #request.type# is "p">
&nbsp;|&nbsp;
<cfif #request.action# is "rebate_estimate">
Rebate Estimate
<cfelse>
<a href="control.cfm?action=rebate_estimate&type=#request.type#&srrKey=#request.srrKey#&#request.addtoken#" target="_blank">Rebate Estimate</a>
</cfif>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "print_app">
Print Application 
<cfelse>
<a href="control.cfm?action=print_app&type=#request.type#&srrKey=#request.srrKey#&#request.addtoken#" target="_blank">Print Application</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "attachments">
Attachments 
<cfelse>
<a href="control.cfm?action=attachments&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Attachments</a>
</cfif>

&nbsp;|&nbsp;
<cfif #request.action# is "record_history">
Record History 
<cfelse>
<a href="control.cfm?action=record_history&srrKey=#request.srrKey#&type=#request.type#&#request.addtoken#">Record History</a>
</cfif>

</div>

</cfif>
</cfoutput>