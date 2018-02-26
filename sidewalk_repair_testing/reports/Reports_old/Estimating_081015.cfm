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
	Estimating.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Type                  DataType: String
		Field: Priority_No           DataType: Integer
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Address, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Priority_No, vwHDRWorkOrders.Package, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Package_Group
	FROM      dbo.vwHDRWorkOrders, dbo.vwHDRAssessmentTracking 
	WHERE     dbo.vwHDRWorkOrders.Package = dbo.vwHDRAssessmentTracking.Package
	ORDER BY vwHDRAssessmentTracking.Package_Group, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Location_No
</cfquery>

<cfreport template="Estimating.cfr" format="pdf" query="MyQuery"/>