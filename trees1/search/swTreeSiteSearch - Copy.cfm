<cfoutput>
		<cfif isdefined("session.userid") is false>
            <script>
               top.location.reload();
            
            </script>
            <cfabort>
		</cfif>

</cfoutput>

			<cfset shellName = "">
            <cfif (findNoCase('Android', cgi.http_user_agent,1) AND findNoCase('mobile', cgi.http_user_agent,1)) OR 
            (findNoCase('Windows', cgi.http_user_agent,1) AND findNoCase('Phone', cgi.http_user_agent,1)) OR 
            (findNoCase('iPhone', cgi.http_user_agent,1) OR findNoCase('iPod', cgi.http_user_agent,1)) OR 
            (findNoCase('BlackBerry', cgi.http_user_agent,1) OR findNoCase('BB10', cgi.http_user_agent,1))>
                <cfset shellName = "Handheld">
            <cfelseif findNoCase('Android', cgi.http_user_agent,1) OR 
            findNoCase('iPad', cgi.http_user_agent,1) OR 
            findNoCase('Playbook', cgi.http_user_agent,1) OR 
            findNoCase('Touch', cgi.http_user_agent,1)>
                <cfset shellName = "Tablet">
            <cfelse>
                <cfset shellName = "Desktop">
            </cfif>




<cfoutput>

<html >
   <head>
    <title>Tree Program - Search Tree Sites</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    
     <!---
             <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

		
			<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
            <script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
            <script src="../js/fw_menu.js"></script>
            
            <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
            <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
            
              --->  
            
            <cfinclude template="../css/css.cfm">
        
            
            
            
            <!--- angular --->
            <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.js"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-touch.js"></script>
            <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-animate.js"></script>
            <script src="http://ui-grid.info/docs/grunt-scripts/csv.js"></script>
            <script src="http://ui-grid.info/docs/grunt-scripts/pdfmake.js"></script>
            <script src="http://ui-grid.info/docs/grunt-scripts/vfs_fonts.js"></script>
            <script src="http://ui-grid.info/release/ui-grid.js"></script>
            <link rel="stylesheet" href="http://ui-grid.info/release/ui-grid.css" type="text/css">
            
            
            
            <!---End  angular --->
            
            
            
            
            <!--- our js --->
            <script language="JavaScript" src="../js/TreeSiteSearch_angular.js"></script>
          <!---  <script language="JavaScript" src="../js/TreeSiteSearch.js"></script>   --->
          
          
	</head>



		

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageGroup ORDER BY package_group
</cfquery>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblType ORDER BY type
</cfquery>


<cfset flw = "style='overflow:auto;'"><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>


<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw#>


 



				<div ng-app="app" id="searchbox" style="display:block;">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                      <tr>
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                              <tr><td height="0"></td></tr>
                                              <tr><td align="center" class="pagetitle">Search Tree Sites</td></tr>
                                              <tr><td height="12"></td></tr>
                                            </table>
                                        </td>
                                      </tr>
                                    </table>
            
            
            
            
                                          <div ng-controller="MainCtrl" cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:1200px;">
                                          
                                          <button id='toggleFiltering' ng-click="toggleFiltering()" class="btn btn-success">Toggle Filtering</button>
                                          <div id="grid1" ui-grid="gridOptions" ></div>
                                        </div>
                                        
                                    
                                        
                                    
                                    
                                    
                                    
                                 
                        

					</div>
                    
                    
  
	
                <div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
                    <a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" 
                         onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
                    <div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
                    <div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
                        <div id="msg_text" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
                        </div>
                        
                        <div style="position:absolute;bottom:15px;width:100%;">
                        <table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr><td align="center">
                                <a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
                                onclick="$('#chr(35)#msg').hide();return false;">Close</a>
                            </td></tr>
                        </table>
                        </div>
                        
                    </div>
                    
                </div>
	
	
	
	

	</body>
</cfoutput>

<cfset vis = "hidden">
<cfif isdefined("session.siteQuery")><cfset vis = "visible"></cfif>

<script>

		<cfoutput>
		var url = "#request.url#";
		var vis = "#vis#";
		</cfoutput>
		
		
		
</script>





</html>


            

				

	


