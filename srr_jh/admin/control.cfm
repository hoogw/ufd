<cfparam name="client.app_login" default="0">

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Admin)">

<cfif not isdefined("request.action")>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="instructions.cfm">
</cfcase>

<cfcase value = "list_users">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="list_users.cfm">
</cfcase>

<cfcase value = "add_user1">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="add_user1.cfm">
</cfcase>

<cfcase value = "add_user2">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="add_user2.cfm">
</cfcase>

<cfcase value = "edit_user1">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="edit_user1.cfm">
</cfcase>

<cfcase value = "edit_user2">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="edit_user2.cfm">
</cfcase>

<cfcase value = "edit_password1">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="edit_password1.cfm">
</cfcase>

<cfcase value = "edit_password2">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="edit_password2.cfm">
</cfcase>

<cfcase value = "resetUserPassword">
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="resetUserPassword.cfm">
</cfcase>

<cfcase value = "log_out">
<cfset client.app_login = 0>
<cfset request.navbar="navbar_admin.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>

</cfswitch>

<cfinclude template="#request.navbar#">
<cfmodule template="#request.content#" login="#client.app_login#">

<cfinclude template="../common/footer.cfm">
