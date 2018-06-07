<HTML>
<!-- Written by: Essam Amarragy *** CITY OF LOS ANGELES *** 213-847-8920 *** eamarrag@eng.lacity.org -->
<HEAD>
<title>::: Maintenance Hole Cover Opening Permit :::</title>
<LINK HREF="/styles/eng.css" REL="stylesheet" TYPE="text/css" SRC="/styles/eng.css">
</HEAD>
<Body>


<cfquery name="find_permit" datasource="#request.dsn#" dbtype="ODBC">
select * from permit_info
where ref_no = #request.ref_no#
</cfquery>


<cfif #find_permit.app_status# is "issued">	
<cflocation addtoken="No" url="../common/final_permit.cfm?ref_no=#request.ref_no#&#request.addtoken#">
<cfabort>
</cfif>


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
<b>APPLICATION / PERMIT<br>
FOR<br>
PERMIT TO OPEN MAINTENANCE HOLE COVER<br></b>
UNDER CHAPTER 6, LOS ANGELES MUNICIPAL CODE - SECTION 62.4
</div>
<br>

<br>
<span style="color: red; font-size: 1.2em;"><div align="center"><b>THIS IS NOT A VALID PERMIT</b></div>
<div align="center"><b>THIS IS A COPY OF YOUR APPLICATION FOR A PERMIT</b></div></span>
<br>

<cfoutput>

<table width="85%" border="1" cellspacing="0" cellpadding="2" align="center">

  <tr>
    <td width="50%">Customer ID</td>
    <td width="50%"><b>#get_cust.cust_id#</b>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%">Applicant/Permittee</td>
    <td width="50%"><b>#get_cust.company_name#</b>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%">Contact Person</td>
    <td width="50%"><b>#get_cust.contact_person#</b>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">Address</td>
    <td width="50%">#get_cust.cust_address#&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">City</td>
    <td width="50%">#get_cust.cust_city#&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">State</td>
    <td width="50%">#get_cust.cust_state#&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">Zip Code</td>
    <td width="50%">#get_cust.cust_zip#&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">Telephone</td>
    <td width="50%">#get_cust.cust_phone#&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">Email</td>
    <td width="50%">#get_cust.cust_email#&nbsp;</td>
  </tr>


  <tr>
    <td width="50%">Owner of Manhole Facility</td>
    <td width="50%">#find_permit.mh_owner#&nbsp;</td>
  </tr>


  <tr>
    <td width="50%" colspan="2" align="center">This permit is valid for the period of ONE YEAR from <b>JANUARY 1, #find_permit.permit_yr# to DECEMBER 31, #find_permit.permit_yr#.</b>
<br>MAINTENANCE HOLE LOCATION:&nbsp; <b>CITYWIDE</b></td>
  </tr>

  <tr>
    <td width="50%">Authorization Letter Required</td>
    <td width="50%"><cfif #find_permit.auth_ltr_req# is "y">Yes<cfelseif #find_permit.auth_ltr_req# is "n">No</cfif>&nbsp;</td>
  </tr>


  <tr>
    <td width="50%">Date Authorization Letter Received</td>
    <td width="50%">#dateformat(find_permit.ddate_auth_ltr_received,"mm/dd/yyyy")#&nbsp;</td>
  </tr>

  <tr>
    <td width="50%">Authorization Letter Uploaded</td>
    <td width="50%"><cfif #find_permit.auth_ltr_uploaded# is "y">Yes<cfelseif #find_permit.auth_ltr_uploaded# is "n">No</cfif>&nbsp;</td>
  </tr>

</table>


<br>

</cfoutput>


<cfoutput>


<div align="center"><hr width="85%" size="2" noshade></div>

<br><br>
<div align="center"><b>Permit Fees:</b></div>
<table width="85%"  border="1" cellspacing="0" cellpadding="2" align="center">
  <tr>
    <td width="25%" height="19"><b>Item</b></td>
    <td width="25%" height="19"><b>Quantity</b></td>
    <td width="25%" height="19"><b>Unit Price</b></td>
    <td width="25%" height="19"><b>Subtotal</b></td>
  </tr>
  <tr>
    <td width="25%" height="14">Permit Fee</td>
    <td width="25%" height="14">1</td>
    <td width="25%" height="14">#dollarformat(get_rates.permit_fee)#</td>
    <td width="25%" height="14">#dollarformat(get_rates.permit_fee)#</td>
  </tr>


  <tr>
    <td width="25%" height="19">No. of Cards</td>
    <td width="25%" height="19">#find_permit.nbr_of_cards#</td>
    <td width="25%" height="19">@ #dollarformat(get_rates.per_card_fee)# per card</td>
    <td width="25%" height="19">#dollarformat(request.per_card_sub)#</td>
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
<cfset request.sur_2 = #request.subtotal# * 0.02>
<cfif #request.sur_2# lt 1.00>
<cfset request.sur_2 = 1.00>
</cfif>

<cfset request.sur_7 = #request.subtotal# * 0.07>
<cfif #request.sur_7# lt 1.00>
<cfset request.sur_7 = 1.00>
</cfif>

<cfset request.total_fees = #request.subtotal# + #request.sur_2# + #request.sur_7#>


  <tr>
    <td width="25%" height="19" colspan="3">2% Surcharge</td>
    <td width="25%" height="19">#dollarformat(request.sur_2)#</td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="3">7% Surcharge</td>
    <td width="25%" height="19">#dollarformat(request.sur_7)#</td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" height="19" colspan="3"><b>Total Fees</b></td>
    <td width="25%" height="19">#dollarformat(request.total_fees)#</td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="4">&nbsp;</td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><b>Payment Received</b></td>
    <td width="25%" height="19"><cfif #find_permit.pmt_received# is "1">Yes</cfif>&nbsp;</td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><b>Received by</b></td>
    <td width="25%" height="19">#find_permit.pmt_received_by#&nbsp;</td>
  </tr>

  <tr>
    <td width="25%" height="19" colspan="3"><b>Date Payment Received</b></td>
    <td width="25%" height="19">#dateformat(find_permit.pmt_received_ddate,"mm/dd/yyyy")#&nbsp;</td>
  </tr>

</table>


</cfoutput>
</BODY>
</HTML>