<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">


<script language="JavaScript" src="common/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">


// This is the main function to check the form entries [start]
function checkForm()
{

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

<title>:::Report Count of Unprocessed Sidewalk Submittals:::</title>
<link href="/dashboard/css/boe_main_2015.css" rel="stylesheet" type="text/css" src="/dashboard/css/boe_main_2015.css">
</head>
<body>

<div id="preloader">
  <div id="status">&nbsp;</div>
</div>


<!--- <cfinclude template="navbar.cfm"> --->
<br>



<body>

<cfoutput>
<!---
<cfif #request.action# is "Download_ReceivedAR1">
--Form Action and Form goes here. It was removed to not confuse. 
--Look at AccessProgram file "rpt_Count_Sumittals1" 
<cfelseif #request.action# is "DownloadAll1">
 --->

<form action="control.cfm?action=DownloadAll2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">


<div class="title"><!--- Report Count of Unprocessed Sidewalk Submittals --->
				Download Sidewalk Rebate Report by <br>Date Range and Council District
</div>

<div class="formbox" style="width:500px;">
<h1>Enter Date Range:</h1>

<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<td>Start Date (Requried)</td>
<td><input type="text" name="ddate1" id="ddate1" size="15" maxlength="15" value="12/06/2016"><br>
<em><div class="size12">&nbsp;&nbsp;&nbsp;&nbsp;Date of Inception</div></em></td>
</tr>

<tr>
<td>End Date (Requried)</td>
<td><input type="text" name="ddate2" id="ddate2" size="15" maxlength="15" value="#dateformat(now(),'mm/dd/yyyy')#" ><br>
<em><div class="size12">&nbsp;&nbsp;&nbsp;&nbsp;Today's Date</div></em></td>
</tr>

<tr>
<td>Council District</td>
<td>
	<select name="CD" id="CD">
		<option value="All" selected>All</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option>
		<option value="12">12</option>
		<option value="13">13</option>
		<option value="14">14</option>
		<option value="15">15</option>

</select>
 </td>
</tr>
</table>

</div>
<br>
<div align="center">
<input type="submit" value="   NEXT &gt;&gt;  " class = "submit">
</div>
</form>

<!--- </cfif> --->
</cfoutput>






</BODY>
