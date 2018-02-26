<cfscript>
    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "xxx.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql( "select
    [Type] ctype, 
    Subtype,	
	Location_No 'Location No',
	facility_name 'Name',
	facility_address 'FAddress',
	Zip_Code 'ZIP',
	Council_District 'Council District',
    Address,
	apn 'APN',
    pind 'PIND',
	case [Warranty_Code] when 'Has Warranty' then 'YES' else 'NO' end as 'Warranty',
	Issuance_Dt 'Issurance Date',
	code 'Code',
	Warranty_Start_Dt 'Warranty Start',
	Warranty_End_Dt 'Warranty End',
	Construction_Start_Date 'Construction Start',
	Construction_Completed_Date 'Construction Complete' from vwHDRCertificates" );
    resp = myQuery.execute();
    rest = resp.getResult();

    myTypesQuery = new Query( dbtype="query" );
    myTypesQuery.setAttributes( src=rest );
    myTypesQuery.setSql( "select ctype, count(*) c from src group by ctype" );
    resp = myTypesQuery.execute();
    myTypes = resp.getResult();

    nTypes = myTypes.RecordCount;
    nTypes = nTypes + 3;
    myXls = SpreadsheetNew( "Summary" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program", 1,1 );
    SpreadsheetAddRow( myXls, "Certificate of Compliance, #Now()#", 2,1 );
    SpreadsheetAddRow( myXls, "Type, Count", 3,1 );
    SpreadsheetAddRows( myXls, myTypes);
    SpreadsheetSetCellFormula( myXls, "sum(b4:b#nTypes#)", #nTypes#+1,2 );

    for( myT in myTypes ) {
        mySelection = new Query( dbtype="query" );
        mySelection.setAttributes( src=rest );
        mySelection.setSql( "select * from src where ctype = :t" );
        mySelection.addParam( name="t", value=myT["cType"], cfsqltype="cf_sql_varchar" );
        book = mySelection.execute().getResult();

        SpreadsheetCreateSheet( myXls, myT[ "ctype" ]);
        SpreadsheetSetActiveSheet( myXls, myT[ "ctype" ]);
        SpreadsheetAddRow( myXls, "Type, Sub Type, Site No, Facility Name, Facility Address, ZIP, Council District, Address, APN, PIN, Warranty, Issuance Date, Code, Warranty Start, Warranty End, Construction Start, Construction Complete", 1,1 );
        SpreadsheetAddRows( myXls, book );
    }

    SpreadsheetSetActiveSheet( myXls, "Summary" );
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=compliance.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />