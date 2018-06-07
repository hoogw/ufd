<cfinclude template="/srr/common/validate_srrKey.cfm">


<!--- <cfoutput>#request.srrkey#</cfoutput> --->
<!--- <cfoutput>#client.staff_user_id#, #now()#</cfoutput>
 --->

 <cfquery name="up_mark_completed" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
lgd_completed_dt = #now()#
,lgd_completed_by = #client.staff_user_id#
where
srrkey = '#srrkey#'
</cfquery>

<div class="warning">Status is Updated Successfully</div>
<div align="center">
<!---<input type="submit" name="submit" value=" Next &gt;&gt; " class = "submit">--->
<input type="button" name="Back_to_Unprocessed" id="Back_to_unprocessed" value="Back To Unprocessed" class="submit" onClick="location.href = 'control.cfm?action=view_unprocessed&#request.addtoken#'">
</div>

