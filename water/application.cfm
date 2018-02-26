<cfapplication name="sidewalk_rpr" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(999999,0,0,0)#" applicationtimeout="#Createtimespan(99999999999999,0,0,0)#">

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

<!--- <CFSET session.addtoken="cfid=#session.cfid#&cftoken=#session.cftoken#"> --->

<cfset request.production=0><!--- 0:testing, 1:intranet, 2:internet --->
<cfif cgi.server_name is "boemaps.eng.ci.la.ca.us">
	<cfset request.production=1>
<cfelseif cgi.server_name is "navigatela.lacity.org">
	<cfset request.production=2>
</cfif>

<cfset request.dir="\\78boe99prod\ufd\water">
<cfset request.server="http://78boe99prod">
<cfset request.url="http://78boe99prod/ufd/water/">
<cfset request.js_sfx="">

<cfif request.production eq 1>
	<cfset request.dir="d:\sidewalk_repair">
	<cfset request.server="http://boemaps.eng.ci.la.ca.us/">
	<cfset request.url="http://boemaps.eng.ci.la.ca.us/sidewalk_repair/">
	<cfset request.js_sfx="_cmp">
<cfelseif request.production eq 2>
	<cfset request.dir="d:\ufd\water">
	<cfset request.server="http://navigatela.lacity.org/">
	<cfset request.url="http://navigatela.lacity.org/ufd/water/">
	<cfset request.js_sfx="_cmp">
</cfif>

<cfset request.PDFlocation="#request.dir#"&"\pdfs\">
<cfset request.PDFRlocation="#request.dir#"&"\reports">
<cfset request.PDFTemp="#request.dir#"&"\print\temp">
<cfset request.pdfConverter="C:\Program Files\Easy Software Products\HTMLDOC\ghtmldoc.exe">

<!--- cfset request.color = chr(35) & "3b6a97"   ---><!--- 99cc00 --->
<cfset request.color = chr(35) & "97683b"> 

<!--- cfset request.bgcolor = chr(35) & "e7f2fc" --->
<cfset request.bgcolor = chr(35) & "fcf1e7"> 

<cfset request.pgcolor = chr(35) & "ffffff">
<cfset request.ltecolor = chr(35) & "f5f5f5">

<!--- cfset request.drkcolor = chr(35) & "8fbce6" ---><!--- 66cccc --->
<cfset request.drkcolor = chr(35) & "e6b98f"> 


<!--- cfset request.fadecolor = chr(35) & "749cc0" --->
<cfset request.fadecolor = chr(35) & "c09874">


<cfset request.width = 230>
<cfset request.height = 21>

<!--- DATASOURCES --->
<cfset request.sqlconn = "sidewalk_read_only">
<!--- <cfset request.sqlconn2 = "UFD_Inventory">   --->

<cfset request.sqlconn2 = "ufd_inventory">



<!--- <cfset request.sqlconn = "sidewalk_spatial">    --->

<cfset request.sqlacc = "ssdr_ac">
<cfset request.sqlacc2 = "ssdr_ace">

<!--- FORM VARIABLES --->
<cfset request.upload_dir = request.dir & "\pdf">
<cfset request.spot_dir = request.dir & "\uploads">
<cfset request.empac_dir = request.dir & "\uploads_empac">

<!--- <CFERROR TYPE="REQUEST" TEMPLATE="request_error.CFM" MAILTO="nathan.neumann@lacity.org">
<cferror type="EXCEPTION" template="request_error.cfm" mailto="nathan.neumann@lacity.org"> --->