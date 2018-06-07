<cfinclude template="../common/validate_arKey.cfm">
<cfparam name="attributes.width" default="350px">

<style>
.data {
color:maroon;
font-weight:normal;
}
</style>

<cfquery name="getAR" datasource="#request.dsn#" dbtype="datasource">
SELECT arKey, dod_loc_comments, dod_internal_comments, spd_internal_comments, ufd_internal_comments, bss_internal_comments, boe_invest_comments
from ar_info
where arKey='#request.arKey#'
</cfquery>





<div class="formbox" style="width:#attributes.width#;margin-left:auto;margin-right:auto;">
<h1>Comments:</h1>

<cfif #trim(getAR.dod_loc_comments)# is not "">
<div align="left">
<span class="data"><strong>Dept. on Disability Location Comments:</strong></span>
<cfloop index="xx" list="#getAR.dod_loc_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
<hr><br>
</cfif>



<cfif #trim(getAR.dod_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>Dept. on Disability Comments:</strong></span>
<cfloop index="xx" list="#getAR.dod_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
<hr><br>
</cfif>



<cfif #trim(getAR.spd_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>Special Projects Div. Comments:</strong></span>
<cfloop index="xx" list="#getAR.spd_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
<hr><br>
</cfif>


<cfif #trim(getAR.ufd_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>Urban Forestry Div. Comments:</strong></span>
<cfloop index="xx" list="#getAR.ufd_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
<hr><br>
</cfif>

<cfif #trim(getAR.bss_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>BSS Comments:</strong></span>
<cfloop index="xx" list="#getAR.bss_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
<hr><br>
</cfif>

<cfif #trim(getAR.boe_invest_comments)# is not "">
<div align="left">
<span class="data"><strong>BOE Investigation Comments:</strong></span>
<cfloop index="xx" list="#getAR.boe_invest_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



