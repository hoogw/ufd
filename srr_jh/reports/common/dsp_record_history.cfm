<cfinclude template="/common/validate_referer.cfm">
<cfinclude template="/common/validate_ref_no.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<cfoutput>


<cfquery name="get_history" datasource="#request.dsn#" dbtype="datasource">
select record_history from permit_info
where ref_no=#request.ref_no#
</cfquery>


<cfset request.tab_title="Record History">
<CFINCLUDE TEMPLATE="/styles/tabbed_container_top_730.cfm">

<cfset request.record_history=#get_history.record_history#>

<DIV ALIGN="center">
<TABLE WIDTH="730" BORDER="0" ALIGN="center">
<TR>
<TD>#request.record_history#</TD>
</TR>
</TABLE>
</DIV>
<CFINCLUDE TEMPLATE="/styles/tabbed_container_bottom.cfm">

</cfoutput>
