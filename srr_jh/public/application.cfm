<cfinclude template="/common/check_sqlinject.cfm">

<cfapplication name="srr_public" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,2,0,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">

<cfparam name="request.action" default="home">

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<!--- <cfif not isdefined("url.eapp_email")>
<cfinclude template="security.cfm">
</cfif> --->

<cfinclude template="../common/read_app_variables.cfm">