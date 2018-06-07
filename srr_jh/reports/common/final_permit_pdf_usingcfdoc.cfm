<cfinclude template="/common/validate_ref_no.cfm">

<?xml version=”1.0? encoding=”UTF-8??>
 <!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
 <html xmlns=”http://www.w3.org/1999/xhtml”>

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

<cfif #find_permit.nbr_of_cards# is "0">
<div align="center">
<font face="Arial" size="2" color="#800000"><b>Please Set the Number of Cards under Review Application
<br><br>
A minimum of 1 card is required.</b>
</font>
</div>
<cfabort>
</cfif>



<cfset request.per_card_sub = #request.nbr_of_cards# * #get_rates.per_card_fee#>
<cfset request.per_card_sub = int(#request.per_card_sub# * 100)/100>





<!--- <cfif #find_permit.nbr_of_50cards# is "">
<cfset request.nbr_of_50cards = 0>
<cfelse>
<cfset request.nbr_of_50cards = #find_permit.nbr_of_50cards#>
</cfif>


<cfset request.cards50_sub = #request.nbr_of_50cards# * #get_rates.per_50cards_fee#> --->



<!--- <cfdocument  format="PDF" pagetype="letter" margintop=".1" marginbottom=".1" marginright=".2" marginleft=".2" orientation="portrait" unit="in" encryption="none" fontembed="Yes"> --->


<cfset curr_yr = year(#now()#)>



<cfoutput>



<cfdocument  format="PDF" pagetype="letter" margintop=".3" marginbottom=".3" marginright=".3" marginleft=".3" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes"> 
<!--- Running header ---> 
<!--- <cfdocumentitem type="header"> 
    <font size="-3"><i>Final Permit</i></font> 
</cfdocumentitem>  --->

<cfloop index="cc" from="#request.start#" to="#request.end#" step="1">


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">

<!--- <LINK HREF="/styles/eng.css" REL="stylesheet" TYPE="text/css" SRC="/styles/eng.css"> --->

<title>::: Maintenance Hole Cover Opening Permit :::</title>
<LINK HREF="../styles/eng_new.css" REL="stylesheet" TYPE="text/css" SRC="../styles/eng_new.css">
<!--- <style>
BODY { background: url(../images/watermark.gif); background-repeat: y}
</style> --->

</head>
<body><!---  background="../images/watermark.gif" --->



<cfif #find_permit.app_status# is not "issued">
<div align="center"><font face="Arial" size="+1" color="red">THIS IS NOT A VALID PERMIT</font></div>
</cfif>


<table width="99%" border="0" cellspacing="0" cellpadding="2" align="center">
<tr>
<td>
<cfif #find_permit.permit_nbr# is not "">
<font face="Arial" size="2"><b>Permit Number: &nbsp;MH#find_permit.permit_nbr#</b></font>
</cfif>
</td>
<td align="right">
<cfif #find_permit.permit_nbr# is not "">
<font face="Arial" size="2"><b>Card No.: #cc# of #find_permit.nbr_of_cards#</b></font>
</cfif>
</td>
</tr>
</table>



<table width="99%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td valign="top">
<div align="center">
<img src="../images/CitySeal_100.png" width="100" height="99" alt="" border="0" />


<br>
<span style="font-family: Arial, Helvetica, sans-serif; font-size: 0.95em; line-height: 1.1em;">City of Los Angeles</span><br>
<span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.0em;"><b>DEPARTMENT OF PUBLIC WORKS</b></span><br>
<span style="font-family: Arial, Helvetica, sans-serif; font-size: 0.95em; line-height: 1.1em;">Bureau of Engineering</span>


</div>



</td>
</tr>



<tr>
<td>
<br>
<div align="center">
<font face="Arial" size="2"><b>APPLICATION/PERMIT<br>
FOR<br>
PERMIT TO OPEN MAINTENANCE HOLE COVER<br>
UNDER CHAPTER 6, LOS ANGELES MUNICIPAL CODE - SECTION 62.40</b></FONT>
</div>
<br>
</td>
</tr>

<tr>
<td>
<font face="Arial" size="2">The undersigned agrees to observe all requirements of the
Municipal Code of the City of Los Angeles.<br>
<br>
<!--- Signed
_____________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date&nbsp; _______________________ --->



Signed
_____________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date Application Received &nbsp; #dateformat(find_permit.ddate_submitted,"mm/dd/yyyy")# #timeformat(find_permit.ddate_submitted,"h:mm tt")#
<br><br></font>
</td>
</tr>
</table>


<table width="99%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="100%"><font face="Arial" size="2">APPLICANT/PERMITTEE  &nbsp;&nbsp; #Ucase(get_cust.company_name)#</FONT></td>
</tr>



<tr>
<td width="100%"><font face="Arial" size="2">CONTACT PERSON &nbsp;&nbsp; #get_cust.contact_person#</FONT></td>
</tr>




<tr>
<td width="100%"><font face="Arial" size="2">ADDRESS &nbsp;&nbsp; #Ucase(get_cust.cust_address)# #Ucase(get_cust.cust_address2)#</FONT></td>
</tr>








<tr>
<td width="100%">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="33%"><font face="Arial" size="2">CITY OR TOWN  &nbsp;&nbsp; #Ucase(get_cust.cust_city)#</FONT></td>
<td width="33%"><font face="Arial" size="2">ZIP CODE #Ucase(get_cust.cust_zip)#</FONT></td>
<td width="34%"><font face="Arial" size="2">TELEPHONE #Ucase(get_cust.cust_phone)#</FONT></td>
</tr>
</table>



</td>
</tr>


<tr>
<td width="100%"><font face="Arial" size="2">OWNER OF MH FACILITY &nbsp;&nbsp; #find_permit.mh_owner#</FONT></td>
</tr>


<tr>
<td width="100%" align="center">
<font face="Arial" size="2">Requests permission to open Sewer, Storm Drain Manholes,
and the Manholes under the control of the above name.</FONT>
</td>
</tr>
<tr>
<td width="100%">


<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="center">
<font face="Arial" size="2">This permit is valid for the period of ONE YEAR from &nbsp;&nbsp;<b>JANUARY 1, #find_permit.permit_yr# to DECEMBER 31, #find_permit.permit_yr#.</b>
<br>MAINTENANCE HOLE LOCATION:&nbsp; CITYWIDE</FONT>
</td>
</tr>
</table>


<hr width="100%" size="1" noshade>
<table width="99%" border="0" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="64%" valign="top">

<table border="0" width="100%">
<tr>
<td width="100%" valign="top">
<div align="center"><b><font face="Arial" size="2">WARNING</FONT></b></div>


<font face="Arial" size="1">
<br>
No person shall open or remove the cover of any maintenance hole, or allow any maintenance hole to remain open in or upon any street or sidewalk without setting barriers in accordance with the latest edition of the Work Area Traffic Control Handbook.&nbsp; Guards or Warning devices shall be maintained at all times while the maintenance hole remains open. &nbsp;Pursuant to the Mayor's Executive Directive No. 2 - Rush Hour Construction on City Streets, &nbsp;No traffic lane shall be obstructed between the hours of 6:00 a.m. and 9:00 a.m. or 3:30 p.m. and 7:00 p.m. without special written permission.  &nbsp;Only one traffic lane may be obstructed at other times.  &nbsp;This permit is not valid for work in all streets affected by &quot;Holiday Season Construction Moratorium&quot; between November 15 and the following January 2 of each year.
<br><br>
</font>


<div align="center"><font face="Arial" size="2"><b>DISCLAIMER ON MAINTENANCE HOLE (MH) OPENING PERMIT CARD</b></FONT></div>




<font face="Arial" size="1"><br>This grants permission for opening of City of Los Angeles sanitary sewer and storm drain maintenance holes only. Opening of maintenance holes owned by any other agency requires permission from that agency.  &nbsp; This does not allow applicant to enter said maintenance hole(s). &nbsp;Physical entry into maintenance holes requires permission from the City of Los Angeles, Department of Public Works, Bureau of Sanitation, Wastewater Collection Systems Division at (323) 342-6006.  &nbsp;Please be advised that personnel entering maintenance holes should be properly trained and equipped for confined space entry per Cal/OSHA Title 8, Section 5157.</FONT>


<font face="Arial" size="1"><br><br>FOR MORE INFORMATION REGARDING THIS PERMIT CONTACT: DEPARTMENT OF PUBLIC WORKS, BUREAU OF ENGINEERING, CENTRAL DISTRICT OFFICE, 201 N. FIGUEROA STREET, 3RD FLOOR, (213) 482-7030.<br><br></FONT>



<div align="center"><font face="Arial" size="2"><b>CERTIFICATION MUST BE ON JOBSITE AT ALL TIMES!</b></FONT></div>
</td>
</tr>



<tr>
<td width="100%" valign="bottom">
<!--- <br> --->
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">
<tr>
<td width="50%"><font face="Arial" size="2"><b>EXPIRES  #dateformat(find_permit.ddate_expires,"mm/dd/yyyy")#</b></FONT>
</td>
<td width="50%"><font face="Arial" size="2"><b>DATE ISSUED  #dateformat(find_permit.ddate_issued,"mm/dd/yyyy")#</b></FONT>
</td>
</tr>
</table>



</td>
</tr>
</table>
<!---  + #request.cards50_sub# --->
<cfset request.subtotal = #get_rates.permit_fee# + #request.per_card_sub#>
<cfset request.subtotal = int(#request.subtotal# * 100)/100>


<cfset request.sur_2 = #request.subtotal# * (#get_rates.surcharge_1#/100) >
<cfif #request.sur_2# lt 1.00>
<cfset request.sur_2 = 1.00>
<cfset request.sur_2 = int(#request.sur_2# * 100)/100>

</cfif>

<cfset request.sur_7 = #request.subtotal# * (#get_rates.surcharge_2#/100) >
<cfif #request.sur_7# lt 1.00>
<cfset request.sur_7 = 1.00>
<cfset request.sur_7 = int(#request.sur_7# * 100)/100>
</cfif>

<cfset request.total_fees = #request.subtotal# + #request.sur_2# + #request.sur_7#>

</td>
<td width="35%" valign="top">
<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolor="##000000" bordercolorlight="##FFFFFF">

<tr>
<td width="65%"><font face="Arial" size="2">PERMIT FEE</FONT></td>
<td width="36%" align="right"><font face="Arial" size="2">#dollarformat(get_rates.permit_fee)#</FONT></td>
</tr>
<tr>
<td width="65%"><font face="Arial" size="2">#find_permit.nbr_of_cards# X CARDS @ #dollarformat(get_rates.per_card_fee)# EACH</FONT></td>
<td width="35%" align="right"><font face="Arial" size="2">#dollarformat(request.per_card_sub)#</FONT></td>
</tr>



<!--- 
<tr>
<td width="65%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 0.95em; line-height: 1.1em;">#find_permit.nbr_of_50cards# X  50-CARDS @ #dollarformat(get_rates.per_50cards_fee)# EACH</span></td>
<td width="35%" align="right"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 0.95em; line-height: 1.1em;">#dollarformat(request.cards50_sub)#</span></td>
</tr> 
--->




<tr>
<td width="65%"><font face="Arial" size="2">#numberformat(get_rates.surcharge_1)#% Surcharge</FONT></td>
<td width="35%" align="right"><font face="Arial" size="2">#dollarformat(request.sur_2)#</FONT></td>
</tr>


<tr>
<td width="65%"><font face="Arial" size="2">#numberformat(get_rates.surcharge_2)#% Surcharge</FONT></td>
<td width="35%" align="right"><font face="Arial" size="2">#dollarformat(request.sur_7)#</FONT></td>
</tr>


<tr>
<td width="65%">&nbsp;</td>
<td width="35%" align="right">&nbsp;</td>
</tr>


<tr>
<td width="65%"><font face="Arial" size="2"><b>TOTAL</b></FONT></td>
<td width="35%" align="right"><font face="Arial" size="2">#dollarformat(request.total_fees)#</FONT></td>
</tr>
<tr>
<td  colspan="2">
<font face="Arial" size="2"><br><br><br><br><br>

BY<br>
<img src="../images/sig.jpg" alt="" width="200" height="80" border="0">
<br>
Shahin Behdin, P.E., District Engineer<br><br>
Central District
<!--- #Ucase(find_permit.issued_by)# ---><br>
BUREAU OF ENGINEERING</FONT></td>
</tr>
</table>
</td>
</tr>
</table>

</table>


<!---  <cfdocumentitem type="footer"> 
<div align="right">Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount# </div>
</cfdocumentitem>  --->





</body>
</html>
<cfif #cc# lt #request.end#>
<cfdocumentitem type="pagebreak"></cfdocumentitem>
</cfif>

</cfloop>
</cfdocument>
</cfoutput>






