<cfinclude template="/common/check_sqlinject.cfm">

<cfapplication name="srr_common" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,1,20,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">

<!--- <cfinclude template="security.cfm"> --->

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<cfinclude template="../common/read_app_variables.cfm">
