<cfparam name="request.date_from" default="">
<cfparam name="request.date_to" default="">
<cfparam name="request.navoption" default="">

<cfmodule template="common/header.cfm" maintitle="Sidewalk Repair Rebate Program">


<cfoutput>

<br>

<form action="control.cfm?action=reports_bydaterange" method="post" name="reports" id="reports" onSubmit="return checkForm()">
<br>

<div class="formbox" style="width:730px;">
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