<!doctype html>

<html>
<head>
	<title>session </title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
</head>

<!--- <cfhttp url="https://www.arcgis.com/sharing/oauth2/token" method="get">
	<cfhttpparam type="URL" name="client_id" value="0Cr0WSHvv1SCbzNS" encoded="no"> 
	<cfhttpparam type="URL" name="client_secret" value="526dbda78e0a4a7ba54242bfd076762f" encoded="no"> 
	<cfhttpparam type="URL" name="grant_type" value="client_credentials" encoded="no"> 
</cfhttp>
<cfdump var="#cfhttp#">
<br> --->
<!--- <cfoutput>#cfhttp.filecontent#</cfoutput> --->

<cfset dt = Now()>
<cfset dt = dateformat(dt,"MM/DD/YYYY") & " " & timeformat(dt,"HH:mm:ss")>


<body>

      <cfdump
    var="#APPLICATION.GetApplicationSettings()#"
    label="GetApplicationSettings() Output"
    />


</body>
</html>


<script>

</script>


