<cfapplication name="accessprogram_admin" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,1,20,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">

<cfmodule template="/common/check_sqlinject.cfm">


<cfif not isdefined("form.admin_submit")>
<cfinclude template="security.cfm">
</cfif>

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<cfinclude template="../common/read_app_variables.cfm">
