<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level is 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
<cfif session.user_power lt 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Create New Tree Site</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>






<!---
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
--->

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>


<!---   version 1.6.4 has bug on selectall check box   --->
	
	<!---
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
	--->
    
    <script src="../js/angularjs.1.6.4/angular.min.js"></script>  
    <script src="../js/angularjs.1.6.4/angular-touch.min.js"></script>
	
   
     


<!---  our js must place behind Jquery js , sine jquery must load first before our js --->

<script language="JavaScript1.2" src="../js/swTreeSiteEntry.js"></script>


<!--- jquery ajax form 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.1/jquery.form.min.js" integrity="sha384-tIwI8+qJdZBtYYCKwRkjxBGQVZS3gGozr3CtI+5JF/oL1JmPEHzCEnIKbDbLTCer" crossorigin="anonymous"></script> 

--->



<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Site Number + 1 --->
<cfquery name="getID" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT max(location_no) as id FROM tblSites
</cfquery>
<cfset swid = getID.id + 1>













<!--- Get Yes No Values 
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<cfset dt = dateFormat(Now(),"mm/dd/yyyy")>
--->

<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<div  ng-app="app" ng-controller="siteController"  id="box" style="height:100%;width:100%;border:0px red solid;overflow-y:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="color:white;">Create New Tree Site</td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:700px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:30px;padding:0px 0px 0px 0px;">
			
			
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th class="drk left middle" style="width:527px;">Create New Tree Site:</th>
                        
                        
                        
									
						</tr>
					</table>
			
			
			</td>
		</tr>
			
            
            
            
            
            
			<tr>
				
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:30px;width:86px;">UFD Type:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:150px;">
                        
                        
                        <select name="sw_type" id="sw_type" class="rounded" style="width:145px;" required="required" ng-disabled="programType_disable"
                            ng-change="program_type_change()"
                            ng-model="program_type"
                            ng-options="option.TYPE for option in programType_options">
                            
                            
                        </select>
                        
                        
                        </td>
						
                        
                        
                        <td style="width:2px;"></td>
						<th class="left middle" style="width:91px;">Package Number:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						
                        
                         <select name="sw_pkg_no" id="sw_pkg_no" class="rounded" style="width:55px;"  ng-disabled="pakageNo_disable"
                            ng-change="package_no_change()"
                            ng-model="package_no"
                            ng-options="option.PACKAGE_NO for option in package_no_options">
                            
                            
                        </select>
                       
                        
                        
                        
                        
                        
                        <td style="width:2px;"></td>
						<th class="left middle" style="width:71px;">Site Number:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:90px;">
                        
                        <select name="sw_site_no" id="sw_site_no" class="rounded" style="width:85px;"  ng-disabled="siteNo_disable"
						    ng-change="site_no_change()"
                            ng-model="site_no"
                            ng-options="option.LOCATION_NO for option in site_no_options">
						    
						</select>
                        
                        
						
						</td>
                        
                        
						<td style="width:2px;"></td>
						<th class="left middle" style="width:22px;">CD:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:64px;">
						  
                          <!---
                          <input type="Text" ng-model="cd"  name="sw_cd" id="sw_cd"  style="width:59px;" class="rounded" ng-disabled="cd_disable">
                           --->
                        
                           <select name="sw_cd" id="sw_cd" class="rounded" style="width:59px;" required="required" ng-disabled="cd_disable"
                            
                            ng-model="cd"
                            ng-options="item for item in cd_options">
                            
                            
                        </select>
                        
                        
						</td>
						</tr>
					</table>
				</td>
				
				
			</tr>
            <tr>
				    <th class="left middle" style="width:90px;">Rebate:</th>
                    <td class="frm"  style="width:185px;">
                        <input type="Text" ng-model="rebate"  name="sw_rebate" id="sw_rebate" value="" style="width:184px;" class="rounded" ng-disabled="rebate_disable"></td>
                    </td>
                <th class="left middle" style="height:30px;width:85px;">SR No.:</th>
				
                
                <td class="frm"  style="width:295px;">
				<input type="Text" ng-model="crm"    name="sw_crm" id="sw_crm" value="" style="width:293px;" class="rounded" ng-disabled="crm_disable"></td>
                
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
        
        <!---
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="submitForm();return false;">Submit</a>
            --->
            
           
            
            <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			ng-click="submitForm();">Submit</a>
            
		</td>
        
        <!---
		<td style="width:15px;"></td>
		<td align="center">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="$('#chr(35)#form1')[0].reset();return false;">Clear</a>
		</td>
        --->
        
	</tr>
	<tr><td height=15></td></tr>
</table>
	
	
	
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
	


</div>
	

</body>
</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
</cfoutput>

</script>

</html>


            

				

	


