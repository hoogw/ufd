component displayname="Bid_Package" output="false"
{
    /*
     * @setter true
     */
     property name="MyDataSource" type="string" displayname="Data Source";
     
     /*
     * @setter true
     */
     property name="MyPackage" type="string" displayname="Package Name";
     
     /*
     * @setter true
     */
     property name="MyLogo" type="string" displayname="Logo Filepath";
     
     public string function Export(required string FilePath = "D:\xxx.xlsx")
        displayname="Export" output="false" returnFormat="plain"
     {
        myFile = FilePath;
        s1 = SpreadsheetNew("EE SUMARY", "yes");
                
        logoAnchor = "1,4,4,5";
        
        var wos = new Query( datasource = #MyDataSource#,
            sql = "select DISTINCT Work_Order from vwHDRAssessmentTracking where Package = :pnum" );
        wos.addParam(name="pnum", value=myPackage, cfsqltype="cf_sql_varchar");
        var w = wos.execute();
        var ww = w.getResult();
        myWList = "";
        for ( wx in ww )
            myWList = ListAppend( myWList, wx["Work_Order"], ", " );
            
        var summary = new Query( datasource = #MyDataSource#,
            sql = "select ROW_NUMBER() OVER( ORDER BY DISPLAY_ORDER ), BID_UNIT, UOM, sum(QUANTITY) sq, avg(U_PRICE) u, sum( ISNULL ( QUANTITY * U_PRICE, 0 )) tot
                    from vwHDRAssessmentTracking a 
                    inner join vwUgly u on a.Location_No = u.Location_No
                    where a.Package = :pnum AND QUANTITY > 0
                    group by BID_UNIT, UOM, DISPLAY_ORDER
                    order by DISPLAY_ORDER" );
        summary.addParam(name="pnum", value=myPackage, cfsqltype="cf_sql_varchar");
        var s = summary.execute();
        var ss = s.getResult();

        SpreadsheetAddRow(s1, "CITY ENGINEER'S ESTIMATE SUMMARY");
        SpreadsheetAddRow(s1, "City of Los Angeles - Department of Public Works - Bureau of Engineering" );
        SpreadsheetAddRow(s1, "SIDEWALK REPAIR PROGRAM PACKAGE " & MyPackage);
        SpreadsheetAddRow(s1, "W.O. " & myWList );
        SpreadsheetAddImage( s1, MyLogo, logoAnchor );

        idx = 1;
        while ( idx <= 4)
        {
            SpreadsheetMergeCells(s1, idx, idx, 1, 2);
            idx = idx + 1;
        }

        SpreadsheetAddRow(s1, "ITEM,DESCRIPTION,UNIT,Quantity,Unit Price,ITEM TOTAL");
        SpreadsheetAddRows(s1, ss);
        
        packageTotal = ArraySum(ss["tot"]);
        SpreadsheetAddRow(s1, ",TOTAL ESTIMATED CONSTRUCTION COST,,,, #packageTotal#" );
        
        var q = new Query( datasource = #MyDataSource#,
			sql= "SELECT Location_No, Name, Address, Work_Order FROM vwHDRAssessmentTracking a WHERE a.Package = :pnum");
        q.addParam(name="pnum", value=myPackage, cfsqltype="cf_sql_varchar");
		var r = q.execute();
		var rs = r.getResult();
       
        fs = { dataformat = "##,##0" };
        SpreadsheetFormatColumn(s1, fs, "4");
        
        fs = { dataformat = "$##,##0.00" };
        SpreadsheetFormatColumn(s1, fs, "5");
        SpreadsheetFormatColumn(s1, fs, "6");
        
        fs = { color = "white", bgcolor = "black" };
        SpreadsheetFormatRow(s1, fs, "5");      
        
        SpreadsheetSetColumnWidth( s1, 1, 8 );  
        SpreadsheetSetColumnWidth( s1, 2, 60 );  
                    
        // do engineer estimates
        for( var r in rs )
        {
            var working = r.Location_No & " EE";
            SpreadsheetCreateSheet(s1, working );
            
            SpreadsheetSetActiveSheet(s1, working );
            
            SpreadsheetAddRow(s1, "CITY ENGINEER'S ESTIMATE");
            SpreadsheetAddRow(s1, "City of Los Angeles - Department of Public Works - Bureau of Engineering" );
            SpreadsheetAddRow(s1, "Site No. " & r.Location_No );
            SpreadsheetAddRow(s1, r.Name );
            SpreadsheetAddRow(s1, "'#r.Address#'" );
            SpreadsheetAddRow(s1, "W.O. " & r.Work_Order);
            SpreadsheetAddImage( s1, MyLogo, logoAnchor );
            
            idx = 1;
            while ( idx <= 6)
            {
                SpreadsheetMergeCells(s1, idx, idx, 1, 2);
                idx = idx + 1;
            }
            
            SpreadsheetAddRow(s1, "ITEM,DESCRIPTION,UNIT,Quantity,Unit Price,ITEM TOTAL");
            
            var estimates = QueryEstimate(r.Location_No);
            SpreadsheetAddRows(s1, estimates);
            
            siteTotal = ArraySum(estimates["Total"]);
            SpreadsheetAddRow(s1, ",TOTAL ESTIMATED CONSTRUCTION COST,,,, #siteTotal#" );

            f2 = { dataformat = "##,##0" };
            SpreadsheetFormatColumn(s1, f2, "4");
            
            f2 = { dataformat = "$##,##0.00" };
            SpreadsheetFormatColumn(s1, f2, "5");
            SpreadsheetFormatColumn(s1, f2, "6");
            
            f = { color = "white", bgcolor = "black" };
            SpreadsheetFormatRow(s1, f, "7");      
            
            SpreadsheetSetColumnWidth( s1, 1, 8 );  
            SpreadsheetSetColumnWidth( s1, 2, 60 );  
        }
        
        // do reference sheet
        for( var r in rs )
        {
            var working = r.Location_No & " RS";
            SpreadsheetCreateSheet(s1, working );
            
            SpreadsheetSetActiveSheet(s1, working );
            SpreadsheetAddRow(s1, "REFERENCE SHEET");
            SpreadsheetAddRow(s1, "City of Los Angeles - Department of Public Works - Bureau of Engineering" );
            SpreadsheetAddRow(s1, "Site No. " & r.Location_No );
            SpreadsheetAddRow(s1, r.Name );
            SpreadsheetAddRow(s1, "'#r.Address#'" );
            SpreadsheetAddRow(s1, "W.O. " & r.Work_Order);
            SpreadsheetAddImage( s1, MyLogo, logoAnchor );

            SpreadsheetAddRow(s1, "ITEM,DESCRIPTION,UNIT,Quantity");
            
            var estimates = QueryReference(r.Location_No);
            SpreadsheetAddRows(s1, estimates);
             
            f2 = { dataformat = "##,##0" };
            SpreadsheetFormatColumn(s1, f2, "4");
            
             f = { color = "white", bgcolor = "black" };
            SpreadsheetFormatRow(s1, f, "7"); 
            
            SpreadsheetSetColumnWidth(s1, 1, 8);
            SpreadsheetSetColumnWidth(s1, 2, 60);           
       }
        
        SpreadsheetSetActiveSheet( s1, "EE SUMARY");        // flip back to the first sheet
        SpreadsheetWrite(s1, myFile, "yes" );
        
        return myFile; 
     } 
     
     function QueryEstimate(required string loc)
     {
        var q = new Query( datasource = MyDataSource,
            sql = "select ROW_NUMBER() OVER( ORDER BY DISPLAY_ORDER ) 'Item No', BID_UNIT, UOM, QUANTITY, U_PRICE, ISNULL( QUANTITY * U_PRICE, 0) 'Total'
                FROM vwUgly 
                WHERE Location_No = :loc AND Quantity > 0
                ORDER BY Display_Order");
        q.addParam( name="loc", value=loc, cfsqltype="cf_sql_integer");
        var r = q.execute();
        var rs = r.getResult();
        
        return rs;
     }
     
      function QueryReference(required string loc)
     {
        var q = new Query( datasource = MyDataSource,
            sql = "select ROW_NUMBER() OVER( ORDER BY DISPLAY_ORDER ) 'Item No', BID_UNIT, UOM, QUANTITY
                FROM vwUgly 
                WHERE Location_No = :loc AND Quantity > 0
                ORDER BY Display_Order");
        q.addParam( name="loc", value=loc, cfsqltype="cf_sql_integer");
        var r = q.execute();
        var rs = r.getResult();
        
        return rs;
     }
     
    // ctor
    public Bid_Package function init(required string ds, string package) 
    {
        MyDataSource = ds;
        MyPackage = package;
        
        MyLogo = GetDirectoryFromPath( GetCurrentTemplatePath() ) & "citySeal.png";
        
        return this;
    }     
}