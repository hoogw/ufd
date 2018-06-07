<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="last_rate_nbr" datasource="#request.dsn#" dbtype="datasource">
select max(rate_nbr) as last_rate_nbr
from rebate_rates
</cfquery>

<cfset request.new_rate_nbr = #last_rate_nbr.last_rate_nbr#>
<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="upateRateNbr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
rate_nbr = #request.new_rate_nbr#
, record_history = isnull(record_history, '') + '|Rate was changed to rate number: #request.new_rate_nbr# on #dnow# by #client.full_name#.'
where srrKey = '#request.srrKey#'
</cfquery>


<cfmodule template="../modules/getCurrentSrCode.cfm" srrKey = "#request.srrKey#">

<cfif #request.currentSrCode# is "" or #request.currentSrCode# is "NA" or #request.currentSrCode# is "N/A" or not isnumeric(#request.currentSrCode#)>
<div class="warning">
Something went wrong with overriding this application.
<br><br>
Please report this SR Number to Application Development Team
</div>
<cfabort>
</cfif>


<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "#request.currentSrCode#"><!--- use the current SR resolution code --->
<cfset request.srComment = "Starting on August 1, 2017, the Board of Public Works has approved an increase to the maximum Rebate amount for both residential and commercial properties. The Rebate increase includes raising the maximum Rebate amount to $10,000 and raising the tree remove and replace valuation amount from $500 to $1,000 for both residential and commercial properties. 

If you previously received a Rebate Offer, it has already been updated to reflect the increased Rebate amounts.

To continue monitoring your application, use the following link:
https://engpermits.lacity.org/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<cfif #request.srupdate_success# is "N">
<cfmail to="essam.amarragy@lacity.org" from="srrUpdateError@lacity.org" subject="Error Updating MyLA311 - SR: #request.sr_number#">
Error Calling srr/modules/updateSR_module.cfm
Update Success = #request.srupdate_success#
Update Err Msg = #request.srupdate_err_message#
</cfmail>
</cfif>
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="srrUpdateError@lacity.org" subject="Error Updating MyLA311 - SR: #request.sr_number#">
Error Calling srr/modules/updateSR_module.cfm - see CFcatch portion on override rebate rates 2
</cfmail>
</cfcatch>
</cftry>

	<cfoutput>
	<div class="warning">Latest Rate Number was Applied to this Application</div>
	<br><br>
	<div style="text-align:center;"><strong><a href="control.cfm?action=rebate_estimate&srrKey=#request.srrKey#&#request.addtoken#">View Valuation Estimate</a></strong></div>
	</cfoutput>

	