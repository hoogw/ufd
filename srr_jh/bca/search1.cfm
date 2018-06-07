<cfinclude template="header.cfm">
<cfinclude template="navbar1.cfm">

<form action="search2.cfm" method="post" name="form1" id="form1" role="form">
<div class="formbox" style="width:90%;">
<h1>Search</h1>


<table border="1" align="center" class="formtable">
<tr>
	<td style="text-align:center;">
	<input type="text" name="search_value" id="search_value" size="20" placeholder="Search for ..." required="yes">
	</td>
</tr>
</table>

</div>





<div style="text-align:center;">
<input type="submit" name="searchButton" id="searchButton" value="Search">
</div>

</form>

<br><br>
<div class="warning">You may search by typing any part of the applicant name, job address, 311 Service Ticket Number</div>

</body>
</html>
