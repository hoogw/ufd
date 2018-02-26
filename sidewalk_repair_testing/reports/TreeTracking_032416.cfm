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
--->

<cfquery name="ReportQuery" datasource="sidewalk">
with removal ( r, c, loc, date, species, contractor, notes ) as (
select ROW_NUMBER() over ( partition by t.location_no, tree_removal_date order by species ), count(*), t.Location_No, TREE_REMOVAL_DATE, SPECIES, i.TREE_REMOVAL_CONTRACTOR, i.TREE_REMOVAL_NOTES
from vwHDRTreeList t
left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
where ACTION_TYPE = 'Removal' and DELETED = 0
group by t.Location_No, TREE_REMOVAL_DATE, SPECIES, i.TREE_REMOVAL_CONTRACTOR, i.TREE_REMOVAL_NOTES
), planting ( r, c, loc, a, date, species, box, contractor, watering_start, watering_end ) as (
select ROW_NUMBER() over ( partition by t.location_no, tree_planting_date order by species ), count(*), t.Location_No, t.Address, TREE_PLANTING_DATE, SPECIES, t.TREE_BOX_SIZE, i.TREE_PLANTING_CONTRACTOR, t.START_WATERING_DATE, t.END_WATERING_DATE
from vwHDRTreeList t
left join vwHDRTreeSiteInfo i on t.Location_No = i.Location_No
where ACTION_TYPE = 'Planting' and DELETED = 0
group by t.Location_No, t.Address, TREE_PLANTING_DATE, SPECIES, t.TREE_BOX_SIZE, i.TREE_PLANTING_CONTRACTOR, t.START_WATERING_DATE, t.END_WATERING_DATE
), grouped ( loc, rd, rs, rc, td, ts, tb, tc, ta, watering_start, watering_end ) as (
select r.loc, r.date 'rd', '(' + cast(r.c as varchar) + ') ' + r.species 'rs', r.contractor 'rc', t.date 'td', '(' + cast( t.c as varchar) + ') ' + t.species 'ts', t.box 'tb', t.contractor 'tc', t.a 'ta', t.watering_start, t.watering_end
from removal r 
full outer join planting t on r.loc = t.loc and r.r = t.r
)
select w.Package, a.Council_District, a.Name, a.Address, i.TREE_REMOVAL_NOTES, g.*
from grouped g
left join vwHDRTreeSiteInfo i on g.loc = i.Location_No
inner join vwHDRAssessmentTracking a on g.loc = a.Location_No
inner join vwHDRWorkOrders w on a.Work_Order = w.Work_Order
order by w.Package, a.Council_District, a.Name
</cfquery>








<cfreport template="TreeTracking.cfr" format="pdf" query="ReportQuery"/>