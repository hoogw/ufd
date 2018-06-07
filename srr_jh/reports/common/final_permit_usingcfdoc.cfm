<cfinclude template="/common/validate_ref_no.cfm">

<!--- <cfquery name="find_permit" datasource="#request.dsn#" dbtype="ODBC">
select * from permit_info
where ref_no = #request.ref_no#
</cfquery> --->
<!--- Top query Replaced with query below--->
<cfquery name="find_permit" datasource="#request.dsn#" dbtype="ODBC">
SELECT        fee_rates.*, permit_info.*, permit_info.ref_no AS Ref_No
FROM            fee_rates INNER JOIN
                         permit_info ON fee_rates.rate_nbr = permit_info.rate_nbr
WHERE        (permit_info.ref_no = #request.ref_no#)
</cfquery>


<!--- <cfif #find_permit.permit_nbr# is not "">
<cfset request.permit_nbr = "MH"&left(#find_permit.permit_nbr#, 4)>

<cfset temp_permit_nbr= left(#find_permit.permit_nbr#, 7)>
<cfset temp_permit_nbr= right(#find_permit.permit_nbr#, 3)>

<cfset request.permit_nbr = #request.permit_nbr#&"-"&#temp_permit_nbr#>


<cfset temp_permit_nbr= right(#find_permit.permit_nbr#, 3)>
<cfset request.permit_nbr = #request.permit_nbr#&"-"&#temp_permit_nbr#>

</cfif> --->


<cfset request.cust_id = #find_permit.cust_id#>
<cfset request.rate_nbr = #find_permit.rate_nbr#>


<cfquery name="get_rates" datasource="#request.dsn#" dbtype="ODBC">
select * from fee_rates
where rate_nbr = #request.rate_nbr#
</cfquery>

<cfquery name="get_cust" datasource="#request.dsn#" dbtype="ODBC">
select * from customers
where cust_id = #request.cust_id#
</cfquery>


<cfif #find_permit.nbr_of_cards# is "">
<cfset request.nbr_of_cards = 0>
<cfelse>
<cfset request.nbr_of_cards = #find_permit.nbr_of_cards#>
</cfif>

<cfset request.per_card_sub = #request.nbr_of_cards# * #get_rates.per_card_fee#>


<!--- <cfif #find_permit.nbr_of_50cards# is "">
<cfset request.nbr_of_50cards = 0>
<cfelse>
<cfset request.nbr_of_50cards = #find_permit.nbr_of_50cards#>
</cfif>


<cfset request.cards50_sub = #request.nbr_of_50cards# * #get_rates.per_50cards_fee#> --->





<cfsavecontent variable="mh_permit">
<cfoutput>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<style type="text/css">

/* 
body {
font-family: arial, verdana, sans-serif;
font-size:  12px;
}

table {
font-family: arial, verdana, sans-serif;
font-size:  12px;
}

*/
td {
font-family: arial, verdana, sans-serif;
font-size:  12px;
}

</style>
<!--- <LINK HREF="/styles/eng.css" REL="stylesheet" TYPE="text/css" SRC="/styles/eng.css"> --->

<title>::: Maintenance Hole Cover Opening Permit :::</title>
</head>

<body>

<cfif #find_permit.app_status# is not "issued">
<div align="center"><font size="+1" color="##FF0000">THIS IS NOT A VALID PERMIT</font></div>
</cfif>

<cfif #find_permit.permit_nbr# is not "">
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
<tr>
<td>
<font size="+1"><b>Permit Number: &nbsp;MH#find_permit.permit_nbr#</b></font>
</td>
<td align="right">
<font size="+1"><b>Number of Cards: &nbsp;#find_permit.nbr_of_cards#</b></font>
</td>
</tr>
</table>
</cfif>



<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td>
<div align="center">
<img src="../images/CitySeal_100.png" alt="" width="100" height="99" border="0">
<br>
City of Los Angeles<br>
<b>DEPARTMENT OF PUBLIC WORKS</b><br>
Bureau of Engineering
</div>



</td>

</tr>
<tr>
<td>
<br>
<div align="center" style="font-size:14px;">
<b>PERMIT TO OPEN MAINTENANCE HOLE COVER<br>
UNDER CHAPTER 6, LOS ANGELES MUNICIPAL CODE - SECTION 62.40</b>
</div>
<br><br>
</td>
</tr>
<tr>
<td>
The undersigned agrees to observe all requirements of the
Municipal Code of the City of Los Angeles.<br>
<br>
<!--- Signed
________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date&nbsp; ____________________________ --->
Signed
________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date Application Received &nbsp; #dateformat(find_permit.ddate_submitted,"mm/dd/yyyy")# #timeformat(find_permit.ddate_submitted,"h:mm tt")#
<br><br>
</td>
</tr>
</table>


<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="100%">APPLICANT/PERMITTEE &nbsp;&nbsp; #get_cust.company_name#</td>
</tr>
<tr>
<td width="100%">CONTACT PERSON &nbsp;&nbsp; #get_cust.contact_person#</td>
</tr>




<tr>
<td width="100%">ADDRESS &nbsp;&nbsp; #get_cust.cust_address# #get_cust.cust_address2#</td>
</tr>



<tr>
<td width="100%">


<table border="0" width="100%">
<tr>
<td width="33%">CITY &nbsp;&nbsp; #get_cust.cust_city#</td>
<td width="33%">ZIP CODE #get_cust.cust_zip#</td>
<td width="34%">TELEPHONE #get_cust.cust_phone#</td>
</tr>

</table>



</td>

</tr>


<tr>
<td width="100%">OWNER OF MH FACILITY &nbsp;&nbsp; #find_permit.mh_owner#</td>
</tr>


<tr>
<td width="100%">Requests permission to open Sewer, Storm Drain Manholes,
and the Manholes under the control of the above name.</td>
</tr>
<tr>
<td width="100%">

<br>


<cfset curr_yr = year(#now()#)>



<table border="0" width="100%">
<tr>
<td align="center">This permit is valid for the period of ONE YEAR from <b>JANUARY 1, #find_permit.permit_yr# to DECEMBER 31, #find_permit.permit_yr#.</b>
<p>MAINTENANCE HOLE LOCATION:&nbsp; CITYWIDE</td>

</tr>
</table>

<br>
<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="64%">



<table border="0" width="100%">
<tr>
<td width="100%">
<div align="center"><b>WARNING</b></div>

<p style="text-align: justify;">No person shall open or remove the cover of any maintenance hole, or allow any maintenance hole to remain open in or upon any street or
sidewalk without setting barriers in accordance with the latest edition of the Work Area Traffic Control Handbook.&nbsp; Guards or Warning
devices shall be maintained at all times while the maintenance hole remains open.  &nbsp;Pursuant to the Mayor's Executive Directive No. 2 - Rush Hour Construction on City Streets,&nbsp;No traffic lane shall be obstructed between the hours of 6:00 a.m. and 9:00 a.m. or 3:30 p.m. and 7:00 p.m. without special written permission.  &nbsp;Only one traffic lane may be obstructed at other times.  &nbsp;This permit is not valid for work in all streets affected by "Holiday Season Construction Moratorium" between November 15 and the following January 2 of each year.
</p>

<div align="center"><b>DISCLAIMER ON MAINTENANCE HOLE (MH) OPENING PERMIT CARD</b></div>


<p style="text-align: justify;">
This grants permission for opening of City of Los Angeles sanitary sewer and storm drain maintenance holes only. &nbsp;Opening of maintenance holes owned by any other agency requires permission from that agency.  &nbsp; This does not allow applicant to enter said maintenance hole(s). &nbsp;Physical entry into maintenance holes requires permission from the City of Los Angeles, Department of Public Works, Bureau of Sanitation, Wastewater Collection Systems Division at (323) 342-6006.  &nbsp;Please be advised that personnel entering maintenance holes should be properly trained and equipped for confined space entry per Cal/OSHA Title 8, Section 5157.
</p>

<div align="center"><b>CERTIFICATION MUST BE ON JOBSITE AT ALL TIMES!</b></div>

<p style="text-align: justify;">
FOR MORE INFORMATION REGARDING THIS PERMIT CONTACT: DEPARTMENT OF PUBLIC WORKS, BUREAU OF ENGINEERING, CENTRAL DISTRICT OFFICE, 201 N. FIGUEROA STREET, 3RD FLOOR, (213) 482-7030.
</p>
</td>
</tr>

<tr>
<td width="100%" valign="bottom">
<br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="50%"><b>EXPIRES</b>  <b>#dateformat(find_permit.ddate_expires,"mm/dd/yyyy")#</b><br><br>
</td>
<td width="50%"><b>DATE ISSUED</b>  <b>#dateformat(find_permit.ddate_issued,"mm/dd/yyyy")#</b><br><br>
</td>
</tr>
</table>



</td>
</tr>
</table>
<!---  + #request.cards50_sub# --->


<cfset request.subtotal = #get_rates.permit_fee# + #request.per_card_sub#>
<cfset request.sur_2 = #request.subtotal# * (#get_rates.surcharge_1#/100)
<cfif #request.sur_2# lt 1.00>
<cfset request.sur_2 = 1.00>
</cfif>

<cfset request.sur_7 = #request.subtotal# * (#get_rates.surcharge_2#/100)>
<cfif #request.sur_7# lt 1.00>
<cfset request.sur_7 = 1.00>
</cfif>

<cfset request.total_fees = #request.subtotal# + #request.sur_2# + #request.sur_7#>

</td>
<td width="36%" valign="top">
<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">

<tr>
<td width="65%">PERMIT FEE</td>
<td width="35%" align="right">#dollarformat(get_rates.permit_fee)#</td>
</tr>
<tr>
<td width="65%">#find_permit.nbr_of_cards#  CARDS @ #dollarformat(get_rates.per_card_fee)# EACH</td>
<td width="35%" align="right">#dollarformat(request.per_card_sub)#</td>
</tr>



<!--- <tr>
<td width="65%">#find_permit.nbr_of_50cards#  X 50-CARDS @ #dollarformat(get_rates.per_50cards_fee)# EACH</td>
<td width="35%" align="right">#dollarformat(request.cards50_sub)#</td>
</tr> --->


<tr>
<td width="65%">#numberformat(get_rates.surcharge_1)#% Surcharge</td>
<td width="35%" align="right">#dollarformat(request.sur_2)#</td>
</tr>


<tr>
<td width="65%">#numberformat(get_rates.surcharge_2)#% Surcharge</td>
<td width="35%" align="right">#dollarformat(request.sur_7)#</td>
</tr>


<tr>
<td width="65%">&nbsp;</td>
<td width="35%" align="right">&nbsp;</td>
</tr>


<tr>
<td width="65%"><b>TOTAL</b></td>
<td width="35%" align="right">#dollarformat(request.total_fees)#</td>
</tr>
<tr>
<td  colspan="2">
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
BY<br>
<cfif #find_permit.app_status# is "issued">
<img src="#request.permit_server#/mhpermits/images/sig.jpg" alt="" width="200" height="80" border="0">
</cfif>
<br>
Shahin Behdin, P.E., District Engineer<br><br>
Central District<br>
BUREAU OF ENGINEERING</td>
</tr>
</table>
</td>
</tr>
</table>

</table>

<!--- #Ucase(find_permit.issued_by)# --->

</body>

</html>
</cfoutput>
</cfsavecontent>














<cfdocument  format="PDF" pagetype="letter" margintop=".5" marginbottom=".5" marginright=".2" marginleft=".2" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes">
<cfoutput>
#mh_permit#
</cfoutput>
</cfdocument>