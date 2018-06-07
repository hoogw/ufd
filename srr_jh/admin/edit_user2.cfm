
<CFPARAM NAME="request.administrator" DEFAULT="0">
<CFPARAM NAME="request.suspend" DEFAULT="0">

<!-- Validating Applicant Inputs -->
<!-- Validating Applicant Inputs -->
<cfif not isdefined("request.first_name") or #trim(request.first_name)# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="First Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.last_name") or #trim(request.last_name)# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Last Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_name") or #trim(request.user_name)# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="User Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_email") or #trim(request.user_email)# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="User Email is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_agency") or #trim(request.user_agency)# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Agency is Required!" showBackButton="1">
<cfabort>
</cfif>


<cfquery name="exist_user" DATASOURCE="#request.dsn#" dbtype="datasource">
Select * 
from staff
where  user_name='#request.user_name#' and user_id <> #request.user_id#
</cfquery>


<cfif exist_user.recordcount is not "0">
<cfoutput>
<div class = 'warning'>User Name &quot;#request.user_name#&quot; is not Available</div>
<div class = 'warning'>Please Try a Different User Name</div>
<br><br>
<div align = "center">
<form method="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfoutput>
<cfabort>
</cfif>


<!-- Insert Record into the database -->
<cfquery name="update_user" datasource="#request.dsn#" dbtype="datasource">
update staff
set
first_name='#trim(request.first_name)#',
last_name='#trim(request.last_name)#',
user_name='#trim(request.user_name)#',
user_phone='#trim(request.user_phone)#',
user_email='#trim(request.user_email)#',
user_agency='#user_agency#',
suspend=#request.suspend#,
administrator=#request.administrator#

where user_id=#request.user_id#
</cfquery>

<div class='warning'>User Account was Successfully Updated</div>