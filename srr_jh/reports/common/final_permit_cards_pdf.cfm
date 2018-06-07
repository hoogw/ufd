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
<cfmodule template="../../common/error_msg.cfm" error_msg="Please Set the Number of Cards under Review Application<br><br>A minimum of 1 card is required.">
</cfif>



<cfset request.per_card_sub = #request.nbr_of_cards# * #get_rates.per_card_fee#>
<cfset request.per_card_sub = int(#request.per_card_sub# * 100)/100>



<cfoutput>

<cfdocument  format="PDF" pagetype="letter" margintop=".2" marginbottom=".2" marginright=".2" marginleft=".2" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes">


<cfset curr_yr = year(#now()#)>


<cfloop index="cc" from="#request.start#" to="#request.end#" step="1">

<!DOCTYPE html>
<html>
<head>
<title>::: Maintenance Hole Cover Opening Permit :::</title>
<style type="text/css">
* {
font-family: arial, verdana, sans-serif;
font-size:  12px;
}
</style>
</head>
<body>



<cfif #find_permit.app_status# is not "issued">
<div align="center" style="font-size:14px;color:red;font-weight:bold;">THIS IS NOT A VALID PERMIT</div>
</cfif>


<table width="99%" border="0" cellspacing="0" cellpadding="2" align="center">
<tr>
<td>
<cfif #find_permit.permit_nbr# is not "">
Permit Number: &nbsp;MH#find_permit.permit_nbr#
</cfif>
</td>
<td align="right">
<cfif #find_permit.permit_nbr# is not "">
Card No.: #cc# of #find_permit.nbr_of_cards#
</cfif>
</td>
</tr>
</table>


<div style="width:100%;border:1px solid black;" align="center">
<img src="../images/CitySeal_100.png" width="100" height="99" alt="" border="0" />
<br>
<span style="font-size: 14px; line-height: 14px;">City of Los Angeles</span>

<br>

<span style="font-size: 14px; line-height: 14px;"><b>DEPARTMENT OF PUBLIC WORKS</b></span>

<br>

<span style="font-size: 14px;">Bureau of Engineering</span>
<div align="center" style="height:5px;"></div>
</div>



<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center" >
<div align="center" style="height:5px;"></div>
<span style="font-size: 14px;"><b>CERTIFICATION CARD<br>
FOR<br>
PERMIT TO OPEN MAINTENANCE HOLE COVER<br>
UNDER CHAPTER 6, LOS ANGELES MUNICIPAL CODE - SECTION 62.40</b></span>
<div align="center" style="height:5px;"></div>
</div>





<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;">
<div align="center" style="height:5px;"></div>
<span style="font-size: 14px; line-height: 14px;">The undersigned agrees to observe all requirements of the
Municipal Code of the City of Los Angeles.</span>

<br>
<br>
<span style="font-size: 14px; line-height: 14px;">
Signed _____________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date Application Received &nbsp; #dateformat(find_permit.ddate_submitted,"mm/dd/yyyy")# #timeformat(find_permit.ddate_submitted,"h:mm tt")#
</span>
<div align="center" style="height:10px;"></div>
</div>



<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;padding-top:3px;padding-bottom:3px;">
<span style="font-size: 13px;font-weight:bold;">APPLICANT/PERMITTEE:  &nbsp;&nbsp; #Ucase(get_cust.company_name)#</span>
</div>

<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;">
<span style="font-size:13px;font-weight:bold;">CONTACT PERSON: &nbsp;&nbsp; #get_cust.contact_person#</span>
</div>

<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;">
<span style="font-size: 13px;font-weight:bold;">ADDRESS: &nbsp;&nbsp; #Ucase(get_cust.cust_address)# #Ucase(get_cust.cust_address2)#</span>
</div>






<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td style="width:33%"><span style="font-size: 13px;font-weight:bold;">CITY OR TOWN:  &nbsp;&nbsp; #Ucase(get_cust.cust_city)#</span></td>
<td style="width:33%"><span style="font-size: 13px;font-weight:bold;">ZIP CODE: #Ucase(get_cust.cust_zip)#</span></td>
<td style="width:34%"><span style="font-size: 13px;font-weight:bold;">TELEPHONE: #Ucase(get_cust.cust_phone)#</span></td>
</tr>
</table>
</div>



<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center">
<span style="font-size: 13px;font-weight:bold;">OWNER OF MH FACILITY &nbsp;&nbsp; #find_permit.mh_owner#</span></div>


<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center"><span style="font-size: 14px; line-height: 14px;">Requests permission to open Sewer, Storm Drain Manholes,
and the Manholes under the control of the above name.</span></div>





<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center">
<span style="font-size: 14px; line-height: 14px;">This permit is valid for the period of ONE YEAR from &nbsp;&nbsp;<b>JANUARY 1, #find_permit.permit_yr# to DECEMBER 31, #find_permit.permit_yr#.</b>
<br>MAINTENANCE HOLE LOCATION:&nbsp; CITYWIDE</span>
</div>


<cfset request.subtotal = #get_rates.permit_fee# + #request.per_card_sub#>
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

<div style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; border-top:0px solid black;width:100%;" align="center">

<table width="100%" border="0" align="center">

<tr>
<td width="65%">
<div align="center"><b><span style="font-size: 14px; line-height: 14px;">WARNING</span></b></div>

<span style="font-size: 13px;">
<br>
No person shall open or remove the cover of any maintenance hole, or allow any maintenance hole to remain open in or upon any street or sidewalk without setting barriers in accordance with the latest edition of the Work Area Traffic Control Handbook.&nbsp; Guards or Warning devices shall be maintained at all times while the maintenance hole remains open. &nbsp;Pursuant to the Mayor's Executive Directive No. 2 - Rush Hour Construction on City Streets, &nbsp;No traffic lane shall be obstructed between the hours of 6:00 a.m. and 9:00 a.m. or 3:30 p.m. and 7:00 p.m. without special written permission.  &nbsp;Only one traffic lane may be obstructed at other times.  &nbsp;This permit is not valid for work in all streets affected by &quot;Holiday Season Construction Moratorium&quot; between November 15 and the following January 2 of each year.
<br><br>
</span>


<div align="center"><span style="font-size: 14px;"><b>DISCLAIMER ON MAINTENANCE HOLE (MH) OPENING PERMIT CARD</b></span></div>




<span style="font-size: 13px;"><br>This grants permission for opening of City of Los Angeles sanitary sewer and storm drain maintenance holes only. Opening of maintenance holes owned by any other agency requires permission from that agency.  &nbsp; This does not allow applicant to enter said maintenance hole(s). &nbsp;Physical entry into maintenance holes requires permission from the City of Los Angeles, Department of Public Works, Bureau of Sanitation, Wastewater Collection Systems Division at (323) 342-6006.  &nbsp;Please be advised that personnel entering maintenance holes should be properly trained and equipped for confined space entry per Cal/OSHA Title 8, Section 5157.</span>


<span style="font-size: 13px;"><br><br>FOR MORE INFORMATION REGARDING THIS PERMIT CONTACT: DEPARTMENT OF PUBLIC WORKS, BUREAU OF ENGINEERING, CENTRAL DISTRICT OFFICE, 201 N. FIGUEROA STREET, 3RD FLOOR, (213) 482-7030.<br><br></span>



<div align="center"><span style="font-size: 14px;"><b>CERTIFICATION MUST BE ON JOBSITE AT ALL TIMES!</b></span></div>

<br>
<div align="center"><span style="font-size: 14px;"><b>EXPIRES  #dateformat(find_permit.ddate_expires,"mm/dd/yyyy")#</b></span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-size: 14px;"><b>DATE ISSUED  #dateformat(find_permit.ddate_issued,"mm/dd/yyyy")#</b></span></div>
</td>


<td width="35%" valign="top">

<table width="100%" cellspacing="0" cellpadding="1" style="border: 1px solid black; border-collapse:collapse;">
<tr>
<td width="65%" style="border-bottom: 1px solid black;border-right: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">PERMIT FEE</span></td>
<td width="36%" align="right" style="border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#dollarformat(get_rates.permit_fee)#</span></td>
</tr>
<tr>
<td width="65%" style="border-right: 1px solid black;border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#find_permit.nbr_of_cards# X CARDS @ #dollarformat(get_rates.per_card_fee)# EACH</span></td>
<td width="35%" align="right" style="border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#dollarformat(request.per_card_sub)#</span></td>
</tr>




<tr>
<td width="65%" style="border-right: 1px solid black;border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#numberformat(get_rates.surcharge_1)#% Surcharge</span></td>
<td width="35%" align="right" style="border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#dollarformat(request.sur_2)#</span></td>
</tr>


<tr>
<td width="65%" style="border-bottom: 1px solid black;border-right: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#numberformat(get_rates.surcharge_2)#% Surcharge</span></td>
<td width="35%" align="right" style="border-bottom: 1px solid black;"><span style="font-size: 14px; line-height: 14px;">#dollarformat(request.sur_7)#</span></td>
</tr>


<tr>
<td width="65%">&nbsp;</td>
<td width="35%" align="right">&nbsp;</td>
</tr>


<tr>
<td width="65%"><span style="font-size: 14px; line-height: 14px;"><b>TOTAL</b></span></td>
<td width="35%" align="right"><span style="font-size: 14px; line-height: 14px;">#dollarformat(request.total_fees)#</span></td>
</tr>


<tr>
<td  colspan="2">
<span style="font-size: 14px; line-height: 14px;"><br><br><br><br><br>

BY<br><!--- #request.permit_server#/mhpermits --->
<cfif #find_permit.app_status# is "issued">
<img src="../images/sig.jpg" width="200" height="80" alt="" border="0" />
</cfif>
<br>
Shahin Behdin, P.E., District Engineer<br><br>
Central District
<!--- #Ucase(find_permit.issued_by)# ---><br>
BUREAU OF ENGINEERING</span></td>
</tr>
</table>


</td>
</tr>
</table>

</div>















<cfdocumentitem type="footer"> 
<div align="right" style="font-family:Arial; font-size: 12pt;">Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount# </div>
</cfdocumentitem>





</body>
</html>
<cfif #cc# lt #request.end#>
<cfdocumentitem type="pagebreak"></cfdocumentitem>
</cfif>

</cfloop>
</cfdocument>
</cfoutput>






