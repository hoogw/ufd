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



 <!---
<cfparam name="report_date" type="date" />
--->

 <!---
                                                Get the HTTP request body content.
                                                NOTE: We have to use toString() as an intermediary method
                                                call since the JSON packet comes across as a byte array
                                                (binary data) which needs to be turned back into a string before
                                                ColdFusion can parse it as a JSON value.
                                                        --->
                                                
                                                <cfset requestBody = toString( getHttpRequestData().content ) />
                                    
                                                    <!--- Double-check to make sure it's a JSON value. --->
                                                   
                                                    <cfif isJSON( requestBody )>
                                                    
                                                        <cfset json_post = deserializeJson( requestBody ) >
                                                        
                                                        <!--- Echo back POST data.
                                                        <cfdump
                                                            var="#deserializeJSON( requestBody )#"
                                                            label="HTTP Body"
                                                            />
                                                         --->
                                                         
                                                            <cfset _selected_users = json_post.selected_users>
                                                            <cfset _report_date = json_post.date>
                                                            
                                                     </cfif>















<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

    
	//--------------------- excel header ------------------------------
	
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
							
							
							
							SpreadsheetAddRow( myXls, "User, Date, CD, Location", 6,1);


     //--------------     End    ------- excel header ------------------------------
	


   // myQuery = new Query( datasource = "sidewalk" );
   myQuery = new Query( datasource = "ufd_inventory" );
  
  /*
  
  // loop through selected user array 
  for (i=1;i LTE ArrayLen(_selected_users);i=i+1) 
  
  {
	//WriteOutput(array[i]);

     //user_name = _selected_users[i].TEXT;
  
						  
							myQuery.setSql("SELECT    
							  :user_name as user_name,
							  t1.date,
							  t2.cd,
							  t2.location
							  
						  FROM water as t1
						  
						  inner join search_tree as t2 on t1.pk_id = t2.id
						
						  where t1.user_id = :user_id  
						  
						  and t1.date = :report_date
						  
						  ");
							
						 myQuery.addParam(name="report_date", value=_report_date, cfsqltype="CF_SQL_DATE");
						 myQuery.addParam(name="user_id", value=_selected_users[i].ID, cfsqltype="CF_SQL_INTEGER");
						 myQuery.addParam(name="user_name", value=_selected_users[i].TEXT, cfsqltype="CF_SQL_VARCHAR");
						 
						 
							water = myQuery.execute().getResult();
						
							
							SpreadsheetAddRows( myXls, water );
    }// for loop
   
      */
	  
	  
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=srp_watering_report.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />