<!---
	FinalQuantities.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Package               DataType: String
		Field: Work_Order            DataType: String
		Field: Name                  DataType: String
		Field: BID_UNIT              DataType: String
		Field: UOM                   DataType: String
		Field: DISPLAY_ORDER         DataType: Integer
		Field: rowid                 DataType: Long
--->

<cfquery name="ReportQuery" datasource="sidewalk">
with wo( Location_no, Package, Work_Order, Name, [Address] ) as (
	select Location_no, Package, Work_Order, Name, [Address]
	from vwHDRAssessmentTracking a
	where Package = '#URL.my_package#'
),
bids( Location_No, Bid_Unit, UOM, DiSPLAY_ORDER, dummy ) as (
	select p.Location_No, p.BID_UNIT, p.UOM, p.DISPLAY_ORDER, DENSE_RANK() over( order by p.DISPLAY_ORDER)
	from wo
	inner join vwHDR_RPT_Pricing p on wo.Location_no = p.Location_No
	where p.QUANTITY > 0
),
idiot( d ) as (
select 1
union all
select 1
union all
select 1
union all
select 1
union all
select 1
union all
select 1
union all
select 1
),
blanks (Location_No, Bid_Unit, UOM, DISPLAY_ORDER ) as (
select Location_No, Bid_Unit, UOM, DiSPLAY_ORDER from bids
union all
select Location_No, '', '', 1000
from bids
inner join idiot on bids.dummy = idiot.d
)
select wo.Location_no, wo.Package, wo.Work_Order, wo.Name, wo.Address, bs.Bid_Unit, bs.UOM, bs.DISPLAY_ORDER
	, row_number() over ( partition by bs.Location_No order by bs.DISPLAY_ORDER ) as 'rowid'
from wo
inner join blanks bs on wo.Location_no = bs.Location_No

</cfquery>


<cfreport template="FinalQuantities.cfr" format="pdf" query="ReportQuery">
	<cfreportparam name="my_package" value="#URL.my_package#"> <!-- String -->
</cfreport>