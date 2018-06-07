<cfset request.dsn= "mhpermits">
<cfset request.revenue_distribution= "revenue_distribution">
<cfset request.fund_lookup= "fund_lookup">
<cfset request.cc_dsn="cc_transactions">
<cfset request.cc_table="boe_cc_transactions">
<cfset request.permit_code= "mh">
<cfset request.ccform="https://dpwpay.lacity.org/vm/index.cfm">

<cfset request.production=1>

<cfif #request.production# is 1>
<cfset request.permit_code = "mh">
<cfset request.permit_server="https://engpermits.lacity.org">
<cfset request.app_url="https://engpermits.lacity.org/mhpermits">
<cfset request.upload_location="https://engpermits.lacity.org/docs/mhpermits">
<cfset request.cc_public_return_url="https://engpermits.lacity.org/mhpermits/public/go_menu_cc.cfm">

<cfelse>

<cfset request.permit_code = "mh">
<cfset request.permit_server="http://localhost">
<cfset request.app_url="http://localhost/mhpermits">
<cfset request.upload_location="http://localhost/docs/mhpermits">
<cfset request.cc_public_return_url="http://localhost/mhpermits/public/go_menu_cc.cfm">
</cfif>


<cfset request.boe_max_rows = 100>
<cfset request.drive_letter = "#left(CF_TEMPLATE_PATH, 3)#">
<cfset request.upload_dir="#request.drive_letter#"&"docs"&"\"&"mhpermits">

<cfset request.pdfConverter = "d:\htmldoc23\htmldoc.exe">
<cfset request.PDFlocation = "d:\docs\temppdfs\mhpermits">
<cfset request.PDFURL = "/docs/temppdfs/mhpermits">


<!--- <cfset request.from_email="Eng.LAPermits@lacity.org"> --->
<cfset request.from_email="victor.murillo@lacity.org">
<cfset request.cc="victor.murillo@lacity.org">

<cfset request.urlkey = "laboe78">

<cfinclude template="/common/formurl2request.cfm">

<cferror type="REQUEST" template="request_error.CFM" mailto="victor.murillo@lacity.org">
<cferror type="VALIDATION" template="validation_error.cfm" mailto="victor.murillo@lacity.org">
<cferror type="EXCEPTION" template="request_error.cfm" mailto="victor.murillo@lacity.org"> 