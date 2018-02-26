<!doctype html>

<html>
<head>
	<title>db_query_tree </title>
	
</head>



<body>

<!---
<cftransaction> 
 <cftry> 
--->

                    <cfquery name="tblTreeList" datasource="sidewalk_read_only" dbtype="ODBC" >
                    SELECT top 10 * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE != 0 and TREE_PLANTING_DATE is not null
                    </cfquery>
                    
                    <cfloop query = "tblTreeList"> 
                    
                         <cfset _this_tree_id = #ID#/> 
                         <cfset _this_type = #TYPE#/> 
                         <cfset _this_site_no = #LOCATION_NO# />
                          <cfset _this_sir_no = #SIR_NO# />
                           <cfset _this_address = #ADDRESS# />
                          <cfset _this_species = #SPECIES# />
                          <cfset _this_action = #ACTION_TYPE# />
                          <cfset _this_tree_planting_date = #TREE_PLANTING_DATE# />
                           <cfset _this_sub_position = #SUB_POSITION# />
                           <cfset _this_start_watering_date = #START_WATERING_DATE	# />
                         
                         <cfquery name="if_tree_exist" datasource="UFD_Inventory" dbtype="ODBC" result="if_tree_exist_result">
                         
                                    SELECT * FROM search_tree
                                    WHERE ID = <cfqueryparam value= #_this_tree_id# cfsqltype="CF_SQL_INTEGER" />
                         </cfquery>
                         
                         
                         <cfif if_tree_exist_result.recordCount eq 0>
                    
                           
                                  
                                  <cfquery name="get_site_info" datasource="sidewalk_read_only" dbtype="ODBC" result="get_site_info_result" maxRows = "1">
                         
                                    SELECT * FROM  tblSites
                                    WHERE LOCATION_NO = <cfqueryparam value= #_this_site_no# cfsqltype="CF_SQL_INTEGER" />
                                  </cfquery>
                                  
                                  <cfloop query = "get_site_info"> 
                                  
                                        <cfset _cd = #COUNCIL_DISTRICT# />
                                  
                                        <cfset _package_no = #PACKAGE_NO# />
                    
                                        
                    
                                                <cfquery name="insert_tree" datasource="UFD_Inventory">
                                                                                                             
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
                                                             <cfqueryPARAM value = "#_this_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  ,
                                                            <cfqueryPARAM value = "#_this_start_watering_date#"   CFSQLType = 'CF_SQL_DATE'>  ,                                                                   
                                                       <cfqueryPARAM value = "#_this_sub_position#"   CFSQLType = 'CF_SQL_VARCHAR'> 
                                                                                                                                        )
                                                                                                             
                                                                                                                 
                                               </cfquery>
                                               
                                               
                                                <cfquery name="insert_tree" datasource="UFD_Inventory">
                                                                                                             
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
                                                                                    
                                                                                    
                             </cfloop>
                         </cfif>
                          
                         
                        
                    </cfloop>







<cfquery name="tblTreeList" datasource="sidewalk_read_only"  >
SELECT top 3 * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE != 0 and TREE_PLANTING_DATE is not null
</cfquery>
<cfdump var="#tblTreeList#">


<!---
                  <cftransaction action="commit" /> 
                  
            <cfcatch type="any"> 
              <cftransaction action="rollback" /> 
            </cfcatch> 
            
            
     </cftry> 
 </cftransaction>

--->


<!---

<!--- Get Site --->
<cfquery name="getSite" datasource="sidewalk_read_only" dbtype="ODBC">
SELECT * FROM tblSites where PACKAGE_NO = '2' 
</cfquery>
<cfdump var="#getSite#">





<cfquery name="getSpecies" datasource="navla_spatial" dbtype="ODBC">
  SELECT DISTINCT common FROM dbo.ags_bss_tree_inventory WHERE common is not null ORDER BY common
</cfquery>


<cfdump var="#getSpecies#">




<cfquery name="add_tree_site" datasource="UFD_Inventory" result="tree_site_result">
          
          
         INSERT INTO main (
         
                                 program_type,
                                 boe_bid_package,
                                 boe_site,
                                 cd,
                                 rebate,crm_number
                                 
                                 )
                                 VALUES(
                                 2,
                                 2,
                                 2,
                                 2,
                                 '2222',
                                 '222222'
         )
          
			</cfquery>


<cfdump var="tree_site_result">
<!---  <cfdump var="#add_tree_site#" label="add_tree_site" />   --->









 <cfquery name="get_site_by_package" datasource="sidewalk_read_only" dbtype="ODBC">
		    Select 
	
		 *
			
			from tblSites
	 		
            <!---where STRUCTURE_ID = #url.pk# --->
            
         <!---   where Package_Group = 'BOE'    --->
        where PACKAGE_NO = '33' 
            
            
            
		</cfquery>
        
        
        <cfdump
    var="#get_site_by_package#"
    label="get_site_by_package"
    />





<!---       ++++++++++++++++++++++++++++++++++++++++++   --->



 <cfquery name="get_package_by_group" datasource="sidewalk_read_only" dbtype="ODBC">
		    Select 
	
			Package_No
			
			from tblPackages
	 		
            <!---where STRUCTURE_ID = #url.pk# --->
            
         <!---   where Package_Group = 'BOE'    --->
             where Package_Group = 'BSS'
            
		</cfquery>
        
        
        <cfdump
    var="#get_package_by_group#"
    label="get_package_by_group"
    />




<!---       ++++++++++++++++++++++++++++++++++++++++++   --->



       <cfquery name="program_type" datasource="UFD_Inventory" dbtype="ODBC">
		    Select 
	
			*
			
			from program_type
	 		
            <!---where STRUCTURE_ID = #url.pk# --->
            
            
		</cfquery>
        
        
        <cfdump
    var="#program_type#"
    label="program type"
    />
        


			
            
            
   <table style="width:20%">
          
           <tr>
    			<th>program ID</th>
    			<th>program type</th> 
    
  			</tr>
           
           <cfloop query="program_type">
  
 				<tr>
   					 <td><cfoutput>#id#</cfoutput></td>
    					<td><cfoutput>#type#</cfoutput></td>
   
 				 </tr>
  


           </cfloop>
	</table>



<!---  check coldfusion verion: current version 11

<!--- Dump out the server scope. --->
<cfdump var="#SERVER#" />

<!--- Store the ColdFusion version. --->
<cfset strVersion = SERVER.ColdFusion.ProductVersion />

<!--- Store the ColdFusion level. --->
<cfset strLevel = SERVER.ColdFusion.ProductLevel />

--->

--->


</body>
</html>


<script>

</script>


