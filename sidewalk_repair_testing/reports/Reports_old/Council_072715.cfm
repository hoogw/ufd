<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=6");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 2>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<!---
	Councils.cfr expects the query passed into it to contain the following column names:
		Field: Council_District      DataType: Integer
		Field: Location_No           DataType: Integer
		Field: Name                  DataType: String
		Field: Type                  DataType: String
		Field: Field_Assessed        DataType: String
		Field: Repairs_Required      DataType: String
		Field: Construction_Start_Date  DataType: Time Stamp
		Field: Construction_Completed_Date  DataType: Time Stamp
		Field: Anticipated_Completion_Date  DataType: Time Stamp
--->

<cfquery name="MyQuery" datasource="sidewalk_spatial">
	SELECT    Council_District, Location_No, Name, Type, Field_Assessed, Repairs_Required, Construction_Start_Date, Construction_Completed_Date, Anticipated_Completion_Date
	FROM      dbo.vwHDRAssessmentTracking 
	ORDER BY Council_District, Location_No
</cfquery>

<cfreport template="Councils.cfr" format="pdf" query="MyQuery"/>