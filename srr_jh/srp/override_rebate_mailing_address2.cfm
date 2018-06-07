<cfinclude template="../common/validate_SrrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfif #request.mailing_address1# is "">
<div class = "warning">Mailing Address (line 1) is Required!</div>
<cfabort>
</cfif>

<cfif #request.mailing_city# is "">
<div class = "warning">City is Required!</div>
<cfabort>
</cfif>

<cfif #request.mailing_state# is "">
<div class = "warning">State is Required!</div>
<cfabort>
</cfif>

<cfif #request.mailing_zip# is "">
<div class = "warning">Zip Code is Required!</div>
<cfabort>
</cfif>


<cfquery name="updateAddress" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
SET

      mailing_address1 = '#toSqlText(request.mailing_address1)#'
      , mailing_address2 = '#toSqlText(request.mailing_address2)#'
      , mailing_city = '#toSqlText(request.mailing_city)#'
      , mailing_state = '#toSqlText(request.mailing_state)#'	  
      , mailing_zip = '#toSqlText(request.mailing_zip)#'

	  
, record_history = isnull(record_history, '') + '|Rebate Mailing Address was updated by #client.full_name# on #dnow#.'

where
srrKey = '#request.srrKey#'

</cfquery>
<div class="warning">Mailing Address (for Rebate) was Successfully Updated</div>
