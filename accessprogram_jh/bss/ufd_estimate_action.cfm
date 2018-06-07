<cfparam name="request.tree_step3_comp" default="">
<cfquery name="readFields" datasource="#request.dsn#" dbtype="datasource">
SELECT
[FieldName]
      ,[Units]
      ,[Price]
      ,[Sort_Order]
      ,[Sort_Group]
  FROM [accessprogram].[dbo].[bssEstimateForm]
  
  where suspend = 'n'
  and bssDivision = 'ufd'
  
order by sort_group, sort_order
</cfquery>

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>


<cfset request.updateQuery = "UPDATE BSSEstimate   set  lastUpdatedOn = #now()#, UpdatedBy = #client.staff_user_id#,  ">


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
<cfoutput>
#PreserveSingleQuotes(request.updateQuery)#
</cfoutput>
</cfquery>

<cfquery name="updateAR" datasource="#request.dsn#" dbtype="datasource">
update ar_info
set
ufd_update_dt = #now()#
, ufd_update_by = #client.staff_user_id#
where arKey = '#request.arKey#'
</cfquery>

<cfif #request.ufd_internal_comments# is not "">
<cfquery name="updateAR" datasource="#request.dsn#" dbtype="datasource">
update ar_info
set
ufd_internal_comments = ISNULL(ufd_internal_comments, '') + '|#request.ufd_internal_comments# <br>(By: #client.full_name# on: #dnow#)'
where arKey = '#request.arKey#'
</cfquery>
</cfif>

<!--- 			<cfquery name="updateTree" datasource="#request.dsn#" dbtype="datasource">
				update ar_info
				set tree_step3_comp = '#tree_step3_comp#'
				where arKey = '#request.arKey#'
			</cfquery>
 --->
 
 
 			<cfquery name="updateTree" datasource="#request.dsn#" dbtype="datasource">
				update ar_info
				set tree_step3_comp = '#request.tree_step3_comp#',
				<cfif #request.tree_step3_comp# is "y">
							record_history = ISNULL(record_history, '') + '|SAR Trees was marked as completed by #client.full_name# on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
					<cfelse>
							record_history = ISNULL(record_history, '') + '|SAR Trees was updated by #client.full_name# on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
					</cfif>
				where arKey = '#request.arKey#'
			</cfquery>


<div class="warning">UFD Estimate was Successfully Updated</div>


