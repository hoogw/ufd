<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
	</script>
	<cfabort>
</cfif>
<cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Edit Package</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<cfparam name="url.pid" default="1">

<!--- Get Package --->
<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackages WHERE id = #url.pid#
</cfquery>

<cfset pno = getPackage.package_no>
<cfset pgroup = getPackage.package_group>

<!--- Get Unassigned Sites --->
<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM vwSites WHERE package_no = #pno# AND package_group = '#pgroup#' ORDER BY location_no
</cfquery>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0"  style="overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle">Edit Package Information</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:750px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;width:750px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:55px;">Package:</th>
						<!--- <th class="drk right middle" style="width:32px;">Group:</th> --->
						<td class="left middle pagetitle" style="width:260px;padding:2px 3px 0px 0px;">#getPackage.package_group# - #getPackage.package_no#
						</td>
						<!--- <th class="drk right middle" style="width:90px;">Package Number:</th> --->
						<!--- <td class="drk right middle" style="width:40px;padding:2px 3px 0px 0px;">#getPackage.package_no#
						</td> --->
						
						<td align="left" style="width:315px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm();return false;">Update</a>
						</td>
						
						<td align="right" style="width:90px;">
							<a href="" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;" 
							onclick="showRemove();return false;">Delete</a>
						</td>
						
						</tr>
					</table>
			
			
			</th>
			
			
			</td>
		</tr>
			<cfset w1 = 130><cfset w2 = 125><cfset w3 = 100><cfset w4 = 110>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Work Order Number:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.work_order>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_wo" id="sw_wo" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">NFB Date:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.nfb_date is not ""><cfset v = dateformat(getPackage.nfb_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_nfb" id="sw_nfb" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Bids Due:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.bids_due_date is not ""><cfset v = dateformat(getPackage.bids_due_date,"MM/DD/YYYY")></cfif>
						<td class="frm" style="width:#w2#px;">
						<input type="Text" name="sw_bid" id="sw_bid" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w1#px;">Construction Order:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.construct_order_date is not ""><cfset v = dateformat(getPackage.construct_order_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_co" id="sw_co" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Precon Meeting:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.precon_meeting_date is not ""><cfset v = dateformat(getPackage.precon_meeting_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_precon" id="sw_precon" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:#w3#px;">Notice to Proceed:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.notice_to_proceed_date is not ""><cfset v = dateformat(getPackage.notice_to_proceed_date,"MM/DD/YYYY")></cfif>
						<td class="frm"  style="width:#w2#px;">
						<input type="Text" name="sw_ntp" id="sw_ntp" value="#v#" style="width:#w2-5#px;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:#w4#px;">Engineers Estimate:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.engineers_estimate is not ""><cfset v = numberformat(getPackage.engineers_estimate,"999,999,999")></cfif>
						<td class="frm"  style="width:#w3#px;">$
						<input type="Text" name="sw_est" id="sw_est" value="#trim(v)#" style="width:#w3-16#px;" class="center rounded" disabled></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Awarded Bid:</th>
						<td style="width:2px;"></td>
						<cfset v = ""><cfif getPackage.awarded_bid is not ""><cfset v = numberformat(getPackage.awarded_bid,"999,999,999")></cfif>
						<td class="frm"  style="width:#w3#px;">$
						<input type="Text" name="sw_award" id="sw_award" value="#trim(v)#" style="width:#w3-16#px;" class="center rounded" disabled></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:81px;">Contractor:</th>
						<td style="width:2px;"></td>
						<cfset v = getPackage.contractor>
						<td class="frm"  style="width:#w2+107#px;">
						<input type="Text" name="sw_contractor" id="sw_contractor" value="#v#" style="width:#w2+102#px;" class="rounded"></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr><th class="left middle" colspan="4" style="height:20px;">Notes:</th></tr>
			<tr>
				<cfset v = getPackage.notes>
				<td class="frm" colspan="4" style="height:75px;">
				<textarea id="sw_notes" class="rounded" style="position:relative;top:0px;left:2px;width:728px;height:67px;">#v#</textarea>
				</td>
			</tr>

		</table>
	</td>
	</tr>
		<input type="Hidden" id="sw_id" name="sw_id" value="#url.pid#">
	</form>
</table>

<table cellspacing="0" cellpadding="0" border="0" align="center" style="width:750px;"><tr><td style="height:2px;"></td></tr></table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:750px;">
	<tr>	
		<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
			<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
				<td colspan="4" style="padding:0px 0px 0px 0px;">
				
					<div id="sites" style="border:0px red solid;height:300px;overflow-y:auto;">
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle nopad" style="height:40px;width:50px;">Remove</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:35px;">Site<br>No.</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:350px;">Facility Name</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:30px;">CD</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:60px;">Total<br>Concrete<br>(sq. ft)</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:70px;">Construction<br>Started</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:70px;">Construction<br>Completed</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:75px;">Anticipated<br>Completion<br>Date</th>
						<td style="width:2px;"></td>
						<th class="center middle nopad" style="width:30px;">Edit</th>
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
							<td class="small center frm">#council_district#</td>
							<td style="width:2px;"></td>
							<td class="small center frm">#total_concrete#</td>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif construction_start_date is not ""><cfset v = dateformat(construction_start_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif construction_completed_date is not ""><cfset v = dateformat(construction_completed_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td>
							<td style="width:2px;"></td>
							<cfset v = ""><cfif anticipated_completion_date is not ""><cfset v = dateformat(anticipated_completion_date,"MM/DD/YYYY")></cfif>
							<td class="small center frm">#v#</td>
							<td style="width:2px;"></td>
							<td class="small frm center"><a href="" onclick="goToSite(#url.pid#,#id#);return false;"><img src="../Images/rep.gif" width="13" height="16" alt="Edit Site Information" title="Edit Site Information"></a></td>
							<td style="width:2px;"></td>
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
	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
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

<div id="msg2" class="box" style="top:40px;left:1px;width:300px;height:90px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header2" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text2" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to delete this Package?<br>All Sites will go back to the unassigned pool.
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="submitForm(1);$('#chr(35)#msg2').hide();return false;">Continue...</a>
			</td>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Cancel</a>
			</td>
			</tr>
			
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
	ht = ht - 315;
	ht2 = ((recs)*25)+42;
	if (ht2 < ht) { ht = ht2;}
	$('#sites').height(ht);
}

function submitForm(rmv) {
	
	var bypass = false;
	$('#msg').hide();
	var errors = '';var cnt = 0;
	
	var chk = $.isNumeric(trim($('#sw_est').val().replace(/,/g,""))); var chk2 = trim($('#sw_est').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Engineers Estimate must be Numeric!<br>"; }
	chk = $.isNumeric(trim($('#sw_award').val().replace(/,/g,""))); chk2 = trim($('#sw_award').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Awarded Bid must be Numeric!<br>"; }
	
	if (errors != '') {
		showMsg(errors,cnt);
		return false;	
	}
	
	var frm = $('#form1').serializeArray();
	frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });

	var idList = "";
	$('input[type=checkbox]').each(function () {
           if (this.checked) { idList = idList + this.id.replace("chk_","") + ","; }
	});
	
	if (idList != "") { idList = idList.substr(0,idList.length-1); }
	frm.push({"name" : "sw_idList", "value" : idList });
	
	if (typeof rmv != "undefined") { 
		if (rmv == 1) {	frm.push({"name" : "sw_remove", "value" : rmv }); }
		else {bypass = true;}
	}
	//console.log(rmv);
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updatePackage&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		//Refresh Package if Sites removed...
		if (data.REMOVED) { location.replace('swPackageEdit.cfm?pid=' + data.ID);	}
		else if (data.REMOVE == 1 && bypass == false) { location.replace('swPackageEntry.cfm'); }
		else { if (bypass == false) {showMsg("Package Information updated successfully!",1,"Package Information"); }}
		
	  }
	});
	
}

function goToSite(pid,sid) {
	submitForm(2);
	location.replace("swSiteEdit.cfm?pid=" + pid + "&sid=" + sid);
}


$(function() {
    $( "#sw_nfb" ).datepicker();
	$( "#sw_bid" ).datepicker();
	$( "#sw_co" ).datepicker();
	$( "#sw_precon" ).datepicker();
	$( "#sw_ntp" ).datepicker();
});

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function showRemove() {
	$('#msg2').css({top:'50%',left:'50%',margin:'-'+($('#msg2').height() / 2)+'px 0 0 -'+($('#msg2').width() / 2)+'px'});
	$('#msg2').show();
}

$(window).resize(function() {
	changeHeight();
});

changeHeight();
</script>

</html>


            

				

	


