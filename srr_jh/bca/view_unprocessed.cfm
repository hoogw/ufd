<cfinclude template="header.cfm">
<cfinclude template="navbar1.cfm">

<cfquery name="view_unprocessed" datasource="#request.dsn#" dbtype="datasource">
SELECT 
	[srr_id]
      ,[ddate_submitted]
      ,[sr_number]
      ,[app_id]
      ,[app_name_nn]
<!---      ,[job_address]
      ,[job_zip]--->
	  
	  , srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd
	  
      ,[bca_action_by]
      ,[tbm_grid]
      ,[prop_type]
	  
	  , Case 
	  when isdate(boe_invest_to_bca_dt)=1 THEN boe_invest_to_bca_dt
	  else [bpw_to_bca_dt]
	  END AS ddate_received
	  
	  
      ,[bpw1_internal_comments]
      ,[bca_comments]
      ,[srr_status_cd]
	  , srrKey
	  , offer_reserved_amt
	  , prop_type
	  , zoningCode
	  
	  
  FROM [srr].[dbo].[srr_info]
  where 
  srr_status_cd = 'pendingBcaReview'
  order by ddate_submitted
</cfquery>



<cfoutput>
<div class="divSubTitle">#view_unprocessed.recordcount# Unprocessed Applications</div>
</cfoutput>

<div align = "center">
<table class="datatable" id="table1">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date<br>Submitted</th>
<th nowrap>Property Address</th>
<!--- <th nowrap>Type</th>
<th nowrap>Reserved Amout</th> --->
</tr>

<cfoutput query="view_unprocessed">
<tr>
<td style="text-align:center;"><a href="application_options.cfm?srrKey=#view_unprocessed.srrKey#&#request.addtoken#">#view_unprocessed.sr_number#</a></td>
<td style="text-align:center;"><div align="center">#dateformat(view_unprocessed.ddate_submitted,"mm/dd/yyyy")#</div></td>
<td>#view_unprocessed.HSE_NBR# #view_unprocessed.HSE_FRAC_NBR# #view_unprocessed.HSE_DIR_CD# #view_unprocessed.STR_NM# #view_unprocessed.STR_SFX_CD# #view_unprocessed.STR_SFX_DIR_CD# #view_unprocessed.ZIP_CD#</td>
<!--- <td>
<cfif #view_unprocessed.prop_type# is "R">
Residential (#zoningCode#)
<cfelse>
Commercial (#zoningCode#)
</cfif>
</td>
<td style="text-align:right;">#dollarformat(view_unprocessed.offer_reserved_amt)#</td> --->
</tr>
</cfoutput>

</table>
</div>


<cfinclude template="footer.cfm">
