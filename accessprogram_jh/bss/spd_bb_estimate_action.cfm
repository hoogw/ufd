<cfparam name="request.swbb_step2_comp" default="">

<cfquery name="readFields" datasource="#request.dsn#" dbtype="datasource">
SELECT
[FieldName]
      ,[Units]
      ,[Price]
      ,[Sort_Order]
      ,[Sort_Group]
  FROM [accessprogram].[dbo].[bssEstimateForm]
  
  where suspend = 'n'
  and bssDivision = 'spd'
  
order by sort_group, sort_order
</cfquery>

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfset request.updateQuery = "UPDATE BSSEstimate_bb  set  lastUpdatedOn = #now()#, UpdatedBy = #client.staff_user_id#, ">



<cfloop query="readFields">

<cfoutput>
<cfset xValue = #Evaluate("request."&#readfields.FieldName#&"_Quantity")#>
<cfset xUnits = #readFields.Units#>
<cfif #xValue# is "">
<cfset xValue = 0>
<cfelse>
<cfset xValue=ReplaceNoCase("#xValue#","$","","ALL")>
<cfset xValue=ReplaceNoCase("#xValue#",",","","ALL")>
<cfset xValue=ReplaceNoCase("#xValue#","%","","ALL")>
</cfif>
<cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#_Quantity="&#xValue#&", ">
<cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#_Units='"&#xUnits#&"', ">
</cfoutput>

</cfloop>

<cfset request.updateQuery = left(#request.updateQuery#, (len(#request.updateQuery#) - 2))>
<cfset request.updateQuery = #request.updateQuery#&" where arKey = '#request.arKey#'">

<!--- <cfdump var="#request.updateQuery#" output="browser"> --->
<!--- <cfoutput>
#request.updateQuery#
</cfoutput>
<br><br> --->

<cfquery name="updateFields" datasource="#request.dsn#" dbtype="datasource">
#PreserveSingleQuotes(request.updateQuery)#
</cfquery>

<cfquery name="updateAR" datasource="#request.dsn#" dbtype="datasource">
update ar_info
set
spd_update_dt = #now()#
, spd_update_by = #client.staff_user_id#
where arKey = '#request.arKey#'
</cfquery>

<cfif #request.spd_internal_comments# is not "">
<cfquery name="updateAR" datasource="#request.dsn#" dbtype="datasource">
update ar_info
set
spd_internal_comments = ISNULL(spd_internal_comments, '') + '|#request.spd_internal_comments# <br>(By: #client.full_name# on: #dnow#)'
where arKey = '#request.arKey#'
</cfquery>
</cfif>




<!--- 	<cfif isdefined("sw_step1_comp")>
		<cfquery name="sw" datasource="#request.dsn#" dbtype="datasource">
			select sw_step1_comp
			from ar_info
			where arkey='#request.arkey#'
		</cfquery>
		<cfif #sw.sw_step1_comp# is "">
			<cfquery name="insertSW" datasource="#request.dsn#" dbtype="datasource">
				insert into ar_info
				(sw_step1_comp)
				values
				('#sw_step1_comp#')
			</cfquery>
		<cfelse> --->
		
		
<!--- 			<cfquery name="updateSwbb" datasource="#request.dsn#" dbtype="datasource">
				update ar_info
				set swbb_step2_comp = '#swbb_step2_comp#'
				where arKey = '#request.arKey#'
			</cfquery> --->
			
			
			
			<cfquery name="updateSwbb" datasource="#request.dsn#" dbtype="datasource">
				update ar_info
				set swbb_step2_comp = '#request.swbb_step2_comp#',
				<cfif #request.swbb_step2_comp# is "y">
								record_history = ISNULL(record_history, '') + '|Non SAR was marked as completed by #client.full_name# on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
					<cfelse>
						record_history = ISNULL(record_history, '') + '|Non SAR was updated by #client.full_name# on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
					</cfif>
						where arKey = '#request.arKey#'
			</cfquery>

<!--- 		</cfif>
	</cfif> --->
	




<div class="warning">SPD Estimate was Successfully Updated</div>

