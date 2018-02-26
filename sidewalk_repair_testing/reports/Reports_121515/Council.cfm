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

<cfquery name="ReportQuery" datasource="sidewalk">
SELECT    vwHDRAssessmentTracking.Council_District, vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Name, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Field_Assessed, vwHDRAssessmentTracking.Repairs_Required, vwHDRAssessmentTracking.Construction_Start_Date, vwHDRAssessmentTracking.Construction_Completed_Date, vwHDRAssessmentTracking.Anticipated_Completion_Date, vwHDRAssessmentTracking.Package, vwHDRWorkOrders.Notice_To_Proceed_Date
FROM      dbo.vwHDRAssessmentTracking
left outer join dbo.vwHDRWorkOrders 
on     dbo.vwHDRAssessmentTracking.Package_No = dbo.vwHDRWorkOrders.Package_No
  AND     dbo.vwHDRAssessmentTracking.Package_Group = dbo.vwHDRWorkOrders.Package_Group
ORDER BY vwHDRAssessmentTracking.Council_District, vwHDRAssessmentTracking.Location_No
</cfquery>


<cfif IsDefined("URL.D")>	
	<cfquery name="ReportQuery" datasource="sidewalk">		
		SELECT t.Council_District
			, t.Location_No
			, t.Name
			, t.Type
			, t.Field_Assessed
			, t.Repairs_Required
			, t.Construction_Start_Date
			, t.Construction_Completed_Date
			, t.Anticipated_Completion_Date
			, t.Package
			, o.Notice_To_Proceed_Date
		FROM  dbo.vwHDRAssessmentTracking t
			left outer join dbo.vwHDRWorkOrders o on t.Package_No = o.Package_No AND  t.Package_Group = o.Package_Group
		WHERE t.Council_District in ( <cfqueryparam value="#URL.D#" cfsqltype="cf_sql_integer" list="true" > )
		ORDER BY t.Council_District, t.Location_No		
	</cfquery>
</cfif>

<cfreport template="Councils.cfr" format="pdf" query="ReportQuery"/>