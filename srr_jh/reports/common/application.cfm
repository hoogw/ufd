<cfinclude template="/common/check_sqlinject.cfm">

<cfapplication name="MHPermits" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,2,0,0)#" clientstorage="PermitVars">

<CFSET request.addtoken="cfid=#client.cfid#&cftoken=#client.cftoken#">


<cfinclude template="security.cfm">


<cfinclude template="../common/read_app_variables.cfm">