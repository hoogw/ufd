<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">

<cfinclude template="../common/validate_srrKey.cfm">

<div class="warning">
Are you sure you want to decline this offer?
<br><br>
By declining this offer, you will lose your place in line and you will have to start a new application if you decide to participate in the Sidewalk Repair Rebate Program
</div>

<cfoutput>
<div align="center">
<input type="button" name="yes" id="yes" value="Yes" class="submit" onClick="location.href='offer_declined.cfm?srrKey=#request.srrKey#&#request.addtoken#'"> &nbsp;&nbsp;
<input type="button" name="no" id="no" value="No" class="submit" onClick="location.href='offer_to_applicant.cfm?srrKey=#request.srrKey#&#request.addtoken#'"> 
 &nbsp;&nbsp;
<input type="button" name="later" id="later" value="I will Decide Later" class="submit" onClick="location.href='offer_later.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>

<cfinclude template="../common/footer.cfm">