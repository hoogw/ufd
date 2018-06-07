<cfapplication name="accessprogram_mapping" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,2,0,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">

<cfinclude template="/common/check_sqlinject.cfm">

<cfif not isdefined("form.mapping_submit")>
<cfinclude template="security.cfm">
</cfif>

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<cfinclude template="/accessprogram/common/read_app_variables.cfm">