<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select 
srr_id
, srrKey
, offerMade_dt 
, offerMade_exp_dt


from srr_info
where srrKey = '#request.srrKey#'

</cfquery>

<cfoutput>

<div class="warning">
This offer is valid until #dateformat(find_srr.offerMade_exp_dt,"mm/dd/yyyy")#
</div>

<!--- <div class="notes">
<strong>Programming Notes:</strong>
<br><br>
Nightly script should check offer date and offer expiration date.<br><br>
Send Resolution Code "EX" to 311 once offers expires (EX will set final status to Canceled).
</div> --->
</cfoutput>

<cfinclude template="../common/footer.cfm">