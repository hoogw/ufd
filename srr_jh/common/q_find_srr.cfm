<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
       [srr_id]
      ,[ddate_submitted]
      ,[receive_method]
      ,[a_ref_no]
      ,[app_id]
      ,[app_name_nn]
      ,[app_contact_name_nn]
      ,[app_address1_nn]
      ,[app_address2_nn]
      ,[app_city_nn]
      ,[app_state_nn]
      ,[app_zip_nn]
      ,[app_phone_nn]
      ,[app_email_nn]
      ,[job_address]
      ,[job_city]
      ,[job_state]
      ,[job_zip]
      ,[unit_range]
      ,[mailing_address1]
      ,[mailing_address2]
      ,[mailing_zip]
      ,[mailing_city]
      ,[mailing_state]
      ,[tree_root_damage]
      ,[bpw_action_by]
      ,[bss_action_by]
      ,[bss_action_req]
      ,[bca_action_by]
      ,[hse_nbr]
      ,[str_nm]
	  
, case 
when (boe_dist = 'c') Then 'Central'
when (boe_dist = 'v') Then 'Valley'
when (boe_dist = 'w') Then 'West LA'
when (boe_dist = 'h') Then 'Harbor'
when (boe_dist is null or boe_dist = '') Then 'Not Assigned'
end as boe_dist
	  
      ,[council_dist]
      ,[bpp]
      ,[pind]
      ,[address_verified]
      ,[hse_id]
      ,[tbm_grid]
      ,[work_description]
      ,[prop_type]
      ,[record_history]
      ,[bpw_to_bca_dt]
      ,[bca_to_bss_dt]
      ,[bca_to_ssd_dt]
      ,[bpw_denied_dt]
      ,[bss_to_ssd_dt]
      ,[ssd_offer_dt]
      ,[bpw1_ownership_verified]
      ,[bpw1_tax_verified]
      ,[zoning_verified]
      ,[program_eligible]
      ,[cust_comments]
      ,[bpw_comments]
      ,[bca_comments]
      ,[bss_comments]
      ,[ssd_comments]
  FROM [srr].[dbo].[srr_info]

, case 
	  when (isdate(ddate_submitted)= 0) 
	  then 'In Progress'

	  when (isdate(ddate_submitted)= 1 and isdate(bpw_to_bca_dt)=0 and isdate(bpw_denied_dt)=0) 
	  then 'Pending Board of Public Work Review'

	  when (isdate(bpw_to_bca_dt)=1 and isdate(bpw_denied_dt)=0 and isdate(bca_to_bss_dt)=0 and isdate(bca_to_ssd_dt)=0) 
	  then 'Pending Bureau of Contract Administration Review'

	  when (isdate(bpw_to_bca_dt)=1 and isdate(bpw_denied_dt)=0 and isdate(bca_to_bss_dt)=0 and isdate(bca_to_ssd_dt)=0) 
	  then 'Pending Bureau of Contract Administration Review'

	  when (isdate(bpw_denied_dt)=1) 
	  then 'Application Not Eligible'

	  when (isdate(bca_to_bss_dt)=1 and isdate(bss_to_ssd_dt)=0) 
	  then 'Pending Bureau of Street Services Review'

	  when (isdate(bca_to_bss_dt)=1 and isdate(bss_to_ssd_dt)=1 and isdate(ssd_offer_dt)=0) 
	  then 'Pending Street & Storm Drain Division Review'

	  	  when (isdate(ssd_offer_dt)=1) 
	  then 'Offer Sent to Customer on '+ CONVERT(varchar(10), ssd_offer_dt, 101)

	  End As srr_status


FROM  dbo.srr_info

where 

srr_info.srr_id =#request.srr_id#
<cfquery>


<cfoutput>
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="formbox" style="width:700px;">
<h1>Application Processing</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
	<tr>
		<td>Ownership Verified?</td>
		<td><input type="radio" name="bpw1_ownership_verified" value="y" <cfif #bpw1_ownership_verified# is "y">checked</cfif>> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="bpw1_ownership_verified" value="n"> No</td>
	</tr>
	<tr>
		<td>Tax Information Verified?</td>
		<td><input type="radio" name="bpw1_tax_verified" value="y"> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="bpw1_tax_verified" value="n"> No</td>
	</tr>
	<tr>
		<td>Zoning Verified?</td>
		<td><input type="radio" name="zoning_verified" value="y"> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="zoning_verified" value="n"> No</td>
	</tr>
	<tr>
		<td>Eligible?</td>
		<td><input type="radio" name="program_eligible" value="y"> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="program_eligible" value="n"> No</td>
	</tr>
	<tr>
		<td colspan="2">Approved applications will be forwarded to BCA for pre-inspection<br />
		Denied applications will trigger a Denial Letter to Applicant</td>
	</tr>
	
	
		<tr>
		<td colspan="2">Board of Public Works Comments<br />
		<textarea cols="" rows="" name="bpw_comments" id="bpw_comments" style="width:500px;height:300px;"></textarea></td>
	</tr>

</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</form>
</cfoutput>

