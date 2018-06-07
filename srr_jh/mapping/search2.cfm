<!---<cfoutput>
SELECT 
	[srr_id]
      ,[ddate_submitted]
      ,[sr_number]
      ,[app_id]
      ,[app_name_nn]
      ,[job_address]
      ,[job_zip]
      ,[bca_action_by]
      ,[tbm_grid]
      ,[prop_type]
      ,[bpw_to_bca_dt]
      ,[bpw_comments]
      ,[bca_comments]
      ,[srr_status_cd]
	  , srrKey
  FROM [srr].[dbo].[srr_info]
  where 
  (
srr_id like '%#request.search_value#%'
  OR
  sr_number like '%#request.search_value#%'
  OR
  app_name_nn like '%#request.search_value#%'
  OR
  job_address like '%#request.search_value#%'
    OR
  a_ref_no like '%#request.search_value#%'
  )
  order by ddate_submitted
</cfoutput>
--->

<cfset request.search_value = #trim(request.search_value)#>

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
	[srr_id]
      ,[ddate_submitted]
      ,[sr_number]
      ,[app_id]
      ,[app_name_nn]
      ,[job_address]
      ,[zip_cd]
      ,[bca_action_by]
      ,[tbm_grid]
      ,[prop_type]
      ,[bpw_to_bca_dt]
      ,[bpw1_internal_comments]
      ,[bca_comments]
      ,[srr_status_cd]
	  , srrKey
	  , lgd_completed_dt
	  
  FROM [srr].[dbo].[srr_info]
  where 
  (
srr_id like '%#request.search_value#%'
  OR
  sr_number like '%#request.search_value#%'
  OR
  app_name_nn like '%#request.search_value#%'
  OR
  job_address like '%#request.search_value#%'
      OR
  a_ref_no like '%#request.search_value#%'
  )
  order by ddate_submitted
</cfquery>




<cfoutput>
<div class="subtitle">#find_srr.recordcount# Applications Found</div>
</cfoutput>

<div align = "center">
<table class="datatable" id="table1">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date<br>Submitted</th>
<th nowrap>Applicant</th>
<th nowrap>Property Address</th>
<th>LGD Completed Date</th>
</tr>

<cfoutput query="find_srr">
<tr>
<td style="text-align:center;">#find_srr.sr_number#<!---  (#srr_id#) ---></td>
<td style="text-align:center;"><div align="center">#dateformat(find_srr.ddate_submitted,"mm/dd/yyyy")#</div> <div align="center">#timeformat(find_srr.ddate_submitted,"h:mm tt")#</div></td>

<td>#find_srr.app_name_nn#</td>

<td>#find_srr.job_address#</td>

<td align="center">
<cfif isdate(#find_srr.lgd_completed_dt#)>
#dateformat(find_srr.lgd_completed_dt,"mm/dd/yyyy")#
<cfelse>
Not Completed
</cfif>
</td>
</tr>
</cfoutput>

</table>
</div>
