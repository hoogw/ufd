<!doctype html>

<html>
<head>
	<title>upsert_srp_to_water </title>
	
</head>




<body>


     <cfquery name="tblTreeList" datasource="#request.sqlconn#" dbtype="ODBC" >
                    SELECT  * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE = 1 and TREE_PLANTING_DATE is not null
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
                           <cfset _this_sub_position = #SUB_POSITION# />
                         
                         <cfquery name="if_tree_exist" datasource="#request.sqlconn2#" dbtype="ODBC" result="if_tree_exist_result">
                         
                                    SELECT * FROM search_tree
                                    WHERE ID = <cfqueryparam value= #_this_tree_id# cfsqltype="CF_SQL_INTEGER" />
                         </cfquery>
                         
                         
                         <cfif if_tree_exist_result.recordCount eq 0>
                    
                           
                                  
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
                                                                                                                                        sub_position
                                                                                                                                        
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
                                                                                                                              <cfqueryPARAM value = "#_this_sub_position#"   CFSQLType = 'CF_SQL_VARCHAR'> 
                                                                                                                                        )
                                                                                                             
                                                                                                                                
                                                                                                                 
                                                                                    </cfquery>
                                                                                    
                                                                                    
                             </cfloop>
                         </cfif>
                          
                         
                        
                    </cfloop>










</body>
</html>


<script>

</script>


