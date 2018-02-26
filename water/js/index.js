// JavaScript Documentvar psearch = {};
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

function changeFrame_literal(source){
var surl = source;

document.getElementById('FORM').src = surl;
}


function changeFrame_post(source, post_data){
var surl = source;

//document.getElementById('FORM').src = surl;

 $.redirect(surl, post_data);

}



// -->

function getIFrameHeight() {
	return $('#FORM').height();
}

function getIFrameWidth() {
	return $('#FORM').width();
}



//----------------------- bottom part --------------------




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
	
	
	
	var div = document.getElementById('div_water');
	if (div != null) {
		lft = $('#div_water').offset().left + 18;
		$('#dd_water').css('left', lft + "px");
		$('#dd_water').css('top', t + "px");
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
	$('#dd_water').hide();
	$('#dd_search').hide();
	$('#dd_add').hide();
	$('#' + ctrl).show();
}

function hideDDs() {
	$('#dd_account').hide();
	$('#dd_create').hide();
	$('#dd_water').hide();
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





