<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.ar_status_cd" default="">

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="ArInfo" datasource="#request.dsn#" dbtype="datasource">
update
ar_info
set

fakeUpdate = 1
,  ar_status_cd = '#request.ar_status_cd#'
<cfif #request.ar_status_cd# is "BssAssessmentCompleted">
, bss_assessed_dt = #now()#
, bss_assessed_by = #client.staff_user_id#
, record_history = record_history + '|BSS Assessment completed on #dnow# by #client.full_name#'
</cfif>

<cfif #request.ar_status_cd# is "pendingBoeReview">
, bss_assessed_dt = null
, bss_assessed_by = null
, bss_to_srp_dt = #now()#
, bss_to_srp_by = #client.staff_user_id#
, record_history = record_history + '|BSS Forwarded application to Engineering for further investigation on #dnow# by #client.full_name#'
</cfif>


<cfif #trim(request.bss_internal_comments)# is not "">
, bss_internal_comments = ISNULL(bss_internal_comments, '') + '|#request.bss_internal_comments# (Added on #dnow# by #client.full_name#)'
</cfif>
	
where arKey = '#request.arKey#'

</cfquery>


 <cfif #request.ar_status_cd# is "BSSAssessmentCompleted">
<cfmodule template="../modules/insertIntoSRP_module.cfm" sr_no="#request.sr_number#">

<!--- <div align="center">
<cfoutput>#request.srp_insert_success#<br></cfoutput>
<cfoutput>#request.srp_insert_error_message#</cfoutput>
</div> --->



</cfif>


<cfoutput>
<div class="warning">Application was Successfully Updated<!--- <br><br>Data Copied to Sidewalk Program Database ---></div>
</cfoutput>