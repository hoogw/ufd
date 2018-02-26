<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=1");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 2>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=1&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Create a Package or Add to a Package</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<cfparam name="url.type" default="add">

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Packages --->
<cfquery name="getPackages" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackages
</cfquery>

<!--- Get Package Number + 1 --->
<cfquery name="getIDs" dbtype="query">
SELECT distinct package_no <!--- ,package_group ---> FROM getPackages <!--- WHERE package_group = 'BOE' AND removed <> 1 ---> ORDER BY package_no
</cfquery>
<cfquery name="getID" dbtype="query">
SELECT max(package_no) as id FROM getPackages <!--- WHERE package_group = 'BOE' --->
</cfquery>
<cfif getID.id is ""><cfset swid = 1><cfelse><cfset swid = getID.id + 1></cfif>



<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageGroup WHERE package_group <> 'RAP' ORDER BY package_group
</cfquery>

<!--- Get Unassigned Sites --->
<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE package_no is null AND removed is null AND field_assessed = 1 ORDER BY location_no
</cfquery>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType ORDER BY type
</cfquery>

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow-y:auto;">


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">
		  <cfif url.type is "add">
		  Add Sites to an Existing Package
		  <cfelse>
		  Create a New Repair Package
		  </cfif>
		  </td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:800px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;width:800px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:425px;">
						<cfif url.type is "add">
						Add Sites to an Existing Package
						<cfelse>
						Create a New Repair Package
						</cfif>
						</th>
						<th class="drk right middle" style="width:32px;">Group:</th>
						<td style="width:65px;padding:2px 3px 0px 0px;">
						<select name="sw_pgroup" id="sw_pgroup" class="rounded" style="width:60px;border:2px #request.color# solid;"
						onchange="getNewList();">
						<cfloop query="getGroups">
							<option value="#package_group#">#package_group#</option>
						</cfloop>
						</select>
						</td>
						<th class="drk right middle" style="width:90px;">Package Number:</th>
						<td class="drk right middle" style="width:60px;padding:2px 3px 0px 0px;">
						<select name="sw_pno" id="sw_pno" class="rounded" style="width:55px;border:2px #request.color# solid;" onchange="getGroup();">
						<cfif url.type is "add">
						<cfset cnt = 1>
						<cfloop query="getIDs">
							<cfset sel = ""><cfif cnt is getIDs.recordcount><cfset sel = "selected"></cfif>
							<option value="#package_no#" #sel#>#package_no#</option>
							<cfset cnt = cnt + 1>
						</cfloop>
						<cfelse>
						<option value="#swid#" selected>#swid#</option>
						</cfif>
						</select>
						</td>
						
						<td align="right" style="width:90px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm();return false;">Submit</a>
						</td>
						
						</tr>
					</table>
			
			
			</th>
		</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
				
					<div id="sites" style="border:0px red solid;height:500px;overflow-y:auto;">
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle" style="height:20px;width:30px;">Add</th>
						<td style="width:2px;"></td>
						<th class="center middle" style="height:20px;width:45px;">Site No.</th>
						<td style="width:2px;"></td>
						<th class="center middle" style="width:300px;">Facility Name</th>
						<td style="width:2px;"></td>
						<th class="center middle" style="width:300px;">Address</th>
						<td style="width:2px;"></td>
						<th class="center middle" style="width:80px;">Type</th>
						<td style="width:2px;"></td>
						<th class="center middle" style="width:30px;">CD</th>
						<td style="width:2px;"></td>
						</tr>
						<cfloop query="getSites">
							
							<tr><td style="height:2px;"></td></tr>
							<tr>
							<td class="small center frm" style="height:20px;"><input type="Checkbox" id="chk_#id#"></td>
							<td style="width:2px;"></td>
							<td class="small center frm">#location_no#<!--- #site_suffix# ---></td>
							<td style="width:2px;"></td>
							<td class="small frm">#name#</td>
							<td style="width:2px;"></td>
							<td class="small frm">#address#</td>
							<td style="width:2px;"></td>
							<cfset t = type>
							<cfif t is not "">
								<cfquery name="typ" dbtype="query">
								SELECT type as t FROM getType where id = #type#
								</cfquery>
								<cfset t = typ.t>
							</cfif>
							<td class="small frm">#t#</td>
							<td style="width:2px;"></td>
							<td class="small center frm">#council_district#</td>
							</tr>
						</cfloop>
						

					</table>
					
					</div>
					
				</td>
			</tr>
			

		</table>
	</td>
	</tr>
	</form>
</table>

<!--- <table align=center border="0" cellpadding="0" cellspacing="0">
		<tr><td height=15></td></tr>
		<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="submitForm();return false;">Submit</a>
			</td>
		</tr>
	</table> --->
	
	
	
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
var recs = #getSites.recordcount#;
</cfoutput>

function changeHeight() {
	var ht = top.getIFrameHeight();
	ht = ht - 110;
	ht2 = ((recs+1)*25)-4;
	if (ht2 < ht) { ht = ht2;}
	$('#sites').height(ht);
}

function submitForm() {

	$('#msg').hide();
	
	var frm = $('#form1').serializeArray();

	var idList = "";
	$('input[type=checkbox]').each(function () {
           if (this.checked) { idList = idList + this.id.replace("chk_","") + ","; }
	});
	
	if (idList == "") { 
		showMsg("No sites were selected!",1);
		return false;	
	 }
	idList = idList.substr(0,idList.length-1);
	
	$('#sw_pgroup').removeAttr("disabled");
	frm = $('#form1').serializeArray();
	
	frm.push({"name" : "sw_idList", "value" : idList });

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=addPackage&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		//Go to Newly created Package...
		location.replace('swPackageEdit.cfm?pid=' + data.ID);
		
	  } 
	});
	
}

function getNewList() {

	/* var frm = $('#form1').serializeArray();
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=getPackageSiteIDs&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
		removeOptions('sw_pno');
		
		opts = [];
		$(data.ARRIDS).each(function (i,item) {
           console.log(item);
		   opts.push( item + "||" + item);
		});
		
		appendOptions('sw_pno',opts);
		removeOneOptions('sw_pno',0);
		setOption('sw_pno',data.ARRIDS[data.ARRIDS.length-1]);
	  } 
	}); */
}

function getGroup() {

	var frm = $('#form1').serializeArray();
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=getPackageGroup&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
		
		console.log(data);
		if (data.GROUP != '') {
			$('#sw_pgroup').val(data.GROUP);
			$('#sw_pgroup').attr('disabled', true);
		}
		else {
			$('#sw_pgroup').removeAttr("disabled");
			$('#sw_pgroup').val('BOE');
		}
		
	  } 
	});
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function removeOptions(ctrl)
{
  var elSel = document.getElementById(ctrl);
  if (elSel.length > 0)
  {
  	for (var j=elSel.length-1,jl=0; j>=jl; j--) 
	{
		elSel.remove(j);
	}
  }
}

function appendOptions(ctrl,opts)
{
	//console.log(opts);
	if (ctrl != 'mn_status') {
		var elOptNew = document.createElement('option');
		elOptNew.text = '';
		elOptNew.value = '';
		if (ctrl == 'pwrs_category') { elOptNew.text = 'All'; elOptNew.value = 'All'; }
		var elSel = document.getElementById(ctrl);
		try {
		  elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
		}
		catch(ex) {
		  elSel.add(elOptNew); // IE only
		}
	}
	
  	$.each(opts, function(i, item) {
		var arrItem = item.split("||");
		var elOptNew = document.createElement('option');
		elOptNew.value = arrItem[0];
		elOptNew.text = arrItem[1];
		var elSel = document.getElementById(ctrl);
		try {
		  elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
		}
		catch(ex) {
		  elSel.add(elOptNew); // IE only
		}
	});
}

function removeOneOptions(ctrl,idx)
{
  var elSel = document.getElementById(ctrl);
  if (elSel.length > 0)
  {
  	elSel.remove(idx);
  }
}

function setOption(ctrl,val)
{
  var elSel = document.getElementById(ctrl);
  if (elSel.length > 0)
  {
  	for (var j=elSel.length-1,jl=0; j>=jl; j--) 
	{
		if (elSel.options[j].value == val)
			elSel.options[j].selected = true;
	}
  }
}

function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

$(window).resize(function() {
	changeHeight();
});

changeHeight();
</script>

</html>


            

				

	


