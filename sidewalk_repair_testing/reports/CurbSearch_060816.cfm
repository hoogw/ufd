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
<!--- <cfif session.user_level lt 2>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<!---
	SiteSearch.cfr expects the query passed into it to contain the following column names:
		Field: Ramp No           					DataType: Integer
		Field: Name                  				DataType: String
		Field: Location No           				DataType: Integer
		Field: Intersection Corner     				DataType: String
		Field: Primary Street  		 				DataType: String
		Field: Secondary Street		 				DataType: String
		Field: Construction_Start_Date  			DataType: Time Stamp
		Field: Priority No           				DataType: Integer
		Field: Type Description        				DataType: String
--->

<cfquery name="ReportQuery" dbtype="query">
SELECT ramp_no,council_district, location_no,intersection_corner,primary_street,secondary_street,construction_completed_date,
designed_by,priority_no,type_description as type FROM session.curbQuery
</cfquery>

<cfreport template="CurbSearch.cfr" format="pdf" query="ReportQuery"/>