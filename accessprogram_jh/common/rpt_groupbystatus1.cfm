
<cfparam name="request.council_dist" default="all">

 
 <cfquery name="StatusCount" datasource="#request.dsn#" >
select count(ar_info.ar_id)as CntNo, ar_status.ar_status_desc,ar_info.ar_status_cd
from ar_info left outer join
		ar_status on ar_info.ar_status_cd= ar_status.ar_status_cd

where ar_info.ar_status_cd=ar_status.ar_status_cd
 <cfif #request.council_dist# is "all">
<!---  do nothing --->
 <cfelse>
	 and ar_info.council_dist =#request.council_dist#
</cfif>

 group by ar_status.ar_status_desc, ar_info.ar_status_cd
</cfquery>

 <cfquery name="TotalCount" datasource="#request.dsn#" >
select count(ar_info.ar_id)as CntNo
from ar_info left outer join
		ar_status on ar_info.ar_status_cd= ar_status.ar_status_cd

where (1=1)
 <cfif #request.council_dist# is "all">
<!---  do nothing --->
 <cfelse>
	 and ar_info.council_dist =#request.council_dist#
</cfif>

</cfquery>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">


<script language="JavaScript" src="common/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">


// This is the main function to check the form entries [start]
function checkForm()
{

// validating not blank
var fld = document.form1.status;
var msg = "Status is Required!";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
//

// validating date
var fld = document.form1.ddate1;
var msg = "Invalid Date!";
if (!isDate(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating date

// validating date
var fld = document.form1.ddate2;
var msg = "Invalid Date!";
if (!isDate(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating date


document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;

}
// This is the main function to check the form entries [end]

</script>

<script>
  $(function() {
    $( "#ddate1" ).datepicker();
  });
  
    $(function() {
	$( "#ddate2" ).datepicker();
  });
 </script>




<style>
/* Preloader Start */
#preloader  {
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background-color: #fefefe;
     z-index: 99;
    height: 100%;
 }

#status  {
     width: 290px;
     height: 176px;
     position: absolute;
     left: 50%;
     top: 50%;
     background-image: url(../../dashboard/images/boe_wait.gif);
     background-repeat: no-repeat;
     background-position: center;
     margin: -100px 0 0 -100px;
 }
/* Preloader End */
</style>

<script type="text/javascript">
jQuery(window).load(function() {
	jQuery("#status").fadeOut();
	jQuery("#preloader").delay(500).fadeOut("fast");
});
</script>

<title>:::Report Count of Sidewalk Submittals:::</title>
<link href="/dashboard/css/boe_main_2015.css" rel="stylesheet" type="text/css" src="/dashboard/css/boe_main_2015.css">
</head>
<body>

<div id="preloader">
  <div id="status">&nbsp;</div>
</div>


<!--- <cfinclude template="navbar.cfm"> --->
<br>



<cfoutput>


<!--- <form name="Form" method="post" action="control.cfm?action=Rpt_Count_Approved_BSS2&#request.addtoken#"> --->
<form name="form1" method="post" action="control.cfm?action=SumRpt_GrpbyCD&council_dist=#request.council_dist#&#request.addtoken#"  id="form1" >
                           <!--- action="rpt_groupbystatustest.cfm?&council_dist=#request.council_dist#" --->
<div class="title">Sidewalk Application Received Summary</div>
<em><div class="size12">Date range of Summary Report (12/06/16 - #dateformat(now(),"mm/dd/yy")#)</div></em>
<br><br>
<div class="formbox" style="width:500px;">
<!--- <h1>&nbsp;</h1> --->

<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<td style="align:center;"> <div align="center">Council District</div></td>
<td><div align="left">
<select name="council_dist" id="council_dist"onchange="this.form.submit()">
<option value="All" <cfif #request.council_dist# is "All">Selected</cfif>>All</option>
	<option value="1" <cfif #request.council_dist# is "1">Selected</cfif>>&nbsp; 1</option>
	<option value="2"<cfif #request.council_dist# is "2">Selected</cfif>>&nbsp; 2</option>
	<option value="3" <cfif #request.council_dist# is "3">Selected</cfif>>&nbsp; 3</option>
	<option value="4" <cfif #request.council_dist# is "4">Selected</cfif>>&nbsp; 4</option>
	<option value="5"<cfif #request.council_dist# is "5">Selected</cfif>>&nbsp; 5</option>
	<option value="6"<cfif #request.council_dist# is "6">Selected</cfif>>&nbsp; 6</option>
	<option value="7"<cfif #request.council_dist# is "7">Selected</cfif>>&nbsp; 7</option>
	<option value="8"<cfif #request.council_dist# is "8">Selected</cfif>>&nbsp; 8</option>
	<option value="9"<cfif #request.council_dist# is "9">Selected</cfif>>&nbsp; 9</option>
	<option value="10"<cfif #request.council_dist# is "10">Selected</cfif>>10</option>
	<option value="11"<cfif #request.council_dist# is "11">Selected</cfif>>11</option>
	<option value="12"<cfif #request.council_dist# is "12">Selected</cfif>>12</option>
	<option value="13"<cfif #request.council_dist# is "13">Selected</cfif>>13</option>
	<option value="14"<cfif #request.council_dist# is "14">Selected</cfif>>14</option>
	<option value="15"<cfif #request.council_dist# is "15">Selected</cfif>>15</option>
	</select>
	<noscript><input type="submit" value="Submit"></noscript></div>
	</td>
</tr>
</table>
</div>	
	</form> 
	
	<br><br>
<div class="formbox" style="width:500px;">
<h1>Summary Report</h1>

<table border="1"  class = "formtable" style = "width: 100%;">
<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Application Status </th>
<th valign="top">Application Count</th>
</tr>

<tr>
<cfloop query="StatusCount">
<tr>
				<td style="align:center;">#StatusCount.ar_status_desc#</td>	
				<td style="align:center;"><div align="center">#StatusCount.CntNo#</div></td>
</tr>
</cfloop>

</td>
</tr>
</cfoutput>

<tr>
<td style="align:center;">** Total Count</td>
	<cfoutput query="totalcount"><td style="align:center;"><div align="center">#totalCount.CntNo#</div></td></cfoutput>
</tr>

</table>
</table>
</div>	



</BODY>
