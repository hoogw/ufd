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
        , a.Construction_Start_Date, a.Construction_Completed_Date
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
    order by 1,2" );

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
    totalQuery.setSql( "with good ( action_type, Tree_Removal_Date, Tree_Planting_Date, t_type, loc_no ) as (
        select action_type, Tree_Removal_Date, Tree_Planting_Date, [type], Location_No
        from vwHDRTreeList
        where deleted = 0 or deleted is null
    )
    select 11, 'Total Number of Trees Removed', count(*) from good where ACTION_TYPE = 'Removal' and TREE_REMOVAL_DATE is not null and t_type in ( 'BSS', 'RAP', 'General Service', 'BSS - Dead Tree', 'BSS - Volunteer' )
	union
    select 21, 'Total Number of Tress to be Removed', count(*) from good inner join vwHDRAssessmentTracking a on loc_no = a.Location_No where ACTION_TYPE = 'Removal' AND TREE_REMOVAL_DATE is null and t_type in ( 'BSS', 'RAP', 'General Service', 'BSS - Dead Tree', 'BSS - Volunteer' ) and ( a.Package_No is not null )
    union
    select 31, 'Total Number of Trees Planted', count(*) from good where ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is not null and t_type in ( 'BSS', 'RAP', 'General Service' )
    union
    select 41, 'Total Number of Trees to be Planted', count(*) from good inner join vwHDRAssessmentTracking a on loc_no = a.Location_No where ACTION_TYPE = 'Planting' AND TREE_PLANTING_DATE is null and t_type in ( 'BSS', 'RAP', 'General Service' ) and ( a.Package_No is not null )" );

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

    // by programs
    totalQuery.setSql("select site_type, site_subtype, 
            sum( case when action_type = 'Planting' and tree_planting_date is not null then 1 else 0 end ) planted,
            sum( case when action_type = 'Planting' and tree_planting_date is null then 1 else 0 end ) pplant,
            sum( case when action_type = 'Removal' and tree_removal_date is not null then 1 else 0 end ) removed,
            sum( case when action_type = 'Removal' and tree_removal_date is null then 1 else 0 end ) premove
        from vwHDRTreeList
        where deleted = 0 or deleted is null
        group by site_type, site_subtype
        order by site_type, site_subtype");

    prgms = totalQuery.execute().getResult();
    SpreadsheetCreateSheet( myXls, "Summary By Programs" );
    SpreadsheetSetActiveSheet( myXls, "Summary By Programs" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,1);
    SpreadsheetAddRow( myXls, "Tree Report", 2,1);
    SpreadsheetAddRow( myXls, Now() ,3,1);
    SpreadsheetAddRow( myXls, "Site Type, Site Subtype, Planted, Pending Planting, Removed, Pending Remove", 5,1);
    SpreadsheetAddRows( myXls, prgms, 6,1);
    // SpreadsheetDeleteColumn( myXls, 1);
    // SpreadsheetShiftColumns( myXls, 2,3, -1);

    totalQuery.setSql("select site_type, site_subtype, offsite,
            case when site_type = 'Rebate' then 'Rebate' else 'Sidewalk' end prgm,
            sum( case when action_type = 'Planting' and offsite='no' and tree_planting_date is not null then 1 else 0 end ) planted,
            sum( case when action_type = 'Planting' and offsite='no' and tree_planting_date is null then 1 else 0 end ) pplant,
            sum( case when action_type = 'Planting' and offsite='yes' and tree_planting_date is not null then 1 else 0 end ) offplanted,
            sum( case when action_type = 'Planting' and offsite='yes' and tree_planting_date is null then 1 else 0 end ) offpplant,
            sum( case when action_type = 'Removal' and tree_removal_date is not null then 1 else 0 end ) removed,
            sum( case when action_type = 'Removal' and tree_removal_date is null then 1 else 0 end ) premove
        from vwHDRTreeList
        where deleted = 0 or deleted is null
        group by site_type, site_subtype, offsite
        order by site_type, site_subtype");

    updates = totalQuery.execute().getResult();

    rupdate = new Query( dbtype = "query" );
    rupdate.setAttributes( updates = updates );
    rupdate.setSql( "select sum(planted) p, sum(pplant) pp, sum(offplanted) op, sum(offpplant) opp, sum(removed) r, sum(premove) pr, prgm from updates where prgm = 'Rebate' group by prgm" );
    rrst = rupdate.execute().getResult();

    supdate = new Query( dbtype = "query" );
    supdate.setAttributes( updates = updates );
    supdate.setSql( "select sum(planted) p, sum(pplant) pp, sum(offplanted) op, sum(offpplant) opp, sum(removed) r, sum(premove) pr, prgm from updates where prgm = 'Sidewalk' group by prgm" );
    srst = supdate.execute().getResult();


    SpreadsheetCreateSheet( myXls, "Tree Replacement Update" );
    SpreadsheetSetActiveSheet( myXls, "Tree Replacement Update" );
    SpreadsheetAddRow( myXls, Now() ,2,1);
    SpreadsheetAddRow( myXls, "Tree Replacement Update", 3,1);
    SpreadsheetMergeCells( myXls, 3,3, 1,7 );

    SpreadsheetAddRow( myXls, "Sidewalk Program, Sidewalk Program, Rebate Program, Rebate Program, Total", 5,3 );
    SpreadsheetAddRow( myXls, "Tree Removals, Trees Removed, 0,0,0,0,0", 6,1);
    SpreadsheetAddRow( myXls, "Tree Removals, Trees Pending Removal, 0,0,0,0,0", 7,1);
    SpreadsheetAddRow( myXls, "Tree Planted, Trees Planted - Onsite, 0,0,0,0,0", 8,1);
    SpreadsheetAddRow( myXls, "Tree Planted, Trees Planted - Offsite, 0,0,0,0,0", 9,1);
    SpreadsheetAddRow( myXls, "Pending Planting, Trees Pending Planting - Onsite, 0,0,0,0,0", 10,1);
    SpreadsheetAddRow( myXls, "Pending Planting, Trees Pending Planting - Offsite, 0,0,0,0,0", 11,1);


    // Rebate
    if ( rrst.recordcount > 0 ) {
        SpreadsheetSetCellValue( myXls, rrst.r[1], 6,5 );
        SpreadsheetSetCellValue( myXls, rrst.pr[1], 7,5 );
        SpreadsheetSetCellValue( myXls, rrst.p[1], 8,5 );
        SpreadsheetSetCellValue( myXls, rrst.op[1], 9,5 );
        SpreadsheetSetCellValue( myXls, rrst.pp[1], 10,5 );
        SpreadsheetSetCellValue( myXls, rrst.opp[1], 11,5 );

        SpreadsheetSetCellFormula( myXls, "SUM(E6:E7)", 6,6);
        SpreadsheetSetCellFormula( myXls, "SUM(E8:E9)", 8,6);
        SpreadsheetSetCellFormula( myXls, "SUM(E10:E11)", 10,6);
    }

    // sidewalk
    if ( srst.recordcount > 0 ) {
        SpreadsheetSetCellValue( myXls, srst.r[1], 6,3 );
        SpreadsheetSetCellValue( myXls, srst.pr[1], 7,3 );
        SpreadsheetSetCellValue( myXls, srst.p[1], 8,3 );
        SpreadsheetSetCellValue( myXls, srst.op[1], 9,3 );
        SpreadsheetSetCellValue( myXls, srst.pp[1], 10,3 );
        SpreadsheetSetCellValue( myXls, srst.opp[1], 11,3 );

        SpreadsheetSetCellFormula( myXls, "SUM(C6:C7)", 6,4);
        SpreadsheetSetCellFormula( myXls, "SUM(C8:C9)", 8,4);
        SpreadsheetSetCellFormula( myXls, "SUM(C10:C11)", 10,4);
    }

    SpreadsheetSetCellFormula( myXls, "SUM(D6,F6)", 6,7);
    SpreadsheetSetCellFormula( myXls, "SUM(D8,F8)", 8,7);
    SpreadsheetSetCellFormula( myXls, "SUM(D10,F10)", 10,7);
    
    
    shet = myXls.getWorkBook().getSheetAt( javacast("int", 3));
        for( i=0; i<7; i++)
            shet.autoSizeColumn( javacast("int", i));

    SpreadsheetMergeCells( myXls, 5,5, 3,4 );
    SpreadsheetMergeCells( myXls, 5,5, 5,6 );

    SpreadsheetMergeCells( myXls, 6,7, 1,1 );
    SpreadsheetMergeCells( myXls, 8,9, 1,1 );
    SpreadsheetMergeCells( myXls, 10,11, 1,1 );

    SpreadsheetMergeCells( myXls, 6,7, 4,4 );
    SpreadsheetMergeCells( myXls, 8,9, 4,4 );
    SpreadsheetMergeCells( myXls, 10,11, 4,4 );

    SpreadsheetMergeCells( myXls, 6,7, 6,6 );
    SpreadsheetMergeCells( myXls, 8,9, 6,6 );
    SpreadsheetMergeCells( myXls, 10,11, 6,6 );

    SpreadsheetMergeCells( myXls, 6,7, 7,7 );
    SpreadsheetMergeCells( myXls, 8,9, 7,7 );
    SpreadsheetMergeCells( myXls, 10,11, 7,7 );

    // SpreadsheetAddRows( myXls, rrst, 15,1);
    // SpreadsheetAddRows( myXls, srst, 16,1);

    SpreadsheetSetActiveSheet( myXls, "Summary" );    
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_tracking.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />