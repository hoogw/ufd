<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=4");
	
	
	
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 3>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=5&chk=authority");
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

<html>
<head>
<title>Sidewalk Repair Program - Manage User</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">



</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- agency role etc... --->
<cfquery name="getAgency" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblAgency order by id
</cfquery>




         

            <cfquery name="getRole" datasource="#request.sqlconn#" dbtype="ODBC">
                SELECT * FROM tblRole  order by Role_Id
            </cfquery>








<cfset flw = ""><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>
<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw#>


<!---  ------------ Search and Listing -------------------    --->

<div id="search_listing">


                        <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td height="8"></td></tr></table>
                        
                        <div id="searchbox" style="display:block;">
                        
                        <table width="100%" border="0" cellspacing="0" cellpadding="3">
                          <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr><td height="7"></td></tr>
                                  <tr><td align="center" class="pagetitle">Manage User</td></tr>
                                  <tr><td height="15"></td></tr>
                                </table>
                            </td>
                          </tr>
                        </table>
                        
                        <table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:704px;">
                            <form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
                            <tr>
                            <td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
                                <table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
                                <tr>
                                    <th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
                                    
                                        
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                <th class="drk left middle" style="width:420px;">Search User:</th>
                                                </tr>
                                            </table>
                                    
                                    
                                    </td>
                                </tr>
                                    
                                    <tr>	
                                        <td colspan="4" style="padding:0px 0px 0px 0px;">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                            
                                            
                                                <tr>
                                                
                                                
                                                <th class="left middle" style="width:65px;">Full Name:</th>
                                                
                                                <td style="width:2px;"></td>
                                                
                                                <td class="frm" style="width:215px;">
                                                    <input type="Text"  name="user_full_name" id="user_full_name" value="" style="width:210px;" class="rounded">
                                                </td>
                                                
                                                <td style="width:2px;"></td>
                                                
                                                
                                                
                                                <th class="left middle" style="height:30px;width:55px;">Agency:</th>
                                                
                                                <td style="width:2px;"></td>
                                                
                                                <td id="user_agency" class="frm"  style="width:115px;">
                                                    <select class="rounded" style="width:110px;">
                                                        <option value=""> </option>
                                                            <cfset cnt = 1>
                                                            
                                                            <cfloop query="getAgency">
                                                                <cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
                                                                <option value="#name#" #sel#>#name#</option>
                                                            </cfloop>
                                                    </select>
                                                </td>
                                                
                                                
                                                
                                                <td style="width:2px;"></td>
                                                
                                                
                                                
                                                
                                                <th class="left middle" style="height:30px;width:45px;">Role:</th>
                                                
                                                <td style="width:2px;"></td>
                                                
                                                <td id="user_role" class="frm"  style="width:165px;">
                                                
                                                    <select class="rounded" style="width:160px;">
                                                        <option value=""></option>
                                                        
                                                        <cfset cnt = 1>
                                                        <cfloop query="getRole">
                                                            <cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
                                                            <option value="#Role_Name#" #sel#>#Role_Name#</option>
                                                        </cfloop>
                                                        
                                                    </select>
                                                </td>
                                              
                                                
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    
                                    
                                    
                        
                                </table>
                            </td>
                            </tr>
                            </form>
                        </table>
                        
                        <table align=center border="0" cellpadding="0" cellspacing="0">
                            <tr><td height=15></td></tr>
                            <tr>
                                <td align="center">
                                    <a id="add_new_user" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;  cursor:pointer;" 
                                    >Add New User</a>
                                </td>
                                
                                
                                <td style="width:15px;"></td>
                                <td align="center">
                                    <a  id="clear_search_parameter" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;  cursor: pointer;" 
                                    >Clear</a>
                                </td>
                                
                                
                                
                                
                            </tr>
                        </table>
                        
                        </div>
                        
                        
                        <!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
                        <div class="overlay">
                            <div id="loading-img"></div>
                        </div>
                        
                        
                        
                        
                        <div name="ss_arrow" id="ss_arrow" onClick="toggleSearchBox();"
                        style="position:absolute;top:192px;left:0px;height:15px;width:50px;border:0px red solid;overflow:hidden;display:none;">
                        <img id="ss_arrow_img" style="position:absolute;top:0px;left:20px;visibility:visible;" src="../images/arrow_up.png" width="19" height="12" title="Hide Search Filter Box"  onmouseover="this.style.cursor='pointer';">
                        </div>
                        
                        
                        <div name="ps_header" id="ps_header" 
                        style="position:relative;top:10px;left:5px;height:25px;width:100%;border:2px #request.color# solid;overflow:hidden;">
                        <table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
                            <tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
                                <table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
                                <tr>
                                    <th class="drk center middle" style="height:21px;width:60px;">Edit</th>
                                    <th class="drk center middle" style="height:21px;width:60px;">Remove</th>
                                    <th class="drk center middle" style="width:120px;" id="header_full_name" onMouseOver="this.style.cursor='pointer';">Full Name</th>
                                    <th class="drk center middle" style="width:120px;" id="header_name" onMouseOver="this.style.cursor='pointer';">Login Name</th>
                                <!---	<th class="drk center middle" style="width:120px;" id="header_password" onMouseOver="this.style.cursor='pointer';">Password</th>  --->
                                    <th class="drk center middle" style="width:120px;" id="header_agency" onMouseOver="this.style.cursor='pointer';">Agency</th>
                                    <th class="drk center middle"                      id="header_role" onMouseOver="this.style.cursor='pointer';">Role</th>
                                </tr>
                                </table>
                            </td></tr>
                        </table>
                        
                        </div>
                        
                        <div name="ps_results" id="ps_results" 
                        style="position:relative;top:8px;left:5px;height:100%;width:100%;border:2px #request.color# solid;overflow-y:auto;overflow-x:hidden;">
                        <table id="tbl_results" border="0" cellpadding="0" cellspacing="0" ><tr><td></td></tr></table>
                        </div>



</div>

<!---  ---------------- end ------------ Search and Listing -------------------    --->








<!--- ------------------------------ add/edit User  --------------------------------------------->



<div id="add_user" style="display:none">


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td colspan="3" height="15"></td></tr>
          <tr><td style="width:25%;text-align:right;">
		 
		  </td>
		  <td  id="add_edit_user" align="center" class="pagetitle">Add/Edit User</td>
		  <td style="width:25%;">
		  
		  </tr>
		 
		</table>
  	</td>
  </tr>
</table>







<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:800px;">
	
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;width:800px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						
						
                        <!---
						
						<th class="drk left middle" style="width:55px;"></th>
                        
						<td  align="middle" style="width:295px;padding:2px 3px 0px 0px;">
                        
                              <span id="user_exist_already"  style="display:none;color:white;"> Full Name Invalid</span>
                              
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              <span id="login_exist_already"  style="display:none;color:white;"> Login Name Invalid</span>
                              
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              <span id="all_field_required"  style="display:none;color:white;"> All Fields Required</span>
                              
                              
                              
						</td>
						
						--->
                        
                        
                        
						<td align="right" style="width:430px;">
							
                            
							<a id="save_new_user_btn" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;   cursor: pointer;"  >Save</a>
							<a id="update_user_btn" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;   cursor: pointer;"    >Update</a>
                           
                            
						</td>
						
						<td align="right" style="width:90px;">
							
                            <!---
							<a id="delete_user" class="button buttonText" style="height:13px;width:60px;padding:1px 0px 1px 0px;  cursor: pointer;">Delete</a>
							--->
                            
                            
						</td>
						
						</tr>
					</table>
			
			
			</th>
			
			
			</td>
		</tr>
			
            
            
            
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
                    
                    
                    
                    
						<tr>
                                    
                                     <input type="hidden" id="add_user_id" name="add_user_id" value="" >
                                    
                                    
                                    <th class="left middle" style="height:30px;width:60px;">Full Name:</th>
                                    <td style="width:2px;"></td>
                                    
                                    <td class="frm" style="width:180px;">
                                        <input type="Text" name="add_user_full_name" id="add_user_full_name" value="" style="width:175px;" class="rounded" required >
                                    </td>
                                    
                                    
                                    
                                    
                                    
                                    <td style="width:2px;"></td>
                                    <th class="left middle" style="width:80px;">Login Name:</th>
                                    <td style="width:2px;"></td>
                                    
                                    <td class="frm" style="width:130px;">
                                        <input type="Text" name="add_user_name" id="add_user_name" value="" style="width:125px;" class="rounded" disabled required>
                                    </td>
                                    
                                    <td style="width:2px;"></td>
                                    <td class="frm" style="width:47px;padding:0px 0px 0px 5px;">
                                       <a id="edit_login_name_btn" class="button buttonText" style="height:17px;width:40px;padding:3px 0px 0px 0px;   cursor: pointer;"  >Edit</a>
                                   </td>
                                   
                                   
                                      <td style="width:2px;"></td>
                                   
                                   
                                   
                                    <th class="left middle" style="width:60px;">Password:</th>
                                        <td style="width:2px;"></td>
                                        
                                        <td class="frm" style="width:130px;" >
                                            <input type="password" name="add_user_password" id="add_user_password" value="" style="width:125px;" class="rounded" required>
                                        </td>
                                   
                                   
                                         <td style="width:2px;"></td>
                                           <td class="frm" style="width:47px;padding:0px 0px 0px 5px;" ><span id="reset_password_btn_td">
                                               <a id="reset_password_btn" class="button buttonText" style="height:17px;width:40px;padding:3px 0px 0px 0px;   cursor: pointer;"  >Reset</a></span>
                                          </td>    
                                        
                                        
                                        
                                     
                                   
                                    
						</tr>
                        
                        
                        
                        
                        
                        
					</table>
				</td>
			</tr>
            
            
            
            
            
            
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
                        
                                       
                                        
                                        
                                        
                                        
                                        
                                        
                                        <th class="left middle" style="height:30px;width:60px;">Agency:</th>
                                        <td style="width:2px;"></td>
                                        <td class="frm"  style="width:180px;">
                                                       <select name="add_user_agency" id="add_user_agency" class="rounded" style="width:175px;">
                                                                        <option value=""> </option>
                                                                            <cfset cnt = 1>
                                                                            
                                                                            <cfloop query="getAgency">
                                                                                <cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
                                                                                <option value="#name#" #sel#>#name#</option>
                                                                            </cfloop>
                                                       </select>
                                                                    
                                        </td>
                                        <td style="width:2px;"></td>
                                        
                                        
                                        
                                        
                                        <th class="left middle" style="width:80px;">Role:</th>
                                        <td style="width:2px;"></td>
                                        <td class="frm" style="width:130px;">
                                                 <select name="add_user_role" id="add_user_role" class="rounded" style="width:125px;" >
                                                                        <option value=""></option>
                                                                        
                                                                        <cfset cnt = 1>
                                                                        <cfloop query="getRole">
                                                                            <cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
                                                                            
                                                                            
                                                                                <!--- --------------- super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ --->  
                                                                            
																						<!---  only Max admin can add new Max Admin, other user would not see Max Admin option --->
                                                                                        <cfif Role_Name eq 'Max Admin'>
                                                                                        
                                                                                        
                                                                                               <cfif session.user_level gt 2 AND session.user_power gt 3> 
                                                                                        
                                                                                                          <option value="#Role_Name#" #sel#>#Role_Name#</option>
                                                                                               </cfif>
                                                                                
                                                                                        <cfelse>
                                                                                
                                                                                                  <option value="#Role_Name#" #sel#>#Role_Name#</option>
                                                                                
                                                                                
                                                                                        </cfif>
                                                                                    
                                                                                    
                                                                                <!--- --------- End ------ super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ --->       
                                                                                    
                                                                            
                                                                        </cfloop>
                                                                        
                                                 </select>
                                        </td>
                                        
                                        
                                        <td style="width:2px;"></td>
                                        
                                        
                                        
                                        <!---
                                        <th id="certificate_th" class="left middle" style="width:180px;">Can issue certificate of compliance:</th>
                                        <td id="certificate_td" class="frm"  style="width:20px;">
                                              <input type="checkbox" id="add_user_certificate_checkbox" style="width:20px;" class="rounded" required>
                                        </td>
                                        --->
                                        
                                        <th class="left middle" style="width:308px;">&nbsp;<span id="certificate_th"><span style="position:relative;top:-2px;">Can Issue Certificate of Compliance:</span> <span style="position:relative;top:1px;"><input type="checkbox" id="add_user_certificate_checkbox" style="width:20px;" class="rounded" required></span></span></th>
                                        <td id="certificate_td">
                                              
                                        </td>
                                        
                                        
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			
			
			
            
                       <!--- <tr> --->
                              <tr>	
                                    <td colspan="4" style="padding:0px 0px 0px 0px;background: #chr(35)#f5f5f5;">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                        
                                          <td class="left middle frm" id="user_exist_already"  style="height:30px;display:none;width:250px;"> Full Name Invalid</td>
                                          
                                          
                                          <td class="left middle frm" id="login_exist_already"  style="height:30px;display:none;width:250px;"> Login Name Invalid</td>
                                          
                                          
                                          <td class="left middle frm" id="all_field_required"  style="height:30px;display:none;width:180px;"> All Fields Required</td>
                              
                              
                                                  </tr>
                                        </table>
                                    </td>
                                </tr>
						    
                    
                   <!---  </tr> --->
			
			
			

		</table>
	</td>
	</tr>
		
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr><td style="height:3px;"></td></tr>
  <tr>
    <td align="center" style="padding:0px 10px 0px 0px;">
	<a id="cancel_btn" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;   cursor: pointer;">Cancel</a>
	</td>
  </tr>
  <tr><td style="height:5px;"></td></tr>
</table>


</div>






<!--- -------------------- End ------------ add User ---------------------------------------- --->





	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
	
	   
       
  <!--- <div id="msg2" class="box" style="top:40px;left:1px;width:300px;height:90px;display:none;z-index:505;">  --->
  <div id="msg2" class="box" style="position: absolute; left: 40%; top: 40%;  transform: translateY(-50%);   width:300px;height:90px;display:none;z-index:505;">
  


	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg2').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header2" class="box_header"><strong>Warning:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text2" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		Are you sure you want to delete this user?
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="45%">
			<tr>
			<td align="center">
				<a id="confirmed_removeUser_btn" href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;    cursor: pointer;">Continue...</a>
			</td>
			<td style="width:15px;"></td>
			<td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg2').hide();return false;">Cancel</a>
			</td>
			</tr>
			
		</table>
		</div>
		
	</div>
</div>
    
    
	
	

</body>

</cfoutput>
</html>



<!--- ------ bug fix:  swUserSearch.js   must load after above html get parsed and all other script loaded, you should not load it before html  -------------- --->
<!--- ------ bug fix: The external reference tag can't be self-closing. It should read <script type="text/javascript" src="/wherever/whatever.js"></script>  -------------- --->
<script language="JavaScript" src="../js/swUserSearch.js"></script>




<script>

		<cfoutput>
		var url = "#request.url#";
		</cfoutput>
		
		
		
		
		
		
</script>






            

				

	


