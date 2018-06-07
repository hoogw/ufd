<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">

<cfif not isdefined("request.srrKey") or len(#request.srrKey#) is not 50>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!--- <cfoutput>
select * 
from srr_info
where 
srrKey = '#request.srrKey#'
</cfoutput>
 --->
<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
select * from srr_info
where 
srrKey = '#request.srrKey#'
</cfquery>

<cfif #getSrr.recordcount# is 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfabort>
</cfif>



<cfoutput>
<div class="textbox" style="width:730px;">
<h1>Service Request Number: #getSrr.sr_number#</h1>

<div class="subtitle">Thank you for submitting the required documents</div>


<br>
<p>
You can check the status of your request by<br>
1.	Visiting <a href="http://myla311.lacity.org" target="_blank">http://myla311.lacity.org</a> <br>
2.	Using the mobile app from <a href="https://play.google.com/store/apps/details?id=com.LA.MyLA311&hl=en" target="_blank">Google Play</a> or the <a href="https://itunes.apple.com/us/app/myla311/id611079486" target="_blank">Apple Store</a><br>
3.	Contacting MyLA311 with your Service Request number (see below for numbers)<br>
<br><br>
Within City of Los Angeles, dial 311<br>
Outside the greater Los Angeles area, dial (213) 473-3231<br>
For the hearing impaired, dial TDD Number (213) 473-5990<br>
The 311 Call Center operating hours are 8:00 am - 4:45 pm daily including weekends and all holidays except Thanksgiving Day and Christmas Day.
</p>


<p>For more information on the Sidewalk Program, go to: <a href="http://sidewalks.lacity.org" target="_blank">sidewalks.lacity.org</a></p>



</div>
</cfoutput>


