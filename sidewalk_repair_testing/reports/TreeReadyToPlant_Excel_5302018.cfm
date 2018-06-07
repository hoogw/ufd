<!--- anticipate to be different from TreeTracking_Excel. so cannot share the same file --->
<!--- new layout 2018.2.22 --->

<!--- tree site info.ready_to_plant is true --->
<cfparam name="planting_start" type="date" default="2000-1-1" />
<cfparam name="planting_end" type="date" default="2100-1-1" />

<cfscript>

    outdir = "D:/sidewalk_repair/coc/";

    myFile = outdir & "ttt.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql("select a.package, a.location_no, a.name, a.address, i.tree_planting_contractor, i.ready_to_plant, t.address 'taddress', t.species, t.parkway_treewell_size, t.overhead_wires, t.sub_position, t.offsite, t.Tree_Planting_Date
    from  vwHDRTreeSiteInfo i
    inner join vwHDRTreeList t on i.location_no = t.location_no
    inner join vwHDRAssessmentTracking a on i.location_no = a.location_no
    where t.action_type = 'planting' and i.ready_to_plant = 1
    and a.package <> ''
    and t.[type] in ( 'BSS', 'RAP', 'General Service' ) 
    and i.[pre_inspection_date] BETWEEN :planting_start AND :planting_end
    order by a.package, i.location_no, taddress, t.tree_no");

    myQuery.addParam(name="planting_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    myQuery.addParam(name="planting_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    trees = myQuery.execute().getResult();

    headerFmt = StructNew();
    // headerFmt.color = 'blue';
    headerFmt.bold = true;

    rightAlign = StructNew();
    rightAlign.alignment = 'left';

    totalFmt = StructNew();
    totalFmt.bold = true;
    totalFmt.alignment = 'center';

    treeHFmt = StructNew();
    treeHFmt.bold = true;
    treeHFmt.alignment = 'center';
    treeHFmt.bottomborder = 'thin';
    treeHFmt.leftborder = 'thin';
    treeHFmt.rightborder = 'thin';
    treeHFmt.topborder = 'thin';

    treeFmt = StructNew();
    treeFmt.bold = false;
    treeFmt.dataFormat = 'General';
    treeFmt.alignment = 'center';
    treeFmt.bottomborder = 'thin';
    treeFmt.leftborder = 'thin';
    treeFmt.rightborder = 'thin';
    treeFmt.topborder = 'thin';

    treeDFmt = StructNew();
    treeDFmt.bold = false;
    treeDFmt.alignment = 'center';
    treeDFmt.dataFormat = 'm/d/yy';
    treeDFmt.bottomborder = 'thin';
    treeDFmt.leftborder = 'thin';
    treeDFmt.rightborder = 'thin';
    treeDFmt.topborder = 'thin';

    myXls = SpreadsheetNew( "Tree Data" );
    SpreadsheetAddRow( myXls, "TREES READY TO PLANT REPORT", 1, 1);
    SpreadsheetMergeCells( myXls, 1,1, 1,7 );
    SpreadsheetFormatCellRange( myXls, headerFmt, 1,1,1,7);

    old_loc = 0;
    siteTotal = 0;
    grandTotal = 0;
    line = 2;

    for( t in trees ) {

        if ( t.location_no != old_loc ) {

            if ( old_loc > 0 ) {
                SpreadsheetAddRow( myXls, "TOTAL NUMBER OF REPLANTS," & siteTotal, line, 1);
                SpreadsheetFormatCellRange( myXls, totalFmt, line,1, line,2);
                siteTotal = 0;
                line++;
            }
            sline = line;
            line += 2;
            SpreadsheetAddRow( myXls, "PACKAGE NUMBER," & t.package, line++, 1 );
            SpreadsheetAddRow( myXls, "SITE NUMBER," & t.location_no, line, 1 ); SpreadsheetFormatCell( myXls, rightAlign, line, 2);
            line++;
            SpreadsheetAddRow( myXls, "SITE ADDRESS", line, 1 ); SpreadsheetSetCellValue( myXls, t.address, line, 2); SpreadsheetMergeCells( myXls, line,line,2,4); line++;
            SpreadsheetAddRow( myXls, "TREE PLANTING CONTRACTOR," & t.tree_planting_contractor, line++, 1 );
            SpreadsheetFormatCellRange( myXls, headerFmt, sline, 1, line, 1);

            line++;
            SpreadsheetAddRow( myXls, "TREE PLANTING ADDRESS,SPECIES TO BE PLANTED,PARKWAY OR TREE WELL SIZE,OVERHEAD WIRES,SUB POSITION,OFFSITE,TREE PLANTING DATE", line, 1);
            SpreadsheetFormatCellRange( myXls, treeHFmt, line, 1, line, 7);
            line++;
            old_loc = t.location_no;
        }

        overhead = t.overhead_wires == 1 ? "Yes" : "No";
        SpreadsheetAddRow( myXls, t.species & "," & t.parkway_treewell_size & "," & overhead & "," & t.sub_position & "," & t.offsite & "," & t.Tree_Planting_Date, line, 2);
        SpreadsheetSetCellValue( myXls, t.taddress, line, 1);
        SpreadsheetFormatCellRange( myXls, treeFmt, line, 1, line, 6);
        SpreadsheetFormatCell( myXls, treeDFmt, line, 7);

        line++;
        
        siteTotal++;
        grandTotal++;
    }

    SpreadsheetAddRow( myXls, "TOTAL NUMBER OF REPLANTS," & siteTotal, line, 1);
    SpreadsheetFormatCellRange( myXls, totalFmt, line,1, line,2);
    line += 2;

    SpreadsheetAddRow( myXls, "GRAND TOTAL REPLANTS," & grandTotal, line, 1);
    SpreadsheetFormatCellRange( myXls, totalFmt, line,1,line,2);

    shet = myXls.getWorkBook().getSheetAt( javacast("int",0));
    for( i=0; i< 7; i++)
        shet.autoSizeColumn( javacast("int", i));


    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_tracking.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />