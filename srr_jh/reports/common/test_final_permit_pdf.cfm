<cfinclude template="/common/validate_referer.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfpdf action="addWatermark" text="<b>TOP SECRET!</b>" source="final_permit_pdf.cfm" foreground="true">

<cfheader name="content-disposition" value="attachment; filename=""test.pdf"""/>
<cfcontent type="application/pdf" variable="#toBinary(final_permit_pdf.cfm)#">

</body>
</html>
