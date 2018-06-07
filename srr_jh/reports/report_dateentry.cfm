<cfparam name="request.date_from" default="">
<cfparam name="request.date_to" default="">
<cfparam name="request.navoption" default="">
<cfparam name="request.date_from" default="12/1/2016">
<cfif #request.date_from# is "">
	<cfset #request.date_from#="2016-12-01">
</cfif>
<cfif #request.date_to# is "">
	<cfset #request.date_to#="#DateFormat(Now(),"yyyy-mm-dd")#">
</cfif>

<style>
* {
font-size: 14px;
}

.myButton {
  -webkit-border-radius: 50;
  -moz-border-radius: 50;
  border-radius: 50px;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  background: #596b8d;
  padding: 5px 7px 4px 4px;
  border: solid #090a0a 0px;
  text-decoration: none;
  text-align:center;
}
.myButton:link {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:visited {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:hover {
  background: #596a8d;
  background-image: -webkit-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -moz-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -ms-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -o-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: linear-gradient(to bottom, #596a8d, #9cc8e6);
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}

.myButton a:hover {
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}
  
.myButton:active {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}
</style>

<cfmodule template="common/header.cfm" maintitle="Sidewalk Repair Rebate Program">

<div class="title">
Application Processing<br>within a date range
</div>
<cfoutput>

<form action="reports_AppProcDateRange.cfm" method="post" name="reports" id="reports" onSubmit="return checkForm()">

<div class="formbox" style="width:400px;">
<h1>Enter Date Range</h1>
<div class="field">
<label for="date_from">Start Date</label>
<input type="date" name="date_from" value="<cfoutput><cfif #request.date_from# is not"">#request.date_from#</cfif></cfoutput>" placeholder="mm/dd/yyyy">
<label for="date_from">End Date</label>
<input type="date" name="date_to" value="<cfoutput><cfif #request.date_to# is not"">#request.date_to#</cfif></cfoutput>" placeholder="mm/dd/yyyy">
</div>
</div>
<br>


<DIV ALIGN="center"><input type="submit" name="submit_daterange" id="submit_daterange" value="Next"></DIV>

</form>



</cfoutput>

<cfinclude template="common/footer.cfm">