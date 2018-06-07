<cfinclude template="/common/validate_referer.cfm">
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


<cfif #request.nbr_of_cards# lte 25>
<cflocation addtoken="No" url="final_permit_cards_pdf.cfm?ref_no=#request.ref_no#&start=1&end=#request.nbr_of_cards#">
<cfabort>
</cfif>

<cfset end_loop = int(#request.nbr_of_cards#/25)*25>


<div align="center"><strong>Please Allow 30 to 60 Seconds after Clicking the Print Link</strong></div>
<br><br>

<!-- create links for each 25 cards -->
<cfloop index="i" from="1" to="#end_loop#" step="25">
<cfset L = #i#+24>
<cfoutput>
<!--- First Card: #i#
<br>
Last Card: #L#
<hr> --->
<div align="center"><a href="final_permit_cards_pdf.cfm?ref_no=#request.ref_no#&start=#i#&end=#L#">Print Cards #i# thru #L#</a></div>
<br>
</cfoutput>
</cfloop>



<cfif #request.nbr_of_cards# gt #end_loop#>
<!-- last set after all 25's are done -->
<cfset first_card = #end_loop# +1>
<cfset last_card = #request.nbr_of_cards#>
<cfoutput>
<!--- First Card: #first_card#
<br>
Last Card: #last_card#
<hr> --->
<div align="center"><a href="final_permit_cards_pdf.cfm?ref_no=#request.ref_no#&start=#first_card#&end=#last_card#">Print Cards #first_card# thru #last_card#</a></div>
<!--- <br> --->
</cfoutput>
</cfif>

