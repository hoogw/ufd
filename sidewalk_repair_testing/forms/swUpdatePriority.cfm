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
<title>Sidewalk Repair Program - Update Site Priority Point System Table</title>
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

<cfquery name="getPriorities" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT b.Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblAccessImprovementType AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'Access_Improvement'
UNION ALL
SELECT 'Severity Index ' + CAST(Key_Value AS varchar) AS type, ID, Category, Key_Value, Points
FROM dbo.tblPriorityRanks WHERE (Category = 'Severity_Index')
UNION ALL
SELECT b.Value as Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblYesNo AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'Cost_Effective'
UNION ALL
SELECT b.Value as Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblYesNo AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'Within_High_Injury'
UNION ALL
SELECT b.Value as Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblYesNo AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'Traveled_By_Disabled'
UNION ALL
SELECT b.Value as Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblComplaintType AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'Complaints_No'
UNION ALL
SELECT b.Value as Type, a.ID, a.Category, a.Key_Value, a.Points
FROM dbo.tblYesNo AS b INNER JOIN
dbo.tblPriorityRanks AS a ON b.ID = a.Key_Value
WHERE a.Category = 'High_Pedestrian_Traffic'
</cfquery>



	
<body style="overflow:auto;">	

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;">Update Site Priority Point System Table</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:460px;">

	<cfset tab1 = 1000><cfset tab2 = 2000>
	
	<form name="form" id="form" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="1" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:260px;">Priority Point System Defaults:</th>
						
						
						<td align="right" style="width:87px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm(0);return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="javascript:changePage('../search/swDownloadData.cfm');return false;">Exit</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
		<tr>
			<th class="left middle"><strong>Category</strong></th>
			<th class="center middle" style="height:30px;width:70px;"><strong>Points</strong></th>
			
		</tr>
		
		<cfset grp = 0><cfset cnt = 1>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Access_Improvement' ORDER BY key_value
		</cfquery>
		<cfset group = "PROGRAM ACCESS IMPROVEMENTS">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Severity_Index' ORDER BY key_value
		</cfquery>
		<cfset group = "SEVERITY CRITERIA">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<cfif getGroup.key_value is 1><cfset sfx = "(Minor)"></cfif>
			<cfif getGroup.key_value is 2><cfset sfx = "(Medium)"></cfif>
			<cfif getGroup.key_value is 3><cfset sfx = "(Major)"></cfif>
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v# #sfx#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Cost_Effective' ORDER BY key_value DESC
		</cfquery>
		<cfset group = "COST EFFECTIVE OR NOT">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Within_High_Injury' ORDER BY key_value DESC
		</cfquery>
		<cfset group = "IS THE SEGMENT IDENTIFIED IN THE HIGH INJURY NETWORK?">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Traveled_By_Disabled' ORDER BY key_value DESC
		</cfquery>
		<cfset group = "IS THE SEGMENT TRAVELED BY DISABLED PERSON(S)?">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'Complaints_No' ORDER BY key_value DESC
		</cfquery>
		<cfset group = "NUMBER OF COMPLAINTS (PER BSS 311)">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<cfquery name="getGroup" dbtype="query">
		SELECT * FROM getPriorities WHERE Category = 'High_Pedestrian_Traffic' ORDER BY key_value DESC
		</cfquery>
		<cfset group = "IS THE SEGMENT TRAVELED BY HIGH PEDESTRIAN TRAFFIC?">
		<tr><th class="drk center middle" colspan="2" style="height:20px;">#group#</th></tr>
		<cfloop query="getGroup">
			<tr>			
				<cfset v = getGroup.type>
				<th class="left middle" style="height:30px;width:360px;">#v#:</th>
				<td class="frm left middle" style="width:80px;"><input type="Text" name="points_#getGroup.id#" id="points_#getGroup.id#" value="#getGroup.points#" style="width:75px;text-align:right;" class="center rounded" tabindex="#cnt#"></td>
				<cfset tab2 = tab2+1>
			</tr>
			<cfset cnt = cnt +1>
		</cfloop>
		
		
		
		<tr>
		<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:234px;">
						<a id="btn2" href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm(1);return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="javascript:changePage('../search/swDownloadData.cfm');return false;">Exit</a>
					</td>
					
					</tr>
				</table>
		</td>
		</tr>
			
			
			
		</table>
	</td>
	</tr>
	</form>
</table>





<table align=center border="0" cellpadding="0" cellspacing="0">
		<tr><td height=15></td></tr>
		<!--- <tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Update</a>
			</td>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="cancelUpdate();return false;">Cancel</a>
			</td>
		</tr>
		<tr><td height=15></td></tr> --->
	</table>
	
<div id="msg" class="box" style="top:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header" class="box_header"><strong>The Following Error(s) Occured:</strong></div>
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

function chkForm() {
	var errors = "";
	var cnt = 0;
	<cfoutput>
	<cfset cnt = 1>
	<cfloop query="getPriorities">
		<cfset v = getPriorities.type>
		<cfset v2 = replace(getPriorities.category,"_"," ","ALL")>
		var chk = $.isNumeric(trim($('#chr(35)#points_#getPriorities.id#').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)#points_#getPriorities.id#').val());
		if (chk2 != '' && chk == false)	{ cnt++;errors = errors + '- #v2# -- #v#  must be numeric!<br>'; }
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;
}


function submitForm(id) {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	//console.log(errors);
	
	if (errors != '') {
		if (id == 0) { showMsg(errors,cnt);	}
		else { showMsg2(errors,cnt);	}
		return false;	
	}
	
	var frm = $('#form').serializeArray();
	//console.log(frm);

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updatePriorityDefault&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		if(data.RESULT != "Success") {
			if (id == 0) { showMsg(data.RESULT,1);}
			else { showMsg(data.RESULT,1);}
			return false;	
		}
		
		if (id == 0) { showMsg("Site Priority Point System Table updated successfully!",1,"Site Priority Point System Default Table");}
			else { showMsg2("Site Priority Point System Table updated successfully!",1,"Site Priority Point System Default Table");}
	  }
	});
	
}

function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function showMsg2(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top: ($('#btn2').position().top - 100) + 'px' ,left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
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


            

				

	


