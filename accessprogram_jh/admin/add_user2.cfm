
<cfparam name="request.administrator" default="0">

<!-- Validating Applicant Inputs -->
<cfif not isdefined("request.first_name") or #trim(request.first_name)# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="First Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.last_name") or #trim(request.last_name)# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="Last Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_name") or #trim(request.user_name)# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="User Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_email") or #trim(request.user_email)# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="User Email is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.user_agency") or #trim(request.user_agency)# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="Agency is Required!" showBackButton="1">
<cfabort>
</cfif>


<cfquery name="exist_user" datasource="#request.dsn#" dbtype="datasource">
Select * 
from staff
where user_name='#trim(request.user_name)#'
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

<cfset pw="NEWUSER">
<!---
<cfoutput>
insert into staff
(
first_name,
last_name,
user_name,
user_password,
user_phone,
user_email,
user_agency,
administrator
)

values

(
'#trim(request.first_name)#',
'#trim(request.last_name)#',
'#trim(request.user_name)#',
'#hash(pw)#',
'#left(trim(request.user_phone),15)#',
'#left(request.user_email,50)#',
'#request.user_agency#',
#request.administrator#

)
</cfoutput>
<cfabort>--->

<cfquery name="add_user" datasource="#request.dsn#" dbtype="datasource">
insert into staff
(
first_name,
last_name,
user_name,
user_password,
user_phone,
user_email,
user_agency,
administrator
)

values

(
'#trim(request.first_name)#',
'#trim(request.last_name)#',
'#trim(request.user_name)#',
'#hash(pw)#',
'#left(trim(request.user_phone),15)#',
'#left(request.user_email,50)#',
'#request.user_agency#',
#request.administrator#

)
</cfquery>

<div class='subtitle'>User Account was Successfully Created</div>
<br>
<div class="warning">Please inform user that his/her temporary password is &quot;newuser&quot;</div>
