<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<!-- Developed by: Nathan Neumann 10/26/17 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->


<!--- <cfif isdefined("Update") is false>
<script language="JavaScript">
location.replace("updateBSSramps.cfm?Update=1&RequestTimeout=500000")
</script>
<cfabort>
</cfif> --->

<font size="2">



<cfset pDS = "geocoding_spatial">
<!--- <cfset sDS = "sidewalk_spatial">  --->

<!--- for testing only  --->
<!---<cfset request.sqlconn = "sidewalk_spatial_testing">  --->
<cfset sDS = request.sqlconn>

<cfset sTable = "tblSites">
<cfset stTable = "tblTreeSiteInfo">
<cfset seTable = "tblEngineeringEstimate">
<cfset sdTable = "tblEstimateDefaults">
<cfset aeTable = "srp_srr_quantities">






<CFOUTPUT>sir number is:  #URL.sir# <br></CFOUTPUT>


<cfquery name="getLocationNumber" datasource="#sDS#" result="r">
	select Location_No from tblTreeSIRs where SIR_NO = '#URL.sir#'
</cfquery>
<cfset _location_no = getLocationNumber.Location_No />
<cfoutput>location no is: #_location_no#</cfoutput>


<cfquery name="getTotalStump" datasource="#sDS#" result="r">
	select 
              TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY ,  
              TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY
    from tblEngineeringEstimate where Location_No = #_location_no#
</cfquery>




<cfset totalStump = getTotalStump.TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY + getTotalStump.TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY >



<cfoutput> </br> Total stump (6-24 inch) + ( 24+ inch) :  #getTotalStump.TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY#  +  #getTotalStump.TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY# = #totalStump# </cfoutput>


<cfquery name="updateFURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY" datasource="#sDS#" result="r">
	
    		UPDATE tblEngineeringEstimate
			SET FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY = #totalStump# * 2
			WHERE Location_No = #_location_no# ;
    
    
</cfquery>





<cfquery name="verifyFURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY" datasource="#sDS#" result="r">
	
            select * from tblEngineeringEstimate
			
			WHERE Location_No = #_location_no# ;
    
    
</cfquery>
<cfoutput> </br> update FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY :  #verifyFURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY.FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY# </cfoutput>






<!--- fake number , must remove after testing ,  sample: (no issue date)  sir number is: 1126009851 , location no is: 621    --->

<!---
    <cfset totalStump = 2 />
    <cfoutput> </br> </br>  ****** fake number totalStump = 2  used, test only   </br>  </br></cfoutput>
	
--->	
	
<!--- fake number , must remove after testing  --->






<cfset totalTreePlant = totalStump * 2 />








<!--- ******************** calculate existing tree for each section  ********************   --->


                <cfquery name="getExistingTreeRemoval" datasource="#sDS#" result="r">
                    
                            select count(*) as count from tblTreeList
                            
                            WHERE Location_No = #_location_no#  and deleted = 0 and  ACTION_TYPE = 0;
                    
                    
                </cfquery>
                <cfset _totalExistingTreeRemoval = getExistingTreeRemoval.count>
                <cfoutput> </br> type [0] total exsiting tree Removal ( #_totalExistingTreeRemoval# ) </cfoutput>
                
                
                
                
                <cfquery name="getExistingTreePlant" datasource="#sDS#" result="r">
                    
                            select count(*) as count from tblTreeList
                            
                            WHERE Location_No = #_location_no#  and deleted = 0 and  ACTION_TYPE = 1;
                    
                    
                </cfquery>
                <cfset _totalExistingTreePlant = getExistingTreePlant.count>
                <cfoutput> </br>  type [1] total exsiting tree plant ( #_totalExistingTreePlant# ) </cfoutput>
                
                
                
                <cfquery name="getExistingTreePreservation" datasource="#sDS#" result="r">
                    
                            select count(*) as count from tblTreeList
                            
                            WHERE Location_No = #_location_no#  and deleted = 0 and  ACTION_TYPE = 2;
                    
                    
                </cfquery>
                <cfset _totalExistingTreePreservation = getExistingTreePreservation.count>
                <cfoutput> </br>  type [2] total exsiting tree Preservation ( #_totalExistingTreePreservation# ) </cfoutput>



<!--- ******************** END *************  calculate existing tree for each section  ********************   --->

























<!--- ******************** get Tree Root Pruning / Shaving (Per Tree) quantity ********************   --->

			<!--- Get Estimates --->
            <cfquery name="getEst" datasource="#sDS#" result="r">
            		SELECT * FROM tblEngineeringEstimate WHERE location_no = #_location_no#  
            </cfquery>


           <cfif evaluate("getEst.TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY") is not "">
					         <cfset __TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY = evaluate("getEst.TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY")>
          </cfif>

            
          <cfoutput> </br> TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY is  ( #__TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY# ) </cfoutput>

<!--- ******************** END ***********  get Tree Root Pruning / Shaving (Per Tree) quantity ********************   --->











<!--- ******************** get HDR certificate issue date ********************   --->



        <cfquery name="getIssueDate" datasource="#sDS#" result="r">
            
                    select issuance_dt from vwHDRCertificates
                    
                    WHERE Location_No = #_location_no#  
            
            
        </cfquery>
        
        
        <cfif getIssueDate.RecordCount GT 0>
        
                    <cfset _hasHDRcertificate_issue_date = true>
                    <cfset _IssueDate_HDRcertificate = getIssueDate.issuance_dt>
                    <cfset _tree_type = 3>
                    
                    <cfoutput> </br> </br>   *** Found issue date from vwHDRCertificates (#_IssueDate_HDRcertificate#) </br></br> </cfoutput>
                    
        <cfelse>            
        
                   <cfset _hasHDRcertificate_issue_date = false>
                    <cfset _IssueDate_HDRcertificate = "">
                    <cfset _tree_type = "">
                    
                    <cfoutput> </br> </br>  *** No issue date from vwHDRCertificates.  </br></br> </cfoutput>
        
        
        </cfif>

<!--- ***********   END ********* get HDR certificate issue date ********************   --->














<!--- ******************** insert into tree removal section ********************   --->

				<cfoutput> </br> </br></br></br> </br></br>******************** insert into tree removal section ********************   </cfoutput> 
                
                <cfif _totalExistingTreeRemoval GT 0>
                
                       <!---  -----  ----- safty check if there is existing item, DO NOT Insert anyting --->
                            <cfoutput> </br> There is exsiting tree Removal ( #_totalExistingTreeRemoval# ), so DO NOT Insert/add anyting  </cfoutput> 
                            
                            
                
                <cfelse>
                
                                <cfloop from="1" to= #totalStump# index="i">
                                
                                             <cfset _addTreeNo = _totalExistingTreeRemoval + i/>
                                
                                            <cfquery name="insert_tblTreeList" datasource="#sDS#" result="r">
                                               
                                                		<cfif _hasHDRcertificate_issue_date >
                                                
                                                            INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO,      TREE_REMOVAL_DATE,                                 TYPE,      ACTION_TYPE,Creation_Date,        DELETED)
                                                                             VALUES (#_location_no#, 1,    #_addTreeNo# , #CreateODBCDateTime(_IssueDate_HDRcertificate)# , #_tree_type#, 0,       #CreateODBCDateTime(Now())#, 0);
                                                            
                                                  		<cfelse>          
                                                            
                                                  
                                                                    INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO,      ACTION_TYPE, Creation_Date,           DELETED)
                                                                                     VALUES (#_location_no#, 1,     #_addTreeNo#, 0,           #CreateODBCDateTime(Now())#  , 0);
                                                      	</cfif>    
                                                
                                            </cfquery>
                                
                                     
                                    <cfoutput></br> Removal Section : add tree no=[#_addTreeNo#], remove-date=[#_IssueDate_HDRcertificate#],  tree-type= [#_tree_type#]  </cfoutput>
                                
                                
                                </cfloop>
                
                
                
                 </cfif>
                 
                 <cfoutput> </br> ================================================================================================   </cfoutput> 

<!--- **********  END ********** insert into tree removal section ********************   --->
























<!--- ******************** insert into tree plant section ********************   --->

				<cfoutput> </br> </br></br></br> </br></br>******************** insert into tree plant section ********************   </cfoutput> 
                
                
                                        <cfif _totalExistingTreePlant GT 0>
                                                    <!---  -----  ----- safty check if there is existing item, DO NOT Insert anyting --->
                                                    <cfoutput> </br> There is exsiting tree plant ( #_totalExistingTreePlant# ), so DO NOT Insert/add anyting  </cfoutput> 
                                                    
                                                    
                                        
                                        <cfelse>
                                        
                                                        <cfloop from="1" to= #totalTreePlant# index="i">
                                                        
                                                                     <cfset _addTreeNo = _totalExistingTreePlant + i/>
                                                                     
                                                        
                                                                <!--- ........... only first half insert get certificate issue date and property owner type .............   --->
                                                                   
                                                                   <cfquery name="insert_tblTreeList" datasource="#sDS#" result="r">
                                                                   
																				
                                                                               <cfif (_hasHDRcertificate_issue_date) >
                                                                                
                                                                                
																							 <cfif (i GT totalStump) >
                                                                                                
                                                                                                   
                                                                                                            INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO, ACTION_TYPE, Creation_Date, DELETED)
                                                                                                            VALUES (#_location_no#, 1, #_addTreeNo#, 1, #CreateODBCDateTime(Now())#  , 0);
                                                                                                    
                                                                                                   
                                                                                                    
                                                                                               
                                                                                              <cfelse>
                                                                                              
                                                                                                       INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO, TREE_PLANTING_DATE, TYPE, ACTION_TYPE, Creation_Date,  DELETED)
                                                                                                        VALUES (#_location_no#, 1, #_addTreeNo# , #CreateODBCDateTime(_IssueDate_HDRcertificate)# , #_tree_type#, 1, #CreateODBCDateTime(Now())#, 0);
                                                                                                   
                                                                                    
                                                                                              </cfif>
                                                                                  
                                                                                  
                                                                                 <cfelse> 
                                                                                  
                                                                                            
                                                                                                            INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO, ACTION_TYPE, Creation_Date, DELETED)
                                                                                                            VALUES (#_location_no#, 1, #_addTreeNo#, 1, #CreateODBCDateTime(Now())#  , 0);
                                                                                                    
                                                                                  
                                                                                  
                                                                                  </cfif>
                                                                                  
                                                        
                                                        
                                                                   </cfquery>
                                                        
                                                        
                                                                 <cfif i GT totalStump >
                                                                              <cfoutput></br>Planting Section :  add tree no=[#_addTreeNo#] </cfoutput>
                                                                   <cfelse>
                                                                   
                                                                                <cfoutput></br>Planting Section :  add tree no=[#_addTreeNo#], planting-date=[#_IssueDate_HDRcertificate#], tree-type=[#_tree_type#] </cfoutput>
                                                                    </cfif>
                                                                   
                                                                   
                                                        
                                                        </cfloop>
                                        
                                        
                                        
                                         </cfif>

              <cfoutput></br>  ================================================================================================   </cfoutput> 
<!--- ******************** END  ********************  insert into tree plant section ********************   --->














<!--- ******************** insert into Tree Preservation section ********************   --->

				<cfoutput> </br> </br></br></br> </br></br>******************** insert into Tree Preservation section ********************   </cfoutput> 
                
                <cfif _totalExistingTreePreservation GT 0>
                
                       <!---  -----  ----- safty check if there is existing item, DO NOT Insert anyting --->
                            <cfoutput> </br> There is exsiting tree Preservation ( #_totalExistingTreePreservation# ), so DO NOT Insert/add anyting  </cfoutput> 
                            
                            
                
                <cfelse>
                
                                <cfloop from="1" to= #__TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___QUANTITY# index="i">
                                
                                             <cfset _addTreeNo = _totalExistingTreePreservation + i/>
                                
                                            <cfquery name="insert_tblTreeList" datasource="#sDS#" result="r">
                                               
                                                		<cfif _hasHDRcertificate_issue_date >
                                                
                                                            INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO,      ROOT_PRUNING_DATE,                                 TYPE,      ACTION_TYPE,Creation_Date,        DELETED)
                                                                             VALUES (#_location_no#, 1,    #_addTreeNo# , #CreateODBCDateTime(_IssueDate_HDRcertificate)# , #_tree_type#, 2,       #CreateODBCDateTime(Now())#, 0);
                                                            
                                                  		<cfelse>          
                                                            
                                                  
                                                                    INSERT INTO tblTreeList (Location_No, GROUP_NO, TREE_NO,      ACTION_TYPE, Creation_Date,           DELETED)
                                                                                     VALUES (#_location_no#, 1,     #_addTreeNo#, 2,           #CreateODBCDateTime(Now())#  , 0);
                                                      	</cfif>    
                                                
                                            </cfquery>
                                
                                     
                                    <cfoutput></br> Preservation Section : add tree no=[#_addTreeNo#], ROOT_PRUNING-date=[#_IssueDate_HDRcertificate#],  tree-type= [#_tree_type#]  </cfoutput>
                                
                                
                                </cfloop>
                
                
                
                 </cfif>
                 
                 <cfoutput> </br> ================================================================================================   </cfoutput> 

<!--- **********  END ********** insert into tree removal section ********************   --->












<cfoutput></br> </br></br> </br></br> </br>success !!!</cfoutput>
</font>
</body>
</html>
