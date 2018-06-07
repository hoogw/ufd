<cfinclude template="/common/validate_referer.cfm">
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

<cfdocument  format="PDF" pagetype="letter" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes">
<HTML>
<!-- Written by: Essam Amarragy *** CITY OF LOS ANGELES *** 213-847-8920 *** eamarrag@eng.lacity.org -->
<HEAD>
<title>::: Maintenance Hole Cover Opening Permit :::</title>
<LINK HREF="/styles/eng.css" REL="stylesheet" TYPE="text/css" SRC="/styles/eng.css">

<!--- <cfif #find_permit.app_status# is not "issued"> --->
<style type="text/css">
  
  body{
    background-image: url(../images/watermark.jpg);
    background-position: bottom left;
    background-repeat: no-repeat;
    height: 11in;
    width: 8.5in;
    padding: .0in;

  }


table
{
border-collapse:collapse;
}

  </style>
<!--- </cfif> --->

</HEAD>
<Body>





<!--- <cfif #find_permit.app_status# is "issued">	
<cflocation addtoken="No" url="../common/final_permit.cfm?ref_no=#request.ref_no#&#request.addtoken#">
<cfabort>
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

<cfset request.cards50_fee = #request.nbr_of_50cards# * #get_rates.per_50cards_fee#> --->

<div align="center">
<span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.1em; line-height: 1.1em;"><b>APPLICATION<br>
FOR<br>
PERMIT TO OPEN MAINTENANCE HOLE COVER<br></b></span>
<span style="font-family: Arial, Helvetica, sans-serif; font-size: 0.85em; line-height: 1.1em;">UNDER CHAPTER 6, LOS ANGELES MUNICIPAL CODE - SECTION 62.4</span>
</div>
<br>
<cfoutput>
<br>
<div align="center"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.4em; line-height: 1.4em;"><b>
APPLICATION / PAYMENT RECEIPT<br />
REFERENCE NUMBER #request.ref_no#
</b></span></div>
<br>



<table width="85%" border="1" cellspacing="0" cellpadding="2"  align="center">

   <tr>
    <td width="50%" ><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Customer ID</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>#get_cust.cust_id#</b></span>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Applicant/Permittee</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>#get_cust.company_name#</b></span>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Contact Person</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>#get_cust.contact_person#</b></span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Address</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_address#</span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">City</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_city#</span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">State</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_state#</span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Zip Code</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_zip#</span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Telephone</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_phone#</span>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Email</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#get_cust.cust_email#</span>&nbsp;</td>
  </tr>


  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Owner of Manhole Facility</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#find_permit.mh_owner#</span>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Authorization Letter Required</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><cfif #find_permit.auth_ltr_req# is "y">Yes<cfelseif #find_permit.auth_ltr_req# is "n">No</cfif>&nbsp;</span></td>
  </tr>


  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Date Authorization Letter Received</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dateformat(find_permit.ddate_auth_ltr_received,"mm/dd/yyyy")#&nbsp;</span></td>
  </tr>

  <tr>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">Authorization Letter Uploaded</span></td>
    <td width="50%"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><cfif #find_permit.auth_ltr_uploaded# is "y">Yes<cfelseif #find_permit.auth_ltr_uploaded# is "n">No</cfif>&nbsp;</span></td>
  </tr>

</table>


<br>

</cfoutput>


<cfoutput>


<div align="center"><hr style="border: medium Black;" width="85%" size="2" noshade="noshade" /></div>

<br><br>
<div align="center"><b><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">PERMIT FEES:</span></b></div>
<table width="85%"  border="1" cellspacing="0" cellpadding="2" align="center">
  <tr>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>ITEM</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>QUANTITY</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>UNIT PRICE</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>SUBTOTAL</b></span></td>
  </tr>
  <tr>
    <td width="25%" height="14"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">PERMIT FEE</span></td>
    <td width="25%" height="14"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">1</span></td>
    <td width="25%" height="14"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(get_rates.permit_fee)#&nbsp;</span></td>
    <td width="25%" height="14"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(get_rates.permit_fee)#&nbsp;</span></td>
  </tr>


  <tr>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">NO. OF CARDS</span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#find_permit.nbr_of_cards#&nbsp;</span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">@ #dollarformat(get_rates.per_card_fee)# per card</span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(request.per_card_sub)#&nbsp;</span></td>
  </tr>


<!---   <tr>
    <td width="25%" height="19">CARDS (per 50 cards)</td>
    <td width="25%" height="19"><input type="text" name="nbr_of_50cards" value="#request.nbr_of_50cards#" size="12"></td>
    <td width="25%" height="19">@ #dollarformat(get_rates.per_50cards_fee)# per 50 cards</td>
    <td width="25%" height="19">#dollarformat(request.cards50_fee)#&nbsp;</td>
  </tr> --->



  <tr>
    <td width="25%" height="19">&nbsp;</td>
    <td width="25%" height="19">&nbsp;</td>
    <td width="25%" height="19">&nbsp;</td>
    <td width="25%" height="19">&nbsp;</td>
  </tr>

<cfset request.subtotal = #get_rates.permit_fee# + #request.per_card_sub#>

<cfset request.subtotal = int(#request.subtotal# * 100)/100>

<cfset request.sur_2 = #request.subtotal# * (#get_rates.surcharge_1#/100)>
<cfif #request.sur_2# lt 1.00>
<cfset request.sur_2 = 1.00>

<cfset request.sur_2 = int(#request.sur_2# * 100)/100>

</cfif>

<cfset request.sur_7 = #request.subtotal# * (#get_rates.surcharge_2#/100)>
<cfif #request.sur_7# lt 1.00>
<cfset request.sur_7 = 1.00>

<cfset request.sur_2 = int(#request.sur_7# * 100)/100>

</cfif>

<cfset request.total_fees = #request.subtotal# + #request.sur_2# + #request.sur_7#>


  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#numberformat(get_rates.surcharge_1)#% Surcharge</span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(request.sur_2)#&nbsp;</span></td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#numberformat(get_rates.surcharge_2)#% Surcharge</span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(request.sur_7)#&nbsp;</span></td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>Total Fees</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dollarformat(request.total_fees)#&nbsp;</span></td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="4">&nbsp;</td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>Payment Received</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><cfif #find_permit.pmt_received# is "1">Yes</cfif>&nbsp;</span></td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>Received by</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#find_permit.pmt_received_by#&nbsp;</span></td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;"><b>Date Payment Received</b></span></td>
    <td width="25%" height="19"><span style="font-family: Arial, Helvetica, sans-serif; font-size: 1.0em; line-height: 1.1em;">#dateformat(find_permit.pmt_received_ddate,"mm/dd/yyyy")#&nbsp;</span></td>
  </tr>

</table>


</cfoutput>
</BODY>
</HTML>

</cfdocument>