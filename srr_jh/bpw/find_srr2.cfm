<cfif not isdefined("request.search_value") or  #request.search_value# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg = "Search Value is Required!">
</cfif>

<CFIF len(#request.search_value#) lt 3>
<cfmodule template="/srr/common/error_msg.cfm" error_msg = "At Least 3 characters or digits are required for search!">
</cfif>

<!--- <cfoutput>
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.a_ref_no
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_id
, dbo.srr_info.job_address
, dbo.srr_info.job_city
, dbo.srr_info.job_state
, dbo.srr_info.job_zip


FROM  dbo.srr_info

where 

(str(srr_info.srr_id)+' '+app_name_nn+' '+job_address) like  '%#trim(form.search_value)#%'
</cfoutput>
<cfabort> --->

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.a_ref_no
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_id
, dbo.srr_info.job_address
, dbo.srr_info.job_city
, dbo.srr_info.job_state
, dbo.srr_info.job_zip
, srr_info.bpw_comments

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

str(srr_info.srr_id)  like  '%#trim(request.search_value)#%'
OR
app_name_nn like '%#trim(request.search_value)#%'
OR
job_address like  '%#trim(request.search_value)#%'
</cfquery>

 
 
<cfif #find_srr.recordcount# is 0>
<CFOUTPUT>
<div class="warning">No Matching Records Found!</div>
<div class="warning">Please modify your search criteria and try again.</div>
<br>
<div align="center">
<FORM METHOD="post">
<INPUT TYPE="button" VALUE="BACK" OnClick="history.go( -1 );return true;" class="submit">
</FORM>
</div>
</CFOUTPUT>
<cfabort>
</cfif>




<cfif #find_srr.recordcount# is  not 0>
<CFOUTPUT>
<DIV ALIGN="center"><span class="subtitle">#find_srr.recordcount# Record(s) Found</span></DIV>
</CFOUTPUT>
</cfif>
<!-- ------------------------------------------------------------------- -->
<cfoutput> 
<BR>


<div align="Center">

<table border="1"  class = "datatable" style = "width: 85%;">
<tr>
<Th>Form Ref. No.</Th>
<Th>Date<br>Submitted</Th>
<Th>Applicant</Th>
<Th>Property Address</Th>
<Th>Status</Th>
<Th>Comments</Th>
</tr>
 </cfoutput>

<Cfset x=0>
<cfoutput query="find_srr">

<cfif (#x# mod 2) is 0>
<tr>
<cfelse>
<tr>
</cfif>


<td style="text-align:center;">
<A HREF="control.cfm?action=dsp_app&&srr_id=#srr_id#&#request.addtoken#">#srr_id#&nbsp;</A>
</td>

<td style="text-align:center;">
#dateformat(ddate_submitted,"mm/dd/yyyy")#
</td>

<td>
#app_name_nn#
</td>

<td>
<cfif #job_address# is not "">
<strong>#job_address#</strong>
<br>
#job_city#, #job_city# #job_zip#
</cfif>
</td>

<td style="text-align:center;">
#srr_status#&nbsp;
</td>


<td style="text-align:center;">
#bpw_comments#&nbsp;
</td>

</tr>
 <cfset x=#x#+1>
</cfoutput> 
</table>
</div>



</BODY>
</HTML>















<!--- <!--- <!--- <!---  ---> ---> ---> --->


