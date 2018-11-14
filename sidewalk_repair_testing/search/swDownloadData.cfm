<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=5");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 3>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=5&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>


<html>
<head>
<title>Sidewalk Repair Program - Download Sidewalk Repair Data</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Download Sidewalk Repair Data</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk center middle" style="width:294px;">Download Excel SpreadSheet</th>
						</tr>
					</table>
			</td>
		</tr>
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="center middle" style="height:30px;width:294px;">
					
					<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
					onclick="downloadData();return false;">Download</a>
					
					</th>
					
				</table>
			</td>
		</tr>
		</table>
	</td>
	</tr>
</table>			


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr><td align="center"><img id="wait" src="../images/preloader.gif" width="32" height="32" alt="" style="display:none;"></td></tr>
		  <tr><td height="15">
		  <a style="visibility:hidden;" id="lnk" href="../downloads/SidewalkRepairProgram.zip">asdas</a>
		  </td></tr>
		</table>
  	</td>
  </tr>
</table>

<cfif session.user_power gt 2>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td style="height:10px;"></td></tr></table>
<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle" style="height:30px;width:294px;">
						<a href="" onClick="javascript:changePage('../forms/swUpdateDefaults.cfm');return false;" style="color:#request.color#">Update Engineering Estimate Default Table</a>
						</th>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle" style="height:30px;width:294px;">
						<a href="" onClick="javascript:changePage('../forms/swUpdatePriority.cfm');return false;" style="color:#request.color#">Update Site Priority Point System Table</a>
						</th>
						</tr>
					</table>
				</td>
			</tr>
			
		</table>	
	</td>
	</tr>
</table>	
</cfif>








<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td style="height:30px;"></td></tr></table>
<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle" style="height:30px;width:294px;">
						<a href="" onClick="javascript:changePage('swUserRights.cfm');return false;" style="color:#request.color#">User Rights</a>
						</th>
						</tr>
					</table>
				</td>
			</tr>
		</table>	
	</td>
	</tr>
</table>	


<!--- ---------- joe hu ---------- nanage users ---------  9/25/2018 ---------------  --->

<cfif session.user_power gt 2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td style="height:30px;"></td></tr></table>
        <table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
            <tr>
            <td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
                <table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
                    <tr>	
                        <td colspan="4" style="padding:0px 0px 0px 0px;">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                <th class="center middle" style="height:30px;width:294px;">
                                <!--- <a href="" onClick="javascript:changePage('swSuperAdmin.cfm');return false;" style="color:#request.color#">Super Admin</a>   --->
                                <a href="" onClick="javascript:changePage('swUserSearch.cfm');return false;" style="color:#request.color#">Manage User</a>
                                </th>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>	
            </td>
            </tr>
        </table>	
</cfif>


<!--- ----  end ------ joe hu ---------- nanage users ---------  9/25/2018 ---------------  --->



	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
</div>
	
</body>
</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
</cfoutput>
var sort = {};

function downloadData() {
	
	$('#wait').show();
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=downloadData&callback=",
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		$('#wait').hide();
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		$link = $('#lnk:first');
		$link[0].click();
		
	  }
	});
	
}

function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function changePage(source,param){
var rand = Math.random();
url = source + "?r=" + rand;
location.replace(url);
}

</script>

</html>


            

				

	


