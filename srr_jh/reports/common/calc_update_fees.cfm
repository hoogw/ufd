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


<cfset request.rate_nbr = #find_permit.rate_nbr#>


<cfquery name="get_rates" datasource="#request.dsn#" dbtype="ODBC">
select * from fee_rates
where rate_nbr = #request.rate_nbr#
</cfquery>


<cfif #find_permit.nbr_of_cards# is "">
<cfset request.nbr_of_cards = 0>
<cfelse>
<cfset request.nbr_of_cards = #find_permit.nbr_of_cards#>
</cfif>

<cfset request.per_card_sub = #request.nbr_of_cards# * #get_rates.per_card_fee#>

<cfset request.subtotal = #get_rates.permit_fee# + #request.per_card_sub#>
<cfset request.sur_2 = #request.subtotal# * (#get_rates.surcharge_1#/100) >
<cfif #request.sur_2# lt 1.00>
<cfset request.sur_2 = 1.00>
</cfif>

<cfset request.sur_7 = #request.subtotal# * (#get_rates.surcharge_2#/100) >
<cfif #request.sur_7# lt 1.00>
<cfset request.sur_7 = 1.00>
</cfif>

<cfset request.total_fees = #request.subtotal# + #request.sur_2# + #request.sur_7#>