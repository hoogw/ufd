<cfinclude template="../common/validate_srrKey.cfm">
<cfparam name="attributes.width" default="350px">

<style>
.data {
color:maroon;
font-weight:normal;
}
</style>

<cfquery name="CommentsModule" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id

      ,[bpw1_ownership_comments]
      ,[bpw1_tax_comments]
      ,[bpw1_comments_to_app]

, srr_info.bpw1_internal_comments
, srr_info.bpw2_internal_comments

, srr_info.bca_comments
, srr_info.bss_comments

, srr_info.boe_invest_comments
, srr_info.boe_invest_response_to_app

, srr_info.paymentIncompleteReasons

, srr_info.gis_comments

FROM  dbo.srr_info
			   
where 
srr_info.srrKey = '#attributes.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>

<cfoutput>
<div class="formbox" style="width:#attributes.width#;margin-left:auto;margin-right:auto;">
<h1>Comments:</h1>


<cfif #trim(CommentsModule.bpw1_ownership_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Ownership Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_ownership_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_tax_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Tax Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_tax_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_comments_to_app)# is not "">
<div align="left">
<span class="data"><strong>BPW Comments to Applicant:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_comments_to_app#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Internal Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.bca_comments)# is not "">
<div align="left">
<span class="data"><strong>BCA Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bca_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.bss_comments)# is not "">
<div align="left">
<span class="data"><strong>BSS Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bss_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.boe_invest_comments)# is not "">
<div align="left">
<span class="data"><strong>BOE Investigation Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.boe_invest_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw2_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Internal Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw2_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.paymentIncompleteReasons)# is not "">
<div align="left">
<span class="data"><strong>BPW Payment Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.paymentIncompleteReasons#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>




<cfquery name="getAppeal" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.appealReason.appealDesc
, dbo.appealReason.suspend
, dbo.appeals.appealDate
, dbo.appeals.appealReason
, dbo.appeals.appealCommentsApp
, dbo.appeals.appealDecision
, dbo.appeals.appealDecisionComments
, dbo.appeals.appealDecision_dt
, dbo.appeals.appealDecision_by
, dbo.srr_info.srr_status_cd
,  dbo.srr_status.srr_status_desc


FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd RIGHT OUTER JOIN
               dbo.staff RIGHT OUTER JOIN
               dbo.appeals ON dbo.staff.user_id = dbo.appeals.appealDecision_by LEFT OUTER JOIN
               dbo.appealReason ON dbo.appeals.appealReason = dbo.appealReason.appealReason ON dbo.srr_info.srr_id = dbo.appeals.srr_id
			   

where 
srr_info.srrKey = '#attributes.srrKey#'
</cfquery>

<cfloop query="getAppeal">
<cfif #getAppeal.appealDesc# is not "">
<p><span class="data">
<strong>Appealed on:</strong> #dateformat(getAppeal.appealDate,"mm/dd/yyyy")#<br>
<strong>Appeal Desc.:</strong> #getAppeal.appealDesc#<br>
<strong>Applicant Comments:</strong> #getAppeal.appealCommentsApp#<br>

<strong>BOE's Decision:</strong> <cfif #getAppeal.appealDecision# is "a">Approved<cfelseif #getAppeal.appealDecision# is "d">Denied</cfif><br>
<strong>BOE's Appeal Comments:</strong> #getAppeal.appealDecisionComments#<br>
</span>
</p>
</cfif>
</cfloop>

</div>
</cfoutput>
