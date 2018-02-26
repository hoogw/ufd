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
    
    <cfelse>
            
                <cfset _user_id = session.user_num>   
            <script>
			
			     var user_id = #_user_id#;
				 
            </script>
            
    
    
    
</cfif>
</cfoutput>
                                            <!--- ===================== get user full name ====================== --->

                                              <cfquery name="get_user_full_name" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                                            
                                                             
                                                                  SELECT 
                                                                      User_FullName
                                                                      
                                                                  FROM tblUsers
                                                                  where User_ID = #_user_id#
                                                             
                                                 </cfquery>
                                                 
                                                  <cfset who_s_raw = get_user_full_name.User_FullName >
                                                   <cfset who_s = REReplace(who_s_raw,"[^0-9A-Za-z]","_","all") >
                                              <!--- ==============         End   ================== get user full name ====================== --->



<cfparam name="type" type="string" />
<cfparam name="report_date" type="date" />



<cfset report_date_format = DateFormat(report_date, "yyyy_mm_dd") />





<cfscript>
    outdir = "D:/sidewalk_repair/downloads/";
    myFile = outdir & "ttt.xls";
   // myQuery = new Query( datasource = "sidewalk" );
   myQuery = new Query( datasource = "ufd_inventory" );
  
    myQuery.setSql("SELECT 
      
      t1.date,
	  t2.cd,
	  t2.location
      
  FROM water as t1
  
  inner join search_tree as t2 on t1.pk_id = t2.id
  where t1.user_id = #_user_id#  
  
  and date = :report_date
  
  ");
	
 myQuery.addParam(name="report_date", value=report_date, cfsqltype="CF_SQL_DATE");
 
 
    water = myQuery.execute().getResult();
    myXls = SpreadsheetNew( "Water Data" );
    
	
	//SpreadsheetSetHeader(myXls,"","SRP TREE WATERING","");
	SpreadSheetSetColumnWidth (myXls, 1, 20);
	SpreadSheetSetColumnWidth (myXls, 2, 30);
	SpreadSheetSetColumnWidth (myXls, 3, 20);
	SpreadSheetSetColumnWidth (myXls, 4, 30);
	SpreadSheetSetColumnWidth (myXls, 5, 20);
	SpreadSheetSetColumnWidth (myXls, 6, 30);
	
	SpreadsheetMergeCells( myXls, 1,1,1,6 );
	SpreadsheetAddRow( myXls, "SRP TREE WATERING", 1,1);
	SpreadSheetSetRowHeight(myXls, 1,50);
	
	
	
	
	SpreadsheetSetCellValue( myXls, "EMPLOYEE NAME", 2, 1);
	SpreadsheetSetCellValue( myXls, "EMPLOYEE ID", 2, 3);
	SpreadsheetSetCellValue( myXls, "CREW", 2, 5);
	SpreadSheetSetRowHeight(myXls, 2,50);
	
	
	
	
	SpreadsheetSetCellValue( myXls, "EQIP NO. & TYPE", 3, 1);
	SpreadsheetSetCellValue( myXls, "START TIME", 3, 3);
	SpreadsheetSetCellValue( myXls, "STOP TIME", 3, 5);
	SpreadSheetSetRowHeight(myXls, 3,50);
	
	
	
	SpreadsheetSetCellValue( myXls, "EQIP NO. & TYPE", 4, 1);
	SpreadsheetSetCellValue( myXls, "MILEAGE START", 4, 3);
	SpreadsheetSetCellValue( myXls, "MILEAGE STOP ", 4, 5);
	SpreadSheetSetRowHeight(myXls, 4,50);
	
	
	
    SpreadsheetAddRow( myXls, "Date, CD, Location", 6,1);
    SpreadsheetAddRows( myXls, water );
   
        
    SpreadsheetWrite( myXls, myFile, "yes" );
</cfscript>



<cfset excel_file_name = "watering_" & who_s & "_" & report_date_format &".xls" />
<cfheader name="Content-Disposition" value="attachment; filename=#excel_file_name#" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />