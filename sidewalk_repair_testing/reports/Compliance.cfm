<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=6");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<!---
	Compliance.cfr expects the query passed into it to contain the following column names:
		Field: coc_id                DataType: Integer
		Field: pin                   DataType: String
		Field: pind                  DataType: String
		Field: address               DataType: String
		Field: apn                   DataType: String
		Field: Warranty_Code         DataType: String
		Field: Code                  DataType: String
		Field: issuance_dt           DataType: Time Stamp
		Field: warranty_start_dt     DataType: Time Stamp
		Field: warranty_end_dt       DataType: Time Stamp
		Field: location_no           DataType: Integer
--->

<cfset end_date = DateAdd("d", 1, Now()) />
<cfparam name="report_start_date" type="date" default="2000-01-01" />
<cfparam name="report_end_date" type="date" default=#end_date# />

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    *
	FROM      dbo.vwHDRCertificates
	WHERE 	[issuance_dt] BETWEEN
		<cfqueryparam value=#report_start_date# CFSQLTYPE="CF_SQL_DATE" /> AND
		<cfqueryparam value=#report_end_date# CFSQLTYPE="CF_SQL_DATE" /> 
	ORDER BY [apn]
</cfquery>

<cfreport template="Compliance.cfr" format="pdf" query="MyQuery"/>