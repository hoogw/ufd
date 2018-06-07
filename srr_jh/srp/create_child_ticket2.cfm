<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfquery name="findSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.sr_number

, tree_insp_sr_number


FROM  srr_info LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfif #findSRR.tree_insp_sr_number# is NOT "">
	<cfoutput>
	<div class="warning">A Child Ticket Number: #request.tree_insp_sr_number# for Tree Inspection already exists.</div>
	</cfoutput>
	<cfabort>
</cfif>
	
	

	<cfif #findSRR.tree_insp_sr_number# is ""><!--- 2 --->
		<cfset request.srNum = "#findSRR.sr_number#">
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
		
		<cfoutput>
		<div class="warning">A Child Ticket Number: #request.srticket_srnum# was created for Tree Inspection.</div>
		</cfoutput>
</cfif><!--- 000 --->
		<cfcatch>
		
		<cfoutput>
		<div class="warning">A Child Ticket for Tree Inspection could NOT be created.</div>
		</cfoutput>
		
		<cfmail to="essam.amarragy@lacity.org" from="ProcessAppeal2@lacity.org" subject="Could Not Generate Child Ticket">
		Error:  Could Not Add MyLA311 Child Ticket for Tree Inspection
		</cfmail>
		
		</cfcatch>
		</cftry>
		
		
	</cfif><!--- 2 --->
