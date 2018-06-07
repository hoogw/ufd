<cfparam name="attributes.title" default="">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<cfoutput>
<title>#attributes.title#</title>
</cfoutput>
<link href="../css/boe_main_2016_v1.css" rel="stylesheet" type="text/css">
<style>
/* Layout styling*/
* {
	margin:0px;
	padding:0px;
}

body {
	margin-top:0px;
	padding:0px;
	text-align:center;
}

.Pheader {
	width: 100%;
	height: 85px;
	margin: 0 auto;
	padding: 0px;
	background: linear-gradient(to bottom, #006699 , #4DC3FF);
}
		
.Pheader  a {
	text-decoration:none;
	color: #FFF;
}


.Pheader  a:visited {
	text-decoration: none;
	color: #FFF;
}


.Pheader  a:hover
{
	text-decoration: underline;
	color: red;
}

.headertitle {
	font-size: 120%;
	color: #33ffff;
	text-shadow: 1px 1px 1px #333333;
}

.headerbackground {
	width: 100%;
	height: 85px;
	top: 0;
}

.headerlinks {
	font-size: 12px;
	color: #FFF;
}

.footer {
	margin-left:  auto;
	margin-right: auto;
	margin-top: 25px;
	margin-bottom: 10px;
	font-size: 12px;
	color: silver;
}
</style>

<body>

<cfoutput>
		<!--- header background container --->
        <div class="Pheader">
			<!--- header container withing the background container 700 px wide--->
            <div style="width: 700px; height: 85px; margin-left: auto; margin-right: auto;">
			
                <div style="padding: 5px 0 0 0; width: 150px; height: 85px; float: left;"><!--- 2 --->
                    <a href="http://eng.lacity.org" target="_blank"><img src="/srr/images/boe_logo_75h1.png" alt="" width="132" height="75" /></a>
                </div><!-- 2 -->
				
				<!--- middle div 450px wide --->
                <div style="padding: 5px 0 0 0; width: 450px; height: 85px; float: left;">
					<!--- subdivs within middle div--->
                    <div style="width: 100%; height: 20px; text-align: right;"><span class="headerlinks"><a href="http://eng.lacity.org" target="_blank">Bureau of Engineering</a> | <a href="http://www.lacity.org" target="_blank">City of LA</a> | <a href="http://navigatela.lacity.org/navigatela" target="_blank">Navigate LA</a> | <a href="http://eng.lacity.org/apps/address_list/contact_list.pdf" target="_blank">Contact us</a></span></div>
                    <div style="width: 100%; height: 65px; padding-top: 15px;padding-left:25px;" class="headertitle">#attributes.maintitle#</div>
					<!--- subdivs within middle div--->
				
                </div>
				<!--- middle div 450px wide --->
				
				 <div style="padding: 5px 0 0 0; width: 100px; height: 85px; float: left;">
                    <a href="http://lacity.org" target="_blank"><img src="/srr/images/city_seal_75h1.png" alt="" width="75" height="75" /></a>
                </div>
				
			<!--- header container withing the background container 700 px wide--->
            </div>
			
        </div>
		<!--- header outer container --->



<div align="center" style="margin_top:0;margin-bottom:5px;"></div>
</cfoutput>