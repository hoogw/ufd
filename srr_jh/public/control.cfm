<cfparam name="client.app_login" default="0">

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">

<cfif not isdefined("request.action")>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "faqs">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="faqs.cfm">
</cfcase>

<cfcase value = "app_requirements">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="app_requirements.cfm">
</cfcase>

<cfcase value = "start_new_app1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="start_new_app1.cfm">
</cfcase>

<cfcase value = "start_new_app2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="start_new_app2.cfm">
</cfcase>

<cfcase value = "dsp_applicant_info">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="dsp_applicant_info.cfm">
</cfcase>

<cfcase value = "get_job_location1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="get_job_location1.cfm">
</cfcase>

<cfcase value = "get_job_location2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="get_job_location2.cfm">
</cfcase>

<cfcase value = "get_job_location3">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="get_job_location3.cfm">
</cfcase>

<cfcase value = "edit_job_location1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="edit_job_location1.cfm">
</cfcase>

<cfcase value = "edit_job_location2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="edit_job_location2.cfm">
</cfcase>

<cfcase value = "edit_job_location3">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="edit_job_location3.cfm">
</cfcase>

<cfcase value = "add_job_location1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="add_job_location1.cfm">
</cfcase>

<cfcase value = "add_job_location2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="add_job_location2.cfm">
</cfcase>

<cfcase value = "add_job_location3">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="add_job_location3.cfm">
</cfcase>

<cfcase value = "dsp_job_location">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="dsp_job_location.cfm">
</cfcase>

<cfcase value = "dsp_work_description">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="dsp_work_description.cfm">
</cfcase>

<cfcase value = "edit_work_description1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="edit_work_description1.cfm">
</cfcase>


<cfcase value = "edit_work_description2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="edit_work_description2.cfm">
</cfcase>

<cfcase value = "dsp_app">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="../common/dsp_app.cfm">
</cfcase>


<cfcase value = "login">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="login.cfm">
</cfcase>

<cfcase value = "authorize">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="authorize.cfm">
</cfcase>

<cfcase value = "logout">
<cfset client.app_login = 0>
<cflocation addtoken="No" url="/public/control.cfm?action=logout">
</cfcase>


<cfcase value = "uploadfile1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="uploadfile1.cfm">
</cfcase>

<cfcase value = "uploadfile2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="uploadfile2.cfm">
</cfcase>

<cfcase value = "my_applications">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="my_applications.cfm">
</cfcase>

</cfswitch>


<cfoutput>
<cfinclude template="#request.navbar#">
<cfif isdefined("request.srr_id") and isnumeric(#request.srr_id#)>
<div class="subtitle">Program Interest Form Reference No. #request.srr_id#</div>
<cfinclude template="/srr/common/get_srr_status.cfm">
<div class="warning">Status: #request.srr_status#</div>
</cfif>
</cfoutput>
<cfmodule template="#request.content#" login="#client.app_login#">
<cfinclude template="footer.cfm">