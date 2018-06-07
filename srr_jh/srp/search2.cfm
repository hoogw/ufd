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
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_id
, dbo.srr_info.app_name_nn
, dbo.srr_info.job_address
, dbo.srr_info.zip_cd
, dbo.srr_info.bca_action_by
, dbo.srr_info.tbm_grid
, dbo.srr_info.prop_type
, dbo.srr_info.bpw_to_bca_dt
, dbo.srr_info.bpw1_internal_comments
, dbo.srr_info.bca_comments
, dbo.srr_info.srr_status_cd
, dbo.srr_info.srrKey
, dbo.srr_status.srr_status_desc
, srr_info.address_verified
, srr_info.rate_nbr

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   
  where 
  (
srr_info.srr_id like '%#request.search_value#%'
  OR
  srr_info.sr_number like '%#request.search_value#%'
  OR
  srr_info.app_name_nn like '%#request.search_value#%'
  OR
  srr_info.job_address like '%#request.search_value#%'
      OR
  srr_info.a_ref_no like '%#request.search_value#%'
  )
  order by srr_info.ddate_submitted
</cfquery>







<div align = "center">
<cfoutput>
<div class="SubTitle">#find_srr.recordcount# Applications Found</div>
</cfoutput>
<table class="datatable" id="table1">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date<br>Submitted</th>
<!--- <th nowrap>Rate No.</th> --->
<th nowrap>Applicant</th>
<th nowrap>Property Address</th>
<th nowrap>Status</th>
</tr>

<cfoutput query="find_srr">
<tr>
<td style="text-align:center;"><a href="control.cfm?action=process_app1&srrKey=#find_srr.srrKey#&#request.addtoken#">#find_srr.sr_number#<!---  (#srr_id#) ---></a></td>

<td style="text-align:center;"><div align="center">#dateformat(find_srr.ddate_submitted,"mm/dd/yyyy")#</div> <div align="center">#timeformat(find_srr.ddate_submitted,"h:mm tt")#</div></td>

<!--- <td>#find_srr.rate_nbr#</td> --->

<td>#app_name_nn#</td>
<td>#find_srr.job_address#
<cfif #find_srr.address_verified# is "N">
<div align="center"><span style="color:red;">Invalid Address</span></div>
</cfif>
</td>
<td>#find_srr.srr_status_desc#</td>
</tr>
</cfoutput>

</table>
</div>
