<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="reasons" datasource="#request.dsn#" dbtype="datasource">
SELECT 
bpw1_tax_comments
, bpw1_comments_to_app
, bpw1_ownership_comments
FROM  dbo.srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<br>

<cfoutput>
<div class="textbox" style="width:730px;">
<h1>Reasons:</h1>
<p>Your application has been deemed incomplete for the following reasons:</p>
<cfif #reasons.bpw1_ownership_comments# is not "">
<p class="data"><strong>#reasons.bpw1_ownership_comments#</strong></p>
</cfif>

<cfif #reasons.bpw1_tax_comments# is not "">
<p class="data"><strong>#reasons.bpw1_tax_comments#</strong></p>
</cfif>

<cfif #reasons.bpw1_comments_to_app# is not "">
<p class="data"><strong>#reasons.bpw1_comments_to_app#</strong></p>
</cfif>

<p>You may use the Add Attachment button to submit documents, except for the IRS W-9 Form or any documents that contain sensitive information such as social security number(s).</p>

</div>

<div align="center"><input type="button" name="addAttachment" id="addAttachment" value="Add Attachment" class="submit"  onClick="location.href='uploadfile1.cfm?srrKey=#request.srrKey#'"></div>
</div>
</cfoutput> 


<cfinclude template="../common/footer.cfm">