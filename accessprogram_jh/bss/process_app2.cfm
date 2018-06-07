<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfquery name="find_ArINFO" datasource="#request.dsn#" dbtype="datasource">
select 

record_history
 				
FROM  dbo.ar_info
where 
ar_info.arKey = '#request.arKey#'

</cfquery>


<!--- <cfset request.record_history=#find_ArInfo.record_history#&"<b>Applicant Information updated</b> on "&#dateformat(now(),"mm/dd/yyyy")#&" at "&#timeformat(now(),"h:mm tt")#&" by "&#client.full_name#&"."&"<br><br>">
 --->
<!--- <cfoutput>#request.record_history#</cfoutput>

<cfabort> --->




<cfquery name="find_ramp_dimension" datasource="#request.dsn#" dbtype="datasource">
select *
from  ramp_dimension
where ar_id = #request.Ar_id#

</cfquery>


<cfset request.record_history=#find_ramp_dimension.record_history#&"<b>Applicant Information updated</b> on "&#dateformat(now(),"mm/dd/yyyy")#&" at "&#timeformat(now(),"h:mm tt")#&" by "&#client.full_name#&"."&"<br><br>">

<cfif #find_ramp_dimension.recordcount# is 1>


<cfquery name="update_ramp_dime" datasource="#request.dsn#" dbtype="datasource">
update
ramp_dimension
set
  site_address = '#request.site_address#'
	,Nbr_Access_Ramp = #toSqlNumeric(Request.nbr_access_ramp)#
 	,Nbr_Truncated_domes =#toSqlNumeric(request.nbr_truncated_domes)#
	,Depressed_curb_LF = #toSqlNumeric(request.depressed_curb_lf)#
	,Sidewalk_Sqft = #toSqlNumeric(request.Sidewalk_sqft)#
	,Curb_LF = #toSqlNumeric(request.curb_lf)#
	,Gutter_LF = #toSqlNumeric(request.gutter_lf)#
	,Driveway_SqFt = #toSqlNumeric(request.driveway_sqft)#
	,Spandrels_SqFt = #toSqlNumeric(request.Spandrels_Sqft)#
	,Alley_Approaches_SqFt = #toSqlNumeric(request.alley_approaches_sqft)#
	,Cross_Gutter_SqFt = #toSqlNumeric(request.cross_gutter_sqft)#
	, Additional_RampOver_135SqFt= #toSqlNumeric(request.additional_rampOver_135Sqft)# 
	,record_history = '#request.record_history#'
	
	where ar_id =#request.ar_id#

</cfquery>


</cfif>

<!--- 
<cfquery name="updateARInfo" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[ar_info]
SET

disability_Valid = '#request.disability_valid#'
,record_history = '#request.record_history#'

where ar_id =  #request.ar_id#
</cfquery> --->


<!--- <cfquery name="updateARInfo" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[Ramp_dimension]
SET --->
<cfif #find_ramp_dimension.recordcount# is 0>
<CFQUERY NAME="iNSERT_ramp_dimension" datasource="#request.dsn#" dbtype="datasource">
insert into Ramp_dimension
(
    ar_id
	,site_address 
	,Nbr_Access_Ramp
	,Nbr_Truncated_domes
	,Depressed_curb_LF 
	,Sidewalk_Sqft
	,Curb_LF
	,Gutter_LF
	, Driveway_SqFt
	,Spandrels_SqFt
	,Alley_Approaches_SqFt
	,Cross_Gutter_SqFt
	,Additional_RampOver_135SqFt
	,record_history
	)
	values
	(
	  #request.ar_id# 
	 ,'#request.site_address#'
	 , #toSqlNumeric(Request.nbr_access_ramp)#
 	 , #toSqlNumeric(request.nbr_truncated_domes)#
	, #toSqlNumeric(request.depressed_curb_lf)#
	 , #toSqlNumeric(request.Sidewalk_sqft)#
	 , #toSqlNumeric(request.curb_lf)#
	 , #toSqlNumeric(request.gutter_lf)#
	, #toSqlNumeric(request.driveway_sqft)#
	, #toSqlNumeric(request.Spandrels_Sqft)#
	, #toSqlNumeric(request.alley_approaches_sqft)#
	, #toSqlNumeric(request.cross_gutter_sqft)#
	, #toSqlNumeric(request.additional_rampOver_135Sqft)# 
	, '#request.record_history#'
)<!--- where ar_id =  --->
</cfquery>
</cfif>

<form action="control.cfm?action=view_unprocessed&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">
<cfoutput>
<div class="warning">
Your Application was Save Successfully 
</div>
<br>
</cfoutput>


<div align="center"><input type="submit" name="submit" id="submit" value="Back"></div>



























<!--- old 12072016 --->
<!--- <cfparam name="request.close_bss_sr311" default="">
<cfparam name="request.meandering_viable" default="">
<cfparam name="request.ar_status_cd" default="">
<cfparam name="request.srNum" default="">
<cfparam name="request.srCode" default="">
<cfparam name="request.srComment" default="">

<cfquery name="updateTrees" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[tree_info]
SET

[nbr_trees_pruned] = #toSqlNumeric(request.nbr_trees_pruned)#
, [lf_trees_pruned] = #toSqlNumeric(request.lf_trees_pruned)#
, [nbr_trees_removed] = #toSqlNumeric(request.nbr_trees_removed)#
, [nbr_stumps_removed] = #toSqlNumeric(request.nbr_stumps_removed)#
, [nbr_trees_onsite] = #toSqlNumeric(request.nbr_trees_onsite)#
, [nbr_trees_offsite] = #toSqlNumeric(request.nbr_trees_offsite)#
, meandering_viable = '#request.meandering_viable#'
, meandering_tree_nbr = #toSqlNumeric(request.meandering_tree_nbr)#

where ar_id =  #request.ar_id#
</cfquery>

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" arKey="#request.arKey#">

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[ar_info]
SET

bss_action_by = #client.staff_user_id#
, close_bss_sr311 = '#request.close_bss_sr311#'


<cfif #request.ar_status_cd# is "offerMade">
, ar_status_cd = 'offerMade'
, offer_reserved_amt = 0
, offer_open_amt = #toSqlNumeric(request.rebateTotal)#
, offer_accepted_amt = 0
, offer_paid_amt = 0
, offerMade_dt = #now()#
, offerMade_exp_dt =  dateAdd("d", 14, #now()#)
, bss_assessment_comp_dt = #now()#
, record_history = record_history + '|BSS/UFD completed assessment on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|Offer emailed to applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
<cfelseif #request.ar_status_cd# is "pendingBOEReview">
, ar_status_cd = 'pendingBOEReview'
, bss_to_boe_dt = #now()#
, record_history = record_history + '|BSS/UFD forwarded application to Engineering (BOE) for further investigation on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#'
<cfelseif #request.ar_status_cd# is "PendingBssReview">
, ar_status_cd = 'PendingBssReview'
, record_history = record_history + '|BSS/UFD updated application on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.  No action was taken.'
</cfif>

, [bss_comments] = '#toSqlText(request.bss_comments)#'

where ar_id =  #request.ar_id#
</cfquery>

<cfoutput>


<cfif #request.ar_status_cd# is "offerMade">
<div class="warning">Status is Updated to Estimate/Assessment Completed <br><br>(Offer Emailed to Applicant)</div>
<cfset request.offerMade_exp_dt =  dateAdd("d", 14, #now()#)>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "20"> <!--- Code 20 offerMade --->
<cfset request.srComment = "Your property has been approved to receive a rebate offer of #dollarformat(request.rebateTotal)# to make repairs that will ensure the fronting sidewalk is ADA compliant. In order to receive the rebate, you must submit the necessary permit(s) within 60 days. Further details regarding you rebate offer are available here:
<br><br>
#request.serverRoot#/accessprogram/public/offer_to_applicant.cfm?arKey=#request.arKey#
<br><br>
This offer will expire on #dateformat(request.offerMade_exp_dt,"mm/dd/yyyy")#">


<cfelseif #request.ar_status_cd# is "pendingBOEReview">
<div class="warning">Status is Updated to Pending BOE Review</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 = pending BCA Review, Pending BOE Review, pending BSS Review --->
<cfset request.srComment = "">


<cfelseif #request.ar_status_cd# is "pendingBssReview">
<div class="warning">No Status Change<br><br>Application is still with BSS/UFD</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 = pending BCA Review, Pending BOE Review, pending BSS Review --->
<cfset request.srComment = "">


</cfif>



<cfif #request.ar_status_cd# is "offerMade">
<cftry>
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">


 --->



<!--- <div class="warning">
Success: #request.srupdate_success#<br>
Error Message: #request.srupdate_err_message#<br>
</div> --->

<!--- 12072016 --->
<!--- <cfcatch type="Any">
<!--- <div class="warning">
Error Updating Ticket in MyLA311<br><br>
Success: #request.srupdate_success#<br>
Error Message: #request.srupdate_err_message#<br>
</div>
<cfabort> --->
</cfcatch>
</cftry>
</cfif>

</cfoutput>
 --->