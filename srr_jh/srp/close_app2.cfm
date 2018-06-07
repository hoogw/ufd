<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfif not isdefined("request.newStatus") or (#request.newStatus# is not "cancel" and #request.newStatus# is not "close")>
<div class="warning">Invalid Request!</div>
<cfabort>
</cfif>

<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, srr_info.job_address
, srr_info.prop_type

FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd

where srrKey = '#request.srrKey#'
</cfquery>


<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

fakeUpdate=1

<cfif #request.close_cancel_comments# is not "">
, close_cancel_comments = isnull(close_cancel_comments, '') + '|#toSqlText(request.close_cancel_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

<cfif #request.newStatus# is "cancel">
, close_cancel_by = #client.staff_user_id#
, close_cancel_dt = #now()#
, srr_status_cd = 'cancelTicket'
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '') + '|BOE/SRP CANCELED application on #dnow# by #client.full_name#.'
<cfelseif  #newStatus.action# is "close">
, close_cancel_by = #client.staff_user_id#
, close_cancel_dt = #now()#
, srr_status_cd = 'closeTicket'
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_open_amt = 0
, record_history = isnull(record_history, '') + '|BOE/SRP CLOSED application on #dnow# by #client.full_name#.'
</cfif>

where srrKey =  '#request.srrKey#'
</cfquery>



<cfif #request.newStatus# is "cancel">
<cfset request.srCode = "CA">
<cfset request.srComment = "Your application for the Sidewalk Rebate Program has been cancelled. If you would like to reapply you may do so at sidewalks.lacity.org. If you have any questions, please contact us at sidewalks@lacity.org">

<Cfelseif #request.newStatus# is "close">
<cfset request.srCode = "CL">
<cfset request.srComment = "Ticket is Closed.">
</cfif>


<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.sr_number#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="SRR@lacity.org" subject="Failed to update MyLA311 Status - Close_app2.cfm">
Update Success = #request.srupdate_success#				
Update Error Messge #request.srupdate_err_message#
</cfmail>
</cfcatch>
</cftry>





<cfoutput>
<div class="warning">Application Updated</div>
</cfoutput>
