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


<cfparam name="type" type="string" />
<cfparam name="report_date" type="date" />



<cfset report_date_format = DateFormat(report_date, "yyyy_mm_dd") />


<!---
<cfscript>
      
       writeOutput(report_date_format);
	   writeOutput(type);
</cfscript>
--->


<!---    http post get post data  
<cfset report_date = "12/15/2017">


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

--->


<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

   // myQuery = new Query( datasource = "sidewalk" );
   myQuery = new Query( datasource = "ufd_inventory" );
  
  
  if(type IS 'supervisor' ){
	                 
					 
					sql_string =  "SELECT 
										  t3.User_FullName,
										  
										  t1.date,
										  t2.cd,
										  t2.boe_site,
										  t2.location
										  
									  FROM water as t1
									  
									  inner join search_tree as t2 on t1.pk_id = t2.id
									  inner join tblUsers as t3 on t1.user_id = t3.User_ID
									
									  where  t1.date = :report_date
									
									  order by t2.boe_site
				  
				                        ";
					myQuery.setSql(sql_string);
					
				     myQuery.addParam(name="report_date", value=report_date, cfsqltype="CF_SQL_DATE");
				
				
				 
  }//if
  
  else   // type IS current_user 
  {
	                  sql_string = "SELECT 
									  t3.User_FullName,
										  
										  t1.date,
										  t2.cd,
										  t2.boe_site,
										  t2.location
										  
									  FROM water as t1
									  
									  inner join search_tree as t2 on t1.pk_id = t2.id
									  inner join tblUsers as t3 on t1.user_id = t3.User_ID
									
									  where  t1.date = :report_date
									    and t1.user_id = :user_id  
								
									  order by t2.boe_site
								 
								  ";
								  
					             myQuery.setSql(sql_string);
									
								 myQuery.addParam(name="report_date", value=report_date, cfsqltype="CF_SQL_DATE");
								 myQuery.addParam(name="user_id", value=_user_id, cfsqltype="CF_SQL_INTEGER");
								
	  
  }// if else
  
  
  
				 
    water = myQuery.execute().getResult();


   //.......................................  excel ....... header .................................
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
	
	
	/*
	
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
	
	*/
	
   
	
	 //................................  End .......  excel ....... header .................................
	
	 SpreadsheetAddRow( myXls, "Employee_Name, Date, CD, Site, Location", 6,1);
	 
	</cfscript>
    
    
    
    
    
	    <cfset _last_site = -1 />
        <cfset _counter = 0 />
         
		<cfloop query = "water">
        
             <cfoutput> #User_FullName#,   #Date#,  #CD# ,   #boe_site# ,  #location# <br/>   </cfoutput>	
             
             <cfif (_last_site NEQ boe_site) and (_last_site NEQ -1)>
             
                                            <cfset _count_row = "Total, , , ," & _counter/>
                    
                                              <cfscript>
                                             SpreadsheetAddRow( myXls, _count_row );
                                             SpreadsheetAddRow( myXls, " , , , , ," );
                                             </cfscript>
                                             
                                              <cfset _counter = 0 />
             
             </cfif>
             
             
                                               <cfset _counter =  _counter + 1/>
											   <cfset _this_site = boe_site />
                                         
                                         <cfset _location = replace(location,","," ","all")/>
                                         
                                         <cfset this_row_string =  #User_FullName# & ',' &   #Date# & ',' &  #CD# & ',' &   #boe_site# & ',' &  _location  />
                                     
                                          
                                          
                                     
                                            <cfscript>
                                             SpreadsheetAddRow( myXls, this_row_string );
                                            
                                             </cfscript>
                                             
                                             
                                             <cfset _last_site = _this_site />
                 
                  
                 
        </cfloop>	
        
        
       	
					<cfset _count_row_last_line = "Total, , , ," & _counter/>
					 <cfscript>	
                    		SpreadsheetAddRow( myXls, _count_row_last_line );	
					</cfscript>
				

	
   
<cfscript>
   //SpreadsheetAddRows( myXls, water );
        
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>



 




<cfset excel_file_name = "watering_" & type & "_" & report_date_format &".xls" />
<cfheader name="Content-Disposition" value="attachment; filename=#excel_file_name#" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />