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

<!--- anticipate to be different from TreeTracking_Excel. so cannot share the same file --->

<!--- tree site info.ready_to_plant is true --->
<!--- filter by start and end dates --->

<cfparam name="planting_start" type="date" />
<cfparam name="planting_end" type="date" />

<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql("with good ( loc, group_no, tree_no, action_type ) as (
        select location_no, group_no, tree_no, action_type
        from vwHDRTreeList
        where deleted = 0 or deleted is null
    )
    , removal( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Removal'
    )
    , plant( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Planting'
    )
    , report_line ( site, line, rloc, rgroup_no, rtree_no, raction_type, tloc, tgroup_no, ttree_no, taction_type ) as (
    select coalesce(g0.loc, g1.loc) site, coalesce(g0.tree_no, g1.tree_no) line, * 
    from removal g0
    full outer join plant g1 on g0.loc = g1.loc and g0.group_no = g1.group_no and g0.tree_no = g1.tree_no
    )

    select site, line
        , c.Type, c.Subtype
        , a.Package
        , a.Location_No
        , c.Facility_Name, c.Facility_Address, a.Zip_Code
        , a.Council_District

        , a.Address
        , c.Construction_Start_Date, c.Construction_Completed_Date
        , info.ready_to_plant

        , r.TREE_NO, r.SPECIES, r.TREE_SIZE, r.PERMIT_ISSUANCE_DATE, r.TREE_REMOVAL_DATE, r.ADDRESS
            , info.TREE_REMOVAL_CONTRACTOR, info.TREE_REMOVAL_NOTES
        , t.TREE_NO, t.SPECIES, t.TREE_BOX_SIZE, t.PERMIT_ISSUANCE_DATE, t.TREE_PLANTING_DATE, t.START_WATERING_DATE, t.END_WATERING_DATE, null
            , t.ADDRESS
            , info.TREE_PLANTING_CONTRACTOR
            , info.TREE_REMOVAL_NOTES
        , coalesce(ee.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0) + coalesce(qc.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0) + coalesce(co.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0 ) root_prune
        , coalesce(ee.[EXISTING_STUMP_REMOVAL_QUANTITY],0) + coalesce(qc.[EXISTING_STUMP_REMOVAL_QUANTITY],0) + coalesce(co.[EXISTING_STUMP_REMOVAL_QUANTITY],0 )
        , coalesce(ee.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(qc.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(co.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0 ) canopy_prune
        , info.Root_Barrier_Lock 
    from report_line rl
    left join vwHDRAssessmentTracking a on rl.site = a.Location_No
    left join ( select distinct Location_No, Type, Subtype, Facility_Name, Facility_Address, Construction_Completed_Date, Construction_Start_Date FROM vwHDRCertificates ) c on rl.site = c.Location_No
    left join vwHDRTreeSiteInfo info on rl.site = info.Location_No
    left join vwHDRTreeList r on rl.site = r.Location_No and rl.rgroup_no = r.group_no and rl.rtree_no = r.TREE_NO and r.ACTION_TYPE = 'Removal'
    left join vwHDRTreeList t on rl.site = t.location_no and rl.tgroup_no = t.group_no and rl.ttree_no = t.tree_no and t.ACTION_TYPE = 'Planting'
    left join vwHDREngineeringEstimate ee on rl.site = ee.Location_No
    left join vwHDRQCQuantity qc on rl.site = qc.Location_No
    left join vwHDRChangeOrders co on rl.site = co.Location_No
    where info.ready_to_plant = 1
    and t.[tree_planting_date] BETWEEN :planting_start AND :planting_end
    order by 1,2" );

    myQuery.addParam(name="planting_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    myQuery.addParam(name="planting_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    trees = myQuery.execute().getResult();

    myXls = SpreadsheetNew( "Tree Data" );
    SpreadsheetAddRow( myXls, "Removal", 1,13);
    SpreadsheetSetCellValue( myXls, "Removal", 1, 13);
    SpreadsheetSetCellValue( myXls, "Planting", 1,21);
    SpreadsheetAddRow( myXls, "s,l, Type, Sub Type, Package, Site No, Facility Name, Facility Address, ZIP, Council District, Address, Construction Start Date, Construction Completed Date, Ready to Plant, Tree No, Species, Size, Permit Issunce Date, Tree Removal Date, Address, Contractor, Notes, Tree No, Species, Box Size, Permit Issuance Date, Tree Planting Date, Start Watering Date, End Watering Date, Most Recent Watering Date, Addres, Contractor, Notes, Tree Root Pruning/Shaving, Existing Stump Removal, Tree Canopy Pruning, Root Control Barrier Installed", 2,1);
    SpreadsheetAddRows( myXls, trees );

    // pretty print. merge cells
    format = new Query( dbtype = "query" );
    format.setAttributes( trees = trees );
    format.setSql ("select site, count(*) as m from trees group by site");
    ff = format.execute().getResult();

    start_r = 3;
    end_r = 2;

    for( g in ff ) {
        end_r = end_r + g["m"];    
        SpreadsheetMergeCells( myXls, start_r, end_r, 3,3);
        SpreadsheetMergeCells( myXls, start_r, end_r, 4,4);
        SpreadsheetMergeCells( myXls, start_r, end_r, 5,5);
        SpreadsheetMergeCells( myXls, start_r, end_r, 6,6);
        SpreadsheetMergeCells( myXls, start_r, end_r, 7,7);
        SpreadsheetMergeCells( myXls, start_r, end_r, 8,8);
        SpreadsheetMergeCells( myXls, start_r, end_r, 9,9);
        SpreadsheetMergeCells( myXls, start_r, end_r, 10,10);
        SpreadsheetMergeCells( myXls, start_r, end_r, 11,11);
        SpreadsheetMergeCells( myXls, start_r, end_r, 12,12);
        SpreadsheetMergeCells( myXls, start_r, end_r, 13,13);
        SpreadsheetMergeCells( myXls, start_r, end_r, 14,14);
        SpreadsheetMergeCells( myXls, start_r, end_r, 21,21);
        SpreadsheetMergeCells( myXls, start_r, end_r, 22,22);
        SpreadsheetMergeCells( myXls, start_r, end_r, 32,32);
        SpreadsheetMergeCells( myXls, start_r, end_r, 33,33);
        SpreadsheetMergeCells( myXls, start_r, end_r, 34,34);
        SpreadsheetMergeCells( myXls, start_r, end_r, 35,35);
        SpreadsheetMergeCells( myXls, start_r, end_r, 36,36);
        SpreadsheetMergeCells( myXls, start_r, end_r, 37,37);
        start_r = start_r + g["m"];
    }
    SpreadsheetDeleteColumn( myXls, 1);
    SpreadsheetDeleteColumn( myXls, 2);
    

    //
    totalQuery = new Query( datasource = "sidewalk" );
    totalQuery.setSql( "with good ( action_type, Tree_Removal_Date, Tree_Planting_Date ) as (
        select action_type, Tree_Removal_Date, Tree_Planting_Date
        from vwHDRTreeList
        inner join vwHDRTreeSiteInfo info on vwHDRTreeList.Location_No = info.Location_No
        where ( deleted = 0 or deleted is null ) and info.ready_to_plant = 1
        and Tree_Planting_Date BETWEEN :planting_start AND :planting_end
    )
    select 1, 'Total Number of Trees Removed', sum ( case when ACTION_TYPE = 'Removal' AND TREE_REMOVAL_DATE is not null then 1 else 0 end ) from good
    union
    select 2, 'Total Number of Tress to be Removed', sum (	case when ACTION_TYPE = 'Removal' AND TREE_REMOVAL_DATE is null then 1 else 0 end ) from good
    union
    select 3, 'Total Number of Trees Planted', sum ( case when ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is not null then 1 else 0 end ) from good
    union
    select 4, 'Total Number of Trees to be Planted', sum ( case when ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is null then 1 else 0 end ) from good" );

    totalQuery.addParam(name="planting_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    totalQuery.addParam(name="planting_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    summary = totalQuery.execute().getResult();

    SpreadsheetCreateSheet( myXls, "Summary" );
    SpreadsheetSetActiveSheet( myXls, "Summary" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,2);
    SpreadsheetAddRow( myXls, "Tree Report", 2,2);
    SpreadsheetAddRow( myXls, Now() ,3,2);
    SpreadsheetAddRows( myXls, summary, 5,1);
    SpreadsheetDeleteColumn( myXls, 1);
    SpreadsheetShiftColumns( myXls, 2,3, -1);


    totalPruneQuery = new Query( datasource = "sidewalk" );
    totalPruneQuery.setSql ("select 
        sum( coalesce(ee.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0) + coalesce(qc.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0) + coalesce(co.[TREE_ROOT_PRUNING_/_SHAVING_(PER_TREE)_QUANTITY],0 )) root_prune
        , sum( coalesce(ee.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(qc.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(co.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0 )) canopy_prune
        from vwHDRTreeSiteInfo rl
        left join vwHDREngineeringEstimate ee on rl.Location_No = ee.Location_No
        left join vwHDRQCQuantity qc on rl.Location_No = qc.Location_No
        left join vwHDRChangeOrders co on rl.Location_No = co.Location_No");
    tpp = totalPruneQuery.execute().getResult();
    
    SpreadsheetAddRow( myXls, "Total Number of Root Prune", 9,1); SpreadsheetSetCellValue( myXls, tpp.root_prune[1], 9,2);
    SpreadsheetAddRow( myXls, "Total Number of Canopy Prune", 10,1); SpreadsheetSetCellValue( myXls, tpp.canopy_prune[1], 10,2);
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_tracking.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />