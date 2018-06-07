<cfinclude template="../common/html_top.cfm">

<CFPARAM NAME="request.login" DEFAULT="0">

<cfquery name="update_pw" datasource="#request.dsn#" dbtype="datasource">
update staff
set
user_password='#hash(ucase(trim(request.pw1)))#'

where user_id=#client.staff_user_id#
</cfquery>


<cfoutput>
<div class="title">PASSWORD HAS BEEN SUCCESSFULLY CHANGED</div>


<BR><BR>
<cfif #request.login# is 1>
<div align="center"><input type="button" name="Continue" id="Continue" value="Continue &gt;&gt;" class="submit" onClick="location.href = 'control.cfm?action=home&#request.addtoken#'"></div>
</cfif>
</cfoutput>

<cfinclude template="/apermits/common/html_bottom.cfm">
