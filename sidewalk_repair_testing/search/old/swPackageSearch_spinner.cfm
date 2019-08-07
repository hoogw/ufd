<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=4");
	</script>
	<cfabort>
</cfif>
<!--- <cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=4&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<cfset shellName = "">
<cfif (findNoCase('Android', cgi.http_user_agent,1) AND findNoCase('mobile', cgi.http_user_agent,1)) OR 
(findNoCase('Windows', cgi.http_user_agent,1) AND findNoCase('Phone', cgi.http_user_agent,1)) OR 
(findNoCase('iPhone', cgi.http_user_agent,1) OR findNoCase('iPod', cgi.http_user_agent,1)) OR 
(findNoCase('BlackBerry', cgi.http_user_agent,1) OR findNoCase('BB10', cgi.http_user_agent,1))>
	<cfset shellName = "Handheld">
<cfelseif findNoCase('Android', cgi.http_user_agent,1) OR 
findNoCase('iPad', cgi.http_user_agent,1) OR 
findNoCase('Playbook', cgi.http_user_agent,1) OR 
findNoCase('Touch', cgi.http_user_agent,1)>
	<cfset shellName = "Tablet">
<cfelse>
	<cfset shellName = "Desktop">
</cfif>

<html>
<head>
<title>Sidewalk Repair Program - Search Sidewalk Repair Packages</title>
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


<script language="JavaScript" src="../js/progressing_loading_sign.js" type="text/javascript"></script>

</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageGroup ORDER BY package_group
</cfquery>

<cfset flw = ""><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>
<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw#>

<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td height="8"></td></tr></table>

<div id="searchbox" style="display:block;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="7"></td></tr>
          <tr><td align="center" class="pagetitle">Search Sidewalk Repair Packages</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:704px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:420px;">Search Sidewalk Repair Packages:</th>
						</tr>
					</table>
			
			
			</td>
		</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:85px;">Package Group:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="ps_group" id="ps_group" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfset cnt = 1>
						<cfloop query="getGroups">
							<cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
							<option value="#package_group#" #sel#>#package_group#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:95px;">Package Number:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<input type="Text" name="ps_no" id="ps_no" value="" style="width:45px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:107px;">Work Order Number:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:107px;">
						<input type="Text" name="ps_wo" id="ps_wo" value="" style="width:102px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:60px;">Fiscal Year:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:80px;">
						<select name="ps_fy" id="ps_fy" class="rounded" style="width:75px;">
						<option value=""></option>
						<cfloop index="i" from="14" to="30">
							<cfset fy = "20#i#-#i+1#">
							<option value="#i#-#i+1#">#fy#</option>
						</cfloop> 
						</select>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:65px;">Contractor:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:238px;">
						<input type="Text" name="ps_con" id="ps_con" value="" style="width:233px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Facility Name:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:287px;">
						<input type="Text" name="ps_name" id="ps_name" value="" style="width:282px;" class="rounded"></td>
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
	<tr>
		<td align="center">
			<a id="search" href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="sortTable(0);return false;">Search</a>
		</td>
		<td style="width:15px;"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick=" $('#chr(35)#form1')[0].reset();return false;">Clear</a>
		</td>
	</tr>
</table>

</div>


<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
<div id="processing_icon" align="center"></div>
<div id="result_panel">




<div name="ss_arrow" id="ss_arrow" onClick="toggleSearchBox();"
style="position:absolute;top:192px;left:0px;height:15px;width:50px;border:0px red solid;overflow:hidden;display:none;">
<img id="ss_arrow_img" style="position:absolute;top:0px;left:20px;visibility:visible;" src="../images/arrow_up.png" width="19" height="12" title="Hide Search Filter Box"  onmouseover="this.style.cursor='pointer';">
</div>


<div name="ps_header" id="ps_header" 
style="position:relative;top:10px;left:5px;height:25px;width:100%;border:2px #request.color# solid;overflow:hidden;display:none;">
<table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
	<tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
		<tr>
			<th class="drk center middle" style="height:21px;width:40px;">Edit</th>
			<th class="drk center middle" style="width:80px;" onClick="sortTable(1);return false;" onMouseOver="this.style.cursor='pointer';">Group</th>
			<th class="drk center middle" style="width:80px;" onClick="sortTable(2);return false;" onMouseOver="this.style.cursor='pointer';">Number</th>
			<th class="drk center middle" style="width:160px;" onClick="sortTable(3);return false;" onMouseOver="this.style.cursor='pointer';">Work Order Number</th>
			<th class="drk center middle" onClick="sortTable(4);return false;" onMouseOver="this.style.cursor='pointer';">Contractor</th>
			<th id="fldFY" class="drk center middle" style="width:65px;" onClick="sortTable(5);return false;" onMouseOver="this.style.cursor='pointer';">Fiscal Year</th>
		</tr>
		</table>
	</td></tr>
</table>

</div>

<div name="ps_results" id="ps_results" 
style="position:relative;top:8px;left:5px;height:100%;width:100%;border:2px #request.color# solid;overflow-y:auto;overflow-x:hidden;display:none;">
<table id="tbl_results" border="0" cellpadding="0" cellspacing="0" ><tr><td></td></tr></table>
</div>

										
</div> <!--- id="result_panel"   --->    										
	
	
	
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

function changeHeight() {
	var ht = top.getIFrameHeight();
	var w = top.getIFrameWidth();
	ht = ht - 55;
	if ( $("#searchbox").is(":visible") ) { 
		ht = top.getIFrameHeight() - 243;
	}
	w = w - 14;
	$('#ps_results').height(ht);
	$('#ps_results').width(w);
	$('#ps_header').width(w);
	$('#fldFY').css('width',"82px");
	if ( $("#ps_results").height() > $("#tbl_results").height()) { $("#ps_results").height($("#tbl_results").height());  $('#fldFY').css('width',"65px");}
}

function sortTable(idx) {

	var dir = "ASC";
	if (idx == sort.id) {
		if(sort.dir == "ASC") { dir = "DESC"; } else { dir = "ASC"; }
	}

	switch (idx) {
	case 1: sort.id = idx; sort.dir = dir; sort.order = "package_group " + dir + ",package_no"; break;
	case 2: sort.id = idx; sort.dir = dir; sort.order = "package_no " + dir + ",package_group"; break;
	case 3: sort.id = idx; sort.dir = dir; sort.order = "work_order " + dir + ",package_group,package_no"; break;
	case 4: sort.id = idx; sort.dir = dir; sort.order = "contractor " + dir + ",package_group,package_no"; break;
	case 5: sort.id = idx; sort.dir = dir; sort.order = "fiscal_year " + dir + ",package_group,package_no"; break;
	default: sort.id = idx; sort.dir = "ASC"; sort.order = "";
	}
	submitForm();
}

function setForm() {
	if (typeof top.psearch.length != "undefined") {
		//console.log(top.psearch);
		$.each(top.psearch, function(i, item) {
			//console.log(item);
			$("#" + item.name ).val(item.value);
		});
		if (typeof top.psearch.sort != "undefined") {
			sort = top.psearch.sort;
		}
		submitForm();
	}
}

function submitForm() {

	var frm = $('#form1').serializeArray();
	
	if(sort.order != "" && (typeof sort.order != "undefined")) {
		frm.push({"name" : "ps_order", "value" : sort.order });
	}
	top.psearch = frm;
	top.psearch.sort = sort;
	//console.log(frm);
	//console.log(top.psearch);
	
	
	<!---  ---- loading sign started ------  --->
	 $("#result_panel").hide();
	 show_loading_img_spinner('processing_icon', 'progressing_loading_sign')
	
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=searchPackages&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		var query = jQuery.parseJSON(data.QUERY);
		console.log(query);
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		
		  
		     
			
			
		
		
		<!---  ---- loading sign ended ------  --->
		//wait(3000);  //3 seconds in milliseconds
		remove_loading_img_spinner('progressing_loading_sign');
		$("#result_panel").show();
		
		
		
		var pg; var pn; var pcon; var pwo; var pid; var pfy;
		$.each(query.COLUMNS, function(i, item) {
			switch (item) {
			case "ID": pid = i; break;
			case "PACKAGE_NO": pn = i; break;
			case "PACKAGE_GROUP": pg = i; break;
			case "WORK_ORDER": pwo = i; break;
			case "CONTRACTOR": pcon = i; break;
			case "FISCAL_YEAR": pfy = i; break;
			}
		});
		
		//console.log(pn);
		//console.log(pg);
		//console.log(pwo);
		//console.log(pcon);
		
		data = data.DATA;
		
		var items = [];
		items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
		items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
		items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
		
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
			
				if (item[pg] == null) {item[pg] = "";}
				if (item[pn] == null) {item[pn] = "";}
				if (item[pwo] == null) {item[pwo] = "";}
				if (item[pcon] == null) {item[pcon] = "";}
				if (item[pfy] == null) {item[pfy] = "";} 
				if (item[pfy] != "") {item[pfy] = "20"+item[pfy];}
	
				items.push("<tr>");
				items.push("<td style='width:39px;height:20px;' class='small center frm'><a href='' onclick='goToPackage(" + item[pid] + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[pg] + "</td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[pn] + "</td>");
				items.push("<td style='width:159px;' class='small center frm'>" + item[pwo] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;' class='small frm'>" + item[pcon] + "</td>");
				items.push("<td style='width:64px;' class='small center frm'>" + item[pfy] + "</td>");
				items.push("</tr>");
			
			});
		}
		else {
			items.push("<td style='height:20px;' class='small center frm'>No Records Found</td>");
		}
		
		items.push("</table>");
		items.push("</td></tr>");
		items.push("</table>");
		
		$("#ps_results").html(items.join(""));
		
		$("#ps_header").show();
		$("#ps_results").show();
		$("#ss_arrow").show();
		changeHeight();
		
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

function goToPackage(pid) {
	
	//  ---- loading sign started ------  --->
	 $("#result_panel").hide();
	 show_loading_img_spinner('processing_icon', 'progressing_loading_sign')
	 
	 
	
	location.replace(url + "forms/swPackageEdit.cfm?pid=" + pid);
}

$(window).resize(function() {
	changeHeight();
});

$(function() {
	$(document).keyup(function (e) { 
		if (e.keyCode == 13) { submitForm(); }
	});
});

function toggleSearchBox() {
	if ( $("#searchbox").is(":visible") ) {
		$("#ss_arrow").css("top",'0px');
		$("#ss_arrow_img").css("top",'3px');
		$("#ss_arrow_img").attr("src",'../images/arrow_down.png');
		$("#ss_arrow_img").attr("title",'Show Search Filter Box');
	}
	else {
		$("#ss_arrow").css("top",'192px');
		$("#ss_arrow_img").css("top",'0px');
		$("#ss_arrow_img").attr("src",'../images/arrow_up.png');
		$("#ss_arrow_img").attr("title",'Hide Search Filter Box');
	}
	$( "#searchbox" ).toggle();
	changeHeight();
}

changeHeight();
setForm();
</script>

</html>


            

				

	


