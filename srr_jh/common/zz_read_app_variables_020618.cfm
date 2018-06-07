<cfset request.drive_letter = "#left(CF_TEMPLATE_PATH, 3)#">

<cfset request.dsn="srr">
<cfset request.from_email="Eng.LAPermits@lacity.org">

<cfset request.drive_letter = "#left(CF_TEMPLATE_PATH, 3)#">
<cfset request.upload_dir="#request.drive_letter#"&"docs"&"\"&"srr"&"\"&"uploads">

<cfset request.upload_location="/docs/srr">

<!--- <cfset request.myLA311Root = "https://myla311test.lacity.org"> --->



<cfset request.production = "t">
<!--- <cfset request.proxy = "y"> ---><!--- set to "n" if production, set to y if running on ".169" or localhost at work.  set to "n" if running at home --->

<cfif #request.production# is 0>
<cfset request.serverRoot = "http://localhost">
<cfset request.myLA311Root = "https://myla311test.lacity.org">
<cfset request.proxy = "y">

<cfelseif #request.production# is "t">
<cfset request.serverRoot = "http://10.78.5.169">
<cfset request.myLA311Root = "https://myla311test.lacity.org">
<cfset request.proxy = "y">

<cfelseif #request.production# is "p">
<cfset request.serverRoot = "https://engpermits.lacity.org">
<cfset request.myLA311Root = "https://myla311.lacity.org">
<cfset request.proxy = "n">

</cfif>
<!-- end of production server settings -->

<cfset request.max_rows=100>

<!--- fund and net_balance --->
<cfset request.start_balance = 906824.75> <!--- (remaining encumbrance from FY 16-17, still being used to pay for current checks) --->
<cfset request.fyAllocation = 1700000><!--- (this is the total rebate program budget for FY 17-18) --->
<!--- <cfset request.pcontingency = 5> --->
<!--- <cfset request.Council_motion_Fund_Transfer = 1180885> --->

<cfset request.contingency = 200000><!--- (this $200k is out of the $1.7M above) --->
<cfset request.net_balance = #request.start_balance# + #request.fyAllocation# - #request.contingency#>
<!--- 01/23/2017 --->
<cfset request.Program_allocation = #request.net_balance#><!--- Total Program --->

<!--- fund and net_balance --->





<CFERROR TYPE="REQUEST" TEMPLATE="/srr/common/request_error.CFM" MAILTO="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">
<CFERROR TYPE="VALIDATION" TEMPLATE="/srr/common/validation_error.cfm" MAILTO="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">
<cferror type="EXCEPTION" template="/srr/common/request_error.cfm" mailto="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">

<cfinclude template="/common/formURL2Request.cfm">


