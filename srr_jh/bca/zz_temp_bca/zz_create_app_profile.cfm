<cfinclude template="/common/check_referer.cfm">

<cfif not isdefined("request.app_name") or not isdefined("request.app_contact_name")>
<cflocation addtoken="no" url="control.cfm?action=create_profile">
</cfif>



<cfquery name="exist_user" DATASOURCE="customers" dbtype="datasource">
Select * from customers
where app_email = '#request.app_email#'
</cfquery>


<cfif exist_user.recordcount is not "0">
<cfoutput>
<div class = 'warning'>User Name &quot;#request.app_email#&quot; is not Available</div>
<div class = 'warning'>Please Try a Different User Name</div>
<br><br>
<div align = "center">
<form method="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfoutput>
<CFABORT>
</cfif>

<cfinclude template="common/generate_new_app_id.cfm">



<!-- Insert Record into the database -->
<cfquery name="add_user" datasource="customers" dbtype="datasource">
insert into customers
(
app_id,
app_name,
app_contact_name,
app_address1,
app_address2,
app_city,
app_state,
app_zip,
app_phone,
app_email,
app_password,
app_suspend,
ddate_modified
)

values

(
#request.app_id#,
'#trim(request.app_name)#',
'#trim(request.app_contact_name)#',
'#trim(request.app_address1)#',
'#trim(request.app_address2)#',
'#trim(request.app_city)#',
'#trim(request.app_state)#',
'#trim(request.app_zip)#',
'#trim(request.app_phone)#',
'#trim(request.app_email)#',
'#trim(request.app_password)#',
#request.suspend#,
#now()#

)
</cfquery>

<cfset client.user="public">
<cfset client.app_id=#request.app_id#>
<cfset client.app_email=#request.app_email#>
<cfset client.app_login = 1>

<cfoutput>
<div class='title'>Your Account is Sucessfully Created</div><br>
<div class='title'>Click Next to Continue</div>


<br><br>
<form action="control.cfm?action=home&#request.addtoken#" method="post" name="form1" id="form1">
<div align="center"><input type="submit" name="submit" id="submit" value="Next &gt;&gt;" class="submit"></div>
</form>
</cfoutput>