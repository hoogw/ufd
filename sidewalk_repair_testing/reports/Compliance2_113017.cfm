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

    myTypesQuery = new Query( datasource = "sidewalk");
    myTypesQuery.setAttributes( src=rest );
    /*
    myTypesQuery.setSql("WITH cat ( ctype, c ) AS 
    ( 
        select 'Access Request', 0
        union
        select 'City Facilities', 0
        union
        select 'Program Access Request', 0
        union
        select 'Rebate', 0
        union
        select 'Other', 0
        union
        SELECT type, count(*) FROM vwHDRCertificates GROUP BY type 
    ) 
    SELECT ctype, sum(c) c FROM cat GROUP BY ctype ORDER BY c DESC" ); */

    myTypesQuery.setSql("with cat ( ctype, m, c ) as (
        select 'Access Request', '7-2017', 0
        union
        select 'City Facilities', '7-2017', 0
        union
        select 'Program Access Request', '7-2017', 0
        union
        select 'Rebate', '7-2017', 0
        union
        select 'Other', '7-2017', 0
        union
            
    SELECT type, '0-2017', count(*) c
    FROM vwHDRCertificates 
    where Issuance_Dt between '2016-7-1' and '2017-6-30'
    GROUP BY type

        union

    SELECT type, cast(Datepart(MONTH, Issuance_Dt) as varchar(2)) + '-' + cast(DATEPART(year, Issuance_dt) as varchar(4)) m, count(*) c
    FROM vwHDRCertificates 
    where Issuance_Dt between '2017-7-1' and '2018-6-30'
    GROUP BY type, cast(Datepart(MONTH, Issuance_Dt) as varchar(2)) + '-' + cast(DATEPART(year, Issuance_dt) as varchar(4))
    ),
    tx ( ctype, fy2016, jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, [dec] ) as (
    select ctype, 
        coalesce([0-2017], 0) ,
        coalesce([1-2018], 0) ,
        coalesce([2-2018], 0) ,
        coalesce([3-2018], 0) , 
        coalesce([4-2018], 0) , 
        coalesce([5-2018], 0) ,
        coalesce([6-2018], 0) ,	
        coalesce([7-2017], 0) ,
        coalesce([8-2017], 0) , 
        coalesce([9-2017], 0) , 
        coalesce([10-2017], 0) ,
        coalesce([11-2017], 0) ,
        coalesce([12-2017], 0)
    from cat
    pivot
    (
    sum( c ) 
    for m in ( [0-2017], [1-2018], [2-2018], [3-2018], [4-2018], [5-2018], [6-2018], [7-2017], [8-2017], [9-2017], [10-2017], [11-2017], [12-2017] )
    ) as pp)
    select ctype
        , fy2016 'FY2016-2017'
        , jul July
        , aug August
        , sep September
        , oct October
        , nov November
        , [dec] December
        , jan January
        , feb February
        , mar March
        , apr April
        , may May
        , jun June
        , jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + [dec] + fy2016 as total
    from tx");
    
    // myTypesQuery.setSql("select ctype, count(*) c from src group by ctype" );
    resp = myTypesQuery.execute();
    myTypes = resp.getResult();

    nTypes = myTypes.RecordCount;
    nTypes = nTypes + 7;
    myXls = SpreadsheetNew( "Summary" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program", 1,1 );
    SpreadsheetAddRow( myXls, "Certificate of Compliance Report", 2,1);
    myDate = DateFormat( Now(), "ddd, mmmm dd, yyyy" );
    SpreadsheetSetCellValue( myXls, myDate, 3,1 );
    SpreadsheetAddRow( myXls, "Certified Compliant Parcels", 4, 2 );
    SpreadsheetMergeCells( myXls, 4,4, 2,15);
    SpreadsheetAddRow( myXls, "Type, FY 16-17, FY 2017-2018", 5,1 );
    SpreadsheetMergeCells( myXls, 5,6, 1,1);
    SpreadsheetMergeCells( myXls, 5,6, 2,2);
    SpreadsheetMergeCells( myXls, 5,5, 3,15);
    SpreadsheetAddRow( myXls, "July, August, September, October, November, December, January, February, March, April, May, June, Total", 6,3 );    
    SpreadsheetAddRows( myXls, myTypes);
    SpreadsheetSetCellFormula( myXls, "sum(b7:b#nTypes#)", #nTypes#+1,2 );

    for( j=6; j LTE #nTypes#+2; j=j+1) {
        SpreadsheetFormatCell( myXls, { leftborder = "medium" }, j, 15);
    }   
    for( j=4; j LTE #nTypes#+1; j=j+1) {
        SpreadsheetFormatCell( myXls, { leftborder = "medium" }, j, 16);
    }
    
    for( rx in [ 4, 7, #nTypes#+1, #nTypes#+2]) {
        for( i=1; i LTE 15; i = i+1) {
            SpreadsheetFormatCell( myXls, { topborder = "medium" }, rx, i);
        }
    }
    for( i=3; i LTE 15; i = i+1) {
        SpreadsheetFormatCell( myXls, { topborder = "medium", bottomborder = "medium" }, 5, i);
    }
    SpreadsheetFormatCell( myXls, { alignment="center", topborder = "medium", leftborder="medium", bottomborder="medium" }, 4,2 );
    SpreadsheetFormatCell( myXls, { alignment="center", rightborder = "medium" }, 5,1 );
    SpreadsheetFormatCell( myXls, { alignment="center", textwrap="true", verticalalignment="true", rightborder = "medium" }, 5,2 );
    SpreadsheetFormatCell( myXls, { alignment="center", leftborder = "medium", rightborder = "medium" }, 6,2 );
    SpreadsheetFormatCell( myXls, { alignment="center", topborder = "medium", bottomborder = "medium" }, 5,3 );
    SpreadsheetFormatCell( myXls, { leftborder = "medium", topborder = "medium" }, 7, 15);
    SpreadsheetFormatCell( myXls, { leftborder = "medium", topborder = "medium" }, #nTypes#+1, 15);

    for( myT in myTypes ) {
        mySelection = new Query( dbtype="query" );
        mySelection.setAttributes( src=rest );
        mySelection.setSql( "select * from src where ctype = :t order by 3,10" );
        mySelection.addParam( name="t", value=myT["cType"], cfsqltype="cf_sql_varchar" );
        book = mySelection.execute().getResult();

        SpreadsheetCreateSheet( myXls, myT[ "ctype" ]);
        SpreadsheetSetActiveSheet( myXls, myT[ "ctype" ]);
        SpreadsheetAddRow( myXls, "Type, Sub Type, Site No, Facility Name, Facility Address, ZIP, Council District, Address, APN, PIN, Warranty, Issuance Date, Code, Warranty Start, Warranty End, Construction Start, Construction Complete", 1,1 );
        SpreadsheetAddRows( myXls, book );
    }

    // column width to auto
    pageNum = 1;
    for( myT in myTypes ) {
        shet = myXls.getWorkBook().getSheetAt( javacast("int", pageNum++));
        for( i=0; i<17; i++)
            shet.autoSizeColumn( javacast("int", i));
    }

    SpreadsheetSetActiveSheet( myXls, "Summary" );
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=compliance.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />