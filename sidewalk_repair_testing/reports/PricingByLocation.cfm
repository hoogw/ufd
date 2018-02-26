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
	PricingByLocation.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Type                  DataType: String
		Field: Priority_No           DataType: Integer
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
		Field: Work_Order            DataType: String
		Field: Name                  DataType: String
		Field: CONTINGENCY           DataType: Float
		Field: CONTINGENCY_PERCENT   DataType: Float
		Field: ENGINEERS_ESTIMATE_TOTAL_COST  DataType: Float
		Field: BID_UNIT              DataType: String
		Field: UOM                   DataType: String
		Field: QUANTITY              DataType: Integer
		Field: U_PRICE               DataType: Big Decimal
		Field: DISPLAY_ORDER         DataType: Integer
		Field: CONTRACTORS_COST      DataType: Big Decimal
		Field: Item_TOTAL            DataType: Big Decimal
		Field: rowid                 DataType: Long
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    a.Location_No, a.Address, a.Type, a.Priority_No, wo.Package, a.Package_No, a.Package_Group, wo.Work_Order, a.Name, e.CONTINGENCY, e.CONTINGENCY_PERCENT, e.ENGINEERS_ESTIMATE_TOTAL_COST, p.BID_UNIT, p.UOM, p.QUANTITY, p.U_PRICE, p.DISPLAY_ORDER, cp.CONTRACTORS_COST,
	
	COALESCE( p.QUANTITY * p.U_PRICE, 0 ) as 'Item_TOTAL',
	row_number() over ( partition by p.Location_No order by p.DISPLAY_ORDER ) as 'rowid'
	
	FROM      dbo.vwHDRWorkOrders AS wo, dbo.vwHDRAssessmentTracking AS a, dbo.vwHDREngineeringEstimate AS e, dbo.vwHDR_RPT_Pricing AS p, dbo.vwHDRContractorPricing AS cp 
	WHERE     wo.Package = a.Package
	  AND     a.Location_No = e.Location_No
	  AND     a.Location_No = p.Location_No
	  AND     a.Location_No = cp.Location_No
	  AND p.QUANTITY > 0
	  AND     (a.Location_No = <cfqueryparam value="#URL.my_loc#" cfsqltype="CF_SQL_INTEGER" >)
	ORDER BY a.Package_Group, a.Package_No, a.Location_No, p.DISPLAY_ORDER
</cfquery>

<cfreport template="PricingByLocation.cfr" format="pdf" query="MyQuery">
	<cfreportparam name="my_loc" value="#URL.my_loc#"> <!-- Integer -->
</cfreport>