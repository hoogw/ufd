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
<div id="box_ass" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;display:block;z-index:500;overflow:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update Engineering Estimate / Contractor Pricing Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:655px;">

	<cfset tab1 = 1000><cfset tab2 = 2000><cfset tab3 = 3000><cfset tab4 = 4000><cfset tab5 = 5000><cfset tab6 = 6000>
	
	<form name="form5" id="form5" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="9" style="height:30px;padding:0px 0px 0px 0px;">
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="drk left middle" style="width:100px;"><!--- Site Number --->Field Assessment:</th>
						<td class="left middle pagetitle" style="width:350px;font-size: 12px;padding:1px 3px 0px 0px;">Loc No: #getSite.location_no# - #getSite.name#
						</td>
						
						
						<td align="right" style="width:87px;">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="submitForm5();return false;">Update</a>
						</td>
						<td style="width:10px;"></td>
						<td align="center">
							<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
							onclick="resetForm();return false;">Cancel</a>
						</td>
						
						</tr>
					</table>
			</td>
		</tr>
		
		<tr>
			<th class="left middle" style="height:20px;" colspan="9">Notes / Comments:</th>
		</tr>
		
		<tr>
			<cfset v = "">
			<cfif getQCs.recordcount gt 0>
				<cfset v = getEst.comments>
			</cfif>
			<td class="frm" colspan="9" style="height:56px;">
			<textarea id="comments" class="rounded" style="position:relative;top:0px;left:0px;width:639px;height:50px;">#v#</textarea>
			</td>
		</tr>
		
		
			<tr>
				<th class="center middle" style="height:30px;width:25px;">NO</th>
				<th class="center middle">DESCRIPTION</th>
				<th class="center middle" style="height:30px;width:40px;">UNIT</th>
				<th class="center middle" style="width:70px;">Assessment<br>Quantity</th>
				<cfset num = getFlds.recordcount+4+3>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="width:70px;">QC<br>Quantity</th>
			
				<!--- <cfset num = 4+(getFlds.recordcount - 4)/3> --->
				<cfset num = getFlds.recordcount+4+3>
				<th class="drk center middle" rowspan="#num#" style="width:5px;"></th>
				<th class="center middle" style="width:70px;">TOTAL</th>
			</tr>
		
		<cfset cnt = 0><cfset etotal = 0><cfset ctotal = 0><cfset no = 0><cfset grp = 0>
		<cfloop query="getFlds">
			<!--- <cfif cnt mod 3 is 2> --->
			<cfif right(column_name,6) is "_UNITS">
			<!--- <cfif find("CONTINGENCY",column_name,"1") gt 0><cfbreak></cfif> --->
			
			<cfset fld = replace(column_name,"_UNITS","","ALL")>
			<cfset u = ""><cfset q = 0><cfset p = 0><cfset c = 0>
			<cfif getEst.recordcount gt 0>
				<cfset u=evaluate("getEst.#fld#_UNITS")>
				<cfset q=evaluate("getEst.#fld#_QUANTITY")>
				<cfset p=evaluate("getEst.#fld#_UNIT_PRICE")>
				<cfif q is ""><cfset q = 0></cfif>
				<cfif p is ""><cfset p = 0></cfif>
			<cfelse>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				<cfset u=evaluate("getDefault.UNITS")>
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>
			</cfif>
			<cfif getQCs.recordcount gt 0>
				<cfset c=evaluate("getQCs.#fld#_QUANTITY")>
				<cfif c is ""><cfset c = 0></cfif>
			</cfif>
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
				<th class="drk center middle"></th>
				<th class="drk center middle"></th>
				</tr>
			</cfif>

			<tr>
				<cfset no = no+1>
				<cfif left(fld,5) is "EXTRA">
				<th class="center middle" style="height:30px;width:25px;">#no#</th>
				<cfelse>
				<th class="center middle" style="height:30px;width:25px;">#sort_order#</th>
				</cfif>
				
				<cfif find("EXTRA_FIELD",column_name,"1") gt 0>
				
					<cfset n=evaluate("getEst.#fld#_NAME")>
					<th class="left middle" style="height:30px;width:320px;">
						<table cellpadding="0" cellspacing="0" border="0"><tr>
						<th class="left middle" style="padding:0px;width:65px;">#v#:</th>
						<th class="left middle">
						<input type="Text" name="ass_#fld#_name" id="ass_#fld#_name" value="#n#" 
						style="position:relative;top:0px;width:220px;height:22px;padding: 2px 5px 2px 5px;font-size:10px;" class="roundedsmall" maxlength="100" tabindex="#tab1#">
						</th>
						<cfset tab1 = tab1+1>
						</tr></table>
					</th>
					
				<cfelse>
					<th class="left middle" style="height:30px;width:320px;">#v#:</th>
				</cfif>

				<td class="frm left middle"><input type="Text" name="ass_#fld#_units" id="ass_#fld#_units" value="#u#" 
				style="width:35px;text-align:center;" class="center rounded" tabindex="#tab3#"></td>
				<cfset tab3 = tab3+1>
				<td class="frm left middle"><input type="Text" name="ass_#fld#_quantity" id="ass_#fld#_quantity" value="#q#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab4#" onkeyup="addTotal('#fld#');"></td>
				<cfset tab4 = tab4+1>
				
				<cfset out=""><cfif session.user_level lt 3><cfset out = "disabled"></cfif>
				<td class="frm left middle"><input type="Text" name="ass_q_#fld#_quantity" id="ass_q_#fld#_quantity" value="#c#" 
				style="width:67px;text-align:center;" class="center rounded" tabindex="#tab5#" onkeyup="addTotal('#fld#');" #out#></td>
				<cfset tab5 = tab5+1>
				<td class="frm center middle"><span id="ass_#fld#_total">#trim(numberformat(c+q,"999,999"))#</span></td>
			</tr>
			</cfif>
			<cfset cnt = cnt + 1>
		</cfloop>
		
		<tr>
		<th class="drk left middle" colspan="9" style="height:30px;padding:0px 0px 0px 0px;">
		
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:70px;"></th>
					<td class="left middle pagetitle" style="width:40px;padding:1px 3px 0px 0px;">
					</td>
					
					
					<td align="right" style="width:424px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm5();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm();return false;">Cancel</a>
					</td>
					
					</tr>
				</table>
		</td>
		</tr>
			
			
			
		</table>
	</td>
	</tr>
	
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
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
	
<div id="msg2" class="box" style="top:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text2" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<div id="button2a" style="display:block;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Close</a>
				</div>
				<div id="button2b" style="display:none;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="continueUpdate(0);return false;">Continue...</a>&nbsp;&nbsp;
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Cancel</a>
				</div>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>


<div id="msg3" class="box_bottom" style="bottom:40px;left:1px;width:480px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg3').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text3" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<div id="button3a" style="display:block;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg3').hide();return false;">Close</a>
				</div>
				<div id="button3b" style="display:none;">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="continueUpdate(1);return false;">Continue...</a>&nbsp;&nbsp;
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg3').hide();return false;">Cancel</a>
				</div>
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

function addTotal(fld) {

	var qc = $('#ass_q_' + fld + '_quantity').val();
	var as = $('#ass_' + fld + '_quantity').val();
	if (isNaN(qc) || trim(qc) == '' ) { qc = 0; }
	if (isNaN(as) || trim(as) == '' ) { as = 0; }
	$('#ass_' + fld + '_total').html(parseInt(qc)+parseInt(as));

}



function submitForm5() {

	<cfoutput>
	<cfloop query="getFlds">
		<cfif right(column_name,6) is "_UNITS">
		<cfset fld = replace(column_name,"_UNITS","","ALL")>
		var fld = '#fld#';
		var qc = $('#chr(35)#ass_q_' + fld + '_quantity').val();
		var as = $('#chr(35)#ass_' + fld + '_quantity').val();
		if (isNaN(qc) || trim(qc) == '' ) { $('#chr(35)#ass_q_' + fld + '_quantity').val(0); }
		if (isNaN(as) || trim(as) == '' ) { $('#chr(35)#ass_' + fld + '_quantity').val(0); }
		</cfif>
	</cfloop>
	</cfoutput>
	
	var frm = $('#form5').serializeArray();
	frm.push({"name" : "comments", "value" : trim($('#comments').val()) });
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateAssessment&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);

		/* if(data.RESULT != "Success") {
			showMsg4(data.RESULT,1);
			return false;	
		}
		
		$('#box_curb').hide();
		$('#msg4').hide();
		
		assSub = true;
				
		showMsg("ADA Curb Ramps updated successfully!",1,"ADA Curb Ramps"); */
		
	  }
	});
	
}



function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
</script>

</html>


            

				

	


