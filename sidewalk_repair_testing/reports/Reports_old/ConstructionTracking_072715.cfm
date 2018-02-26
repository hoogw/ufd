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
	ConstructionTracking.cfr expects the query passed into it to contain the following column names:
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
		Field: Engineers_Estimate    DataType: Big Decimal
		Field: Work_Order            DataType: String
		Field: NFB_Date              DataType: Time Stamp
		Field: Bids_Due_Date         DataType: Time Stamp
		Field: Construct_Order_Date  DataType: Time Stamp
		Field: Precon_Meeting_Date   DataType: Time Stamp
		Field: Notice_To_Proceed_Date  DataType: Time Stamp
		Field: Awarded_Bid           DataType: Big Decimal
		Field: Contractor            DataType: String
		Field: Notes                 DataType: String
		Field: Location_No           DataType: Integer
		Field: Name                  DataType: String
		Field: Council_District      DataType: Integer
		Field: Construction_Start_Date  DataType: Time Stamp
		Field: Construction_Completed_Date  DataType: Time Stamp
		Field: 4_INCH_SIDEWALK_QUANTITY  DataType: Integer
		Field: 6_INCH_DRIVEWAY_AND_SIDEWALK_QUANTITY  DataType: Integer
		Field: 8_INCH_DRIVEWAY_AND_SIDEWALK_HIGH_EARLY_STRENGTH_QUANTITY  DataType: Integer
--->

<cfquery name="MyQuery" datasource="sidewalk_spatial">
	SELECT    wo.Package, a.Package_No, wo.Package_Group, wo.Engineers_Estimate, wo.Work_Order, wo.NFB_Date, wo.Bids_Due_Date, wo.Construct_Order_Date, wo.Precon_Meeting_Date, wo.Notice_To_Proceed_Date, wo.Awarded_Bid, wo.Contractor, wo.Notes, a.Location_No, a.Name, a.Council_District, a.Construction_Start_Date, a.Construction_Completed_Date, e.[4_INCH_SIDEWALK_QUANTITY], e.[6_INCH_DRIVEWAY_AND_SIDEWALK_QUANTITY], e.[8_INCH_DRIVEWAY_AND_SIDEWALK_HIGH_EARLY_STRENGTH_QUANTITY]
	FROM      dbo.vwHDRWorkOrders AS wo, dbo.vwHDRAssessmentTracking AS a, dbo.vwHDREngineeringEstimate AS e 
	WHERE     wo.Package = a.Package
	  AND     a.Location_No = e.Location_No
	ORDER BY wo.Package_Group, a.Package_No, a.Location_No
</cfquery>

<cfreport template="ConstructionTracking.cfr" format="pdf" query="MyQuery"/>