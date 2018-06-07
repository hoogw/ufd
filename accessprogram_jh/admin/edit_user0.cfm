<cfinclude template="/apermits/common/html_top.cfm">

<CFQUERY NAME="LIST_USERS" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT *
FROM boe_users order by first_name, last_name
</CFQUERY>

<!-- --------------------------------------------------------------------------- -->

<div align="center">
<TABLE WIDTH="90%" BORDER="0" CELLSPACING="0" CELLPADDING="5" ALIGN="center">
<TBODY>
<tr>
<TD>
<div align="center">
<b>
<font class="title">
AUTHORIZED  BOE USERS
</font>
</b>
</div>
</TD>
</tr>
</TBODY>
</table>
</div>


<div align="center">(Sorted by First Name, then by Last Name)</div>

<br>


<div align = "center">
<TABLE WIDTH="95%" BORDER="1" CELLSPACING="0" CELLPADDING="3" ALIGN="center" BORDERCOLORDARK="White">
<tr>
<Th>User ID</Th>
<Th>First Name</Th>
<Th>Last Name</Th>
<Th>Login Name</Th>
<Th>Email</Th>
<Th>District</Th>
<Th>Administrator</Th>
<Th>Account Status</Th>
</tr>

<cfset xx=0>

<cfoutput query="list_users">

<cfif (#xx# mod 2) is 0>
<tr bgcolor="##DFDFDF">
<cfelse>
<tr>
</cfif>

<TD>
<a href="edit_boe_user1.cfm?user_id=#user_id#" target="main">#user_id#</a>&nbsp;
</TD>
<TD>
#Ucase(first_name)#&nbsp;
</TD>
<TD>
#Ucase(last_name)#&nbsp;
</TD>
<TD>
#Lcase(user_name)#&nbsp;
</TD>


<TD>
#Lcase(user_email)#&nbsp;
</TD>

<TD>
<cfif #user_dist# is "C">
Central
<cfelseif #user_dist# is "W">
West LA
<cfelseif #user_dist# is "V">
Valley
<cfelseif #user_dist# is "H">
Harbor
<cfelse>
&nbsp;
</cfif>
</TD>

<TD>
<cfif #administrator# is 0>
NO
<cfelse>
<strong>YES</strong>
</cfif>
</TD>

<TD>
<cfif #suspend# is 0>
Active
<cfelse>
<strong>Not Active</strong>
</cfif>
</TD>

</tr>
<cfset xx=#xx#+1>
</cfoutput>
</table>
</div>

<cfinclude template="/apermits/common/html_bottom.cfm">

