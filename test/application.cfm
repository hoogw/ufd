<cfapplication name="UFD" 
clientmanagement="Yes" 
sessionmanagement="Yes" 
sessiontimeout="#Createtimespan(0,4,0,0)#"  
applicationtimeout="#Createtimespan(1,0,0,0)#">





<cfif 
	FindNoCase(";DECLARE",cgi.query_string) 
	or REFindNoCase("[=]CAST[(]",cgi.query_string)  
	or FindNoCase("CAST",cgi.query_string)
	or FindNoCase("CONVERT",cgi.query_string) 
	or FindNoCase(";ALTER",cgi.query_string) 
	or FindNoCase(";DROP",cgi.query_string) 
	or FindNoCase(";EXEC",cgi.query_string)
	or FindNoCase("CHAR(",cgi.query_string)
	or (len(cgi.query_string) gt 256)
	or FindNoCase("DB_NAME",cgi.query_string)
	or FindNoCase("SERVERNAME",cgi.query_string)
	or FindNoCase("SERVICENAME",cgi.query_string)
	or FindNoCase("SYSTEM_USER",cgi.query_string)
	or FindNoCase("MSSQLSERVER",cgi.query_string)
>
<cfabort>
</cfif>
<cfif 
	FindNoCase("googlebot", cgi.http_user_agent)
	or FindNoCase("heritrix", cgi.http_user_agent)
	or FindNoCase("QQDownload", cgi.http_user_agent)
	or FindNoCase("Baiduspider", cgi.http_user_agent)
	or FindNoCase("bingbot", cgi.http_user_agent)
	or FindNoCase("msnbot", cgi.http_user_agent)
>
<cfabort>
</cfif>
<cfif 
	<!--- FindNoCase("www.google.com", #cgi.http_referer#)
	or FindNoCase("www.bing.com", #cgi.http_referer#)
	or ---> FindNoCase("www.yahoo.com", #cgi.http_referer#)
>
<cfabort>
</cfif>

<cf_FormURL2Attributes>
<cfinclude template="formURL2Request.cfm">

<cfset request.production=0><!--- 0:testing, 1:intranet, 2:internet --->
<cfif cgi.server_name is "boemaps.eng.ci.la.ca.us">
	<cfset request.production=1>
<cfelseif cgi.server_name is "navigatela.lacity.org">
	<cfset request.production=2>
</cfif>

<cfset request.report_url = "http://78boe99prod/">

<cfset request.ds_sql = "navla_sql">

<cfif request.production eq 1>
	<cfset request.report_url = "http://boemaps.eng.ci.la.ca.us/">
<cfelseif request.production eq 2>
	<cfset request.report_url = "http://navigatela.lacity.org/">
</cfif>

<!--- Source code location --->
<cfset request.dir="d:\ufd">