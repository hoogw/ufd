<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfparam name="form.login" default="">
<cfparam name="form.password" default="">

<html>
<head>
	<title>Verify Log In</title>
</head>

<cfoutput>
<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM dbo.tblUsers WHERE user_name = '#form.login#' AND user_password = '#form.password#' AND user_level >= 0
</cfquery>

<cfif login_chk.recordcount gt 0>
	<cfset session.userid = login_chk.user_name>
	<cfset session.password = login_chk.user_password>
	<cfset session.agency = login_chk.user_agency>
	<cfset session.user_level = login_chk.user_level>
	<cfset session.user_power = login_chk.user_power>
	<cfset session.user_num = login_chk.user_id>
	
	<!--- <cfapplication name="SSDR" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#Createtimespan(0,8,0,0)#" applicationtimeout="#Createtimespan(1,0,0,0)#"> --->
	
	<cfif s is 1>
		<cfset url_redirect = "forms/swPackageEntry.cfm">
	<cfelseif s is 2>
		<cfset url_redirect = "forms/swSiteEntry.cfm">
	<cfelseif s is 3>
		<cfset url_redirect = "search/swSiteSearch.cfm">
	<cfelseif s is 4>
		<cfset url_redirect = "search/swPackageSearch.cfm">
	<cfelseif s is 5>
		<cfset url_redirect = "search/swDownloadData.cfm">
	<cfelseif s is 6>
		<cfset url_redirect = "search/swReports.cfm">
	<cfelseif s is 7>
		<cfset url_redirect = "search/swUserRights.cfm">
	<cfelseif s is 8>
		<cfset url_redirect = "ssdrDownloads.cfm">
	<cfelseif s is 9>
		<cfset url_redirect = "ssdrAdjustorsReport.cfm">
	<cfelseif s is 10>
		<cfset url_redirect = "ssdrUploads.cfm">
	</cfif>
	
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("#url_redirect#?r=#Rand()#");
	</script>
<cfelse>

	<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
	SELECT * FROM dbo.tblUsers WHERE user_name = '#form.login#'
	</cfquery>
	
	<cfif login_chk.recordcount is 0>
		<cfset chk_log = "log">
	<cfelse>
		<cfset chk_log = "pass">
	</cfif>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("login.cfm?relog=false&chk=#chk_log#&s=#s#&r=#Rand()#");
	</script>
</cfif>
</cfoutput>
<body>
</body>
</html>
