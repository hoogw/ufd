<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_info.srr_id, srr_info.srrKey, srr_info.sr_number, srr_info.srr_status_cd, srr_status.srr_status_desc, srr_info.job_address, 
               srr_info.prop_type, rebate_rates.res_cap_amt, rebate_rates.comm_cap_amt
			   
			   
FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd

where srrKey = '#request.srrKey#'
</cfquery>

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

fakeUpdate=1

<cfif #request.boe_invest_comments# is not "">
, boe_invest_comments = isnull(boe_invest_comments, '') + '|#toSqlText(request.boe_invest_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

, boe_invest_response_to_app = '#toSqlText(request.boe_invest_response_to_app)#'

, srr_status_cd = '#request.srr_status_cd#'

<cfif #getSRR.prop_type# is "r">
, offer_reserved_amt = #getSRR.res_cap_amt#
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_reserved_amt = #getSRR.res_cap_amt#
</cfif>

, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0


<cfif #request.srr_status_cd# is "received">
, boe_invest_to_bpw_dt = #now()#
, boe_invest_to_bpw_by = #client.staff_user_id#
, record_history = isnull(record_history, '') + '|BOE/SRP returned application to BPW on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'


<cfelseif #request.srr_status_cd# is "PendingBssReview">
, boe_invest_to_bss_dt = #now()#
, boe_invest_to_bss_by = #client.staff_user_id#
, record_history = isnull(record_history, '')  + '|BOE/SRP returned application to BSS/UFD on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

<cfelseif #request.srr_status_cd# is "PendingBcaReview">
, boe_invest_to_bca_dt = #now()#
, boe_invest_to_bca_by = #client.staff_user_id#
, record_history = isnull(record_history, '')  + '|BOE/SRP returned application to BCA on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

<cfelseif #request.srr_status_cd# is "notEligibleTemp">
, boe_invest_notEligible_dt = #now()#
, boe_invest_notEligible_by = #client.staff_user_id#
, record_history = isnull(record_history, '')  + '|BOE/SRP determined that application is not eligible on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
, notEligible_dt = #now()#
, notEligible_exp_dt = dateAdd("d", 14, #now()#)
</cfif>

where srrKey =  '#request.srrKey#'
</cfquery>


<cfif #request.srr_status_cd# is "notEligibleTemp">
<cfset request.notEligible_exp_dt = dateAdd("d", 14, #now()#)>

<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"><!--- code 13 for notEligible --->
<cfset request.srComment = "We regret to inform you that your application has been deemed ineligible for the Sidewalk Rebate Program. The specific reason(s) that the application was ineligible are provided in the following link: 
<br><br>
#request.serverRoot#/srr/public/whyNotEligible.cfm?srrKey=#request.srrKey#
<br><br>
To appeal this decision, use the following link to submit an appeal no later than #dateformat(request.notEligible_exp_dt,'mm/dd/yyyy')#
<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#request.srrKey#
<br><br>
Rebate FAQ:
<br>
http://sidewalks.lacity.org/rebate-program-faqs
<br>
Rebate Program Rules and Regulations:
<br>
http://sidewalks.lacity.org/rebate-program-rules-and-regulations
">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>

</cfif>




<cfif #request.srr_status_cd# is "pendingBssReview"><!--- 1 --->
		<cfquery name="checkChildTicket" datasource="#request.dsn#" dbtype="datasource">
		Select srr_id, tree_insp_sr_number, sr_number
		from srr_info
		where srrKey='#request.srrKey#'
		</cfquery>
	
	<cfif #checkChildTicket.tree_insp_sr_number# is ""><!--- 2 --->
		<cfset request.srNum = "#checkChildTicket.sr_number#">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->		
		<cfmodule template="../modules/insertSRTicket_module.cfm" srNum="#request.srNum#">
	<!--- 	#request.srticket_success#<br>
		#request.srticket_err_message#<br>
		#request.srticket_srnum#<br> --->
		<cfquery name="TreeInspecSrNumber" datasource="#request.dsn#" dbtype="datasource">
		UPDATE srr_info
		set tree_insp_sr_number = '#request.srticket_srnum#'
		WHERE
		srrKey = '#request.srrKey#'
		</cfquery>
		
</cfif><!--- 000 --->		
		
		<cfcatch>
		
		<cfmail to="essam.amarragy@lacity.org" from="Process_app2@lacity.org" subject="Could Not Generate Child Ticket">
		Error:  Could Not Add MyLA311 Child Ticket for Tree Inspection
		</cfmail>

		</cfcatch>
		</cftry>
	</cfif><!--- 2 --->


</cfif><!--- 1 --->






<cfoutput>
<div class="warning">Application Updated</div>
</cfoutput>
