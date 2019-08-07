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

<!--- Use this convention for date fields for filter and sort to work: replace(convert(NVARCHAR, date_logged, 101), ' ', '/'). Use "dt_" as a prfix for all date fields for sort to work --->
<cfquery name="getARP" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT location_no as site_no,sr_number,address,replace(convert(NVARCHAR, date_logged, 101), ' ', '/') as dt_date_logged, score FROM vwPriorityARP ORDER BY score DESC,date_logged
</cfquery>

<!--- <cfdump var="#getARP#">

<cfabort> --->


	
<body style="overflow:auto;">	

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="10"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;">Access Request Program Priority Scores</td></tr>
		  <tr><td height="5"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:258px;border-width:2px;">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="center middle" style="height:22px;width:40px;">Filter:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:200px;">
						<input type="Text" name="search" id="search" value="" style="width:197px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"
						onkeyup="doFilter('search');">
						<div id="clearSearch" style="position:absolute;top:6px;right:12px;display:none;">
						<a href="" onClick="blankFilter();return false;"><img src="../images/greyer_x.png" height="8" width="8" title="Clear Search" alt="Clear Search" border="0" style="position:relative;top:5px;left:0px;"></a>
						</div>
						
						</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" style="width:700px;" align="center">
	<tr><td class="dd right" style="height:5px;color:#request.color#;"><strong>Record Count: <span id="cnt" style="color:#request.drkcolor#;">#getARP.recordcount#</span></strong></td></tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:700px;">
		
		<tr><td>
		
		<table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
			<tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
				<div id="results">
				<!--- <table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
				<tr>
					<th class="drk center middle" style="width:50px;" onMouseOver="this.style.cursor='pointer';" onClick="setSort(0,4,desc);">Site&nbsp;No.</th>
					<th class="drk center middle" style="width:80px;" onMouseOver="this.style.cursor='pointer';" onClick="setSort(1,4,desc);">SR&nbsp;Number</th>
					<th class="drk left middle" style="height:21px;" onMouseOver="this.style.cursor='pointer';" onClick="setSort(2,4,desc);">Address</th>
					<th class="drk center middle" style="width:80px;" onMouseOver="this.style.cursor='pointer';" onClick="setSort(3,4,desc);">Date&nbsp;Logged</th>
					<th class="drk center middle" style="width:40px;" onMouseOver="this.style.cursor='pointer';" onClick="setSort(4,3,desc);">Score</th>
				</tr>
				<th class="drk left middle" colspan="5" style="height:2px;padding:0px 0px 0px 0px;"></th>
				<cfloop query="getARP">
				<tr>
					<td style="" class="small center frm">#site_no#</td>
					<td style="" class="small center frm">#sr_number#</td>
					<td style="" class="small left frm">#address#</td>
					<td style="" class="small center frm">#dt_date_logged#</td>
					<td style="" class="small center frm">#score#</td>
				</tr>
				</cfloop>
				<tr><th class="drk left middle" colspan="5" style="height:2px;padding:0px 0px 0px 0px;"></th></tr>
				</table> --->
				</div>
			</td></tr>
		</table>
		
		</td></tr>
			
		</table>
	</td>
	</tr>

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
var arr = #SerializeJSON(getARP)#;
</cfoutput>
var recs = arr.DATA;
var flds = arr.COLUMNS; //used to check field name to see if it's a date (prefix "dt_")
$.each(recs, function(i, item) { $.each(item, function(j, n) { if (n == null) { item[j] = ""; } }); }); // replace all null values in records with ""


//Defaults
var sortfld = 4;
var sort2fld = 3;
var desc = true;

/* function removeEl(array, remIdx) {
 return array.map(function(arr) {
         return arr.filter(function(el,idx){return idx !== remIdx});  
        });
};
recs = removeEl(recs,3); */
//console.log(recs);

function setSort(sfld,s2fld,dsc) {  //sfld is sort field, s2fld is secondary sort field, dsc is the default desc value.
	
	if (sfld == sortfld) { desc = !dsc; } else { desc = false; }
	
	sortfld = sfld;
	sort2fld = s2fld;
	
	doFilter('search');
}

function blankFilter() {
	$('#search').val('');
	doFilter('search');
}

function doFilter(ctrl) {

	var str = $('#' + ctrl).val().toString();
	if (str == '') { $('#clearSearch').hide(); } else { $('#clearSearch').show(); }
	var filter = [];

	$.each(recs, function(i, item) {
		var found = $.grep( item, function (n) { if (n != null) { return ( n.toString() && n.toString().toLowerCase().indexOf(str.toLowerCase())!=-1 ); } }) ;
		if (found.length > 0) {
			//console.log(found);
			filter.push(item);
		}
		
	});

	//console.log(filter);
	//var sortfld = 4;
	//var sort2fld = 2;

	var x = filter.sort(function(a, b)
	{
		
		var d = Date.parse(a[sortfld]);
		//console.log(d);

		if (isNaN(a[sortfld]) || isNaN(b[sortfld])) { var x = a[sortfld].toLowerCase(), y = b[sortfld].toLowerCase(); }
		else { var x = a[sortfld], y = b[sortfld]; }
		var isDate = false; if (flds[sortfld].substring(0,3).toLowerCase() == "dt_") { isDate = true; }
		if (isDate) { var x = Date.parse(a[sortfld]), y = Date.parse(b[sortfld]); }
		
	    if(x === y)
	    {
			if (isNaN(a[sort2fld]) || isNaN(b[sort2fld])) { var z = a[sort2fld].toLowerCase(), zz = b[sort2fld].toLowerCase(); }
			else { var z = a[sort2fld], zz = b[sort2fld]; }
			var isDate = false; if (flds[sort2fld].substring(0,3).toLowerCase() == "dt_") { isDate = true; }
			if (isDate) { var z = Date.parse(a[sort2fld]), zz = Date.parse(b[sort2fld]); }
			
			if (desc) { return z > zz ? -1 : z < zz ? 1 : 0; } // Added to undo descending for 2nd sort
			else { return z < zz ? -1 : z > zz ? 1 : 0; }
	    }

	    return x < y ? -1 : x > y ? 1 : 0;
	});
	
	if (desc) { x.reverse(); }
	//console.log(x);
	
	buildResults(x);

}

function buildResults(x) {

	var colspan = 5;
	var items = [];
	
	items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
	items.push("<tr>");
	
	//s: The field names for the table. Right now hard coded. Maybe someday make dynamic
	items.push("<th class='drk center middle' style='width:50px;' onMouseOver=\"this.style.cursor='pointer';\" onClick='setSort(0,4," + desc + ")'>Site&nbsp;No.</th> ");
	items.push("<th class='drk center middle' style='width:80px;' onMouseOver=\"this.style.cursor='pointer';\" onClick='setSort(1,4," + desc + ")'>SR&nbsp;Number</th>");
	items.push("<th class='drk left middle' style='height:21px;' onMouseOver=\"this.style.cursor='pointer';\" onClick='setSort(2,4," + desc + ")'>Address</th>");
	items.push("<th class='drk center middle' style='width:80px;' onMouseOver=\"this.style.cursor='pointer';\" onClick='setSort(3,4," + desc + ")'>Date&nbsp;Logged</th>");
	items.push("<th class='drk center middle' style='width:40px;' onMouseOver=\"this.style.cursor='pointer';\" onClick='setSort(4,3," + desc + ")'>Score</th>");
	//e: The field names for the table. Right now hard coded. Maybe someday make dynamic

	items.push("</tr>");
	items.push("<tr><th class='drk left middle' colspan='" + colspan + "' style='height:2px;padding:0px 0px 0px 0px;'></th></tr>");
	
	if (x.length > 0) {
	
		//s: add each value from array
		$.each(x, function(i, rec) {
			items.push("<tr>");
			items.push("<td class='small center frm'>" + rec[0] + "</td>");
			items.push("<td class='small center frm'>" + rec[1] + "</td>");
			items.push("<td class='small left frm'>" + rec[2] + "</td>");
			items.push("<td class='small center frm'>" + rec[3] + "</td>");
			items.push("<td class='small center frm'>" + rec[4] + "</td>");
			items.push("</tr>");
		});
		//e: add each value from array
	
	}
	else {
		items.push("<td class='small center frm' colspan='" + colspan + "'>No Records Found</td>");
	}

	items.push("<tr><th class='drk left middle' colspan='" + colspan + "' style='height:2px;padding:0px 0px 0px 0px;'></th></tr>");
	items.push("</table>");
	$('#results').html(items.join(''));
	$('#cnt').html(x.length);
	
}

doFilter('search');


</script>

</html>


            

				

	


