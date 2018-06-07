<cfinclude template="../common/validate_srrKey.cfm">
<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/include_sr_job_address.cfm">


<cfquery name="reasons" datasource="#request.dsn#" dbtype="datasource">
SELECT 
bpw1_tax_comments
, bpw1_comments_to_app
, bpw1_ownership_comments
, boe_invest_response_to_app
FROM  dbo.srr_info
where srrKey = '#request.srrKey#'
</cfquery>


<br>
<cfoutput>
<div class="textbox" style="width:730px;">
<h1>Reasons:</h1>
<p>Your application has been deemed ineligible for the Sidewalk Rebate Program for the following reasons:</p>


<cfif #trim(reasons.bpw1_ownership_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Ownership Comments:</strong></span>
<cfloop index="xx" list="#reasons.bpw1_ownership_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(reasons.bpw1_tax_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Tax Comments:</strong></span>
<cfloop index="xx" list="#reasons.bpw1_tax_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(reasons.bpw1_comments_to_app)# is not "">
<div align="left">
<span class="data"><strong>BPW General Comments:</strong></span>
<cfloop index="xx" list="#reasons.bpw1_comments_to_app#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #reasons.boe_invest_response_to_app# is not "">
<div align="left">
<span class="data"><strong>Engineering Comments:</strong></span>
<p class="data"><strong>#reasons.boe_invest_response_to_app#</strong></p>
</div>
</cfif>

</div>

</cfoutput> 

<cfinclude template="../common/footer.cfm">