
<CFQUERY NAME="LIST_USERS" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT *
FROM staff order by first_name, last_name
</CFQUERY>



<div class="title" align="center">Authorized Users</div>
<div align="center">(Sorted by first name then last name)</div>
<div align="center">Click on User ID to Revise User Information</div>
<br>

<!--- padding-bottom:10px; font-size:105%; --->
<!---<a href="add_boe_user1.cfm?#request.addtoken#">Add User</a>--->
<cfoutput>
<div align="center">
<div align="right" style="width:90%; ">
<input type="button" name="add_user" id="add_user" value="Add User" class="submit" onClick="location.href = 'control.cfm?action=add_user1&#request.addtoken#'">
</div>
</div>
</cfoutput>

<div align="center">
<table class="datatable" id="table1" style="width:95%;">
<tr>
<Th>User ID</Th>
<Th>First Name</Th>
<Th>Last Name</Th>
<Th>User Name</Th>
<Th>User Email</Th>
<Th>Agency</Th>
<Th>Administrator</Th>
<Th>Status</Th>
</tr>

<cfset xx=0>

<cfoutput query="list_users">


<cfif (#xx# mod 2) is 0>
<tr class="alt">
<cfelse>
<tr>
</cfif>


<TD>
<a href="control.cfm?action=edit_user1&user_id=#user_id#&#request.addtoken#">#user_id#</a>
</TD>
<TD>
#Ucase(first_name)#
</TD>
<TD>
#Ucase(Last_name)#
</TD>
<TD>
#Lcase(user_name)#
</TD>

<TD>
#Lcase(user_email)#
</TD>

<TD>
#ucase(user_agency)#
</TD>

<td style="text-align:center;">
#YesNoFormat(administrator)#
</td>

<td style="text-align:center;">
<cfif #suspend# is 1>
<strong>Inactive</strong>
<cfelse>
Active
</cfif>
</td>


</tr>

<cfset xx=#xx#+1>
</cfoutput>
</table>
</div>