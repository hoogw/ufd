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
		Field: Package               DataType: String
		Field: Notice_To_Proceed_Date  DataType: Time Stamp
--->

<cfquery name="MyQuery" datasource="sidewalk">
SELECT    vwHDRAssessmentTracking.Council_District, vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Name, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Field_Assessed, vwHDRAssessmentTracking.Repairs_Required, vwHDRAssessmentTracking.Construction_Start_Date, vwHDRAssessmentTracking.Construction_Completed_Date, vwHDRAssessmentTracking.Anticipated_Completion_Date, vwHDRAssessmentTracking.Package, vwHDRWorkOrders.Notice_To_Proceed_Date
FROM      dbo.vwHDRAssessmentTracking
left outer join dbo.vwHDRWorkOrders 
on     dbo.vwHDRAssessmentTracking.Package_No = dbo.vwHDRWorkOrders.Package_No
  AND     dbo.vwHDRAssessmentTracking.Package_Group = dbo.vwHDRWorkOrders.Package_Group
ORDER BY vwHDRAssessmentTracking.Council_District, vwHDRAssessmentTracking.Location_No
</cfquery>

<cfreport template="Councils.cfr" format="pdf" query="MyQuery"/>