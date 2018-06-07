<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="checkExist" datasource="#request.dsn#" dbtype="datasource">
Select srr_id 
from 
tree_pruning_permit
where srr_id = #request.srr_id#
</cfquery>

<cfif #checkExist.recordcount# is 0>
<cfquery name="createTreeRemovalPermit" DATASOURCE="#request.dsn#" dbtype="datasource">
insert into tree_pruning_permit
(
srr_id
, ddate_submitted
)
values
(
#request.srr_id#
, #now()#
)
</cfquery>
</cfif>


<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

record_history = record_history + '|A Tree Root Pruning Permit was submitted by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srrKey = '#request.srrKey#'
</cfquery>

<cfmodule template="../common/checkRequiredPermitsSubmitted_module.cfm" srrKey="#request.srrKey#">

<cfoutput>
<div class="warning">
Your Tree Root Pruning Permit was Successfully Submitted
</div>

<div align="center"><input type="button" name="back" id="back" value="Back to Requirements" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'"></div>
</cfoutput>

