<CFPARAM NAME="request.login" DEFAULT="0">
<cfparam name="request.date_from" default="12/1/2016">
<cfif #request.date_from# is "">
	<cfset #request.date_from#="2016-12-01">
</cfif>
<cfif #request.date_to# is "">
	<cfset #request.date_to#="#DateFormat(Now(),"yyyy-mm-dd")#">
</cfif>
<div>
<link href="css/navbar.css" rel="stylesheet" type="text/css" src="css/navbar.css">
<cfoutput>
<center>
<div style="width:800px;">
<!--- <div align="center">
<table border="1"  class = "formtable" style = "width: 400px;">
<tr>
<td style="font-size:14px;font-family: arial;text-align: center">
some title intructions entered here
</td>
</table>
</div> --->
</div>
</center>

<ul id="menu" style="padding-top:0px;margin-top:10px;">
	<li onClick=”return true;”><a href="control.cfm?action=dateentry&date_from=#request.date_from#&date_to=#request.date_to#&#request.addtoken#">Home</a></li>

	<li onClick=”return true;”><a href="control.cfm?action=dateentry&navoption=bill&date_from=#request.date_from#&date_to=#request.date_to#&#request.addtoken#">Report</a></li>	

	<li onClick=”return true;”><a href="control.cfm?action=dateentry&navoption=fms&date_from=#request.date_from#&date_to=#request.date_to#&#request.addtoken#"></a></li>	

</ul>

</div>
<!--- <div style="margin-bottom:10px;"></div> --->
</cfoutput>