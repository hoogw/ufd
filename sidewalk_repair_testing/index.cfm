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
<TITLE>Sidewalk Repair Program</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">


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
<SCRIPT TYPE="text/javascript">

var psearch = {};
var ssearch = {};

function newImage(arg) {
	if (document.images) {
		rslt = new Image();
		rslt.src = arg;
		return rslt;
	}
}

function changeImages() {
	if (document.images && (preloadFlag == true)) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
		}
	}
}

function changeFrame(source,param){
var rand = Math.random();
var surl = source + "?r=" + rand;
if (typeof param != "undefined") { surl = surl + "&" + param; }
document.getElementById('FORM').src = surl;
}
// -->

function getIFrameHeight() {
	return $('#FORM').height();
}

function getIFrameWidth() {
	return $('#FORM').width();
}

</SCRIPT>
<cfoutput>

<cfinclude template="css/css.cfm">

<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->


</HEAD>
<BODY BGCOLOR="#request.pgcolor#">

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
              <td style="position:absolute;top:0px;left:0px;width:100%;height:100%;" align="center" valign="top" background="images/sidewalk.png"> 
                  <table style="position:absolute;top:0px;left:0px;width:100%;height:100%;border:0px red solid;" border="0" cellspacing="0" cellpadding="0">
				  	 <tr> 
                      <td id="banner2_div" class="subheader" style="width:100%;height:20px;color:#request.color#;text-align:center;padding:10px 0px 0px 0px;">
					  <div id="banner2" style="position:relative;top:0px;">Bureau of Engineering</div>
					  </td>
                    </tr>
                    <tr> 
                      <td id="banner_div" class="header" style="width:100%;height:70px;color:#request.color#;text-align:center;">
					  <div id="banner">#ucase("Sidewalk Repair Program")#</div>
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
									<td id="div_create" class="center menubar" style="width:80px;" onClick="showDDs('dd_create');">
									<div onMouseOver="this.style.cursor='pointer';showDDs('dd_create');" 
									onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">Create</div>
									</td>
									</cfif>
								<td id="div_search" class="center menubar" style="width:70px;">
								<div onMouseOver="this.style.cursor='pointer';showDDs('dd_search');" onClick="showDDs('dd_search');"
								onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">Search</div>
								</td>
									<cfif session.user_level gte 2 AND session.user_power gte 0>
									<td id="div_add" class="center menubar" style="width:70px;" onClick="showDDs('dd_add');">
									<div onMouseOver="this.style.cursor='pointer';showDDs('dd_add');"
									onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">Add</div>
									</td>
									</cfif>
                                    
                                    
                                    <!--- joe hu 7/31/18 report access --->
									<cfif session.user_level gte 2 OR (session.user_power is 1 AND session.user_level is 0) OR (len(session.user_report) gt 0)>
                                    
                                    
									<td class="center menubar" style="width:80px;"
									onclick="changeFrame('search/swReports.cfm');hideDDs();" onMouseOver="this.style.cursor='pointer';">
									Reports
									</td>
									</cfif>
								</cfif>
								<td class="right menubar"></td>
								<cfif isdefined("session.userid")>
									<cfif session.user_level gte 3>
									<td class="center menubar" style="width:60px;" 
									onclick="changeFrame('search/swDownloadData.cfm');hideDDs();" onMouseOver="this.style.cursor='pointer';">
									Data
									</td>
									</cfif>
								</cfif>
								<cfif isdefined("session.userid") is false>
								<td class="center menubar" style="width:70px;" onClick="showLogin();" onMouseOver="this.style.cursor='pointer';">Login</td>
								<cfelse>
								<td class="center menubar" style="width:110px;" onClick="showDDs('dd_account');">
								<div onMouseOver="this.style.cursor='pointer';showDDs('dd_account');"
								onmouseout="hideDDs();" style="height:20px;border:0px red solid;position:relative;top:3px;">My&nbsp;Account</div>
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
                                <IFRAME NAME="FORM" id="FORM" SRC="swWelcome.cfm" allowtransparency="true" background-color="transparent" style="height:100%;width:100%;border:0px red solid;" frameborder="0"></IFRAME>
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
			onclick="changeFrame('forms/swSiteEntry.cfm');$('#chr(35)#dd_create').hide();" onMouseOver="this.style.cursor='pointer';">
			New Sidewalk Repair Site
			</th>
			</tr>
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
			onclick="changeFrame('search/swSiteSearch.cfm');$('#chr(35)#dd_search').hide();" onMouseOver="this.style.cursor='pointer';">
			Sidewalk Repair Site
			</th>
			</tr>
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
</cfoutput>

function showLogin() {
	$('#log_text').html('');
	$('#user').val('');
	$('#password').val('');
	$('#login').css('height',"170px");
	$('#login').css({top:'50%',left:'50%',margin:'-'+($('#login').height() / 2)+'px 0 0 -'+($('#login').width() / 2)+'px'});
	$('#login').toggle();
	$('#user').focus();
}

function chkLogin() {

	var frm = $('#form_login').serializeArray();
	//console.log(frm);
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=chkLogin&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if (data.RESPONSE == "Failed") {
		
			var msg = "<font color='" + clr + "'><strong>Password</strong></font> does not match <font color='" + clr + "'><strong>User ID</strong></font>.<br>For assistance with Login, Please Call: (213) 482-7124.";
			if (data.CHK == "log") {
				msg = "You are <font color='" + clr + "'><strong>NOT AUTHORIZED</strong></font> to enter this site.<br>For assistance with Login, Please Call: (213) 482-7124.";
			}
			$('#login').css('height',"200px");
			$('#log_text').html(msg);
		}
		else {
			var rand = Math.random();
			var surl = url //+ "?r=" + rand;
			top.location.replace(surl);
		}
	  }
	});
}

function doLogOff() {

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=doLogoff&callback=",
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);
		var rand = Math.random();
		var surl = url //+ "?r=" + rand;
		top.location.replace(surl);
	  }
	});
}

$(function() {
	$(document).keyup(function (e) { 
		if (e.keyCode == 13) { if( $('#login').is(':visible') ) { chkLogin(); } }
	});
});


function hideTOC() {
	if( $('#toc').is(':visible') ) {
		$('#toc').hide();
		$('#toc_img').attr('src','images/arrow_right_w.png');
		$('#toc_div').css('left','5px');
		$('#toc_img').attr('title','Show Table of Contents');
	}
	else {
		$('#toc').show();
		$('#toc_img').attr('src','images/arrow_left_w.png');
		$('#toc_div').css('left','222px');
		$('#toc_img').attr('title','Hide Table of Contents');
	}
}

function changeDDs() {
	
	var dw = $(document).width();
	if (dw < 500) {
		$("#banner").css('font-size',"24px");
		$("#banner").css('text-align',"left");
		$("#banner").css('padding',"0px 0px 0px 5px");
		$("#banner2").css('font-size',"14px");
		$("#banner2").css('top',"10px");
		$("#banner2").css('text-align',"left");
		$("#banner2").css('padding',"0px 0px 0px 7px");
		$("#boe_img").height(55);
		$("#boe_img").width(95);
		$("#boe_img").css('top',"0px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(50);
	}
	else if (dw < 560) {
		$("#banner").css('font-size',"24px");
		$("#banner").css('text-align',"left");
		$("#banner").css('padding',"0px 0px 0px 20px");
		$("#banner2").css('font-size',"14px");
		$("#banner2").css('top',"10px");
		$("#banner2").css('text-align',"left");
		$("#banner2").css('padding',"0px 0px 0px 20px");
		$("#boe_img").height(55);
		$("#boe_img").width(95);
		$("#boe_img").css('top',"0px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(50);
	}
	else if (dw < 580) {
		$("#banner").css('font-size',"28px");
		$("#banner").css('text-align',"left");
		$("#banner").css('padding',"0px 0px 0px 20px");
		$("#banner2").css('font-size',"18px");
		$("#banner2").css('top',"10px");
		$("#banner2").css('text-align',"left");
		$("#banner2").css('padding',"0px 0px 0px 20px");
		$("#boe_img").height(55);
		$("#boe_img").width(95);
		$("#boe_img").css('top',"0px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(50);
	}
	
	else if (dw < 700) {
		$("#banner").css('font-size',"28px");
		$("#banner").css('text-align',"left");
		$("#banner").css('padding',"0px 0px 0px 20px");
		$("#banner2").css('font-size',"18px");
		$("#banner2").css('top',"15px");
		$("#banner2").css('text-align',"left");
		$("#banner2").css('padding',"0px 0px 0px 20px");
		$("#boe_img").height(66);
		$("#boe_img").width(114);
		$("#boe_img").css('top',"5px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	else if (dw < 760) {
		$("#banner").css('font-size',"28px");
		$("#banner").css('text-align',"center");
		$("#banner").css('padding',"0px 0px 0px 0px");
		$("#banner2").css('font-size',"18px");
		$("#banner2").css('top',"15px");
		$("#banner2").css('text-align',"center");
		$("#banner2").css('padding',"0px 0px 0px 0px");
		$("#boe_img").height(66);
		$("#boe_img").width(114);
		$("#boe_img").css('top',"5px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	else if (dw < 790) {
		$("#banner").css('font-size',"32px");
		$("#banner").css('text-align',"center");
		$("#banner").css('padding',"0px 0px 0px 0px");
		$("#banner2").css('font-size', '');
		$("#banner2").css('top',"10px");
		$("#banner2").css('text-align',"center");
		$("#banner2").css('padding',"0px 0px 0px 0px");
		$("#boe_img").height(66);
		$("#boe_img").width(114);
		$("#boe_img").css('top',"5px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	else if (dw < 850) {
		$("#banner").css('font-size',"32px");
		$("#banner").css('text-align',"center");
		$("#banner").css('padding',"0px 0px 0px 0px");
		$("#banner2").css('font-size', '');
		$("#banner2").css('top',"10px");
		$("#banner2").css('text-align',"center");
		$("#banner2").css('padding',"0px 0px 0px 0px");
		$("#boe_img").height(77);
		$("#boe_img").width(133);
		$("#boe_img").css('top',"0px");
		$("#banner2_div").css('padding',"0px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	else if (dw < 940) {
		$("#banner").css('font-size',"36px");
		$("#banner").css('text-align',"center");
		$("#banner").css('padding',"0px 0px 0px 0px");
		$("#banner2").css('font-size', '');
		$("#banner2").css('top',"0px");
		$("#banner2").css('text-align',"center");
		$("#banner2").css('padding',"0px 0px 0px 0px");
		$("#boe_img").height(77);
		$("#boe_img").width(133);
		$("#boe_img").css('top',"5px");
		$("#banner2_div").css('padding',"10px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	else { 
		$("#banner").css('font-size', '');
		$("#banner").css('text-align',"center");
		$("#banner").css('padding',"0px 0px 0px 0px");
		$("#banner2").css('font-size', '');
		$("#boe_img").height(88);
		$("#boe_img").width(152);
		$("#boe_img").css('top',"0px");
		$("#banner2_div").css('padding',"10px 0px 0px 0px");
		$("#banner_div").height(70);
	}
	
	
	var t = ($('#div_home').offset().top + $('#div_home').height() + 1); var lft;
	var rght = ($(window).width()-3) - ($('#main_table').offset().left + $('#main_table').width());
	$('#dd_account').css('right', rght + "px");
	$('#dd_account').css('top', t + "px");
	
	var div = document.getElementById('div_create');
	if (div != null) {
		lft = $('#div_create').offset().left + 18;
		$('#dd_create').css('left', lft + "px");
		$('#dd_create').css('top', t + "px");
	}
	div = document.getElementById('div_search');
	if (div != null) {
		lft = $('#div_search').offset().left + 11;
		$('#dd_search').css('left', lft + "px");
		$('#dd_search').css('top', t + "px");
	}
	div = document.getElementById('div_add');
	if (div != null) {
		lft = $('#div_add').offset().left + 18;
		$('#dd_add').css('left', lft + "px");
		$('#dd_add').css('top', t + "px");
	}

}

function showDDs(ctrl) {
	$('#dd_account').hide();
	$('#dd_create').hide();
	$('#dd_search').hide();
	$('#dd_add').hide();
	$('#' + ctrl).show();
}

function hideDDs() {
	$('#dd_account').hide();
	$('#dd_create').hide();
	$('#dd_search').hide();
	$('#dd_add').hide();
}


function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

$(document).ready(function(){
	$(window).resize(function() {
		changeDDs();
	});
});

changeDDs();

</script>