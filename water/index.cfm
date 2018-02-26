<!doctype html>


<cfset font_color = "ffffff">

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

<HTML>
<HEAD>
<TITLE>Tree Replacement And Watering</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="apple-mobile-web-app-capable" content="yes" />
<cfif shellName is "Tablet">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, maximum-scale=2, minimum-scale=1, user-scalable=1.0">
<cfelse>
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=0.5, maximum-scale=1, minimum-scale=0.5, user-scalable=1.0">
</cfif>
<!-- Sets the style of the status bar for a web application. -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />





<!-- ImageReady Preload Script (mtmenu.psd) -->
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script src="js/google_analytics.js"></script> <!--- Mayor's Office requirement --->
<script src="js/index.js"></script> <!--- all javascript move to here --->








<cfoutput>

<cfinclude template="css/css.cfm">

<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->






<cfparam name="iframe" default="swWelcome.cfm" />


<cfset iframe_src = iframe />




</HEAD>



					<!--- ===================== get user full name ====================== --->
                         
                         <cfoutput>
                            <cfif isdefined("session.userid") is false>
                                
                            <cfset who_s = '' >
                           <cfelse>
										<cfif session.user_level lt 0>
                                            <script>
                                            self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
                                            </script>
                                           
                                            
                                            <cfset who_s = '' >
                                            
                                         <cfelse>
                                                    
                                                        <cfset _user_id = session.user_num>   
                                                    <script>
                                                    
                                                         var user_id = #_user_id#;
                                                         
                                                    </script>
                                                    
                                            
                                                 <cfquery name="get_user_full_name" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                                            
                                                             
                                                                  SELECT 
                                                                      User_FullName
                                                                      
                                                                  FROM tblUsers
                                                                  where User_ID = #_user_id#
                                                             
                                                 </cfquery>
                                                 
                                                  <cfset who_s = get_user_full_name.User_FullName >
                                            
                                            
                                            
                                            
                                           </cfif>
                                
                            </cfif>
                            </cfoutput>
                    
                         
                    
                                               
                    
                    
                    <!--- ==============         End   ================== get user full name ====================== --->
                    









                                               <!---  **********************  Get tree numbers  ********************   --->
 							 <cfquery name="search_tree_all" datasource="#request.sqlconn2#" dbtype="ODBC" >
                             			 <!---	Select count(*) as total from search_tree where deleted = 0    --->
                                         
                                          Select count(*) as total from vw_search_tree where deleted = 0
                                         
                             </cfquery>
                             
                              <cfset all_tree_total = search_tree_all.total >
                             

                           <!---
                              <cfloop query = "search_tree_all"> 
                                  <cfset all_tree_total = total >
                              </cfloop>
                           --->
                           
                           
                            <cfquery name="Between_7_to_10" datasource="#request.sqlconn2#" dbtype="ODBC" >
                             	<!---			Select count(*) as total from search_tree where deleted = 0 and days_since_last_water >= 7 
                     and days_since_last_water <= 10
					              --->
					 
					 Select count(*) as total from vw_search_tree where deleted = 0 and days_since_last_water >= 7 
                     and days_since_last_water <= 10
					 
                             </cfquery>
                             
                              <cfset Between_7_to_10_total = Between_7_to_10.total >
                           
                           
                           
                           
                           <cfquery name="more_than_10" datasource="#request.sqlconn2#" dbtype="ODBC" >
                             		<!---		Select count(*) as total from search_tree where deleted = 0 and days_since_last_water > 10  --->
                                                    Select count(*) as total from vw_search_tree where deleted = 0 and days_since_last_water > 10
                             </cfquery>
                             
                              <cfset more_than_10_total = more_than_10.total >
                           
                          
                           
                           
                                                <!---  *************     End    *********  Get tree numbers  ********************   --->
                           
                           


<BODY BGCOLOR="#request.pgcolor#" background="images/tree.jpg">


<div style="position:absolute;top:15px;left:20px;">
  <img style="position:relative;top:0px;" id="bss_img" src="images/bss_logo_new.jpg" width="88" height="88" alt="">
</div>

<div style="position:absolute;top:15px;right:20px;">
  <img style="position:relative;top:0px;" id="boe_img" src="images/BOE_Logo.png" width="152" height="88" alt="">
</div>


<div align="center" style="position:absolute;top:5px;left:5px;border:0px red solid;width:100%;height:100%;"> 
  <table border="0" cellspacing="0" cellpadding="0" style="border:0px red solid;width:100%;height:100%;">
    <tr> 
      <td>
	  	  <cfset clr = request.fadecolor>
		  <cfif brow is "C"><cfset clr = request.color></cfif>
          <table id="main_table" border="0" cellpadding="0" cellspacing="0" style="position:absolute;top:0px;left:0px;border:2px #clr# solid;width:99%;height:98%;overflow:hidden;">
            <tr> 
              <td style="position:absolute;top:0px;left:0px;width:100%;height:100%;" align="center" valign="top" > 
                  <table style="position:absolute;top:0px;left:0px;width:100%;height:100%;border:0px red solid;" border="0" cellspacing="0" cellpadding="0">
				  	
                    <!--
                    
                     <tr> 
                      <td id="banner2_div" class="subheader" style="width:100%;height:20px;color:#request.color#;text-align:center;padding:10px 0px 0px 0px;">
					  <div id="banner2" style="position:relative;top:0px;color:white;">Bureau of Engineering</div>
					  </td>
                    </tr>
                    --->
                    
                    <tr> 
                      <td id="banner2_div" class="subheader" style="width:100%;height:20px;color:#request.color#;text-align:center;padding:10px 0px 0px 0px;">
					  <div id="banner2" style="position:relative;top:0px;color:white;"></div>
					  </td>
                    </tr>
                    
                    
                    <tr> 
                      <td id="banner_div" class="header" style="width:100%;height:70px;color:#request.color#;text-align:center;">
					  <div id="banner" style="color:white;">#ucase("Tree Watering")#</div>
					  </td>
                    </tr>
                    <tr> 
                      <td class="fade" style="width:100%;height:25px;">
					  
					  	<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
							<tr>
                            
								<td id="div_home" class="center menubar" style="width:80px;" 
									onclick="changeFrame('swWelcome.cfm');hideDDs();" onMouseOver="this.style.cursor='pointer';">
											Home&nbsp;Page
								</td>
                                
                                
								<cfif isdefined("session.userid")>
                                
                                
									<cfif session.user_power gte 0 AND session.user_level gt 0>
                                    
                                    
                                             
                                    <!---
                                    
                                            <td id="div_create" class="center menubar" style="width:80px;" onClick="showDDs('dd_create');">
                                              <div onMouseOver="this.style.cursor='pointer';showDDs('dd_create');" 
                                                     onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">
                                                   Create
                                                </div>
                                            </td>
                                    --->
                                    
                                          
                                             
                                    
                                    
									</cfif>
                                    
                                    
                                    
                                  
                                    
                                   
                                    
                                <!---    
                                    
                                    
								<td id="div_search" class="center menubar" style="width:70px;">
										<div onMouseOver="this.style.cursor='pointer';showDDs('dd_search');" onClick="showDDs('dd_search');"
												onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">
                                                
                                                Search
                                        </div>
								</td>
                                
                                --->
                                
                                
                                
                                
                                 <td id="div_water" class="center menubar" style="width:70px;">
										<div onMouseOver="this.style.cursor='pointer';showDDs('dd_water');" onClick="showDDs('dd_water');"
												onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">
                                                
                                                Water
                                        </div>
								   </td>
                                
                                
                                
                                
                                
                                
                                
                                <!---
									<cfif session.user_level gte 2 AND session.user_power gte 0>
									<td id="div_add" class="center menubar" style="width:70px;" onClick="showDDs('dd_add');">
									<div onMouseOver="this.style.cursor='pointer';showDDs('dd_add');"
									onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">Add</div>
									</td>
									</cfif>
                               
							   ---> 
							        
									<cfif session.user_level gte 2 OR (session.user_power is 1 AND session.user_level is 0)>
									<td class="center menubar" style="width:80px;"
									onclick="changeFrame('search/swReports.cfm');hideDDs();" onMouseOver="this.style.cursor='pointer';">
									Reports
									</td>
									</cfif>
                                    
                                   
                                    
								</cfif>
                                
                                
								<td class="right menubar"></td>
								<cfif isdefined("session.userid")>
									<cfif session.user_level gte 3>
                                    
                                    <!---
									<td class="center menubar" style="width:60px;" 
									onclick="changeFrame('search/swDownloadData.cfm');hideDDs();" onMouseOver="this.style.cursor='pointer';">
									Data
									</td>
                                    
                                    --->
                                    
									</cfif>
								</cfif>
								<cfif isdefined("session.userid") is false>
								<td class="center menubar" style="width:70px;" onClick="showLogin();" onMouseOver="this.style.cursor='pointer';">Login</td>
								<cfelse>
								<td class="center menubar" style="width:110px;" onClick="showDDs('dd_account');">
                                
								<div onMouseOver="this.style.cursor='pointer';showDDs('dd_account');"
								onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;"><!---My&nbsp;Account  ---> #who_s# </div>
								</td>
								</cfif>
							</tr>
						</table>
					  
					  </td>
                    </tr>
                    <tr> 
                      <td height="100%" align="center" valign="top"> 
                        <div align="center" style="width:100%;height:100%;"> 
                          <table style="width:100%;height:100%;" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                             
                             	<td style="width:100%;height:100%;border:0px red solid;" valign="top">
                                <IFRAME NAME="FORM" id="FORM"  allowtransparency="true" background-color="transparent" style="height:100%;width:100%;border:0px red solid;" frameborder="0"></IFRAME>
                                
                                 <!---    <IFRAME NAME="FORM" id="FORM" SRC="swWelcome.cfm" allowtransparency="true" background-color="transparent" style="height:100%;width:100%;border:0px red solid;" frameborder="0"></IFRAME>   --->
                              	</td>
                               
                            </tr>
                            <tr> 
                      			<td class="fade" style="width:100%;height:20px;">
								<!--- <div id="toc_div" style="position:relative;border:0px red solid;width:30px;top:2px;left:222px;" onclick="hideTOC();return false;" onMouseOver="this.style.cursor='pointer'"><img id="toc_img" src="images/arrow_left_w.png" width="8" height="15" title="Hide Table of Contents"></div> --->
								</td>
                    		</tr>
                          </table>
                        </td>
                    </tr>
                  </table>
                </td>
            </tr>
          </table>
        </div>
		</td>
    </tr>
  </table>
</div>

<div id="login" class="box" style="top:40px;left:1px;width:320px;height:200px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#login').hide();return false;"><img src="images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div id="msg_header5" class="box_header"><strong></strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">

		<div id="msg_text5" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 0px;align:center;text-align:center;">
		
		<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:300px;border: 2px solid #request.drkcolor#;">
		<tr>
			<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
				<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
					<form id="form_login">
					<tr>
						<th class="drk left middle" colspan="2" style="height:20px;">Login:</td>
					</tr>
					<tr>
						<th class="left middle" style="height:30px;width:130px;">User ID:</th>
						<td class="frm" style="width:180px;padding:0px 0px 0px 5px;"><INPUT type="Text" name="user" id="user" value="" style="width:170px;" class="rounded"></td>
					</tr>
					<tr>
						<th class="left middle" style="height:30px;width:130px;">Password:</td>
						<td class="frm" style="width:180px;"><input class="rounded" type="password" name="password" id="password" maxlength="15" style="width:170px;"></td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		</table>
	
	<table align=center border="0" cellpadding="0" cellspacing="0">
		<tr><td height=10></td></tr>
		<tr>
			<td align="center">
				<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
				onclick="chkLogin();return false;">Submit</a>
			</td>
		</tr>
		<tr><TD height="35" colspan="3" class="page" align="center"><span id="log_text"><font color="#request.color#"><strong>Password</strong></font> does not match <font color="#request.color#"><strong>User ID</strong></font>.<br>For assistance with Login, Please Call: (213) 482-7124.</span></TD></tr>
	</table>
		
		
		</div>
		
	</div>
</div>

<cfset t = 136><cfif brow is "M"><cfset t = 133></cfif>
<div id="dd_account" style="position:absolute;top:#t#px;right:0px;display:none;z-index:999;" onMouseOver="$('#chr(35)#dd_account').show();" onMouseOut="$('#chr(35)#dd_account').hide();">
<table align="center" bgcolor="#request.color#" cellspacing="0" cellpadding="0" border="0">
<tr>	
	<td colspan="4" style="padding:1px">
		<table cellpadding="0" cellspacing="0" border="0">
			<!--- <tr><td style="height:4px;"></td></tr> --->
			<tr>
			<th class="dropdown left middle" style="height:20px;width:110px;" 
			onclick="changeFrame('changePassword.cfm');$('#chr(35)#dd_account').hide();" onMouseOver="this.style.cursor='pointer';">
			Change Password
			</th>
			</tr>
			<tr><td style="height:1px;"></td></tr>
			<tr>
			<th class="dropdown left middle" style="height:21px;" onClick="doLogOff();" onMouseOver="this.style.cursor='pointer';">
			Log off
			</th>
			</tr>
		</table>
	</td>
</tr>
</table>
</div>



<div id="dd_create" style="position:absolute;top:#t#px;left:0px;display:none;z-index:999;" onMouseOver="$('#chr(35)#dd_create').show();" onMouseOut="$('#chr(35)#dd_create').hide();">
        <table align="center" bgcolor="#request.color#" cellspacing="0" cellpadding="0" border="0">
                <tr>	
                    <td colspan="4" style="padding:1px">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <!--- <tr><td style="height:4px;"></td></tr> --->
                            <tr>
                            <th class="dropdown left middle" style="height:20px;width:150px;" 
                            onclick="changeFrame('forms/swTreeSiteEntry.cfm');$('#chr(35)#dd_create').hide();" onMouseOver="this.style.cursor='pointer';">
                            New Site
                            </th>
                            </tr>
                            
                            <!---
                            
                            <cfif isdefined("session.userid") is true>
                                <cfif session.user_level gte 2 AND session.user_power gte 0>
                                <tr><td style="height:1px;"></td></tr>
                                <tr>
                                <th class="dropdown left middle" style="height:21px;"
                                onclick="changeFrame('forms/swPackageEntry.cfm','type=new');$('#chr(35)#dd_create').hide();" onMouseOver="this.style.cursor='pointer';">
                                New Repair Package
                                </th>
                                </tr>
                                </cfif>
                            </cfif>
                            
                            <tr><td style="height:1px;"></td></tr>
                            <tr>
                            <th class="dropdown left middle" style="height:20px;width:150px;" 
                            onclick="changeFrame('forms/swCurbRampEntry.cfm');$('#chr(35)#dd_create').hide();" onMouseOver="this.style.cursor='pointer';">
                            New Curb Ramp
                            </th>
                            </tr>
                            
                            --->
                            
                        </table>
                    </td>
                </tr>
        </table>
</div>











<div id="dd_search" style="position:absolute;top:#t#px;left:0px;display:none;z-index:999;" onMouseOver="$('#chr(35)#dd_search').show();" onMouseOut="$('#chr(35)#dd_search').hide();">
<table align="center" bgcolor="#request.color#" cellspacing="0" cellpadding="0" border="0">
<tr>	
	<td colspan="4" style="padding:1px">
		<table cellpadding="0" cellspacing="0" border="0">
			<!--- <tr><td style="height:4px;"></td></tr> --->
               
               
                <tr>
                        <th class="dropdown left middle" style="height:20px;width:150px;" 
                        onclick="changeFrame('search/swTreeSiteSearch.cfm');$('#chr(35)#dd_search').hide();" onMouseOver="this.style.cursor='pointer';">
                        Tree Site
                        </th>
			    </tr>
                
                
                <!---
            
                    <tr><td style="height:1px;"></td></tr>
                    
					<tr>
                    <th class="dropdown left middle" style="height:21px;"
                    onclick="changeFrame('search/swPackageSearch.cfm');$('#chr(35)#dd_search').hide();" onMouseOver="this.style.cursor='pointer';">
                    Sidewalk Repair Package
                    </th>
                   
				    <tr><td style="height:1px;"></td></tr>
                    
					<tr>
                    <th class="dropdown left middle" style="height:21px;"
                    onclick="changeFrame('search/swCurbRampSearch.cfm');$('#chr(35)#dd_search').hide();" onMouseOver="this.style.cursor='pointer';">
                    Curb Ramp Repairs
                    </th>
                    </tr>
				--->	
				
					
		</table>
	</td>
</tr>
</table>
</div>







<!--- Bug,     mouse out on top of menu will NOT trigger this event,   only under menu works. onMouseOut="alert('out');$('#chr(35)#dd_water').hide(); hideDDs();" --->

<div id="dd_water" style="position:absolute;top:#t#px;left:0px;display:none;z-index:999;" onMouseOver="$('#chr(35)#dd_water').show();" onMouseOut="$('#chr(35)#dd_water').hide(); ">

<table align="center" bgcolor="#request.color#" cellspacing="0" cellpadding="0" border="0">
<tr>	
	<td colspan="4" style="padding:1px">
		<table cellpadding="0" cellspacing="0" border="0">
			<!--- <tr><td style="height:4px;"></td></tr> --->
                <tr>
                        <th class="dropdown left middle" style="height:20px;width:150px;" 
                        onclick="changeFrame_literal('search/swWateringSearch.cfm');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">   
                     <!---   onclick="location.href='search/swWateringSearch.cfm';" onMouseOver="this.style.cursor='pointer';">  --->
                        
                        
                        All Tree (#all_tree_total#)
                        </th>
                 </tr>
                 
                 <tr><td style="height:1px;"></td></tr>
                 <tr>       
                        
                        <th class="dropdown left middle" style="height:20px;width:150px;" 
                     <!---   onclick="changeFrame('search/swWateringSearch.cfm?dmt=7&dlt=10');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">   --->
                        onclick="changeFrame_literal('search/swWateringSearch.cfm?dmt=7&dlt=10');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">
                        
                       7 - 10 days (<font size="4" color="red">#Between_7_to_10_total#</font>)   
                       
                        </th>
                        
                   </tr>
                   
                   
                   <tr><td style="height:1px;"></td></tr>
                   
                 <tr>        
                         <th class="dropdown left middle" style="height:20px;width:150px;" 
                        onclick="changeFrame_literal('search/swWateringSearch.cfm?dmt=10');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">
                        > 10 days (<font size="4" color="red">#more_than_10_total#</font>)   
                        </th>
                        
			    </tr>
                
                
              <!---
                    <tr><td style="height:1px;"></td></tr>
                    
					<tr>
                        <th class="dropdown left middle" style="height:21px;"
                        onclick="changeFrame('water/swPackageSearch.cfm');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">
                        Sidewalk Repair Package
                        </th>
                    </tr>    
                   
				    <tr><td style="height:1px;"></td></tr>
                    
					<tr>
                        <th class="dropdown left middle" style="height:21px;"
                        	onclick="changeFrame('water/swCurbRampSearch.cfm');$('#chr(35)#dd_water').hide();" onMouseOver="this.style.cursor='pointer';">
                        	Curb Ramp Repairs
                        </th>
                    </tr>
					
				--->
					
		</table>
	</td>
</tr>
</table>
</div>









<div id="dd_add" style="position:absolute;top:#t#px;left:0px;display:none;z-index:999;" onMouseOver="$('#chr(35)#dd_add').show();" onMouseOut="$('#chr(35)#dd_add').hide();">
<table align="center" bgcolor="#request.color#" cellspacing="0" cellpadding="0" border="0">
<tr>	
	<td colspan="4" style="padding:1px">
		<table cellpadding="0" cellspacing="0" border="0">
			<!--- <tr><td style="height:4px;"></td></tr> --->
			<tr>
			<th class="dropdown left middle" style="height:20px;width:160px;" 
			onclick="changeFrame('forms/swPackageEntry.cfm','type=add');$('#chr(35)#dd_add').hide();" onMouseOver="this.style.cursor='pointer';">
			Site to an Existing Package
			</th>
			</tr>
		</table>
	</td>
</tr>
</table>
</div>




</BODY>
</cfoutput>
</HTML>

<script>

		<cfoutput>
			var url = "#request.url#";
			var clr = "#request.color#";
			
			
			
			
			changeFrame_literal('#iframe_src#');
			
			
			
		</cfoutput>


		changeDDs();
		
		
		
		

</script>