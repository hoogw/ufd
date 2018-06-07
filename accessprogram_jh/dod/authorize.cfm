<cfinclude template="../common/delete_client_variables.cfm">

<cfif not isdefined("request.user_name") or not isdefined("request.user_password")>
<cflocation url="../dod.htm" addtoken="No">
</cfif>

<cfif not isdefined("request.user_name") or #request.user_name# is "">
<cfmodule template="/common/error_msg.cfm" error_msg="User Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_password") or #request.user_password# is "">
<cfmodule template="/common/error_msg.cfm" error_msg="Password is Required!" showBackButton="1">
<cfabort>
</cfif>


<!-- Check if user is authorized to access and process applications -->
<cfquery name="checkit" datasource="#request.dsn#" dbtype="datasource">
select * from staff
where user_name = '#trim(request.user_name)#' and (user_agency = 'dod' or user_agency='all')
</cfquery>




<!-- Case 1   User Name does not exist -->
<cfif #checkit.recordcount# is "0">
<cfmodule template="/common/error_msg.cfm" error_msg="Invalid Login!" showBackButton="1">
<cfabort>
</cfif>


<cfif #checkit.suspend# is 1>
<cfmodule template="/common/error_msg.cfm" error_msg="This Account is Suspended, Contact Administrator!" showBackButton="1">
<cfabort>
</cfif>


<!-- Case 2    User Name exists, but password is incorrect -->
<cfif #checkit.user_password# IS NOT '#hash(trim(ucase(request.user_password)))#' OR #checkit.user_name# IS NOT '#trim(request.user_name)#'>
<cfmodule template="/common/error_msg.cfm" error_msg="Invalid Login!" showBackButton="1">
<cfabort>
</cfif>



<!-- Case 3    User Name and Password are valid -->
<cfif #checkit.user_name# is '#trim(request.user_name)#' and #checkit.user_password# is '#hash(trim(ucase(request.user_password)))#'>

<cfset client.staff_user_id=#checkit.user_id#>
<cfset client.full_name=#checkit.first_name#&" "&#checkit.last_name#>
<cfset client.user_agency=#checkit.user_agency#>

<cfif #checkit.administrator# is 1>
<cfset client.administrator=1>
<cfelse>
<cfset client.administrator=0>
</cfif>

<cfif #request.user_password# is "eng78" or #request.user_password# is "newuser">
<cflocation url="edit_password1.cfm?login=1"> 
</cfif>

<cflocation url="control.cfm?action=home&#request.addtoken#" addtoken="No"> 
</cfif>