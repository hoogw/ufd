<CFPARAM NAME="request.login" DEFAULT="0">

<cfquery name="update_pw" datasource="#request.dsn#" dbtype="datasource">
update staff
set
user_password='#hash(ucase(trim(request.pw1)))#'

where user_id=#client.staff_user_id#
</cfquery>


<cfoutput>
<div class="warning">Password has been successfully changed</div>


<BR><BR>

<div align="center"><input type="button" name="continue" id="continue" value="Continue &gt;&gt;" class="submit" onClick="parent.location.href = 'control.cfm?action=home&#request.addtoken#'"></div>

</cfoutput>

