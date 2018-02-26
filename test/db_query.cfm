<!doctype html>

<html>
<head>
	<title>db_query </title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
</head>

<!--- <cfhttp url="https://www.arcgis.com/sharing/oauth2/token" method="get">
	<cfhttpparam type="URL" name="client_id" value="0Cr0WSHvv1SCbzNS" encoded="no"> 
	<cfhttpparam type="URL" name="client_secret" value="526dbda78e0a4a7ba54242bfd076762f" encoded="no"> 
	<cfhttpparam type="URL" name="grant_type" value="client_credentials" encoded="no"> 
</cfhttp>
<cfdump var="#cfhttp#">
<br> --->
<!--- <cfoutput>#cfhttp.filecontent#</cfoutput> --->

<cfset dt = Now()>
<cfset dt = dateformat(dt,"MM/DD/YYYY") & " " & timeformat(dt,"HH:mm:ss")>


<body>



<!--- Get Site --->
<cfquery name="getSite" datasource="sidewalk_read_only" dbtype="ODBC">
SELECT top 3 * FROM tblSites where PACKAGE_NO = '2' 
</cfquery>
<cfdump var="#getSite#">



<cfquery name="hdr_tree_list" datasource="sidewalk_read_only" dbtype="ODBC" >
SELECT top 2 * FROM vwHDRTreeList
</cfquery>
<cfdump var="#hdr_tree_list#">



<cfquery name="tblTreeList" datasource="sidewalk_read_only"  >
SELECT top 3 * FROM tblTreeList WHERE DELETED = 0 and ACTION_TYPE != 0 and TREE_PLANTING_DATE is not null

</cfquery>
<cfdump var="#tblTreeList#">


<cfquery name="tblTreeList_0" datasource="sidewalk_read_only"  >
SELECT top 3 * FROM tblTreeList WHERE ID = 1

</cfquery>
<cfdump var="#tblTreeList_0#">


<cfquery name="hdr_tree_list" datasource="sidewalk_read_only" dbtype="ODBC" >
SELECT top 3 * FROM vwHDRTreeList
where id = 7
</cfquery>
<cfdump var="#hdr_tree_list#">

<!---

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


