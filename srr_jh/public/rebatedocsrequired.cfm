<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select 
srr_id
, srrKey
, paymentIncompleteReasons

from srr_info
where srrKey = '#request.srrKey#'

</cfquery>

<br>
<cfoutput>
<div class="textbox" style="width:730px;">
<h1>Comments:</h1>
<cfif #trim(find_srr.paymentIncompleteReasons)# is not "">
<div align="left">
<span class="data"><strong>Rebate Comments:</strong></span>
<cfloop index="xx" list="#find_srr.paymentIncompleteReasons#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>

<p>You can download W9 Form from the IRS site at: <a href="https://www.irs.gov/pub/irs-pdf/fw9.pdf" target="_blank">W9 form</a></p>

<p>You may use the Add Attachment button to submit documents, except W9 form or any documents that contain sensitive information such as social security number(s).</p>

</div>

<div align="center"><input type="button" name="addAttachment" id="addAttachment" value="Add Attachment" class="submit"  onClick="window.location.href='uploadfile1.cfm?srrKey=#request.srrKey#'"></div>
</cfoutput>

<cfinclude template="../common/footer.cfm">