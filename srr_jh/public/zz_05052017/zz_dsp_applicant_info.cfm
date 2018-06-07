<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->
<cfinclude template="/srr/common/dsp_applicant_info.cfm">

<cfoutput>
<div align="center">
<input type="button" name="back" id="back" value="Back" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'">
</div>
</cfoutput>