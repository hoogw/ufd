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
	TreeTracking.cfr expects the query passed into it to contain the following column names:
		Field: Package               DataType: String
		Field: Council_District      DataType: Integer
		Field: Name                  DataType: String
		Field: rd                    DataType: Date
		Field: rc                    DataType: String
		Field: rs                    DataType: String
		Field: Address               DataType: String
		Field: ts                    DataType: String
		Field: tb                    DataType: String
		Field: td                    DataType: Date
		Field: tc                    DataType: String
		Field: loc                   DataType: Integer
		Field: ta                    DataType: String
		Field: watering_start        DataType: Date
		Field: watering_end          DataType: Date
		Field: TREE_REMOVAL_NOTES    DataType: String
		Field: rtot                  DataType: Integer
		Field: ttot                  DataType: Integer
		Field: gtot_r                DataType: Integer
		Field: gtot_pr               DataType: Integer
		Field: gtot_p                DataType: Integer
		Field: gtot_pp               DataType: Integer
--->

<cfquery name="ReportQuery" datasource="sidewalk">
with goodtree( Location_No, TREE_REMOVAL_DATE, SPECIES, TREE_PLANTING_DATE, START_WATERING_DATE, END_WATERING_DATE, ACTION_TYPE, ADDRESS, TREE_BOX_SIZE   ) as (
	select Location_No, TREE_REMOVAL_DATE, SPECIES, TREE_PLANTING_DATE, START_WATERING_DATE, END_WATERING_DATE, ACTION_TYPE, ADDRESS, TREE_BOX_SIZE 
	from vwHDRTreeList
	where [TYPE] = 'BSS' and DELETED = 0
),
label ( gtot_r, gtot_pr, gtot_p, gtot_pp ) as (
select
	case when ACTION_TYPE = 'Removal' AND TREE_REMOVAL_DATE is not null then 1 else 0 end,
	case when ACTION_TYPE = 'Removal' AND TREE_REMOVAL_DATE is null then 1 else 0 end,
	case when ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is not null then 1 else 0 end,
	case when ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is null then 1 else 0 end
	from goodtree
),
grand ( d, gtot_r, gtot_pr, gtot_p, gtot_pp ) as (
select 
	'dummy',
	sum( gtot_r ) 'Total Removed',
	sum( gtot_pr ) 'Total Planned Removal',
	sum( gtot_p ) 'Total Planted',
	sum( gtot_pp ) 'Total Planned Planting'
	from label
),
removal ( r, c, loc, date, species, contractor, notes ) as (
	select ROW_NUMBER() over ( partition by t.location_no order by tree_removal_date, species ), count(*), t.Location_No, TREE_REMOVAL_DATE, SPECIES, i.TREE_REMOVAL_CONTRACTOR, i.TREE_REMOVAL_NOTES
	from goodtree t
	left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
	where ACTION_TYPE = 'Removal' and TREE_REMOVAL_DATE is not null 
	group by t.Location_No, TREE_REMOVAL_DATE, SPECIES, i.TREE_REMOVAL_CONTRACTOR, i.TREE_REMOVAL_NOTES
),
planting ( r, c, loc, a, date, species, box, contractor, watering_start, watering_end ) as (
	select ROW_NUMBER() over ( partition by t.location_no order by tree_planting_date, species ), count(*), t.Location_No, t.Address, TREE_PLANTING_DATE, SPECIES, t.TREE_BOX_SIZE, i.TREE_PLANTING_CONTRACTOR, t.START_WATERING_DATE, t.END_WATERING_DATE
	from goodtree t
	left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
	where ACTION_TYPE = 'Planting' and TREE_PLANTING_DATE is not null 
	group by t.Location_No, t.Address, TREE_PLANTING_DATE, SPECIES, t.TREE_BOX_SIZE, i.TREE_PLANTING_CONTRACTOR, t.START_WATERING_DATE, t.END_WATERING_DATE
), 
grouped ( loc, rd, rs, rc, rtot, td, ts, ttot, tb, tc, ta, watering_start, watering_end, d ) as (
	select coalesce( r.loc, t.loc), r.date 'rd', '(' + cast(r.c as varchar) + ') ' + r.species 'rs', r.contractor 'rc', coalesce( r.c,0), t.date 'td', '(' + cast( t.c as varchar) + ') ' + t.species 'ts', coalesce(t.c,0), t.box 'tb', t.contractor 'tc', t.a 'ta', t.watering_start, t.watering_end
	, 'dummy'
	from removal r 
	full outer join planting t on r.loc = t.loc and r.r = t.r
)
select 
w.Package, a.Council_District, a.Name, a.Address, i.TREE_REMOVAL_NOTES, g.*, grand.*
from grouped g
left join vwHDRTreeSiteInfo i on g.loc = i.Location_No
inner join vwHDRAssessmentTracking a on g.loc = a.Location_No
inner join vwHDRWorkOrders w on a.Work_Order = w.Work_Order
inner join grand on grand.d = g.d
order by w.Package_group desc, w.Package_No, g.loc
</cfquery>

























<cfreport template="TreeTracking.cfr" format="pdf" query="ReportQuery"/>