
<cfset brow = ""><cfif ucase(cgi.HTTP_USER_AGENT) contains "NETSCAPE"><cfset brow = "N">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "FIREFOX"><cfset brow = "F">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "OPERA"><cfset brow = "O">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "CHROME"><cfset brow = "C">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "MSIE" AND ucase(cgi.HTTP_USER_AGENT) contains "9.0"><cfset brow = "M">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "MSIE" AND ucase(cgi.HTTP_USER_AGENT) contains "10.0"><cfset brow = "M">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "rv:" AND ucase(cgi.HTTP_USER_AGENT) contains "11.0"><cfset brow = "M">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "rv:" AND ucase(cgi.HTTP_USER_AGENT) contains "12.0"><cfset brow = "M">
<cfelseif ucase(cgi.HTTP_USER_AGENT) contains "MSIE"><cfset brow = "IE">
</cfif>

<style> 
html, body { position:fixed; top:0px; left: 0px; height: 100%; width: 100%; margin: 0; padding: 0; overflow:hidden;} 

a {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-decoration: none;
	color: #request.color#;
}
a:visited {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color:#request.color#;
	text-decoration: none;
}

.page {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: #chr(35)#000000;
	text-decoration: none;
}
.page2{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: #chr(35)#000000;
	text-decoration: none;
}

.page3{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: #chr(35)#000000;
	text-decoration: none;
}

.pagegray {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: #chr(35)#C0C0C0;
	text-decoration: none;
}

.pagetitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-style: normal;
	line-height: normal;
	font-weight: bold;
	font-variant: normal;
	<cfoutput>
	color: #request.color#;
	</cfoutput>
	text-decoration: none;
}	

.mtmenubottom {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-decoration: none;
	color: #request.color#;
}
.mtmenuleft {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-decoration: none;
	color: #request.color#;
	border-bottom-width: 1px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: solid;
	border-left-style: none;
	border-bottom-color: #request.color#;

}
.mtmenuleft a{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-decoration: none;
	color: E36F1E;
}
.formtitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 21px;
	font-style: normal;
	line-height: normal;
	font-weight: bold;
	font-variant: normal;
	color: #request.color#;
	text-decoration: none;
}
.formbody {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: #chr(35)#000000;
	text-decoration: none;
}
.formbodybold {
font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-style: normal;
	line-height: normal;
	font-weight: bolder;
	font-variant: normal;
	color: 000000;
	text-decoration: none;
}
.copyright {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	color: 87746A;
	text-decoration: none;
}
.headerspaceleft {
	padding-left: 30px;
}
.headerspaceright {
	padding-right: 30px;
}
.actionmenu {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #chr(35)#FFFFFF;
	text-decoration: none;
	font-weight: bold;
	padding-left: 120px;
	padding-top: 2px;
}
.actionmenuheader {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #chr(35)#FFFFFF;
	text-decoration: none;
	font-weight: bold;
	padding-left: 120px;
	padding-top: 2px;
}

.formelement {
	border: 1px solid #chr(35)#999999;
	height: 22px;
}

.formtextarea {
	border: 1px solid #chr(35)#999999;
}

.search_container{
	border: 1px solid #chr(35)#999999;
	list-style-position: outside;
	list-style-type: disc;
	width: 450px;
}

td.pad { padding:4px 0px 4px 0px; }

.header { 
	font-size:40px; 
	font-family: Arial, Helvetica, sans-serif;
}

.subheader { 
	font-size:20px; 
	font-family: Arial, Helvetica, sans-serif;
}

.frame	{
			position:relative;
			top:0px;
			left:0px;
			z-index:25;
			
			width:100%;
			-webkit-border-radius: 4px 4px 4px 4px;
			-moz-border-radius: 4px 4px 4px 4px;
			border-radius: 4px 4px 4px 4px;

			<cfoutput>
			border: 1px solid #request.color#;
			</cfoutput>
			
			overflow:hidden;

			margin-left: auto;
  			margin-right: auto;		
			margin-top: 1px;	
			// padding: 2px 0px 1px 1px;
			text-align: left; 
			vertical-align: bottom;
			font: 10px Arial, Verdana, Helvetica, sans-serif;
			behavior: url(../htc/PIE.htc);	
		}
		
table.frame	{
			position:relative;
			top:0px;
			left:0px;
			z-index:25;
			
			width:100%;
			-webkit-border-radius: 4px 4px 4px 4px;
			-moz-border-radius: 4px 4px 4px 4px;
			border-radius: 4px 4px 4px 4px;

			<cfoutput>
			border: 3px solid #request.color#;
			</cfoutput>
			
			overflow:hidden;

			margin-left: auto;
  			margin-right: auto;		
			margin-top: 1px;	
			// padding: 2px 0px 1px 1px;
			text-align: left; 
			vertical-align: bottom;
			font: 10px Arial, Verdana, Helvetica, sans-serif;
			behavior: url(../htc/PIE.htc);	
		}
		
th {
			<cfoutput>
			background:#request.bgcolor#;
			color:#request.color#;
			</cfoutput>
			
			padding:1px 3px 1px 0px;
			height:15px;
			
			-moz-border-radius: 3px;
			-webkit-border-radius: 3px;
			border-radius: 3px;
			
			
			/* width:104px; */
			margin:1px 0px 1px 2px;
			text-align:right;
			font: 11px Arial, Verdana, Helvetica, sans-serif;
			behavior: url(../htc/PIE.htc);
			vertical-align:top;

			}
			
th.left {
	
			padding:1px 0px 1px 5px;
			height:15px;
			text-align:left;
			}
			
th.center {
		padding:1px 2px 1px 1px;
		text-align:center;
		}
		
th.right {
		text-align:right;
		}
		
th.middle {
		vertical-align:middle;
		}	
		
th.nopad { padding:0px; }	

th.small { font: 10px Arial, Verdana, Helvetica, sans-serif; }
		
td.frm {
			color:#666666;
			
			padding:2px 0px 0px 2px;
			height:15px;
			
			/* width:170px; */
			margin:1px 0px 1px 0px;
			font: 12px Arial, Verdana, Helvetica, sans-serif;
			<cfoutput>
			border:1px #request.ltecolor# solid;
			background:#request.ltecolor#;
			</cfoutput>
			
			-moz-border-radius: 4px;
			-webkit-border-radius: 4px;
			border-radius: 4px;
			behavior: url(../htc/PIE.htc);
	}
	
td.dd_select {
			
			padding:1px 0px 1px 4px;
			height:12px;
			/* width:170px; */
			margin:1px 0px 1px 0px;
			font: 11px Arial, Verdana, Helvetica, sans-serif;
			<cfoutput>
			border:1px #request.bgcolor# solid;
			background:#request.bgcolor#;
			</cfoutput>
			
			-moz-border-radius: 2px;
			-webkit-border-radius: 2px;
			border-radius: 2px;
			behavior: url(../htc/PIE.htc);
	}
	
td.dd {

			padding:1px 0px 1px 5px;
			height:14px;			
			/* width:170px; */
			margin:1px 0px 1px 0px;
			font: 11px Arial, Verdana, Helvetica, sans-serif;
			
	}
	
td.center { text-align:center; }

td.right { text-align:right; padding:2px 5px 0px 2px;}

td.small { font: 10px Arial, Verdana, Helvetica, sans-serif; }
	
	
th.drk {
			<cfoutput>
			background:#request.drkcolor#;
			border-color:#request.drkcolor#;
			</cfoutput>
			color:#000000;
	}
	
th.dropdown {

			-moz-border-radius: 1px;
			-webkit-border-radius: 1px;
			border-radius: 1px;
			font: 12px Arial, Verdana, Helvetica, sans-serif;

}
	
td.menubar {

			
			
			padding:2px 0px 0px 2px;
			height:25px;
			
			/* width:170px; */
			margin:1px 1px 1px 1px;
			font: 12px Arial, Verdana, Helvetica, sans-serif;
			<cfoutput>
			color:#request.ltecolor#;
			border:0px #request.ltecolor# solid;
			<!--- background:#request.color#; --->
			</cfoutput>
			
			/* -moz-border-radius: 4px;
			-webkit-border-radius: 4px;
			border-radius: 4px;
			behavior: url(../htc/PIE.htc); */
	}
	
td.fade {

			<cfoutput>
			background:#request.color#;
			background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.fadecolor#), to(#request.color#));
			background: -webkit-linear-gradient(#request.fadecolor#, #request.color#);
			background: -moz-linear-gradient(#request.fadecolor#, #request.color#);
			background: -ms-linear-gradient(#request.fadecolor#, #request.color#);
			background: -o-linear-gradient(#request.fadecolor#, #request.color#);
			background: linear-gradient(#request.fadecolor#, #request.color#);
			-pie-background: linear-gradient(#request.fadecolor#, #request.color#);
			
			/* background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.color#), to(#request.fadecolor#));
			background: -webkit-linear-gradient(#request.color#, #request.fadecolor#);
			background: -moz-linear-gradient(#request.color#, #request.fadecolor#);
			background: -ms-linear-gradient(#request.color#, #request.fadecolor#);
			background: -o-linear-gradient(#request.color#, #request.fadecolor#);
			background: linear-gradient(#request.color#, #request.fadecolor#);
			-pie-background: linear-gradient(#request.color#, #request.fadecolor#); */
			</cfoutput>
}
	
.button {
			
			-webkit-border-radius: 6px;
			-moz-border-radius: 6px;
			border-radius: 6px;
			display:inline-block;
			
			<cfoutput>
			background:#request.color#;
			background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.drkcolor#), to(#request.color#));
			background: -webkit-linear-gradient(#request.drkcolor#, #request.color#);
			background: -moz-linear-gradient(#request.drkcolor#, #request.color#);
			background: -ms-linear-gradient(#request.drkcolor#, #request.color#);
			background: -o-linear-gradient(#request.drkcolor#, #request.color#);
			background: linear-gradient(#request.drkcolor#, #request.color#);
			-pie-background: linear-gradient(#request.drkcolor#, #request.color#);
			
			
			border: 1px solid #request.color#;
			</cfoutput>
			color: #ffffff;
			
			/* padding: 2px 4px 0px 4px; */  
			text-align:center;
			outline:none;

			behavior: url(htc/PIE.htc);	
	}
	
	.button:hover {
	
			<cfoutput>
			background:#request.color#;
			background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.color#), to(#request.drkcolor#));
			background: -webkit-linear-gradient(#request.color#, #request.drkcolor#);
			background: -moz-linear-gradient(#request.color#, #request.drkcolor#);
			background: -ms-linear-gradient(#request.color#, #request.drkcolor#);
			background: -o-linear-gradient(#request.color#, #request.drkcolor#);
			background: linear-gradient(#request.color#, #request.drkcolor#);
			-pie-background: linear-gradient(#request.color#, #request.drkcolor#);
			</cfoutput>
			
			color: #ffffff;
			
			
			behavior: url(htc/PIE.htc);		
	}	
	
	.buttonText {
		font: 11px Arial, Verdana, Helvetica, sans-serif;
		text-decoration:none;
		padding:2px 0px 0px 0px;
	}
	
	.buttonSoft {
			
			-webkit-border-radius: 6px;
			-moz-border-radius: 6px;
			border-radius: 6px;
			display:inline-block;
			
			<cfoutput>
			background:#request.color#;
			background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.bgcolor#), to(#request.drkcolor#));
			background: -webkit-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -moz-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -ms-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -o-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
			-pie-background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
			border: 1px solid #request.drkcolor#;
			color: #request.color#; 
			</cfoutput>
			
			/* padding: 2px 4px 0px 4px; */  
			text-align:center;
			outline:none;

			behavior: url(htc/PIE.htc);	
	}
	
	input.rounded {
			border: 1px solid #ccc;
			-moz-border-radius: 6px;
			-webkit-border-radius: 6px;
			border-radius: 6px;
			
			font: 12px Arial, Verdana, Helvetica, sans-serif;
			/*color: #708090; */
			padding: 4px 7px 4px 4px;  
			outline:none;

			behavior: url(htc/PIE.htc);			
	}
	
	input.roundedsmall {
			border: 1px solid #ccc;
			-moz-border-radius: 6px;
			-webkit-border-radius: 6px;
			border-radius: 6px;
			
			font: 11px Arial, Verdana, Helvetica, sans-serif;
			/*color: #708090; */
			padding: 1px 5px 3px 2px;  
			outline:none;

			behavior: url(htc/PIE.htc);			
	}
	
	input.center { text-align:center;
				   padding: 4px 5px 4px 6px; }
	
select.rounded {
		border: 1px solid #ccc;
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		border-radius: 6px;
		
		font: 12px Arial, Verdana, Helvetica, sans-serif;
		/*color: #708090; */
		height:24px;
		padding: 0px 0px 0px 2px; 
		margin:0px 0px 2px 0px; 
		outline:none;

		behavior: url(htc/PIE.htc);			
}

select.roundedsmall {
		border: 1px solid #ccc;
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		border-radius: 6px;
		
		font: 11px Arial, Verdana, Helvetica, sans-serif;
		/*color: #708090; */
		height:20px;
		padding: 0px 0px 0px 2px; 
		margin:0px 0px 2px 0px; 
		outline:none;

		behavior: url(htc/PIE.htc);			
}
	
textarea.rounded {
		border: 1px solid #ccc;
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		border-radius: 6px;
		
		font: 12px Arial, Verdana, Helvetica, sans-serif;
		/*color: #708090; */
		height:24px;
		padding: 4px 4px 2px 7px; 
		margin:0px 0px 2px 0px; 
		outline:none;

		behavior: url(htc/PIE.htc);			
}

textarea {
    resize: none;
}
	
.ui-datepicker {
	<cfoutput>
    background: #request.bgcolor#;
    border: 1px solid #request.color#;
    color: #request.drkcolor#;
	font-size: 10px;
	margin-left: -50px;
	margin-top:2px;
	</cfoutput>
}

.ui-widget-header {
	
	<cfoutput>
	background:#request.color#;
	background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.bgcolor#), to(#request.drkcolor#));
	background: -webkit-linear-gradient(#request.bgcolor#, #request.drkcolor#);
	background: -moz-linear-gradient(#request.bgcolor#, #request.drkcolor#);
	background: -ms-linear-gradient(#request.bgcolor#, #request.drkcolor#);
	background: -o-linear-gradient(#request.bgcolor#, #request.drkcolor#);
	background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
	-pie-background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
	border: 1px solid #request.drkcolor#;
	</cfoutput>
	color: #000000; 
	
	behavior: url(htc/PIE.htc);	
}

.ui-menu-item {
    font-family: Arial, Verdana, Helvetica, sans-serif;
    font-size: 10px;
}


.box {
			position:absolute;
			top:10px;
			left:10px;
			width:100px;
			height:100px;
			
			-webkit-border-radius: 8px;
			-moz-border-radius: 8px;
			border-radius: 8px;
			
			-webkit-box-shadow: #666 0px 4px 5px;
			-moz-box-shadow: #666 0px 4px 5px;
			box-shadow: #666 0px 4px 5px;
			
			<cfoutput>
			border: 1px solid #request.color#;
			</cfoutput>
			overflow: hidden;
			
			behavior: url(htc/PIE.htc);
	}
	
.box_bottom {
			position:absolute;
			bottom:10px;
			left:10px;
			width:100px;
			height:100px;
			
			-webkit-border-radius: 8px;
			-moz-border-radius: 8px;
			border-radius: 8px;
			
			-webkit-box-shadow: #666 0px 4px 5px;
			-moz-box-shadow: #666 0px 4px 5px;
			box-shadow: #666 0px 4px 5px;
			
			<cfoutput>
			border: 1px solid #request.color#;
			</cfoutput>
			overflow: hidden;
			
			behavior: url(htc/PIE.htc);
	}

.box_header

	{
		position:absolute;
		top:0px;
		left:0px;
		z-index:20;
		height:15px;
		
		width:100%;
		
		-webkit-border-radius: 8px 8px 0px 0px;
		-moz-border-radius: 8px 8px 0px 0px;
		border-radius: 8px 8px 0px 0px;

		<cfoutput>
		background:#request.color#;
		background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.bgcolor#), to(#request.drkcolor#));
		background: -webkit-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -moz-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -ms-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -o-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
		-pie-background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
		border: 1px solid #request.drkcolor#;
		color: #request.color#; 
		</cfoutput>
		
		
		padding: 3px 0px 1px 5px;
		text-align: center; width: 100%;
		vertical-align: bottom;



		font: 11px Arial, Verdana, Helvetica, sans-serif;
		
		behavior: url(htc/PIE.htc);	
	
	
	}
	
.box_body {

		position:absolute;
		top:0px;
		z-index:10;

		width:100%;
		height:100%;
		
		-webkit-border-radius: 8px;
		-moz-border-radius: 8px;
		border-radius: 8px;
		
		<cfoutput>
		background: #request.bgcolor#;
		</cfoutput>
		
		padding: 0px;
		overflow: hidden;
		font: 11px Arial, Verdana, Helvetica, sans-serif;
		
		behavior: url(htc/PIE.htc);	
	}

.closex {
		position:absolute;
		left:2px;
		top:2px;
	}
	
.close {
			
		position:absolute;
		top:5px;
		right:6px;
		height:12px;
		width:12px;
		
		-webkit-border-radius: 2px;
		-moz-border-radius: 2px;
		border-radius: 2px;
		display:inline-block;
		
		<cfoutput>
		background:#request.color#;
		background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.bgcolor#), to(#request.drkcolor#));
		background: -webkit-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -moz-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -ms-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: -o-linear-gradient(#request.bgcolor#, #request.drkcolor#);
		background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
		-pie-background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
		border: 1px solid #request.drkcolor#;
		color: #request.color#; 
		</cfoutput>
		
		/* padding: 2px 4px 0px 4px; */  
		text-align:center;

		behavior: url(htc/PIE.htc);	
	}
	
input.file {
	position: absolute;
	text-align: right;
	z-index: 2;
	<cfif brow is "M">
		width:400px;
		height:21px;
	<cfelse>
		height:20px;
		width:400px;
	</cfif>
	
	-moz-opacity:0;
	opacity:0;
	filter:alpha(opacity:0);
	
}

.file_header {
			position:relative;
			<cfoutput>
			background:#request.color#;
			background: -webkit-gradient(linear, 0 0, 0 bottom, from(#request.bgcolor#), to(#request.drkcolor#));
			background: -webkit-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -moz-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -ms-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: -o-linear-gradient(#request.bgcolor#, #request.drkcolor#);
			background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
			-pie-background: linear-gradient(#request.bgcolor#, #request.drkcolor#);
			border: 1px solid #request.drkcolor#;
			color: #request.color#; 
			</cfoutput>
			
			-moz-border-radius: 3px;
			-webkit-border-radius: 3px;
			border-radius: 3px;
			
			height:15px;
			
			<cfif brow is "M">
				padding:2px 3px 0px 0px;
			<cfelse>
				padding:2px 3px 0px 0px;
			</cfif>
			width:104px;
			margin:1px 0px 1px 2px;
			text-align:right;
			font: 11px Arial, Verdana, Helvetica, sans-serif;
			behavior: url(htc/PIE.htc);
		}
	
div.fileinputs {
	position: absolute;
	top:2px;
	left:2px;
	border: 1px solid #ccc;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	width:300px;
	font: 11px Arial, Verdana, Helvetica, sans-serif;
	<cfif brow is "M">
	padding: 2px 7px 2px 4px; 
	height:14px; 
	<cfelse>
	padding: 1px 7px 7px 4px;  
	height:10px;
	</cfif>
	overflow:hidden;
	outline:none;

	behavior: url(htc/PIE.htc);			
}

/*
  ===================== joe hu  7/17/2018 ----- add progressing loading sign 
*/


#loading-img {
    background: url(../images/preloader.gif) center center no-repeat;
    height: 100%;
    z-index: 20;
}

.overlay {
    background: #e9e9e9;  
    display: none;        
    position: absolute;   
    top: 0;                  
    right: 0;               
    bottom: 0;
    left: 0;
    opacity: 0.5;
	z-index:1000;
}
/*
   ====== end ========= joe hu  7/17/2018 ----- add progressing loading sign 
*/








/*
  ===================== super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu 
*/

            .overlay_editable {
								background: #e9e9e9;  
								display: none;        
								position: absolute;   
								top: 0;                  
								right: 0;               
								bottom: 0;
								left: 0;
								opacity: 0.4;
								z-index:100;
							}





                       /* The switch - the box around the slider */
									.switch {
									  position: relative;
									  display: inline-block;
									  width: 50px;
									  height: 24px;  
									  
									}
									
									/* Hide default HTML checkbox */
									.switch input {
									  opacity: 0;
									  width: 0;
									  height: 0;
									}
									
									/* The slider */
									.slider {
									  position: absolute;
									  cursor: pointer;
									  top: 0;
									  left: 0;
									  right: 0;
									  bottom: 0;
									  background-color: #8fbce6;  /*  #e7f2fc;     #ccc;    */
									  -webkit-transition: .4s;
									  transition: .4s;
									}
									
									.slider:before {
									  position: absolute;
									  content: "";
									  height: 16px;
									  width: 16px;
									  left: 4px;
									  bottom: 4px;
									  background-color: white;
									  -webkit-transition: .4s;
									  transition: .4s;
									}
									
									input:checked + .slider {
									  background-color: #3b6a97;  /*  #2196F3;   */
									}
									
									input:focus + .slider {
									  box-shadow: 0 0 1px #3b6a97;  /*  #2196F3;   */
									}
									
									input:checked + .slider:before {
									  -webkit-transform: translateX(26px);
									  -ms-transform: translateX(26px);
									  transform: translateX(26px);
									}
									
									/* Rounded sliders */
									.slider.round {
									  border-radius: 34px;
									}
									
									.slider.round:before {
									  border-radius: 50%;
									}




                 /*   for toggle switch    */
                   #lock-wrapper {
							  display: flex;
							}
							
							






    

/*
   ====== end ========= super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu 
*/



















</style> 