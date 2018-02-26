<!doctype html>

<html>
<head>
	<title>Empower LA Test</title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
</head>

<!--- <cfset restInitApplication("D:\empowerla\cfc","EmpowerLA")> --->

<cfhttp url="http://navigatela.lacity.org/rest/srp/requests/getBidItems" method="get">
	<!--- <cfhttpparam type="formfield" name="x" value="6485678.07" encoded="no"> 
    <cfhttpparam type="formfield" name="y" value="1839085.10" encoded="no">  --->
</cfhttp>
<cfdump var="#cfhttp#">
<br>
<cfoutput>#cfhttp.filecontent#</cfoutput>

<!--- <cfhttp url="http://navigatela.lacity.org/rest/geocoders/geoQuery_MyLA/addressValidationService" method="post">
	<cfhttpparam type="formfield" name="addressSearch" value="1st/main" encoded="no"> 
</cfhttp>
<cfdump var="#cfhttp#"> --->
<br>
<!--- <cfoutput>#cfhttp.filecontent#</cfoutput> --->



<script>
function doTest() {

	var frm = [];
	frm.push({"name" : "x", "value" : 6485678.07 });
	frm.push({"name" : "y", "value" : 1839085.10 });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "http://navigatela.lacity.org/rest/empowerla/requests/retrieveNCID",
	  data: frm,
	  success: function(data) { 
	  	//data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		
		
	  }
	});

}

function doTest2() {

	var frm = [];
	frm.push({"name" : "AddressSearch", "value" : "600 spring" });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "http://navigatela.lacity.org/rest/geocoders/geoQuery_MyLA/addressValidationService",
	  data: frm,
	  success: function(data) { 
	  	//data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		
	  }
	});

}
</script>

<body>

<input onclick="doTest();return false;" style="width: 100px; height: 28px;" type="Button" value="Ajax NCID" tabindex="2" title="Search Button" alt="Search Button" name="go" />
<br><br>
<input onclick="doTest2();return false;" style="width: 100px; height: 28px;" type="Button" value="Ajax Address" tabindex="2" title="Search Button" alt="Search Button" name="go" />

</body>
</html>
