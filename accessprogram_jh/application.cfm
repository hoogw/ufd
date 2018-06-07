<cfapplication name="accessprogram" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,2,0,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#" clientstorage="PermitVars">

<cfinclude template="/common/check_sqlinject.cfm">

<cfset request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">

<cfinclude template="common/read_app_variables.cfm">