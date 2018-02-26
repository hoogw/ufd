<!doctype html>


<cfset font_color = "ffffff">


<HTML>
<HEAD>
<TITLE>Sidewalk Repair Program</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- ImageReady Preload Script (mtmenu.psd) -->
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
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
url = source + "?r=" + rand;
if (typeof param != "undefined") { url = url + "&" + param; }
document.getElementById('FORM').src = url;
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

<div style="position:absolute;top:15px;right:20px;"><img src="images/BOE_Logo.png" width="152" height="88" alt=""></div>


<div align="center" style="position:absolute;top:5px;left:5px;border:0px red solid;width:100%;height:100%;"> 
  <table border="0" cellspacing="0" cellpadding="0" style="border:0px red solid;width:100%;height:100%;">
    <tr> 
      <td>
          <table border="0" cellpadding="0" cellspacing="0" style="position:absolute;top:0px;left:0px;border:2px #request.color# solid;width:99%;height:98%;overflow:hidden;">
            <tr> 
              <td style="position:absolute;top:0px;left:0px;width:100%;height:100%;" align="center" valign="top" background="images/sidewalk.png"> 
                  <table style="position:absolute;top:0px;left:0px;width:100%;height:100%;border:0px red solid;" border="0" cellspacing="0" cellpadding="0">
				  	 <tr> 
                      <td class="subheader" style="width:100%;height:20px;color:#request.color#;text-align:center;padding:10px 0px 0px 0px;">
					  Bureau of Engineering
					  </td>
                    </tr>
                    <tr> 
                      <td class="header" style="width:100%;height:70px;color:#request.color#;text-align:center;">
					  #ucase("Sidewalk Repair Program")#
					  </td>
                    </tr>
                    <tr> 
                      <td style="width:100%;height:20px;background:#request.color#;"></td>
                    </tr>
                    <tr> 
                      <td height="100%" align="center" valign="top"> 
                        <div align="center" style="width:100%;height:100%;"> 
                          <table style="width:100%;height:100%;" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td>
                                <table style="width:100%px;height:100%;" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td style="width:230px;position:relative;top:0px;left:0px;border-right:2px #request.color# solid;" valign="top">
									  <div id="toc" style="display:block;">
                                      <table style="width:230px;" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td valign="top"> 

										  	  <cfset h = 21>
                                              <table style="width:230px;border:0px red solid;" border="0" cellspacing="0" cellpadding="0">
											  	<tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('swWelcome.cfm');return false;"><font color="#request.color#">Go to Home Page</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('forms/swSiteEntry.cfm');return false;"><font color="#request.color#">Create a New Sidewalk Repair Site</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('forms/swPackageEntry.cfm','type=new');return false;"><font color="#request.color#">Create a New Repair Package</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('forms/swPackageEntry.cfm','type=add');return false;"><font color="#request.color#">Add Sites to an Existing Package</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('search/swSiteSearch.cfm');return false;"><font color="#request.color#">Search Sidewalk Repair Sites</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('search/swPackageSearch.cfm');return false;"><font color="#request.color#">Search Sidewalk Repair Packages</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('search/swDownloadData.cfm');return false;"><font color="#request.color#">Download Sidewalk Repair Data</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('search/swReports.cfm');return false;"><font color="#request.color#">Generate Sidewalk Repair Reports</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<!---  <tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="page" height="#h#"><font color="#request.color#">Reports</font></td>
                                                </tr>
                                                <tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="page" height="#h#"><a href="" onclick="javascript:changeFrame('ssdrSummaryReport.cfm');return false;">												  
												  <font color="#request.color#">&nbsp;&nbsp;SSDR Summary Activity Report</font></a>
												  </td>
                                                </tr>
												<tr> 
                                                  <td>&nbsp;</td>
                                                  <td class="page" height="#h#"><a href="" onclick="javascript:changeFrame('ssdrUserReport.cfm');return false;">												  
												  <font color="#request.color#">&nbsp;&nbsp;SSDR Users Report</font></a>
												  </td>
                                                </tr>
												<tr> 
                                                  <td>&nbsp;</td>
                                                  <td class="page" height="#h#"><a href="" onclick="javascript:changeFrame('ssdrIndUserReport.cfm');return false;">												  
												  <font color="#request.color#">&nbsp;&nbsp;SSDR Individual User Report</font></a>
												  </td>
                                                </tr>
												<tr> 
                                                  <td>&nbsp;</td>
                                                  <td class="page" height="#h#"><a href="" onclick="javascript:changeFrame('ssdrCorrectionsReport.cfm');return false;">												  
												  <font color="#request.color#">&nbsp;&nbsp;SSDR Corrections Report</font></a>
												  </td>
                                                </tr>
												<tr> 
                                                  <td>&nbsp;</td>
                                                  <td class="page" height="#h#"><a href="" onclick="javascript:changeFrame('ssdrAdjustorsReport.cfm');return false;">												  
												  <font color="#request.color#">&nbsp;&nbsp;SSDR Adjustors Report</font></a>
												  </td>
                                                </tr>
												<tr><td colspan="2" style="height:4px;width:100%;"></td></tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('ssdrDownloads.cfm');return false;"><font color="#request.color#">Downloads</font></a></td>
                                                </tr>
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr>
												<tr> 
                                                  <td class="page" height="#h#">&nbsp;</td>
                                                  <td class="pad"><a href="" onclick="javascript:changeFrame('ssdrUploads.cfm');return false;"><font color="#request.color#">Uploads</font></a></td>
                                                </tr> 
												<tr><td colspan="2" style="height:1px;width:100%;background:#request.color#;"></td></tr> --->
												<tr> 
                                                  <td colspan="2"><IFRAME NAME="FORM2" id="FORM2" SRC="toc.cfm" allowtransparency="true" background-color="transparent" scrolling="auto" frameborder="0" style="width:#request.width#px;overflow:hidden;border:0px red solid;">
</IFRAME></td>
                                                </tr>
												
                                                <tr> 
                                                  <td class="page" class="page" height="#h#">&nbsp;</td>
                                                  <td class="page">&nbsp;</td>
                                                </tr>
                                              </table>
											  </div>
                                            </td>
                                        </tr>
                                        <tr> 
                                          <td valign="top"></td>
                                        </tr>
                                      </table></td>
                                    	<td style="width:100%;height:100%;border:0px red solid;" valign="top">
                                       <IFRAME NAME="FORM" id="FORM" SRC="swWelcome.cfm" allowtransparency="true" background-color="transparent" style="height:100%;width:100%;border:0px red solid;" frameborder="0"></IFRAME>
                                     	</td>
                                  </tr>
                                </table></td>
                            </tr>
                            <tr> 
                      			<td style="width:100%;height:20px;background:#request.color#;">
								<div id="toc_div" style="position:relative;border:0px red solid;width:30px;top:2px;left:222px;" onclick="hideTOC();return false;" onMouseOver="this.style.cursor='pointer'"><img id="toc_img" src="images/arrow_left_w.png" width="8" height="15" title="Hide Table of Contents"></div>
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
</BODY>
</cfoutput>
</HTML>

<script>
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

</script>