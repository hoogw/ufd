<!doctype html>

<html>
<head>
	<title>upsert_srp_to_water </title>
	
</head>




<body>

      
      <!--- action_type = 0: remove, 1: plant --->
      <!--- type = 1:BSS, 2: RAP 3: private 4: General Service 5: BSS dead tree  6: BSS Volunteer --->
      
     <cfquery name="tblTreeList" datasource="#request.sqlconn#" dbtype="ODBC" >
                 <!---   SELECT  * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE = 1 and ( TYPE = 1 or TYPE = 5 or TYPE = 6 ) and TREE_PLANTING_DATE is not null   --->
                    
                    
                    SELECT dbo.tblSites.Location_No, dbo.tblPackages.Notice_To_Proceed_Date, dbo.tblTreeList.TREE_REMOVAL_DATE, 
dbo.tblTreeList.TREE_PLANTING_DATE, dbo.tblTreeList.ACTION_TYPE, dbo.tblTreeList.TYPE, dbo.tblTreeList.ID, dbo.tblTreeList.SIR_NO, dbo.tblTreeList.ADDRESS, dbo.tblTreeList.SPECIES,
dbo.tblTreeList.START_WATERING_DATE,  dbo.tblTreeList.SUB_POSITION, dbo.tblTreeList.OFFSITE
FROM dbo.tblSites LEFT OUTER JOIN dbo.tblTreeList ON dbo.tblSites.Location_No = dbo.tblTreeList.Location_No LEFT OUTER JOIN
dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group
WHERE (dbo.tblPackages.Notice_To_Proceed_Date IS NOT NULL) AND (dbo.tblTreeList.DELETED = 0) AND (dbo.tblTreeList.TYPE = 1) and (dbo.tblTreeList.TREE_PLANTING_DATE is not null)
                    
       </cfquery>
                    
      <cfloop query = "tblTreeList"> 
                    
                    <cfif len(trim(#ID#))>
                         <cfset _this_tree_id = #ID#/> 
                     <cfelse>
                         <cfset _this_tree_id = '-1'/>
                     </cfif>  
                     
                     
                     
                       <cfif len(trim(#TYPE#))>
                         <cfset _this_type = #TYPE#/> 
                       <cfelse>  
                          <cfset _this_type = '-1'/> 
                        </cfif> 
                         
                         
                         <cfif len(trim(#LOCATION_NO#))>
                          <cfset _this_site_no = #LOCATION_NO# />
                         <cfelse>
                             <cfset _this_site_no = '-1' />
                         </cfif>
                         
                         
                         <cfif len(trim(#SIR_NO#))>
                              <cfset _this_sir_no = #SIR_NO# />
                          <cfelse>
                               <cfset _this_sir_no = '-1' />
                          </cfif>
                          
                          
                          
                          
                          <cfset _this_new_added = '1' />
                          <cfset _this_deleted = '0' />
                         
                          
                          
                           <cfset _this_address = #ADDRESS# />
                          <cfset _this_species = #SPECIES# />
                          
                          
                          
						  <cfif len(trim(#ACTION_TYPE#))>
                          
                               
                               <cfif #OFFSITE# eq '1'>
                               
                                   
						               <cfset _this_action = '2' />
                                   <cfelse>
                                       <cfset _this_action = '1' />
                                 
                                </cfif>
                                
                                
                           <cfelse>
                                <cfset _this_action = '-1' />
                          </cfif>
                          
                          
                          
                          <cfset _this_tree_planting_date = #TREE_PLANTING_DATE# />
                         
                         
                         <cfif len(trim(#START_WATERING_DATE#))>
                              <cfset _this_start_watering_date = #START_WATERING_DATE# />
                          <cfelse>
                          
                               <!--- if start water date is null, keep it as is. --->
                               <cfset _this_start_watering_date = #START_WATERING_DATE# />
                          </cfif>
                         
                          
                          
                          
                           <cfset _this_sub_position = #SUB_POSITION# />
                         
                         <cfquery name="if_tree_exist" datasource="#request.sqlconn2#" dbtype="ODBC" result="if_tree_exist_result">
                         
                                    SELECT * FROM search_tree
                                    WHERE ID = <cfqueryparam value= #_this_tree_id# cfsqltype="CF_SQL_INTEGER" />
                                    
                         </cfquery>
                         
                         
                         <cfif if_tree_exist_result.recordCount eq 0>
                    
                           
                           
                                          		<!---   ===============  =================  get_latest_watering_date =========================   --->
                
                     
                                                     
                                                      <cfquery name="select_latest_watering_date" datasource="#request.sqlconn2#">
                                                                                         
                                                                  
                                                                  SELECT max(date) as date
                                                                  FROM water
                                                                  where pk_id = #_this_tree_id# 
                                                                                    
                                                                     
                                                       </cfquery>
                                                       
                                                        <cfloop query = "select_latest_watering_date"> 
                
                                                              <cfif len(trim(#date#))>
                                                              
																   <cfset _this_tree_last_water_date = #date# />
                                                                  
                                                                   
                                                                   
                                                              <cfelseif len(trim(_this_start_watering_date)) >
                                                              
                                                                   <cfset _this_tree_last_water_date = _this_start_watering_date />
                                                                   
                                                                   
                                                                   <!--- if no water history, should insert start watering date as last water date --->
                                                                   <cfquery name="insert_water" datasource="#request.sqlconn2#">
                                                                                                                                 
                                                                           INSERT INTO dbo.water
                                                                            ( 
                                                                               pk_id,
                                                                               user_id,
                                                                                modified_date,
                                                                                date                                            
                                                                           ) 
                                                                           Values 
                                                                              (
                                                                               <cfqueryPARAM value = "#_this_tree_id#"   CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                                               -1,
                                                                               <cfqueryPARAM value = "#_this_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                                               <cfqueryPARAM value = "#_this_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  
                                                                              )
                                                                                                           
                                                                   </cfquery>    
                                                                   <!---    end  -------  if no water history, should insert start watering date as last water date --->
                                                                   
                                                                   
                                                              <cfelse>     
                                                                        <cfset _this_tree_last_water_date = _this_tree_planting_date/>
                                                                   
                                                              </cfif>
                                                              
                                                              
                                                              <cfif len(trim(_this_tree_last_water_date))>
																   <cfset _this_days_since_last_water = dateDiff("d", _this_tree_last_water_date, now())/>
                                                              <cfelse>
                                                              
                                                                   <!--- if last water date is null, keep it as is. --->
                                                                   <cfset _this_days_since_last_water = '-1' />
                                                              </cfif>
                                                              
                                                             
                                                            
                                                           
                                                          <cfbreak>  
                                                       </cfloop>
                
                								<!---   ===============  ======  End   ===========  get_last_watering_date  =========================   --->
                           
                           
                           
                           
                           
                           
                           
                           
                                          <!---   ===============  =================  get_site no, package no, cd, =========================   --->
                                  
                                          <cfquery name="get_site_info" datasource="#request.sqlconn#" dbtype="ODBC" result="get_site_info_result" maxRows = "1">
                                 
                                            SELECT * FROM  tblSites
                                            WHERE LOCATION_NO = <cfqueryparam value= #_this_site_no# cfsqltype="CF_SQL_INTEGER" />
                                          </cfquery>
                                          
                                          
                                          
                                          <cfloop query = "get_site_info"> 
                                          
                                                <cfif len(trim(#COUNCIL_DISTRICT#))>
                                                   <cfset _cd = #COUNCIL_DISTRICT# />
                                                <cfelse>
                                                     <cfset _cd = '-1' /> 
                                                </cfif>
                                          
                                          
                                          
                                                <cfif len(trim(#PACKAGE_NO#))>
                                                       <cfset _package_no = #PACKAGE_NO# />
                                                  <cfelse>
                                                        <cfset _package_no = '-1' />
                                                   </cfif>
                                        
                                           </cfloop>
                                         
                                          <!---   =============== End of =================  get_site no, package no, cd, =========================   --->
                                          
                                          
                                          
                                          
                                          
                                           
                                          
                                          <!---   ===============  =================  get TBM tom's brother map =========================   --->
                                  
                                  
                                                       <cfset _page = -1 /> 
                                                       <cfset _row =  -1 />
                                                       <cfset _column = '' />
                                                        <cfset _tbm = ''/>
                                  
                                  
                                    
                                  
                                          <cfquery name="getTBM" datasource="#request.sqlconn#" dbtype="ODBC" result="getTBM_result" maxRows = "1">
                                 
                                            SELECT a.tree_id, b.Page, b.Row, b.Column_
                                                        FROM sidewalk_repair.dbo.tblGeocodingTrees AS a, navla.dbo.ags_tbm_page_grid AS b
                                                        WHERE a.Shape.STIntersects(b.Shape) = 1 
                                                               and a.tree_id = #_this_tree_id#
                                                       
                                          </cfquery>
                                          
                                          
                                          <!---  have TBM info   --->
                                          <cfif getTBM.recordCount GT 0>
                                          
                                          
                                          
                                                      <cfloop query = "getTBM"> 
                                                      
                                                            <cfif len(trim(#PAGE#))>
                                                               <cfset _page = #PAGE# />
                                                            <cfelse>
                                                                 <cfset _page = -1 /> 
                                                            </cfif>
                                                      
                                                      
                                                      
                                                            <cfif len(trim(#ROW#))>
                                                                   <cfset _row = #ROW# />
                                                              <cfelse>
                                                                    <cfset _row = -1 />
                                                               </cfif>
                                                               
                                                               
                                                               
                                                               <cfif len(trim(#COLUMN_#))>
                                                                   <cfset _column = #COLUMN_# />
                                                              <cfelse>
                                                                    <cfset _column = '' />
                                                               </cfif>
                                                               
                                                               
                                                               <cfset _tbm = _page & '-' &  _column & _row/>
                                                    
                                                       </cfloop>
                                           
                                           <cfelse>
                                                      <!--- no TBM info --->
                                           
                                                       <cfset _page = -1 /> 
                                                       <cfset _row =  -1 />
                                                       <cfset _column = '' />
                                                        <cfset _tbm = ''/>
                                           </cfif>
                                           
                                                
                                                
                                                
                                                 
                                         
                                          <!---   =============== End of =================  get TBM tom's brother map =========================   --->
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                           <!---   ===============================  insert this tree =========================   --->
                                         <cfquery name="insert_tree" datasource="#request.sqlconn2#">
                                                                                                             
                                                  INSERT INTO dbo.search_tree
                                                  ( 
                                                        id,
                                                        program_type,
                                                        boe_bid_package,
                                                        boe_site,
                                                        cd,
                                                        crm_number,
                                                        location,
                                                        species,
                                                        action,
                                                        
                                                        planting_date,
                                                        last_water_date,
                                                        start_watering_date,
                                                        
                                                        sub_position,
                                                        new_added,
                                                        deleted,
                                                        days_since_last_water,
                                                       
                                                       
                                                        tbm,
                                                        page,
                                                        row,
                                                        column_
                                                        
                                                        ) 
                                                 Values 
                                                       (
                                                         <cfqueryPARAM value = "#_this_tree_id#"   CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                         <cfqueryPARAM value = "#_this_type#"      CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                         <cfqueryPARAM value = "#_package_no#"     CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                          <cfqueryPARAM value = "#_this_site_no#"   CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                          <cfqueryPARAM value = "#_cd#"             CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                          <cfqueryPARAM value = "#_this_sir_no#"    CFSQLType = 'CF_SQL_VARCHAR'>  ,
                                                          <cfqueryPARAM value = "#_this_address#"   CFSQLType = 'CF_SQL_VARCHAR'>  ,
                                                          <cfqueryPARAM value = "#_this_species#"   CFSQLType = 'CF_SQL_VARCHAR'>  ,
                                                          <cfqueryPARAM value = "#_this_action#"   CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                                                                                              
                                                            <cfqueryPARAM value = "#_this_tree_planting_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                            <cfqueryPARAM value = "#_this_tree_last_water_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                            <cfqueryPARAM value = "#_this_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                                                 
                                                         <cfqueryPARAM value = "#_this_sub_position#"   CFSQLType = 'CF_SQL_VARCHAR'> ,
                                                         <cfqueryPARAM value = "#_this_new_added#"   CFSQLType = 'CF_SQL_INTEGER'> ,
                                                         <cfqueryPARAM value = "#_this_deleted#"   CFSQLType = 'CF_SQL_INTEGER'> ,
                                                         <cfqueryPARAM value = "#_this_days_since_last_water#"   CFSQLType = 'CF_SQL_INTEGER'>,
                                                         
                                                         
                                                         <cfqueryPARAM value = "#_tbm#"   CFSQLType = 'CF_SQL_VARCHAR'> ,
                                                         <cfqueryPARAM value = "#_page#"   CFSQLType = 'CF_SQL_INTEGER'> ,
                                                         <cfqueryPARAM value = "#_row#"   CFSQLType = 'CF_SQL_INTEGER'> ,
                                                         <cfqueryPARAM value = "#_column#"   CFSQLType = 'CF_SQL_VARCHAR'> 
                                                         
                                                         
                                                         
                                                        )
                                        </cfquery>
                                                                                    
                                                                                    
                                                                                    
                                                         
                                                                                    
                                                                                    
                                                                                    
                                        <!---   ===================   End ============  insert this tree =========================   --->                                            
                                                                                    
                                                                                    
                                                                                    
                                       
                             
                             
                             
                             
                         </cfif>   <!--- if not exist, insert  new one --->
                          
                         
                        
                    </cfloop>










</body>
</html>


<script>

</script>


