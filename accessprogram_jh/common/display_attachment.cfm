<cfinclude template="validate_arKey.cfm">

<cfinclude template="html_top.cfm">
<script src="../jquery/js/jquery-1.11.1.min.js" type="text/javascript"></script>

	<style>
	#image1 {
    transform-origin: top left; /* IE 10+, Firefox, etc. */
    -webkit-transform-origin: top left; /* Chrome */
    -ms-transform-origin: top left; /* IE 9 */
}

#image1.rotate90 {
    transform: rotate(90deg) translateY(-100%);
    -webkit-transform: rotate(90deg) translateY(-100%);
    -ms-transform: rotate(90deg) translateY(-100%);
}
#image1.rotate180 {
    transform: rotate(180deg) translate(-100%,-100%);
    -webkit-transform: rotate(180deg) translate(-100%,-100%);
    -ms-transform: rotate(180deg) translateX(-100%,-100%);
}
#image1.rotate270 {
    transform: rotate(270deg) translateX(-100%);
    -webkit-transform: rotate(270deg) translateX(-100%);
    -ms-transform: rotate(270deg) translateX(-100%);
}
	</style>


<body onload="window.open('', '_self', '');">
<cfoutput>

<div align="center">
<button name="bbb" id="bbb" class="submit">Rotate</button>&nbsp;&nbsp;<input type="button" name="Close" value="Close" onClick="window.close();" class="submit"> 
</div>

<div align="center">
<img src="#request.upload_location#/uploads/#request.ar_id#/#file_name#"  alt="" width="900" border="0" id="image1">
</div>

</cfoutput>


<script language="JavaScript" type="text/javascript">
var angle = 0;
img = document.getElementById('image1');

document.getElementById('bbb').onclick = function() {
    angle = (angle+90)%360;
    img.className = "rotate"+angle;
}
</script>


</body>
</html>
