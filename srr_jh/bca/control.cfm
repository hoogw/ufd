<cfparam name="request.srr_id" default="">

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (BCA)">

<cfif not isdefined("request.action")>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>

<cfcase value = "instructions1">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>


<cfcase value = "view_unprocessed">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="view_unprocessed.cfm">
</cfcase>

<cfcase value = "dsp_app">
<cfset request.navbar="navbar_bca.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/dsp_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "print_app">
<cfset request.navbar="navbar_bca.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>


<cfcase value = "process_app1">
<cfset request.navbar="navbar_bca.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="process_app1.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "process_app2">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="process_app2.cfm">
</cfcase>


<cfcase value = "find_form1">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="find_form1.cfm">
</cfcase>

<cfcase value = "find_form2">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="find_form2.cfm">
</cfcase>


<cfcase value = "print_not_eligible_letter_pdf">
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="../common/print_not_eligible_letter_pdf.cfm">
</cfcase>

<cfcase value = "edit_assessment1">
<cfset request.navbar="navbar_bca.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="edit_assessment1.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->

</cfcase>


<cfcase value = "log_out">
<cfset client.app_login = 0>
<cfset request.navbar="navbar_bca.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>




</cfswitch>

<div class="title"></div>


<cfoutput>
<cfinclude template="#request.navbar#">
<cfif isnumeric(#request.srr_id#)>
<div class="subtitle">Program Interest Form Reference No. #request.srr_id#</div>
<cfinclude template="/srr/common/get_srr_status.cfm">
<div class="warning">Status: #request.srr_status#</div>
</cfif>


<cfmodule template="#request.content#" srr_id="#request.srr_id#">
<cfinclude template="../common/footer.cfm">
</cfoutput>