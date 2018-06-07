<cfparam name="request.srrKey" default="ZqO6JGM8H2A7Bb1vo9g2J8ZhWY0mfgbfd79QZMYICKfe9Q7i1R">
<cfinclude template="validate_srrKey.cfm">

<cfquery name="printPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT
srr_info.srr_id
, srr_info.sr_number
, srr_info.app_name_nn
, srr_info.app_address1_nn
, srr_info.app_address2_nn
, srr_info.app_city_nn
, srr_info.app_state_nn
, srr_info.app_zip_nn, 
srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.job_address

, srr_info.mailing_address1
, srr_info.mailing_address2
, srr_info.mailing_zip
, srr_info.mailing_city
, srr_info.mailing_state

, Tree_removal_permit.ddate_submitted AS tr_submit_ddate
, Tree_removal_permit.bss_issued_by as tr_issue_by
, Tree_removal_permit.bss_ddate_issued as tr_issue_ddate
, tree_info.nbr_trees_pruned
, tree_info.lf_trees_pruned
, tree_info.nbr_trees_removed
, staff.first_name
, staff.last_name

FROM  dbo.staff RIGHT OUTER JOIN
               dbo.Tree_removal_permit ON dbo.staff.user_id = dbo.Tree_removal_permit.bss_issued_by RIGHT OUTER JOIN
               dbo.srr_info LEFT OUTER JOIN
               dbo.tree_info ON dbo.srr_info.srr_id = dbo.tree_info.srr_id ON dbo.Tree_removal_permit.srr_id = dbo.srr_info.srr_id

where srr_info.srr_id = #request.srr_id#
</cfquery>

<cfdocument  format="PDF" pagetype="letter" margintop="0.2" marginbottom=".5" marginright=".3" marginleft=".3" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes">
<style type="text/css">
* {

		margin:0px;
		padding:0px;
		font-family: arial, verdana, sans-serif;
		font-size:  14px;

}


.pdf_table {
font-family: arial, verdana, sans-serif;
width:100%;
border-collapse:collapse;
border-spacing: 0px; 

/*   vertical-align: top;   */
/*   padding: 0px;   */
/*   text-align:left;  */
/*   border-width:0px;  */
}

.pdf_table th {
vertical-align: top; 
border:1px solid #000;
color:#000;
padding:0px 2px;

/*   border-collapse:collapse;  */
/*   margin:0px;  */
/*   border-width:0px;  */
}

.pdf_table td{
/*   border-collapse:collapse;  */
color:#000;
vertical-align: top; 
border:1px solid #000;
padding:0px 2px;
/*   margin:0px;  */
/*   border-width:1px;  */
/*   border-spacing:0px;  */
}

.data {
color:maroon;
font-weight:bold;
}

</style>


<cfoutput query="printPermit">




<body>

<div align="center">
<table style="width: 650px;" border="0" align="center">
<TR>
<TD>


<table width="100%" border="0" align="center">
<TR>
<TD style="vertical-align:top;text-align:center;"><img src="../images/BSS_logo.jpg" alt="" width="108" height="85" border="0">
</TD>

<TD style="vertical-align:top;text-align:center;">
APPLICATION FOR A<BR>
TREE REMOVAL PERMIT<BR>
CITY OF LOS ANGELES<BR>
DEPARTMENT OF PUBLIC WORKS<BR>
</TD>

<TD  style="vertical-align:top;text-align:center;">BUREAU OF STREET SERVICES<BR>
URBAN FORESTRY DIVISION<BR>
1149 S BROADWAY, SUITE 400<br>
LOS ANGELES, CA  90015<BR>
TEL : 213.847.3077<BR>
</TD>

</TR>




</TABLE>
</td>
</tr>

<tr><td style = "padding:15px;"><div align="center"><span class="data">TREE REMOVAL PERMIT</span></div><br></td></tr>


<tr>
<td>
<table  border="0" >
<TR>
<TD>

Service Request Number: <span class="data">#printPermit.sr_number# (Sidewalk Rebate Request)</span>

</TD>
</TR>




</TABLE>


</td>
</tr>

<tr>
<td nowrap>
<table border="0" >
<TR>
<TD nowrap> 

Property Address:&nbsp;&nbsp;<span class="data">#printPermit.job_address#</span>

</TD>


</TR>



<TR>
<TD nowrap > Property Owner's Name: <span class="data">#printPermit.app_name_nn#</span></td>

</TD>


</TR>






<TR>
<TD nowrap colspan="2"> Property Owner's Contact Information :&nbsp;&nbsp; <span class="data">#printPermit.app_phone_nn#</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="data">#printPermit.app_email_nn#</span></td>

<TR>
<TD nowrap > Total Number of tree(s):&nbsp;&nbsp;<span class="data">#printPermit.nbr_trees_removed#</span> &nbsp;&nbsp;&nbsp;&nbsp;Reason for tree removal: &nbsp;&nbsp; <span class="data">Repair/Replace Sidewalk</span></td>




</TR>





</TABLE>
</td>
</tr>

<tr>
<td>

<table  border="0" >
<TR>
<TD > Property Owner's Representative/Agent:&nbsp;&nbsp; <span class="data">Not Applicable</span></td>
</tr>

<tr>
<td >&nbsp;
</td>
</tr>


<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Company Name: </td>
</tr>

<tr>
<TD nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Property Address :&nbsp;&nbsp;</td>



</tr>


<TR>
<TD nowrap colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contact Information :</font>    
</TD>




</table>

</tr>
</td>


<tr>
<td>

<table  border="0" >
<TR>
<TD >If the tree removal is approved and any fees due have been paid, the permit should be made out to:  </td>
</tr>

<tr>
<td >&nbsp;
</td>
</tr>



<TR>
<TD >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name:  <span class="data">#printPermit.app_name_nn#</span>
</TD>

<tr>
<TD >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email or Mailing Address: <span class="data">#printPermit.app_email_nn#</span>   
</TD>
</tr>

</table>
</td>
</tr>






<TR>
<TD>
<table  border="0" >
<TR>
<TD nowrap valign="top"><input type="checkbox" name="standard_app_street_trees" value="1" checked style="font-weight:bold;color:black;"></td>
<td><strong> This is a standard application for street trees. </strong> Please complete the attached check list.</td>
</tr>

<TR>
<TD nowrap valign="top"><input type="checkbox" name="standard_app_protected_trees" value="1" ></td>
<td valign="baseline"><strong> This is a standard application for protect trees.</strong>  Please complete the attached check list. If mailing PTR documents, you <strong>MUST</strong> include a self-addressed stamped envelope for returns.</td>
</tr>


<TR>
<TD nowrap valign="top"><input type="checkbox" name="subdivision_landdevelopment_case" value="1" ></td>
<td  valign="top"> <strong>This application pertains to Subdivision/Land Development case.</strong>  Please complete the checklist an attach the following:
&nbsp;&nbsp;&nbsp;&nbsp;
<ol>
<li>  B-permit  number, plot plans, conditions of approval and final version of CEQA Documents.  All documents MUST be attached to this application.  If mailing documents <strong>MUST</strong> include a self-addressed stamped envelope for returns.</li>

<li>  Project title and case number: &nbsp;&nbsp;<span class="data">Sidewalk Repair Rebate Program</span></li>
</ol></td>
</tr>


</table>


</TD>
</TR>

<tr>
<Td>&nbsp;</TD></tr>

<TR>
<TD>
<table border="0" align="center">
<TR>
<TD colspan="3">I am submitting this application along with attached checklist (as indicated above) and required documents to the above address.  I understand that submittal of this application does not guarantee an approval for a tree removal permit.  
If the tree removal permit is granted, I understand I will be required to replace the removed tree(s) at a ratio provided by the Urban Forestry Division  and pay any outstanding planting, removal and or permit fees.</td>

<tr>
<Td>&nbsp;</TD></tr>




<tr><td colspan="3">&nbsp;</td></tr>
<tr>
<td align="left" >Date Issued:<br>
<span class="data">#DateFormat(printPermit.tr_issue_ddate,"mm/dd/yyyy")#</span>

</td>


<td style="text-align:center;">&nbsp;&nbsp;Signed Electronically by<Br>
<span class="data">Property Owner/Representative</span>
</TD>

<td style="text-align:center;">
Issued Electronically by:<br>
&nbsp;&nbsp;<span class="data">#printPermit.first_name# #printPermit.last_name#</span><Br>

</TD>
</tr>
</table>
</TD>
</TR>



</table>






<cfdocumentitem type="footer">
<div align="center"><font face="Arial" size="2">AN EQUAL EMPLOYMENT OPPORTUNITY EMPLOYER</font></div>
</cfdocumentitem>


</body>
</html>
</cfoutput>
</cfdocument>