<cfinclude template="/common/check_sqlinject.cfm">

<cfapplication name="srr_srp" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,2,0,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">


<cfif not isdefined("form.srp_submit")>
<cfinclude template="security.cfm">
</cfif>

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<cfinclude template="/srr/common/read_app_variables.cfm">