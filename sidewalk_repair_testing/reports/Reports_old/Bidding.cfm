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
	Bidding.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Type                  DataType: String
		Field: Priority_No           DataType: Integer
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
		Field: BID_UNIT              DataType: String
		Field: UOM                   DataType: String
		Field: QUANTITY              DataType: Integer
		Field: U_PRICE               DataType: Big Decimal
		Field: DISPLAY_ORDER         DataType: Integer
		Field: Work_Order            DataType: String
		Field: Name                  DataType: String
		Field: Creation_Date         DataType: Time Stamp
		Field: CONTINGENCY           DataType: Big Decimal
		Field: CONTINGENCY_PERCENT   DataType: Float
		Field: ENGINEERS_ESTIMATE_TOTAL_COST  DataType: Big Decimal
		Field: rowid                 DataType: Long
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Address, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Priority_No, vwHDRWorkOrders.Package, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Package_Group, vwUgly.BID_UNIT, vwUgly.UOM, vwUgly.QUANTITY, vwUgly.U_PRICE, vwUgly.DISPLAY_ORDER, vwHDRWorkOrders.Work_Order, vwHDRAssessmentTracking.Name, vwHDREngineeringEstimate.Creation_Date, vwHDREngineeringEstimate.CONTINGENCY, vwHDREngineeringEstimate.CONTINGENCY_PERCENT, vwHDREngineeringEstimate.ENGINEERS_ESTIMATE_TOTAL_COST,
	
	row_number() over ( partition by vwUgly.Location_No order by vwUgly.DISPLAY_ORDER ) as 'rowid'
	
	FROM      dbo.vwHDRWorkOrders, dbo.vwHDRAssessmentTracking, dbo.vwUgly, dbo.vwHDREngineeringEstimate 
	WHERE     dbo.vwHDRWorkOrders.Package = dbo.vwHDRAssessmentTracking.Package
	  AND     dbo.vwHDRAssessmentTracking.Location_No = dbo.vwUgly.Location_No
	  AND     dbo.vwHDRAssessmentTracking.Location_No = dbo.vwHDREngineeringEstimate.Location_No
	  AND     (vwHDRWorkOrders.Package = '#URL.my_package#')
	ORDER BY vwHDRAssessmentTracking.Package_Group, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Location_No, vwUgly.DISPLAY_ORDER
</cfquery>

<cfheader name="Content-Disposition" value="inline; filename=Bid.pdf" >
<cfreport template="Bidding.cfr" format="pdf" query="MyQuery">
	<cfreportparam name="my_package" value="#URL.my_package#"> <!-- String -->
</cfreport>

