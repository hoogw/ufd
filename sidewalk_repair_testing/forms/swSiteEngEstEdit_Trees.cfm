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
<title>Sidewalk Repair Program - Update Engineering Estimate / Contractor Pricing Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<cfparam name="url.sid" default="5">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">

<!--- Get Package --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>

<!--- Get Estimates --->
<cfquery name="getEst" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblEngineeringEstimate WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get QC Values --->
<cfquery name="getQCs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblQCQuantity WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get ChangeOrder Values --->
<cfquery name="getCOs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblChangeOrders WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Contractor Price --->
<cfquery name="getContract" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblContractorPricing WHERE location_no = #getSite.location_no#
</cfquery>


<!--- <cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
</cfquery> --->

<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, sort_order, sort_group
FROM vwSortOrder
ORDER BY full_sort, sort_group, sort_order
</cfquery>

<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
	
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />
	
	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

	
<body>	

<div id="box_attachments" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:block;overflow:auto;">

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:400px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:400px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:212px;">Uploaded Files</th>
					<td style="width:90px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm8();return false;">Close</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
				<td class="center"><span class="pagetitle" style="position:relative;top:0px;font-size: 12px;">Loc No: #getSite.location_no# - #getSite.name#</span></td>
				</tr>
			</table>
			</td>
		</tr>
		
		<cfif session.user_power gte 0>
		<tr>
		<th class="left middle" colspan="2" style="height:30px;">
			
			<cfset src_arb = "../images/pdf_icon_trans.gif"><cfset href_arb = "">
			<cfset src_rmvl = "../images/pdf_icon_trans.gif"><cfset href_rmvl = "">
			<cfset src_cert = "../images/pdf_icon_trans.gif"><cfset href_cert = "">
			<cfset src_curb = "../images/pdf_icon_trans.gif"><cfset href_curb = "">
			<cfset src_memo = "../images/pdf_icon_trans.gif"><cfset href_memo = "">
			<cfset src_roe = "../images/pdf_icon_trans.gif"><cfset href_roe = "">
			
			<cfset cnt = 5 - len(getSite.location_no)><cfset dir2 = getSite.location_no><cfloop index="i" from="1" to="#cnt#"><cfset dir2 = "0" & dir2></cfloop>
			<cfset dir = request.dir & "\pdfs\" & dir2>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.pdf">
			<cfloop query="pdfdir">
				<cfif lcase(pdfdir.name) is "tree_removal_permits." & dir2 & ".pdf">
					<cfset src_rmvl = "../images/pdf_icon.gif">
					<cfset href_rmvl = "href = '" & request.url & "pdfs/" & dir2 & "/tree_removal_permits." & dir2 & ".pdf' title='View Tree Removal Permits PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "arborist_report." & dir2 & ".pdf">
					<cfset src_arb = "../images/pdf_icon.gif">
					<cfset href_arb = "href = '" & request.url & "pdfs/" & dir2 & "/arborist_report." & dir2 & ".pdf' title='View Arborist Report PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "certification_form." & dir2 & ".pdf">
					<cfset src_cert = "../images/pdf_icon.gif">
					<cfset href_cert = "href = '" & request.url & "pdfs/" & dir2 & "/certification_form." & dir2 & ".pdf' title='View Certification Form PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "curb_ramp_plans." & dir2 & ".pdf">
					<cfset src_curb = "../images/pdf_icon.gif">
					<cfset href_curb = "href = '" & request.url & "pdfs/" & dir2 & "/curb_ramp_plans." & dir2 & ".pdf' title='View Curb Ramp Plans PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "memos." & dir2 & ".pdf">
					<cfset src_memo = "../images/pdf_icon.gif">
					<cfset href_memo = "href = '" & request.url & "pdfs/" & dir2 & "/memos." & dir2 & ".pdf' title='View Memos PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "roe_form." & dir2 & ".pdf">
					<cfset src_roe = "../images/pdf_icon.gif">
					<cfset href_roe = "href = '" & request.url & "pdfs/" & dir2 & "/roe_form." & dir2 & ".pdf' title='View ROE Form PDF'">
				</cfif>
			</cfloop>
			
			
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_cert is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_cert" #href_cert# target="_blank"><img id="img_cert" src="#src_cert#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Certification Form</span></a>
					<span id="rmv_cert" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(2);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Certification Form" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_roe is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_roe" #href_roe# target="_blank"><img id="img_roe" src="#src_roe#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">ROE Form</span></a>
					<span id="rmv_roe" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(3);return false;"><img src="../images/grey_x.png" width="8" height="8" title="ROE Form" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_memo is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_memo" #href_memo# target="_blank"><img id="img_memo" src="#src_memo#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Memos</span></a>
					<span id="rmv_memo" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(4);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Memos" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_curb is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_curb" #href_curb# target="_blank"><img id="img_curb" src="#src_curb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Curb Ramp Plans</span></a>
					<span id="rmv_curb" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(5);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Curb Ramp Plans" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_rmvl is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_rmvl" #href_rmvl# target="_blank"><img id="img_rmvl" src="#src_rmvl#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Tree Removal Permits</span></a>
					<span id="rmv_rmvl" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(0);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Tree Removal Permits" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr><td class="vspacer" height="5px;"></td></tr>
				<tr>
					<cfset attvis = "hidden"><cfif href_arb is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:120px;"><a id="a_arb" #href_arb# target="_blank"><img id="img_arb" src="#src_arb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Arborist Report</span></a>
					<span id="rmv_arb" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(1);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Arborist Report" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
				</tr>
				<tr>
					<th><a href="" onclick="showAttach();return false;"><img src="../images/attach.png" width="9" height="15" title="Attach Files" style="position:relative;top:3px;right:5px;">
					<span style="position:relative;top:0px;right:5px;" title="Attach Files">Attach Files</span></a></td>
				</tr>
			</table>
				
		</th>
		</tr>
		</cfif>
		</table>
	</td>
	</tr>
</table>
	
	
<div id="msg5" class="box" style="top:40px;left:1px;width:380px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg5').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text5" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg5').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>


<div id="msg7" class="box" style="top:40px;left:1px;width:350px;height:80px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg7').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header5" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text7" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to remove this Attachment?
		</div>
		<input type="Hidden" id="attached_type" name="attached_type" value="">
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="doRemoveAttach();$('#chr(35)#msg7').hide();return false;">Continue...</a>
			</td>
			<td style="width:0px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg7').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>
	
	
	
	
</div>



</body>


</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
var pid = #url.pid#;
var search = #url.search#;
</cfoutput>

var treeSub = false;


function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

Number.prototype.formatMoney = function(c, d, t){
var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };
 
 
 
 
 
 function resetForm8() {
	$('#box_attachments').hide();
	$('#msg5').hide();
}




function showMsg5(txt,cnt) {
	$('#msg_text5').html(txt);
	$('#msg5').height(35+cnt*14+30);
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg5').height() / 2)+'px 0 0 -'+($('#msg5').width() / 2)+'px'});
	$('#msg5').show();
}


function showRemoveAttach(idx) {
	$('#msg7').css({top:'50%',left:'50%',margin:'-'+($('#msg7').height() / 2)+'px 0 0 -'+($('#msg7').width() / 2)+'px'});
	$('#msg7').show();
	$('#attached_type').val(idx);
}

function doRemoveAttach() {

	var ref = $('#a_rmvl').attr('href');
	var typ = $('#attached_type').val();
	if (typ == 1) {	ref = $('#a_arb').attr('href'); }
	else if (typ == 2) { ref = $('#a_cert').attr('href'); }
	else if (typ == 3) { ref = $('#a_roe').attr('href'); }
	else if (typ == 4) { ref = $('#a_memo').attr('href'); }
	else if (typ == 5) { ref = $('#a_curb').attr('href'); }

	var arrRef = ref.split("/");
	ref = arrRef[arrRef.length-1];
	dir = arrRef[arrRef.length-2];
	//console.log(ref);
	
	var frm = [];
	frm.push({"name" : "file_name", "value" : ref });
	frm.push({"name" : "dir", "value" : dir });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=doDeleteAttachment&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESPONSE != "Success") {
			$('#msg7').hide();
			return false;	
		}
		
		if (typ == 1) {
			$("#a_arb").removeAttr('href');
			$("#a_arb").removeAttr('title');
			$("#img_arb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_arb").css('visibility', 'hidden');
		}
		else if (typ == 2) {
			$("#a_cert").removeAttr('href');
			$("#a_cert").removeAttr('title');
			$("#img_cert").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_cert").css('visibility', 'hidden');
		}
		else if (typ == 3) {
			$("#a_roe").removeAttr('href');
			$("#a_roe").removeAttr('title');
			$("#img_roe").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_roe").css('visibility', 'hidden');
		}
		else if (typ == 4) {
			$("#a_memo").removeAttr('href');
			$("#a_memo").removeAttr('title');
			$("#img_memo").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_memo").css('visibility', 'hidden');
		}
		else if (typ == 5) {
			$("#a_curb").removeAttr('href');
			$("#a_curb").removeAttr('title');
			$("#img_curb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_curb").css('visibility', 'hidden');
		}
		else {
			$("#a_rmvl").removeAttr('href');
			$("#a_rmvl").removeAttr('title');
			$("#img_rmvl").attr('src', '../images/pdf_icon_trans.gif');
			$("#img_arb").attr('title', 'View Arborist Report PDF');
			$("#rmv_rmvl").css('visibility', 'hidden');
		}
		
	  }
	});

}



</script>

</html>


            

				

	


