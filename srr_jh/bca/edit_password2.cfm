<cfinclude template="/srr/common/html_top.cfm">

<CFPARAM NAME="request.login" DEFAULT="0">

<cfquery name="update_pw" datasource="#request.dsn#" dbtype="datasource">
update staff
set
user_password='#hash(ucase(trim(request.pw1)))#'

where user_id=#client.staff_user_id#
</cfquery>


<cfoutput>
<div class="title">Password was Successfully Updated</div>


<BR><BR>
<cfif #request.login# is 1>
<div align="center"><input type="button" name="continue" id="continue" value="Continue &gt;&gt;" class="submit" onClick="location.href = 'view_unprocessed.cfm?#request.addtoken#'"></div>
</cfif>
</cfoutput>

<cfinclude template="/srr/common/html_bottom.cfm">
