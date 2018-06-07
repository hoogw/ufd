
<cfquery name="my_apps" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.receive_method
, srr_info.a_ref_no
, srr_info.app_id
, srr_info.app_name_nn
, srr_info.app_contact_name_nn
, srr_info.app_address1_nn
, srr_info.app_address2_nn
, srr_info.app_city_nn
, srr_info.app_state_nn
, srr_info.app_zip_nn
, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.job_address
, srr_info.job_city
, srr_info.job_state
, srr_info.job_zip
, srr_info.unit_range

, case 
	  when (isdate(ddate_submitted)= 0) 
	  then 'In Progress'

	  when (isdate(ddate_submitted)= 1 and isdate(bpw_to_bca_dt)=0 and isdate(bpw_denied_dt)=0) 
	  then 'Pending Board of Public Work Review'

	  when (isdate(bpw_to_bca_dt)=1 and isdate(bpw_denied_dt)=0 and isdate(bca_to_bss_dt)=0) 
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

, case when srr_info.boe_dist = 'c' THEN 'Central'
when srr_info.boe_dist = 'v' THEN 'Valley'
when srr_info.boe_dist = 'w' THEN 'West LA'
when srr_info.boe_dist = 'h' THEN 'Harbor'
else 'Not Assigned'
END AS boe_dist


, srr_info.bpp
, srr_info.pind
, srr_info.address_verified

FROM  srr_info 
  
where srr_info.app_id = #client.app_id#
</cfquery>




<cfif #my_apps.recordcount# is 0>
<div class="warning">No applications were submitted under this account.</div>
<br><br>
<div align="center">If you need to apply for a new permit, please use <strong><em>Apply for a New Permit</em></strong></div>
<cfabort>
</cfif>


<div class="title">The following is a list of your applications</div>

<div align="center">
<table class="datatable" id="table1" style="width:95%;">

<tr>
<th>Reference No.</th>
<th>Date Submitted</th>
<th>Applicant</th>
<th>Property Address</th>
<th>Engineering<br>Dist.</th>
<th>Application Status</th>

</tr>

<cfset xx=0>
<!--- startrow="#start_row#" maxrows="#request.boe_max_rows#" --->
<cfoutput query="my_apps">
<cfif (#xx# mod 2) is 0>
<tr class = "alt">
<cfelse>
<tr>
</cfif>


<td>
<cfif #my_apps.ddate_submitted# is not "">
<a href="control.cfm?action=dsp_app&srr_id=#my_apps.srr_id#&#request.addtoken#">
#my_apps.srr_id#</a>
<cfelse>
<a href="control.cfm?action=app_requirements&srr_id=#my_apps.srr_id#&#request.addtoken#" target="_top">
#my_apps.srr_id#</a>
</cfif>
</td>

<td style="text-align:center;">
<cfif #my_apps.ddate_submitted# is not "">
#dateformat(my_apps.Ddate_Submitted,"mm/dd/yyyy")#
<cfelse>
Not Submitted
</cfif>
</td>
<td style="text-align:center;">
#my_apps.app_name_nn#
</td>

<td>
<cfif #my_apps.job_address# is not "">
<span class="data">
<strong>
<div align="left">#Ucase(my_apps.job_address)# </div>
<div align="left">#Ucase(my_apps.job_city)#, #Ucase(my_apps.job_state)# #Ucase(my_apps.job_zip)#</div>
</strong>
</span>
<cfelse>
&nbsp;
</cfif>
</td>

<td style="text-align:center;">
#my_apps.boe_dist#
</td>


<!---<td>
#my_apps.app_name_nn#
</td>
--->


<td style="text-align:center;">
<strong><span class="data">#my_apps.srr_status#</span></strong> &nbsp;
</td>

</tr>


<cfset xx=#xx# + 1>
</cfoutput>
</table>
</div>