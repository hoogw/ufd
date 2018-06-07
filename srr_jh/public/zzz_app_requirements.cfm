<cfparam name="request.srr_id" default="">

<style>
LI {
margin-left:15px;
margin-top:5px;
margin-bottom:5px;
}


.red {
color: red;
}

.green {
color: green;
}

</style>

<cfoutput>

<cfif isnumeric(#request.srr_id#)><!--- 1 --->
<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select srr_id, ddate_submitted
from srr_info 
where srr_id = #request.srr_id#
</cfquery>

<cfquery name="screen_dates" datasource="#request.dsn#" dbtype="datasource">
select * from screen_dates 
where srr_id = #request.srr_id#
</cfquery>

<!---<div class="title">Application Reference Number: #request.srr_id#</div>--->

<cfif #find_srr.ddate_submitted# is "">
<div class="warning">This Application is not Submitted</div>
</cfif>

</cfif><!--- 2 --->

<div class="formbox" style="width:700px;">
<h1>Application Requirements:</h1>
<table border="1"  class = "formtable" style = "width: 700px;">

<tr>
<td class="head">&nbsp;</td>
<td width="70%" class="head">Item</td>
<td class = "head">Status</td>
</tr>

<ul type="circle">

<!-- Start New Application -->
<tr>
<td width="10%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#)>
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
<cfelse>
<img src="/common/ar2.gif" alt="" width="45" height="40" border="0">
</cfif>
</td>
<td width="70%">
<cfif isnumeric(#request.srr_id#)>
<strong>Start a New Application</strong>
<cfelse>
<strong><a href="control.cfm?action=start_new_app1&#request.addtoken#">1. Start a New Application</a></strong>
</cfif>
<br>
Once you click the start button, a reference number will be assigned to your new application.
</td>
<td width="20%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.start_app_dt# is not "">
<span class="green">Completed</span> <br>on:#dateformat(screen_dates.start_app_dt,"mm/dd/yyyy")# <br>at:#timeformat(screen_dates.start_app_dt,"h:mm tt")#
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.start_app_dt# is "" and #find_srr.ddate_submitted# is not "">
<span class="green">Completed</span> <br>on:#dateformat(find_srr.ddate_submitted,"mm/dd/yyyy")# <br>at:#timeformat(find_srr.ddate_submitted,"h:mm tt")#
<cfelse>
<form action="control.cfm?action=start_new_app1&#request.addtoken#" method="post" name="form1" id="form1">
<input type="submit" name="submit" id="submit" value=" Start ">
</form>
</cfif>
</td>
</tr>
<!-- Start New Application -->

<cfif  isnumeric(#request.srr_id#)  and #find_srr.ddate_submitted# is "" and #screen_dates.applicant_screen_dt# is not "">
<tr><td colspan="3" align="center" style="background:silver;"><strong>The following steps can be completed in any order</strong></td></tr>
</cfif>


<!-- Applicant Information -->
<tr>
<td width="10%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.applicant_screen_dt# is not "">
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.applicant_screen_dt# is "">
<img src="/common/ar2.gif" alt="" width="45" height="40" border="0">
</cfif>
</td>
<td width="70%">
<cfif isnumeric(#request.srr_id#)>
<a href="control.cfm?action=dsp_applicant_info&srr_id=#request.srr_id#&#request.addtoken#">
<li>View Applicant Information</li>
</a>
<cfelse>
<li><strong>View Applicant Information</strong></li>
</cfif>
</td>
<td width="20%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.applicant_screen_dt# is not "">
<span class="green">Completed/Updated</span><br>on:#dateformat(screen_dates.applicant_screen_dt,"mm/dd/yyyy")#<br>at:#timeformat(screen_dates.applicant_screen_dt,"h:mm tt")#
<cfelse>
<span class="red">Not Completed</span>
</cfif>
</td>
</tr>
<!-- Applicant Information -->


<!-- Job Address -->
<tr>
<td width="10%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.job_address_screen_dt# is not "">
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.job_address_screen_dt# is  "">
<img src="/common/ar2.gif" alt="" width="45" height="40" border="0">
</cfif>
</td>
<td width="70%">
<cfif isnumeric(#request.srr_id#) and #screen_dates.job_address_screen_dt# is  "">
<a href="control.cfm?action=get_job_location1&srr_id=#request.srr_id#&#request.addtoken#">
<li>Complete Job Location</li>
</a>
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.job_address_screen_dt# is not  "">
<a href="control.cfm?action=edit_job_location1&srr_id=#request.srr_id#&#request.addtoken#">
<li>Complete Job Location</li>
</a>
<cfelse>
<li><strong>Complete Job Location</strong></li>
</cfif>
</td>
<td width="20%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.job_address_screen_dt# is not "">
<span class="green">Completed/Updated</span><br>on:#dateformat(screen_dates.job_address_screen_dt,"mm/dd/yyyy")#<br>at:#timeformat(screen_dates.job_address_screen_dt,"h:mm tt")#
<cfelse>
<span class="red">Not Completed</span>
</cfif>

</td>
</tr>
<!-- Job Address -->

<!-- Work Description -->
<tr>
<td width="10%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.work_desc_screen_dt# is not "">
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.work_desc_screen_dt# is  "">
<img src="/common/ar2.gif" alt="" width="45" height="40" border="0">
</cfif>
</td>
<td width="70%">
<cfif isnumeric(#request.srr_id#) and #find_srr.ddate_submitted# is "">
<a href="control.cfm?action=edit_work_description1&srr_id=#request.srr_id#&#request.addtoken#">
<li>Complete Work Description</li>
</a>
<cfelseif isnumeric(#request.srr_id#) and #find_srr.ddate_submitted# is not "">
<!--- <a href="dsp_work_description.cfm?srr_id=#request.srr_id#&#request.addtoken#"> --->
<a href="control.cfm?action=dsp_work_description&srr_id=#request.srr_id#&#request.addtoken#">
<li>View Work Description</li>
</a>
<!--- (Work Description is based on original permit) --->
<cfelse>
<li><strong>Complete Work Description</strong></li>
</cfif>
</td>
<td width="20%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #screen_dates.work_desc_screen_dt# is not "">
<span class="green">Completed/Updated</span><br>on:#dateformat(screen_dates.work_desc_screen_dt,"mm/dd/yyyy")#<br>at:#timeformat(screen_dates.work_desc_screen_dt,"h:mm tt")#
<cfelse>
<span class="red">Not Completed</span>
</cfif>

</td>
</tr>
<!-- Work Description -->


<!-- Add Attachments -->
<tr>
<td width="10%" align="center"  valign="top">
<!--- <cfif isnumeric(#request.srr_id#) and #screen_dates.other_items_screen_dt# is not "">
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
<cfelseif isnumeric(#request.srr_id#) and #screen_dates.other_items_screen_dt# is  "">
<img src="/common/ar2.gif" alt="" width="45" height="40" border="0">
</cfif> --->
</td>&nbsp;
<td width="70%">
<cfif isnumeric(#request.srr_id#)>
<a href="control.cfm?action=uploadfile1&srr_id=#request.srr_id#&#request.addtoken#">
<li>Add Attachments</li>
</a>
<cfelse>
<li><strong>Add Attachments</strong></li>
</cfif>
<p>Attachments are optional but any photos showing the existing conditions will expedite the processing for your application.</p>
</td>
<td width="20%" align="center"  valign="top">
<!--- <cfif isnumeric(#request.srr_id#) and #screen_dates.other_items_screen_dt# is not "">
<span class="green">Completed/Updated</span><br>on:#dateformat(screen_dates.other_items_screen_dt,"mm/dd/yyyy")#<br>at:#timeformat(screen_dates.other_items_screen_dt,"h:mm tt")#
<cfelse>
<span class="red">Not Completed</span>
</cfif> --->
&nbsp;
</td>
</tr>
<!-- Add Attachments -->


<cfif isnumeric(#request.srr_id#)>
<cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT * 
FROM uploads
WHERE srr_id=#request.srr_id#
</cfquery>
<cfif #uploaded_files.recordcount# is not 0>
<tr>
<td colspan="3">
<strong>Attachments:</strong><br>
<table width="100%" border="1" align="center">
<tr>
<th>Description</th>
<th>File Name</th>
<th>Date Uploaded</th>
</tr>
<cfloop query="uploaded_files">
<tr>
<td><!-- This is to handle old uploads before adding the doc_desc field -->
<cfif #doc_desc# is not "">
#doc_desc#
<cfelse>
#file_name#
</cfif>
</td>
<td>
<cfif #right(file_name,4)# is  ".pdf">
<A HREF="/docs/srr/uploads/#request.srr_id#/#file_name#">#file_name#</A>
<cfelse>
<a href="/srr/common/display_attachment.cfm?file_name=#file_name#&srr_id=#request.srr_id#&#request.addtoken#">#file_name#</a>
</cfif>
</td>
<td align="center"  valign="top">
#dateformat(Ddate_uploaded,"mm/dd/yyyy")#
</td>
</tr>
</cfloop>
</table>
</td>
</tr>
</cfif>
</cfif>






<!-- Submit Application -->
<tr>
<td width="10%" align="center"  valign="top">
<cfif isnumeric(#request.srr_id#) and #find_srr.ddate_submitted# is not "">
<img src="/common/checkmark2.png" alt="" width="40" height="40" border="0">
</cfif>
</td>
<td width="70%"><strong><li>Submit Application</li></strong>
<cfif  isnumeric(#request.srr_id#) and #find_srr.ddate_submitted# is "">
<p>Your application can be submitted only after completing all the steps above.</p>
<cfelseif not isnumeric(#request.srr_id#)>
<p>Your application can be submitted only after completing all the steps above.</p>
</cfif>
<p>Once your application is submitted, it cannot be revised.  Applicant can submit/view attachments at any time.</p>
</td>
<td width="20%" align="center" valign="top">
<cfif  isnumeric(#request.srr_id#) and #find_srr.ddate_submitted# is not "">
<span class="green">Submitted</span><br>on:#dateformat(find_srr.ddate_submitted,"mm/dd/yyyy")#<br>at:#timeformat(find_srr.ddate_submitted,"h:mm tt")#
<cfelseif isnumeric(#request.srr_id#) 
and #screen_dates.start_app_dt# is not ""
and #screen_dates.applicant_screen_dt# is not ""
and #screen_dates.job_address_screen_dt# is not ""
and #screen_dates.work_desc_screen_dt# is not ""
>


<form action="submit_application.cfm" method="post" name="form1" id="form1" target="_top">
<input type="submit" name="submit" id="submit" value="Submit" class="submit">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

</form>
<cfelse>
<input type="button" name="gsubmit" id="gsubmit" value="Submit" class="submitgray" onClick="alert('Your application can be submitted only after completing all the steps above.');">
</cfif>

</td>
</tr>

</UL>
<!-- Submit Application -->
</table>
</div>

</cfoutput>

