<!doctype html>

<html>
<head>
	<title>clean_deleted_trees and sync start_watering_date </title>
	
</head>




<body>

      
      <!--- action_type = 0: remove, 1: plant --->
      <!--- type = 1:BSS, 2: RAP 3: private 4: General Service 5: BSS dead tree  6: BSS Volunteer --->
      <!--- DELETED = 0, means not deleted, 1 means deleted --->
      
      <cfquery name="search_tree_list" datasource="#request.sqlconn2#" dbtype="ODBC" >
                         
                                    SELECT * FROM search_tree WHERE deleted = 0
                                    
      </cfquery>
      
      
       <cfquery name="tblTreeList" datasource="#request.sqlconn#" dbtype="ODBC" >
                    SELECT  * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE = 1 and ( TYPE = 1 or TYPE = 5 or TYPE = 6 ) and TREE_PLANTING_DATE is not null
                    </cfquery>
      
      
    <cfif search_tree_list.RecordCount GT 0>

                 
       <cfloop query = "search_tree_list"> 
      
      
                		<cfif len(trim(#ID#))>
                         <cfset _water_tree_id = #ID#/> 
                     <cfelse>
                         <cfset _water_tree_id = '-1'/>
                     </cfif> 
                     
                     
                     
                     <cfset _should_delete = true />
                     <cfloop query = "tblTreeList"> 
                    
							<cfif len(trim(#ID#))>
                                 <cfset _srp_tree_id = #ID#/> 
                             <cfelse>
                                 <cfset _srp_tree_id = '-1'/>
                             </cfif>  
                             
                             
                             <cfif _srp_tree_id eq _water_tree_id>
                                 <cfset _should_delete = false /> 
                            
                             </cfif> 
                             
                             
                             
                     </cfloop>
                     
                     <cfif _should_delete>
                     
                              <cfquery name="update_deleted_search_tree" datasource="#request.sqlconn2#" dbtype="ODBC" >
                         
                                    update search_tree 
                                    SET deleted = 1
                                    WHERE id =  "#_water_tree_id#" 
                                    
      							</cfquery>
                           
                     
                     </cfif> 
                     
                     
      
             </cfloop>
     </cfif>  
      
      
    <!--- *********************** sync start watering date ********************************   --->
    
     <cfquery name="search_tree_list2" datasource="#request.sqlconn2#" dbtype="ODBC" >
                         
                                    SELECT * FROM search_tree WHERE start_watering_date IS NULL
                                    
      </cfquery>
      
      
      
      
    <cfif search_tree_list2.RecordCount GT 0>
                         
       <cfloop query = "search_tree_list2"> 
      
      
                		<cfif len(trim(#ID#))>
                         <cfset _water_tree_id = #ID#/> 
                     <cfelse>
                         <cfset _water_tree_id = -1/>
                     </cfif> 
                     
                     
                     
                      <cfquery name="tblTreeList2" datasource="#request.sqlconn#" dbtype="ODBC" >
                    SELECT  * FROM tblTreeList WHERE ID = #_water_tree_id# and START_WATERING_DATE is not null
                    </cfquery>
                     
                    
                     <cfif tblTreeList2.RecordCount GT 0>
                           <cfloop query = "tblTreeList2"> 
                           
								   <cfset _start_watering_date = #start_watering_date#/> 
                                   
                                        <cfquery name="update_start_watering_date" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                 
                                            update search_tree 
                                            SET start_watering_date = #_start_watering_date#,
                                                last_water_date = #_start_watering_date#
                                                
                                            WHERE id =  "#_water_tree_id#" 
                                            
                                        </cfquery>
                                        
                                        <cfquery name="insert_tree" datasource="#request.sqlconn2#">
                                                                                                             
                                                           INSERT INTO dbo.water
                                                                                        ( 
                                                                                          pk_id,
                                                                                          user_id,
                                                                                          modified_date,
																						  date
                                                                                 
                                                                                         ) 
                                                                                            Values 
                                                                                            (
                                                                                              <cfqueryPARAM value = "#_water_tree_id#"   CFSQLType = 'CF_SQL_INTEGER'>  ,
                                                                                              -1,
                                                                                              <cfqueryPARAM value = "#_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                                                              <cfqueryPARAM value = "#_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  
                                                                                            )
                                                           
                                                           
                                                           
                                               
                                               </cfquery>        
                                
                                
                           </cfloop>
                   
                     </cfif>
      
      </cfloop>
</cfif>  

      <!--- ******************        end    ***** sync start watering date ********************************   --->






</body>
</html>


<script>

</script>


