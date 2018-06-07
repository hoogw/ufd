<cfinclude template="/accessprogram/common/validate_arkey.cfm">

<!--- <cfoutput>#request.srrkey#</cfoutput> --->
<!--- <cfoutput>#client.staff_user_id#, #now()#</cfoutput>
 --->
<!---  <cfabort> --->

 <cfquery name="up_mark_completed" datasource="#request.dsn#" dbtype="datasource">
update ar_info
set
lgd_completed_dt = #now()#
,lgd_completed_by = #client.staff_user_id#
where
arkey = '#arkey#'
</cfquery>

 <div class="warning">Status is Updated Successfully</div>
<div align="center">
<!---<input type="submit" name="submit" value=" Next &gt;&gt; " class = "submit">--->
<input type="button" name="Back_to_Unprocessed" id="Back_to_unprocessed" value="Back To Unprocessed" class="submit" onClick="location.href = 'control.cfm?action=view_unprocessed&#request.addtoken#'">
</div>
