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
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=7&chk=authority");
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
body
{
	background-color: transparent;
	overflow:auto;	
}
</style>

<cfquery name="getLogins" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM dbo.tblUsers WHERE user_id NOT IN (1,50)
</cfquery>

<!--- <cfdump var="#getLogins#"> --->

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Sidewalk Repair User Rights</td></tr>
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
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Super Administrator</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 3 AND user_power = 3 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Administrator</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 3 AND user_power = 2 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Power Manager</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 2 AND user_power = 3 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Manager</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 2 AND user_power = 2 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Power User</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 2 AND user_power = 0 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">User</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 1 AND user_power = 0 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">BSS Power User</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 0 AND user_power = 1 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">BSS User</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 0 AND user_power = 0 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		<tr>
			<th class="drk left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:294px;">Viewer</th>
					</tr>
				</table>
			</td>
		</tr>
		<cfquery name="tmpQuery" dbtype="query">
		SELECT * FROM getLogins WHERE user_level = 2 AND user_power = -1 ORDER by user_fullname
		</cfquery>
		<cfloop query="tmpQuery">
		<tr>	
			<td colspan="4" style="padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="left middle" style="height:20px;width:294px;">
					#user_fullname#	
					</th>
					</tr>
				</table>
			</td>
		</tr>
		</cfloop>
		
		</table>
	</td>
	</tr>
</table>			

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr><td style="height:20px;"></td></tr>
</table>


<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Super Administrator</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Full Access</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Administrator</th></tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Full Access (with exceptions below)</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Do Change Orders</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Update Engineer Estimate Defaults</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Update Site Priority Point System Table</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Power Manager</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Full Access (with exceptions below)</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Packages</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Data Tab</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Manager</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Full Access (with exceptions below)</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Packages</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Data Tab</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Do Change Orders</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Power User</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Full Access (with exceptions below)</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Delete Packages</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Data Tab</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Do Change Orders</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Contractor Contact Information Hidden</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">User</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Create New Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Create Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Search Sites/Packages/Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Reports</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Data Tab</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Contractor Contact Information Hidden</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">BSS Power User</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Search Sites/Packages/Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Package if BSS is Contractor or if is BSS Package</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can't Add or Remove Sites from Package</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Site Information for BSS Packages</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Site Information for BSS Contracted Sites</td></tr>
		<!--- <tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Construction Start and End Dates of BSS Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Notes for BSS Sites</td></tr> --->
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Assessment Quantity for BSS Package Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Contractors Unit Price for All BSS Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Change Order Quantities for All BSS Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Edit Tree Information for Sites</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">No Access to Data Tab</td></tr>
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">BSS User</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Search Sites/Packages/Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Only Edit Tree Information for Sites</td></tr>		
		<tr>
			<th class="left middle" colspan="4" style="height:20px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr><th class="left middle" style="width:294px;">Viewer</th></tr>
				</table>
			</td>
		</tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Search Sites/Packages/Curb Ramps</td></tr>
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can See Site and Package Details</td></tr>	
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Data is Read Only</td></tr>	
		<tr><td class="frm small left middle" colspan="4" style="height:16px;width:294px;">Can Access Reports</td></tr>
		</table>
	</td>
	</tr>
</table>
		
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr><td style="height:20px;"></td></tr>
</table>
	
<!--- <div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
</div> --->
	
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


            

				

	


