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
	TreeTracking_Planned.cfr expects the query passed into it to contain the following column names:
		Field: Package               DataType: String
		Field: Council_District      DataType: Integer
		Field: Name                  DataType: String
		Field: rs                    DataType: String
		Field: Address               DataType: String
		Field: ts                    DataType: String
		Field: tb                    DataType: String
		Field: loc                   DataType: Integer
		Field: ta                    DataType: String
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
	from goodtree g
	inner join vwHDRAssessmentTracking a on g.Location_No = a.Location_No
	inner join vwHDRWorkOrders w on a.Package = w.Package
	where w.Notice_To_Proceed_Date is not null
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
removal ( r, c, loc, species ) as (
	select ROW_NUMBER() over ( partition by t.location_no order by species ), count(*), t.Location_No, SPECIES
	from goodtree t
	left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
	where ACTION_TYPE = 'Removal' and TREE_REMOVAL_DATE is null 
	group by t.Location_No, SPECIES
),
planting ( r, c, loc, a, species, box ) as (
	select ROW_NUMBER() over ( partition by t.location_no order by species ), count(*), t.Location_No, t.Address, SPECIES, t.TREE_BOX_SIZE
	from goodtree t
	left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
	where ACTION_TYPE = 'Planting' and TREE_PLANTING_DATE is null 
	group by t.Location_No, t.Address, SPECIES, t.TREE_BOX_SIZE
), 
grouped ( loc, rs, rtot, ts, ttot, tb, ta, d ) as (
	select coalesce( r.loc, t.loc), '(' + cast(r.c as varchar) + ') ' + r.species 'rs', coalesce( r.c,0), '(' + cast( t.c as varchar) + ') ' + t.species 'ts', coalesce(t.c,0), t.box 'tb', t.a 'ta'
	, 'dummy'
	from removal r 
	full outer join planting t on r.loc = t.loc and r.r = t.r
)select 
w.Package, a.Council_District, a.Name, a.Address, g.*, grand.*
from grouped g
left join vwHDRAssessmentTracking a on g.loc = a.Location_No
left join vwHDRWorkOrders w on a.Package = w.Package
inner join grand on g.d = grand.d
where g.ts is not null or g.rs is not null
order by w.Package_group desc, w.Package_No, g.loc
</cfquery>


<cfreport template="TreeTracking_Planned.cfr" format="pdf" query="ReportQuery"/>
