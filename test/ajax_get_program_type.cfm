<!doctype html>

<html>
<head>
	<title>ajax_get_program_type </title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
    
    
    
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


<!-- Square card -->
<style>
.demo-card-square.mdl-card {
  width: 320px;
  height: 320px;
}
.demo-card-square > .mdl-card__title {
  color: #fff;
  background:
     bottom right 15% no-repeat #46B6AC;
}
</style>

<div class="demo-card-square mdl-card mdl-shadow--2dp">
  <div class="mdl-card__title mdl-card--expand">
    <h2 class="mdl-card__title-text" id="prog_name_display">...</h2>
  </div>
  <div class="mdl-card__supporting-text">
    
         <!-- Numeric Textfield -->
  
  <div class="mdl-textfield mdl-js-textfield">
    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="program_id">
    <label class="mdl-textfield__label" for="program_id">Number...</label>
    <span class="mdl-textfield__error">Input is not a number!</span>
  </div>
  
    
    
    
  </div>
  <div class="mdl-card__actions mdl-card--border">
    <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" onClick="get_program_name();return false;">
      get program type by ID
    </a>
  </div>
</div>

<!---
<input onClick="ajax_call_js();return false;" style="width: 100px; height: 28px;" type="Button" value="ajax call server" tabindex="2" title="Search Button" alt="Search Button" name="go" />
--->

</body>
</html>


<script>
var token = "";

function get_program_name() {

	var frm = [];
	var _txt = $('#program_id').val();
	frm.push({"name" : "program_id", "value" : _txt });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "http://78boe99prod/ufd/cfc/get_program_type.cfc?method=lookup_program_type&callback=",
	  data: frm,
	  dataType: 'json', // using json, jquery will make parse for  you
	  success: function(data) { 
	  
	 
	  console.log(data.NAME);
	  
		
		$("#prog_name_display").text(data.NAME);
		
	  	
	  }
	});

}
</script>


