<!doctype html>

<html>
<head>
	<title>ajax call </title>
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

<input onClick="ajax_call_js();return false;" style="width: 100px; height: 28px;" type="Button" value="ajax call server" tabindex="2" title="Search Button" alt="Search Button" name="go" />

</body>
</html>


<script>
var token = "";

function ajax_call_js() {

	var frm = [];
	frm.push({"name" : "user", "value" : "joe" });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "http://78boe99prod/ufd/cfc/cf_service.cfc?method=ajax_server&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON($.trim(data));
	  	console.log(data);
		alert(JSON.stringify(data));
	  }
	});

}
</script>


