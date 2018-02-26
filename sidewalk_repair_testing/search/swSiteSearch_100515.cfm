<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=3");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level is 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=3&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Search Sidewalk Repair Sites</title>
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

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageGroup ORDER BY package_group
</cfquery>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType ORDER BY type
</cfquery>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Search Sidewalk Repair Sites</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:840px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:420px;">Search Sidewalk Repair Sites:</th>
						</tr>
					</table>
			
			
			</td>
		</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:82px;">Location No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<input type="Text" name="ss_no" id="ss_no" value="" style="width:55px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<!--- <th class="left middle" style="width:60px;">Site Suffix:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<select name="ss_sfx" id="ss_sfx" class="rounded" style="width:45px;">
						<option value=""></option>
						<option value="a">a</option>
						<option value="b">b</option>
						<option value="c">c</option>
						<option value="d">d</option>
						<option value="e">e</option>
						<option value="f">f</option>
						<option value="f">g</option>
						<option value="f">h</option>
						<option value="f">i</option>
						<option value="f">j</option>
						<option value="f">k</option>
						</select>
						</td>
						<td style="width:2px;"></td> --->
						<th class="left middle" style="width:95px;">Package Group:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="ss_pgroup" id="ss_pgroup" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfset cnt = 1>
						<cfloop query="getGroups">
							<cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
							<option value="#package_group#" #sel#>#package_group#</option>
						</cfloop>
						<option value="ALL">ALL</option>
						<option value="NONE">NONE</option>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:78px;">Package No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<input type="Text" name="ss_pno" id="ss_pno" value="" style="width:45px;" class="rounded"></td>
						<td style="width:2px;"></td>						
						<th class="left middle" style="width:68px;">Type:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:145px;">
						<select name="ss_type" id="ss_type" class="rounded" style="width:140px;">
						<option value=""></option>
						<cfloop query="getType">
							<option value="#id#">#type#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<select name="ss_cd" id="ss_cd" class="rounded" style="width:45px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="15">
							<option value="#i#">#i#</option>
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
						<th class="left middle" style="width:82px;">Facility Name:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:228px;">
						<input type="Text" name="ss_name" id="ss_name" value="" style="width:223px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:55px;">Address:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:228px;">
						<input type="Text" name="ss_address" id="ss_address" value="" style="width:223px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:64px;">Work Order:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:137px;">
						<input type="Text" name="ss_wo" id="ss_wo" value="" style="width:132px;" class="rounded"></td>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:82px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="ss_assessed" id="ss_assessed" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:85px;">Field Assessor:<br><div style="position:relative;left:20px;">(Intials)</div></th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<input type="Text" name="ss_assessor" id="ss_assessor" value="" style="width:55px;" class="rounded"></td> --->
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:95px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="ss_repairs" id="ss_repairs" class="rounded" style="width:55px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:55px;">QC'd By:<br><div style="position:relative;left:2px;">(Intials)</div></th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<input type="Text" name="ss_qc" id="ss_qc" value="" style="width:45px;" class="rounded"></td> --->
						<td style="width:2px;"></td>
						<th class="left middle" style="width:78px;">Severity Index:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<select name="ss_severity" id="ss_severity" class="rounded" style="width:45px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="3">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>			
						
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:68px;">Site Deleted:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:74px;">
						<select name="ss_removed" id="ss_removed" class="rounded" style="width:69px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfif id is 1>
							<option value="#id#">#value#</option>
							</cfif>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:64px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:137px;">
						<input type="Text" name="ss_zip" id="ss_zip" value="" style="width:132px;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="width:82px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:228px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
						<span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_assfrm" id="ss_assfrm" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_assto" id="ss_assto" value="" style="width:75px;" class="rounded">
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:55px;">QC Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:228px;">
						<span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_qcfrm" id="ss_qcfrm" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_qcto" id="ss_qcto" value="" style="width:75px;" class="rounded">
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="height:30px;width:64px;">Keyword:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:137px;">
						<input type="Text" name="ss_keyword" id="ss_keyword" value="" style="width:132px;" class="rounded"></td>
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


<div name="ss_header" id="ss_header" 
style="position:relative;top:10px;left:5px;height:25px;width:100%;border:2px #request.color# solid;overflow:hidden;display:none;">
<table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
	<tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
		<tr>
			<th class="drk center middle" style="height:21px;width:30px;">Edit</th>
			<th class="drk center middle" style="width:35px;" onclick="sortTable(1);return false;" onmouseover="this.style.cursor='pointer';">Site</th>
			<th class="drk center middle" style="width:50px;" onclick="sortTable(2);return false;" onmouseover="this.style.cursor='pointer';">Package</th>
			<th class="drk center middle" style="width:370px;" onclick="sortTable(3);return false;" onmouseover="this.style.cursor='pointer';">Facility Name</th>
			<th class="drk center middle" onclick="sortTable(4);return false;" onmouseover="this.style.cursor='pointer';">Address</th>
			<th class="drk center middle" style="width:80px;" onclick="sortTable(5);return false;" onmouseover="this.style.cursor='pointer';">Con. Started</th>
			<th class="drk center middle" style="width:85px;" onclick="sortTable(6);return false;" onmouseover="this.style.cursor='pointer';">Con. Completed</th>
			<th class="drk center middle" style="width:80px;" onclick="sortTable(7);return false;" onmouseover="this.style.cursor='pointer';">Type</th>
			<th id="fldWO" class="drk center middle" style="width:65px;" onclick="sortTable(8);return false;" onmouseover="this.style.cursor='pointer';">Work Order</th>
			<!--- <th class="drk center middle" style="width:25px;" onclick="sortTable(3);return false;" onmouseover="this.style.cursor='pointer';">CD</th> --->
		</tr>
		</table>
	</td></tr>
</table>

</div>

<div name="ss_results" id="ss_results" 
style="position:relative;top:8px;left:5px;height:100%;width:100%;border:2px #request.color# solid;overflow-y:auto;overflow-x:hidden;display:none;">
<table id="tbl_results" border="0" cellpadding="0" cellspacing="0" ><tr><td></td></tr></table>
</div>

										
										
	
	
	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
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
	ht = ht - 308;
	w = w - 14;
	$('#ss_results').height(ht);
	$('#ss_results').width(w);
	$('#ss_header').width(w);
	$('#fldWO').css('width',"82px");
	if ( $("#ss_results").height() > $("#tbl_results").height()) { $("#ss_results").height($("#tbl_results").height()); $('#fldWO').css('width',"65px");}
}

function sortTable(idx) {

	var dir = "ASC";
	if (idx == sort.id) {
		if(sort.dir == "ASC") { dir = "DESC"; } else { dir = "ASC"; }
	}

	switch (idx) {
	case 1: sort.id = idx; sort.dir = dir; sort.order = "location_no " + dir + ",location_suffix "  + dir; break;
	case 2: sort.id = idx; sort.dir = dir; sort.order = "package_group " + dir + ",package_no "  + dir; break;
	case 3: sort.id = idx; sort.dir = dir; sort.order = "name " + dir + ",location_no,location_suffix"; break;
	case 4: sort.id = idx; sort.dir = dir; sort.order = "address " + dir + ",name"; break;
	case 5: sort.id = idx; sort.dir = dir; sort.order = "construction_start_date " + dir + ",location_no,location_suffix"; break;
	case 6: sort.id = idx; sort.dir = dir; sort.order = "construction_completed_date " + dir + ",location_no,location_suffix"; break;
	case 7: sort.id = idx; sort.dir = dir; sort.order = "type_desc " + dir + ",location_no,location_suffix"; break;
	case 8: sort.id = idx; sort.dir = dir; sort.order = "work_order " + dir + ",location_no,location_suffix"; break;
	default: sort.id = 1; sort.dir = "ASC"; sort.order = "";
	}
	submitForm();
}

function setForm() {
	if (typeof top.ssearch.length != "undefined") {
		//console.log(top.psearch);
		$.each(top.ssearch, function(i, item) {
			//console.log(item);
			$("#" + item.name ).val(item.value);
		});
		if (typeof top.ssearch.sort != "undefined") {
			sort = top.ssearch.sort;
		}
		submitForm();
	}
}

function submitForm() {

	var frm = $('#form1').serializeArray();
	
	if(sort.order != "" && (typeof sort.order != "undefined")) {
		frm.push({"name" : "ss_order", "value" : sort.order });
	}
	top.ssearch = frm;
	top.ssearch.sort = sort;
	console.log(frm);
	//console.log(top.ssearch);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=searchSites&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		var query = jQuery.parseJSON(data.QUERY);
		//console.log(query);
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		var sno; var ssfx; var sp; var sg; var sname; var saddr; var stype; var swo; var sid; var spid;
		$.each(query.COLUMNS, function(i, item) {
			switch (item) {
			case "ID": sid = i; break;
			case "LOCATION_NO": sno = i; break;
			case "LOCATION_SUFFIX": ssfx = i; break;
			case "PACKAGE_NO": sp = i; break;
			case "PACKAGE_GROUP": sg = i; break;
			case "NAME": sname = i; break;
			case "ADDRESS": saddr = i; break;
			case "CONSTRUCTION_START_DATE": scons = i; break;
			case "CONSTRUCTION_COMPLETED_DATE": sconc = i; break;
			case "TYPE_DESC": stype = i; break;
			case "WORK_ORDER": swo = i; break;
			case "PACKAGE_ID": spid = i; break;
			}
		});
		
		/* console.log(sid);
		console.log(sno);
		console.log(ssfx);
		console.log(sp);
		console.log(sg);
		console.log(sname);
		console.log(saddr);
		console.log(stype);
		console.log(swo); */
		
		data = data.DATA;
		
		
		var items = [];
		items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
		items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
		items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
		
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
			
				if (item[sno] == null) {item[sno] = "";}
				if (item[ssfx] == null) {item[ssfx] = "";}
				if (item[sp] == null) {item[sp] = "";}
				if (item[sg] == null) {item[sg] = "";}
				if (item[sname] == null) {item[sname] = "";}
				if (item[saddr] == null) {item[saddr] = "";}
				if (item[scons] == null) {item[scons] = "";}
				if (item[sconc] == null) {item[sconc] = "";}
				if (item[stype] == null) {item[stype] = "";}
				if (item[swo] == null) {item[swo] = "";}
				if (item[spid] == null) {item[spid] = 0;}
				
				if (item[scons] != "") {
					var d = new Date(item[scons]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[scons] = mm + '/' + dd + '/' + d.getFullYear();	
				}
				
				if (item[sconc] != "") {
					var d = new Date(item[sconc]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[sconc] = mm + '/' + dd + '/' + d.getFullYear();
				}
				
				
				var pkg = item[sg] + item[sp]; if (pkg != "") { pkg = item[sg] + " - " + item[sp]; }
	
				items.push("<tr>");
				items.push("<td style='width:29px;height:20px;' class='small center frm'><a href='' onclick='goToSite(" + item[sid] + "," + item[spid] + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
				items.push("<td style='width:34px;' class='small center frm'>" + item[sno] + item[ssfx]  + "</td>");
				items.push("<td style='width:49px;' class='small center frm'>" + pkg + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;width:366px;' class='small frm'>" + item[sname] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;' class='small frm'>" + item[saddr] + "</td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[scons] + "</td>");
				items.push("<td style='width:84px;' class='small center frm'>" + item[sconc] + "</td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[stype] + "</td>");
				items.push("<td style='width:64px;' class='small center frm'>" + item[swo] + "</td>");
				items.push("</tr>");
			
			});
		}
		else {
			items.push("<td style='height:20px;' class='small center frm'>No Records Found</td>");
		}
		
		items.push("</table>");
		items.push("</td></tr>");
		items.push("</table>");
		
		$("#ss_results").html(items.join(""));
		
		$("#ss_header").show();
		$("#ss_results").show();
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

function goToSite(sid,spid) {
	location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid + "&pid=" + spid + "&search=true");
}

$(window).resize(function() {
	changeHeight();
});

$(function() {
	$(document).keyup(function (e) { 
		if (e.keyCode == 13) { submitForm(); }
	});
});

$( "#ss_assfrm" ).datepicker();
$( "#ss_assto" ).datepicker();
$( "#ss_qcfrm" ).datepicker();
$( "#ss_qcto" ).datepicker();

changeHeight();
setForm();
</script>

</html>


            

				

	


