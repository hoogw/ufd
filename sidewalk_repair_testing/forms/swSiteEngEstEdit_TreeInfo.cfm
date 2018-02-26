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

<cfparam name="url.sid" default="4">
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
<!--- Get Curbs --->
<cfquery name="getTrees" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeRemovalInfo WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Curb Fields --->
<cfquery name="getFlds3" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH as cml
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
</cfquery>


<div id="box_tree" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:block;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update ADA Curb Ramps Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:420px;">
	<form name="form7" id="form7" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:420px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:212px;">Tree Removal Information</th>
					<td align="right" style="width:100px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm7();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm7();return false;">Cancel</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">
			<span class="pagetitle" style="font-size: 12px;">
			Loc No: #getSite.location_no# - #getSite.name#
			</span>
			</td>
		</tr>
		
		<cfset cnt = 0>
		<cfloop query="getFlds3">			
			<cfif cnt gt 1>
				<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
				<cfset v = replace(column_name,"_"," ","ALL")>
				<cfset v = replace(v,"NO ","number of ","ALL")>
				<cfset v = lcase(v)>
				<cfset v = CapFirst(v)>
				<cfset v = replace(v,"And","and","ALL")>
				<cfset v = replace(v," ","&nbsp;","ALL")>

				<cfset c = "">
				<cfif getTrees.recordcount gt 0>
					<cfset c = evaluate("getTrees.#column_name#")>
				</cfif>
				<cfif c is "" AND data_type is not "nvarchar" AND data_type is not "datetime"><cfset c = 0></cfif>
				
				
				<cfif data_type is "datetime">
				<cfset v = "Date&nbsp;" & replace(v,"&nbsp;Date","","ALL")>
				<tr>
					<th class="left middle" style="height:30px;width:270px;">#v#:&nbsp;</th>
					<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
				</tr>
				<cfelseif data_type is not "nvarchar">
				<cfset v = replace(v,"Pullbox","Pullboxes","ALL")>
				<tr>
					<th class="left middle" style="height:30px;">#v#:&nbsp;</th>
					<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
				</tr>
				<cfelse>
				
					<cfif cml lt 0>
					<tr><th class="left middle" colspan="2" style="height:20px;">#v#:</th></tr>
					<tr>
						<td class="frm" colspan="2" style="height:73px;">
						<textarea id="#column_name#" class="rounded" style="position:relative;top:0px;left:2px;width:405px;height:65px;">#c#</textarea>
						</td>
					</tr>
					<cfelse>
					<tr>
						<th class="left middle" style="height:30px;">#v#:&nbsp;</th>
						<td class="frm left middle"><input type="Text" name="#column_name#" id="#column_name#" value="#c#" 
						style="width:130px;text-align:center;" class="center rounded"></td>
					</tr>
					</cfif>
				
				</cfif>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		</table>
	</td>
	</tr>
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>
	
	
	
<div id="msg5" class="box" style="top:40px;left:1px;width:350px;height:144px;display:none;z-index:505;">
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
 
 
 
 
 
 function resetForm7() {
	if (treeSub == false) { $('#form7')[0].reset(); }
	$('#box_tree').hide();
	$('#msg5').hide();
}


function chkForm7() {
	
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>	
	<cfloop query="getFlds3">			
		<cfif cnt gt 1>
			<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
			<cfset v = replace(column_name,"_"," ","ALL")>
			<cfset v = replace(v,"NO ","number of ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v,"And","and","ALL")>
			<cfset v = replace(v," ","&nbsp;","ALL")>

			<cfif data_type is not "nvarchar" AND data_type is not "datetime">
				var chk = $.isNumeric(trim($('#chr(35)##column_name#').val().replace(/,/g,""))); 
				var chk2 = trim($('#chr(35)##column_name#').val());
				if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'#v#\' must be numeric!<br>'; }
			</cfif>
		</cfif>
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;

}

function submitForm7() {

	var chk = chkForm7().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	if (errors != '') {
		showMsg5(errors,cnt);
		return false;	
	}
	
	var frm = $('#form7').serializeArray();
	
	<cfoutput><cfloop query="getFlds3"><cfif data_type is "nvarchar" AND cml lt 0>
	frm.push({"name" : "#column_name#", "value" : trim($('#chr(35)##column_name#').val()) });
	</cfif></cfloop></cfoutput>
	
	console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateTrees&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);

		if(data.RESULT != "Success") {
			showMsg5(data.RESULT,1);
			return false;	
		}
		
		$('#box_tree').hide();
		$('#msg5').hide();
		
		treeSub = true;
				
		showMsg("Tree Removals updated successfully!",1,"Tree Removal Form");
		
	  }
	});
	
}

function showMsg5(txt,cnt) {
	$('#msg_text5').html(txt);
	$('#msg5').height(35+cnt*14+30);
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg5').height() / 2)+'px 0 0 -'+($('#msg5').width() / 2)+'px'});
	$('#msg5').show();
}
 

<cfoutput>
<cfset cnt = 0>
<cfloop query="getFlds3">			
<cfif cnt gt 1>
<cfif find("Date",column_name,"1") gt 0><cfbreak></cfif>
<cfif data_type is "datetime">
$( "#chr(35)##column_name#" ).datepicker();
</cfif>
</cfif>
<cfset cnt = cnt + 1>
</cfloop>
</cfoutput>

</script>

</html>


            

				

	


