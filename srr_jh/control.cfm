<cfparam name="client.app_login" default="0">

<cfmodule template="/common/header.cfm" title="Bureau of Engineering">

<cfif not isdefined("request.action")>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="i_want_to.cfm">
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
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>

<cfcase value = "forgot_password1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="forgot_password1.cfm">
</cfcase>

<cfcase value = "forgot_password2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="forgot_password2.cfm">
</cfcase>

<cfcase value = "forgot_password3">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="forgot_password3.cfm">
</cfcase>

<cfcase value = "forgot_password4">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="forgot_password4.cfm">
</cfcase>


<cfcase value = "create_profile1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="create_profile1.cfm">
</cfcase>

<cfcase value = "create_profile2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="create_profile2.cfm">
</cfcase>

<cfcase value = "revise_profile1">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="revise_profile1.cfm">
</cfcase>

<cfcase value = "revise_profile2">
<cfset request.navbar="navbar_public.cfm">
<Cfset request.content="revise_profile2.cfm">
</cfcase>

</cfswitch>

<cfinclude template="#request.navbar#">
<cfmodule template="#request.content#" login="#client.app_login#">
<cfinclude template="footer.cfm">
