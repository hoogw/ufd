<cfset pw="NEWUSER">
<!-- Insert Record into the database -->
<cfquery name="update_user" datasource="#request.dsn#" dbtype="datasource">
update staff
set
user_password='#hash(ucase(pw))#'

where user_id=#request.user_id#
</cfquery>


<div class='warning'>User password has been reset to &quot;newuser&quot;.</div>
<br><br>
<div align="center">User will be asked to change password on first login.</div>