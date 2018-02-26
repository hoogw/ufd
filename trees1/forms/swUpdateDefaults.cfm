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

<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, sort_order, sort_group
FROM vwSortOrder WHERE column_name not like 'EXTRA%'
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

	
<body style="overflow:auto;">	

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;">Update Engineering Estimate Default Table</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:565px;">

	<cfset tab1 = 1000><cfset tab2 = 2000>
	
	<form name="form" id="form" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:365px;">Engineer Estimate Defaults:</th>
						
						
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
			<th class="center middle" style="height:30px;width:25px;">No</th>
			<th class="center middle"></th>
			<th class="center middle" style="width:70px;">Units</th>
			<th class="center middle" style="width:70px;">Unit Price</th>
			
		</tr>
		
		<cfset grp = 0><cfset cnt = 1>
		<cfloop query="getFlds">
		
			<cfif right(column_name,6) is "_UNITS">
			
				<cfset fld = replace(column_name,"_UNITS","","ALL")>
				<cfset v = replace(column_name,"___",")_","ALL")><cfset v = replace(v,"__"," (","ALL")><cfset v = replace(v,"_UNITS","","ALL")>
				<cfset v = replace(v,"_l_","_/_","ALL")><cfset v = replace(v,"_ll_",".","ALL")><cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
				<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
				<cfset v = replace(v,"_INCH","#chr(34)#","ALL")><cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
				<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
				<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
				<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
				<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
				<cfset v = replace(v," ","&nbsp;","ALL")>
				
				<cfif grp lt sort_group>
					<cfset grp = sort_group>
					<cfif grp is 1><cfset group = "GENERAL CODITIONS / GENERAL REQUIREMENTS"></cfif>
					<cfif grp is 2><cfset group = "DEMOLITION & REMOVALS"></cfif>
					<cfif grp is 3><cfset group = "CONCRETE (SIDEWALKS & DRIVEWAYS)"></cfif>
					<cfif grp is 4><cfset group = "TRESS & LANDSCAPING"></cfif>
					<cfif grp is 5><cfset group = "UTILITIES"></cfif>
					<cfif grp is 6><cfset group = "MISCELLANEOUS ITEMS"></cfif>
					<tr>
					<th class="drk center middle" colspan="4" style="height:15px;">#group#</th>
					</tr>
				</cfif>
				
				<cfquery name="getDefaults" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
	
				<tr>
					
					<th class="center middle" style="height:30px;width:25px;">#sort_order#</th>
					
					
					<th class="left middle" style="height:30px;width:360px;">#v#:</th>
					
					<td class="frm left middle" style="width:70px;"><input type="Text" name="units_#cnt#" id="units_#cnt#" value="#getDefaults.units#" 
				style="width:65px;text-align:center;" class="center rounded" tabindex="#tab1#" maxlength="7"></td>
					<cfset tab1 = tab1+1>
					
					<td class="frm left middle" style="width:80px;"><input type="Text" name="price_#cnt#" id="price_#cnt#" value="#trim(numberformat(getDefaults.price,999999.00))#" style="width:75px;text-align:right;" class="center rounded" tabindex="#tab2#"></td>
					<cfset tab2 = tab2+1>
					<input type="Hidden" name="fieldname_#cnt#" id="fieldname_#cnt#" value="#getDefaults.fieldname#">
				</tr>
			</cfif>
			<cfset cnt = cnt +1>
		</cfloop>
		
		<tr>
		<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:339px;">
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
	<cfloop query="getFlds">
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		<cfset v = replace(column_name,"___",")_","ALL")><cfset v = replace(v,"__"," (","ALL")><cfset v = replace(v,"_UNITS","","ALL")>
		<cfset v = replace(v,"_l_","_/_","ALL")><cfset v = replace(v,"_ll_",".","ALL")><cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
		<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")><cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
		<cfset v = replace(v,"_INCH","#chr(34)#","ALL")><cfset v = replace(v,"_"," ","ALL")><cfset v = lcase(v)><cfset v = CapFirst(v)>
		<cfset v = replace(v," Dwp "," DWP ","ALL")><cfset v = replace(v," Pvc "," PVC ","ALL")><cfset v = replace(v,"(n","(N","ALL")>
		<cfset v = replace(v,"(t","(T","ALL")><cfset v = replace(v,"(c","(C","ALL")><cfset v = replace(v,"(r","(R","ALL")>
		<cfset v = replace(v,"(h","(H","ALL")><cfset v = replace(v,"(o","(O","ALL")><cfset v = replace(v,"(p","(P","ALL")>
		<cfset v = replace(v,"(ada","(ADA","ALL")><cfset v = replace(v," And "," & ","ALL")><cfset v = replace(v,"Composite","Comp","ALL")>
		<cfset v = replace(v," ","&nbsp;","ALL")>
		var chk = $.isNumeric(trim($('#chr(35)#price_#cnt#').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)#price_#cnt#').val());
		if (chk2 != '' && chk == false)	{ cnt++;errors = errors + '- #v# Unit Price must be numeric!<br>'; }
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	return errors + ":" + cnt;
}


function submitForm(id) {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	
	if (errors != '') {
		if (id == 0) { showMsg(errors,cnt);	}
		else { showMsg2(errors,cnt);	}
		return false;	
	}
	
	var frm = $('#form').serializeArray();
	//console.log(frm);

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateDefault&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if(data.RESULT != "Success") {
			if (id == 0) { showMsg(data.RESULT,1);}
			else { showMsg(data.RESULT,1);}
			return false;	
		}
		
		if (id == 0) { showMsg("Default Table updated successfully!",1,"Engineering Estimate Default Table");}
			else { showMsg2("Default Table updated successfully!",1,"Engineering Estimate Default Table");}
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


            

				

	


