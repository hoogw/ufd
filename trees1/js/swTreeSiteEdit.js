function submitForm() {

	$('#msg').hide();
	var errors = '';var cnt = 0;
	if (trim($('#sw_name').val()) == '')	{ cnt++; errors = errors + "- Facility Name is required!<br>"; }
	if (trim($('#sw_address').val()) == '')	{ cnt++; errors = errors + "- Address is required!<br>"; }
	if (trim($('#sw_type').val()) == '')	{ cnt++; errors = errors + "- Type is required!<br>"; }
	
	//var chk = $.isNumeric(trim($('#sw_tcon').val().replace(/,/g,""))); var chk2 = trim($('#sw_tcon').val());
	//if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Total Concrete must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_priority').val().replace(/,/g,""))); var chk2 = trim($('#sw_priority').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Priority No. must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_zip').val().replace(/,/g,""))); var chk2 = trim($('#sw_zip').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- Zip Code must be numeric!<br>"; }
	
	var chk = $.isNumeric(trim($('#sw_no_trees').val().replace(/,/g,""))); var chk2 = trim($('#sw_no_trees').val());
	if (chk2 != '' && chk == false)	{ cnt++; errors = errors + "- No. Trees to Remove per Arborist must be numeric!<br>"; }
	
	if ($('#sw_excptn').is(':checked') && $('#sw_excptn').is(':disabled') != true) {
		if($.trim($('#sw_excptn_notes').val()) == "") { cnt++; errors = errors + "- ADA Compliance Exception Notes cannot be blank!<br>"; }
	}

	if (errors != '') {
		showMsg(errors,cnt);		
		return false;	

	}
	

	var frm = $('#form1').serializeArray();
	//frm.push({"name" : "sw_notes", "value" : trim($('#sw_notes').val()) });
	//frm.push({"name" : "sw_loc", "value" : trim($('#sw_loc').val()) });
	//frm.push({"name" : "sw_damage", "value" : trim($('#sw_damage').val()) });
	//frm.push({"name" : "sw_tree_notes", "value" : trim($('#sw_tree_notes').val()) });
	
	//if ($('#sw_no_trees').is(':disabled')) { frm.push({"name" : "sw_no_trees", "value" : trim($('#sw_no_trees').val()) }); }
	
	//if ($('#sw_dsgnstart').is(':disabled')) { frm.push({"name" : "sw_dsgnstart", "value" : trim($('#sw_dsgnstart').val()) }); }
	//if ($('#sw_dsgnfinish').is(':disabled')) { frm.push({"name" : "sw_dsgnfinish", "value" : trim($('#sw_dsgnfinish').val()) }); }
	//if ($('#sw_tree_rm_date').is(':disabled')) { frm.push({"name" : "sw_tree_rm_date", "value" : trim($('#sw_tree_rm_date').val()) }); }
	
	frm = frm.filter(function(item) { return item.name !== "sw_excptn"; }); //Remove checkbox because will add in element loop
	
	for(var i=0; i < form1.elements.length; i++){
    	var e = form1.elements[i];
    	//console.log(e.name+"="+e.id);
		if (e.type != "checkbox") {
			if ($('#' + e.id).is(':disabled')) { frm.push({"name" : e.id, "value" : trim($('#' + e.id).val()) }); }
		}
		else {
			//console.log(e.id + "="+e.type);
			var v = "";
			if ($('#' + e.id).is(':checked')) { v = "1"; }
			frm.push({"name" : e.id, "value" : v });
		}
	}
	
	var pchk_new = trim($('#sw_severity').val()) + "|" + trim($('#sw_ait_type').val()) + "|" + trim($('#sw_costeffect').val()) + "|" + trim($('#sw_injury').val()) + "|" + trim($('#sw_disabled').val()) + "|" + trim($('#sw_complaints').val()) + "|" + trim($('#sw_pedestrian').val());

	if (pchk != pchk_new) { frm.push({"name" : "do_priority", "value" : 1 });     }

	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateSite&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		if (pchk != pchk_new) {
			if(data.PRIORITY != 0) { $('#sw_priority').val(data.PRIORITY); } else { $('#sw_priority').val(''); }
			pchk = pchk_new;
		}
		
		//Go to Referring Project...
		if (pid > 0 && search == false) {
			location.replace("swPackageEdit.cfm?pid=" + pid);
			return false;
		}
		
		
		
		$('#NO_TREES_TO_REMOVE_PER_ARBORIST').val($('#sw_no_trees').val());
		$('#TREES_REMOVED_DATE').val($('#sw_tree_rm_date').val());
		$('#TREE_REMOVAL_NOTES').val($('#sw_tree_notes').val());
		treeSub = true;
		
		showMsg("Site Information updated successfully!",1,"Site Information");
	  }
	});
	
}

function cancelUpdate() {
	if (search) { location.replace("../search/swSiteSearch.cfm"); }
	else if (crid > 0) { location.replace("swCurbRampEdit.cfm?crid=" + crid + "&search=" + crsearch); }
	else { location.replace("swPackageEdit.cfm?pid=" + pid); }
}

function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function goToPackage(pid) {
	location.replace(url + "forms/swPackageEdit.cfm?pid=" + pid);
}


function chkAccess() {

	var idx = $('#sw_type').val();
	var trig = false;
	
	$.each(arrIsCity, function(i, item) {
		if (idx == item) { trig = true; return false; }
	});

	if (trig) {
		$('#sw_ait_type').val(1);
		$('#sw_ait_type').attr('disabled', true);
	}
	else {
		$('#sw_ait_type').removeAttr('disabled');
	}	
}


function openViewer() 
{
var search="";
if (geoCnt == 0) {
	var chk = trim($('#sw_address').val());
	if (chk != "") { search = "&search=" + escape(chk); }
}

//console.log(search);
var url = "http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRP&ref_no=" + loc + "&pin=&return_url=http%3A%2F%2Fengpermits%2Elacity%2Eorg%2Fexcavation%2Fboe%2Fgo%5Fmenu%5Fgc%2Ecfm&allow_edit=" + ro + "&p_start_ddate=05-01-2003&p_end_ddate=05-30-2003" + search;
//console.log(url);

newWindow(url,'',900, 700,'no');
return false;
}



function newWindow(mypage, myname, w, h, scroll) 
{
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',menubar=no,resizable=yes,location=no';
	window.open(mypage,myname,winprops);
}

function showMsg2(txt,cnt,id) {
	$('#button2a').show();
	$('#button2b').hide();
	if (id == 1) {
		$('#button2a').hide();
		$('#button2b').show();
	}
	$('#msg_text2').html(txt);
	$('#msg2').height(35+cnt*14+30);
	$('#msg2').css({top:'50%',left:'50%',margin:'-'+($('#msg2').height() / 2)+'px 0 0 -'+($('#msg2').width() / 2)+'px'});
	$('#msg2').show();
}

function showMsg3(txt,cnt,id) {
	$('#button3a').show();
	$('#button3b').hide();
	if (id == 1) {
		$('#button3a').hide();
		$('#button3b').show();
	}
	$('#msg_text3').html(txt);
	$('#msg3').height(35+cnt*14+30);
	$('#msg3').css({top: ($('#btn2').position().top - 100) + 'px' ,left:'50%',margin:'-'+($('#msg3').height() / 2)+'px 0 0 -'+($('#msg3').width() / 2)+'px'});
	$('#msg3').show();
}



function calcSubTotal () {

	var chk = chkForm().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	
	if (errors != '') {
		showMsg2(errors,cnt);		
		return false;	
	}
	
	//$("#TRAFFIC_CONTROL_AND_PERMITS_quantity").val('1');
	//$("#MOBILIZATION_quantity").val('1');
	//$("#TEMPORARY_DRAINAGE_INLET_PROTECTION_quantity").val('1');

	$("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val('0');
	$("#MOBILIZATION_unit_price").val('0');
	$("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val('0');
	$("#contingency").val('0');
	
	var cnt = 0;
	while (cnt < 100) {
	
		var total = getSubTotal();
		//console.log(total);
		
		var pct1 = $("#TRAFFIC_CONTROL_AND_PERMITS_percent").val();
		var pct2 = $("#MOBILIZATION_percent").val();
		var pct3 = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_percent").val();
		
		var max1 = $("#TRAFFIC_CONTROL_AND_PERMITS_maximum").val().replace(',','')/1;
		var max2 = $("#MOBILIZATION_maximum").val().replace(',','')/1;
		var max3 = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_maximum").val().replace(',','')/1;
		
		var five1 = Math.round(total*pct1*100)/100;
		var five2 = Math.round(total*pct2*100)/100;
		var one = Math.round(total*pct3*100)/100;
		var con = Math.round(total*($("#contingency_percent").val())*100)/100;
		
		var tcp = $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val();
		var mob = $("#MOBILIZATION_unit_price").val();
		var tdip = $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val();
		
		if (pct1 < 0) { five1 = max1; }
		if (pct2 < 0) { five2 = max2; }
		if (pct3 < 0) { one = max3; }
		
		if (tcp != five1) {
			if (tcp < max1) { $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val(five1.toFixed(2)); }
			else {  $("#TRAFFIC_CONTROL_AND_PERMITS_unit_price").val(max1.toFixed(2)); }
		}
		
		if (mob != five2) {
			if (mob < max2) { $("#MOBILIZATION_unit_price").val(five2.toFixed(2)); }
			else {  $("#MOBILIZATION_unit_price").val(max2.toFixed(2)); }
		}
		
		if (tdip != one) {
			if (tdip < max3) { $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val(one.toFixed(2)); }
			else {  $("#TEMPORARY_DRAINAGE_INLET_PROTECTION_unit_price").val(max3.toFixed(2)); }
		}
		
		$("#e_subtotal").html(total.formatMoney(2));
		$("#contingency").val(con.formatMoney(2));		
		$("#ENGINEERS_ESTIMATE_TOTAL_COST").val((con+total).formatMoney(2));
		
	    cnt++;
	}
	engCalc = true;

}





function resetForm2() {
	if (adaSub == false) { $('#form4')[0].reset(); }
	$('#box_curb').hide();
	$('#msg4').hide();
}


function addRamp(sw_id) {
	location.replace(url + "forms/swCurbRampEntry.cfm?sw_id=" + sw_id + "&sid=" + sid + "&pid=" + pid + "&search=" + search);
}
 
function editRamp(crid) {
	location.replace(url + "forms/swCurbRampEdit.cfm?crid=" + crid + "&sid=" + sid + "&pid=" + pid + "&search=" + search + "&editcr=true");
}


function openEstimate() {
	$('#box').show();
	engCalc = false;
	conCalc = false;	
}

function openAssessment() {
	$('#box_ass').show();
}

function openChangeOrders() {
	$('#box_cor').show();
}

function chkCalculated() {
	var errors = ""; cnt = 1;
	if (engCalc == false) {	errors = errors + "- You have not calculated the Engineer's Estimate.<br>"; cnt++; }
	if (conCalc == false) {	errors = errors + "- You have not calculated the Contractor's Cost.<br>"; cnt++; }
	if (errors != "") { errors = errors + "Do you want to continue?"; }
	return errors + ":" + cnt;
}

function continueUpdate(id) {
	engCalc = true;
	conCalc = true;	
	submitForm2(id)
}

function showRemove() {
	$('#msg10').css({top:'50%',left:'50%',margin:'-'+($('#msg10').height() / 2)+'px 0 0 -'+($('#msg10').width() / 2)+'px'});
	$('#msg10').show();
}

function deleteSite(idx) {
	var frm = [];
	frm.push({"name" : "sid", "value" : sid });
	//console.log(frm);
	var typ = "deleteSite"; if (idx == 1) { typ = "restoreSite"; }
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=" + typ + "&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		if(data.RESULT != "Success") {
			showMsg4(data.RESULT,1);
			return false;	
		}
		location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid);
	  }
	});
}

function updateDefaultPrice() {

	var frm = [];
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=getDefaults&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		var query = jQuery.parseJSON(data.QUERY);
		//console.log(query);
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
				//console.log(item);
				$('#' + item[0] + '_unit_price').val(item[2].formatMoney(2));
			});
		}
	  }
	});
	
}

function addTotal(fld) {

	var qc = $('#ass_q_' + fld + '_quantity').val();
	var as = $('#ass_' + fld + '_quantity').val();
	if (isNaN(qc) || trim(qc) == '' ) { qc = 0; }
	if (isNaN(as) || trim(as) == '' ) { as = 0; }
	$('#ass_' + fld + '_total').html(parseInt(qc)+parseInt(as));

}





function showMsg5(txt,cnt) {
	$('#msg_text5').html(txt);
	$('#msg5').height(35+cnt*14+30);
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg5').height() / 2)+'px 0 0 -'+($('#msg5').width() / 2)+'px'});
	$('#msg5').show();
}

function addTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	$('#tr_' + typ + '_div_' + scnt + '_' + (cnt+1)).show();
	
	var pfx = "tr";
	if (typ == "add") { pfx = "tp"; }
	if (typ == "add0") { pfx = "tp0"; }
	
	$("#" + pfx + "dia_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "pidt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "trdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "swdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "ewdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "addr_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "species_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "type_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	if ( cnt < lgth2) { 
		$('#' + pfx + '_tot_' + scnt).html(cnt+1); 
		$('#tr_' + typ + '_cnt_' + scnt).val(cnt+1); 
		if (typ == "add") { calcTrees(); } 
		if (typ == "add0") { calcTrees0(); }
		
	}
}

function delTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	if (cnt != 0) {	
		$('#tr_' + typ + '_div_' + scnt + '_' + (cnt)).hide();
		$('#tr_' + typ + '_cnt_' + scnt).val(cnt-1); 
		var pfx = "tr";
		
		if (typ == "add") { pfx = "tp"; }
		if (typ == "add0") { pfx = "tp0"; }
		
		$("#" + pfx + "dia_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "pidt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "trdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "swdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "ewdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "addr_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "species_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "type_" + scnt + "_" + (cnt)).attr('disabled', true);
		$('#' + pfx + '_tot_' + scnt).html(cnt-1);
		if (typ == "add") { calcTrees(); }
		if (typ == "add0") { calcTrees0(); }
	}
}

function calcTrees() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	var tot = 0; var tot2 = 0;
	for (var i = 1; i < cnt+1; i++) {
		var cnt2 = parseInt($('#tr_add_cnt_' + i).val());
		
		for (var j = 1; j < cnt2+1; j++) {
			var v = parseInt($("#tpdia_" + i + "_" + j).val());
			if (v == 24) {
				tot++;
				//console.log("tot=" + tot);
			}
		}
		tot2 = tot2 + cnt2;
	}
	$('#tree_FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY').val(tot);
	
	if ($('#tree_lock').is(':checked') == false) {	
		$('#tree_INSTALL_ROOT_CONTROL_BARRIER_QUANTITY').val(tot2*14);
	}
}



// add0 calcTrees0 ---------- off site section.   add calcTrees without 0 means on site section
function calcTrees0() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	var tot = 0; var tot2 = 0;
	for (var i = 1; i < cnt+1; i++) {
		var cnt2 = parseInt($('#tr_add0_cnt_' + i).val());
		
		for (var j = 1; j < cnt2+1; j++) {
			var v = parseInt($("#tp0dia_" + i + "_" + j).val());
			if (v == 24) {
				tot++;
				//console.log("tot=" + tot);
			}
		}
		tot2 = tot2 + cnt2;
	}
	$('#tree_FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_QUANTITY').val(tot);
	
	if ($('#tree_lock').is(':checked') == false) {	
		$('#tree_INSTALL_ROOT_CONTROL_BARRIER_QUANTITY').val(tot2*14);
	}
}





function autoLock() {
	if ($('#tree_lock').is(':checked') == false) {	
		$('#tree_lock').prop('checked', true);
	}
}


function addSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	$('#trees_div_' + (cnt+1)).show();
	$('#trees_sir_cnt').val(cnt+1);
	$('#sir_' + (cnt+1)).removeAttr('disabled');
	$('#sirdt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_rmv_cnt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_add_cnt_' + (cnt+1)).removeAttr('disabled');
}

function delSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	if (cnt != 1) {	
		$('#trees_div_' + cnt).hide();
		$('#trees_sir_cnt').val(cnt-1); 
		$('#sir_' + cnt).attr('disabled', true);	
		$('#sirdt_' + cnt).attr('disabled', true);	
		$('#tr_rmv_cnt_' + cnt).attr('disabled', true);	
		$('#tr_add_cnt_' + cnt).attr('disabled', true);	
	}
}


function applyConValuesAll() {

	var frm = $('#form3').serializeArray();
	var frm2 = [];
	$.each(frm, function(i, item) {
		if (item.name.substr(0,2) == "c_") {
			if (item.name != "c_CONTRACTORS_COST") { frm2.push(item); }
		}
		if (item.name == "sw_id") { frm2.push(item); }
	});
	
	/* $.each(frm2, function(i, item) {
		console.log(item);
	}); */
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateContractorAll&callback=",
	  data: frm2,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		$('#msg_all').hide();
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1,"Contractor Pricing Update");
			return false;	
		}
		showMsg("Information updated successfully!",1,"Contractor Pricing Update");
	  }
	});
	

}
 
function showMsgAll() {
	$('#msg_all').css({top:'50%',left:'50%',margin:'-'+($('#msg_all').height() / 2)+'px 0 0 -'+($('#msg_all').width() / 2)+'px'});
	$('#msg_all').show();
}

function chkDesign() {
	if ($('#sw_designreq').val() == 1) {
		$("#sw_dsgnstart").removeAttr('disabled');
		$("#sw_dsgnfinish").removeAttr('disabled');
	}
	else {
		$("#sw_dsgnstart").attr('disabled', true);
		$("#sw_dsgnfinish").attr('disabled', true);
	}
}

function chkRampOnly() {
	if ($('#sw_curbramp').val() == 0) {
		//$("#sw_no_trees").removeAttr('disabled');
		//$("#sw_tree_rm_date").removeAttr('disabled');
		//$("#sw_tree_notes").removeAttr('disabled');
		
		
		//$("#sw_notes").removeAttr('disabled');
	}
	else {
		//$("#sw_no_trees").attr('disabled', true);
		//$("#sw_tree_rm_date").attr('disabled', true);
		//$("#sw_tree_notes").attr('disabled', true);
		
		
		//$("#sw_notes").attr('disabled', true);
	}
}

function openTreeForm() {

	console.log("here");

	if ($('#sw_curbramp').val() == 0) { $('#box_tree').show(); toggleArrows(); calcTrees(); }

}

function cancelAttach()
{
	$("#fi_rmvl").html('');
	$("#fi_arb").html('');
	$('#attach_file_form')[0].reset();
	$("#attachments").hide();
}

function setFileName (idx)
{
	var f = $("#file_" + idx ).val();
	if (f != '') {
		if (document.getElementById("file_" + idx).files[0].size > (1048576 * 10)) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Files must not be more than 10MB!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("&") >= 0)	{
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have the \"&\" character!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("#") >= 0) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have the \"#\" character!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
		else if (f.search("'") >= 0) {
			$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Filename must not have a single quote!");
			$("#attach_msg").show();
			$("#fi_div_" + idx ).html($("#fi_div_" + idx ).html());
			$("#fi_" + idx ).html('');
			f = '';
		}
	}
	
	$("#fi_" + idx ).html(f.replace(/C:\\fakepath\\/g,""));
}

function showAttach(txt,cnt) {
	$("#fi_rmvl").html('');
	$("#fi_arb").html('');
	$("#fi_cert").html('');
	$("#fi_curb").html('');
	$("#fi_memo").html('');
	$("#fi_roe").html('');
	$("#fi_prn").html('');
	$("#fi_rcurb").html('');
	$('#attach_file_form')[0].reset();
	$('#attach_msg').html('');
	$('#attachments').css({top:'50%',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	//$('#attachments').css({top:'200px',left:'50%',margin:'-'+($('#attachments').height() / 2)+'px 0 0 -'+($('#attachments').width() / 2)+'px'});
	$('#attachments').show();
}

function attachFiles(sw_id) {

	$("#attach_msg").hide();
	$('#attach_iframe').attr('src', "");
	document.getElementById("attach_file_form").action = "swUpload.cfm?sw_id=" + sw_id + "&r=" + Math.random();
	document.getElementById("attach_file_form").submit();
	
	var goBool = false;
	var counter = 0;
	intervalId = setInterval(function() {
    	//make this is the first thing you do in the set interval function
        counter++;
		if (typeof $( '#attach_iframe' ).contents().find('#response').html() != "undefined")
		 	goBool = true;
		//console.log(counter);
	    //make this the last check in your set interval function
	     if ( counter > 60 || goBool == true ) {
	          clearInterval(intervalId);
			  var msg = $( '#attach_iframe' ).contents().find('#response').html();
			  var doArb = $( '#attach_iframe' ).contents().find('#doARB').html();
			  var doRmvl = $( '#attach_iframe' ).contents().find('#doRMVL').html();
			  var doCert = $( '#attach_iframe' ).contents().find('#doCERT').html();
			  var doCurb = $( '#attach_iframe' ).contents().find('#doCURB').html();
			  var doMemo = $( '#attach_iframe' ).contents().find('#doMEMO').html();
			  var doRoe = $( '#attach_iframe' ).contents().find('#doROE').html();
			  var doPrn = $( '#attach_iframe' ).contents().find('#doPRN').html();
			  var doRCurb = $( '#attach_iframe' ).contents().find('#doRCURB').html();
			  var dir = $( '#attach_iframe' ).contents().find('#dir').html();
			  finishUploadFiles(msg,doArb,doRmvl,doCert,doCurb,doMemo,doRoe,doPrn,doRCurb,dir);
	     }
	//end setInterval
    } , 1000);

}

function finishUploadFiles(msg,doArb,doRmvl,doCert,doCurb,doMemo,doRoe,doPrn,doRCurb,dir){

	if (msg != "Success") {
		$("#attach_msg").html("<span style='color:red;'>Attachment Failed:</span> Please try again.");
		$("#attach_msg").show();
		return false;
	}
	
	if (doArb == "true") {
		$("#a_arb").attr('href', url + 'pdfs/' + dir + '/Arborist_Report.' + dir + '.pdf');
		$("#a_arb").attr('title', 'View Arborist Report PDF');
		$("#img_arb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_arb").css('visibility', 'visible');
	}
	if (doRmvl == "true") {
		$("#a_rmvl").attr('href', url + 'pdfs/' + dir + '/Tree_Removal_Permits.' + dir + '.pdf');
		$("#a_rmvl").attr('title', 'View Tree Removal Permits PDF');
		$("#img_rmvl").attr('src', '../images/pdf_icon.gif');
		$("#rmv_rmvl").css('visibility', 'visible');
	}
	if (doCert == "true") {
		$("#a_cert").attr('href', url + 'pdfs/' + dir + '/Certification_Form.' + dir + '.pdf');
		$("#a_cert").attr('title', 'View Certification Form PDF');
		$("#img_cert").attr('src', '../images/pdf_icon.gif');
		$("#rmv_cert").css('visibility', 'visible');
	}
	if (doCurb == "true") {
		$("#a_curb").attr('href', url + 'pdfs/' + dir + '/Curb_Ramp_Plans.' + dir + '.pdf');
		$("#a_curb").attr('title', 'Curb Ramp Plans PDF');
		$("#img_curb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_curb").css('visibility', 'visible');
	}
	if (doMemo == "true") {
		$("#a_memo").attr('href', url + 'pdfs/' + dir + '/Memos.' + dir + '.pdf');
		$("#a_memo").attr('title', 'Memo\'s PDF');
		$("#img_memo").attr('src', '../images/pdf_icon.gif');
		$("#rmv_memo").css('visibility', 'visible');
	}
	if (doRoe == "true") {
		$("#a_roe").attr('href', url + 'pdfs/' + dir + '/ROE_Form.' + dir + '.pdf');
		$("#a_roe").attr('title', 'View Tree Removal Permits PDF');
		$("#img_roe").attr('src', '../images/pdf_icon.gif');
		$("#rmv_roe").css('visibility', 'visible');
	}
	if (doPrn == "true") {
		$("#a_prn").attr('href', url + 'pdfs/' + dir + '/Tree_Prune_Permits.' + dir + '.pdf');
		$("#a_prn").attr('title', 'View Tree Prune Permits PDF');
		$("#img_prn").attr('src', '../images/pdf_icon.gif');
		$("#rmv_prn").css('visibility', 'visible');
	}
	if (doRCurb == "true") {
		$("#a_rcurb").attr('href', url + 'pdfs/' + dir + '/Revised_Curb_Ramp_Plans.' + dir + '.pdf');
		$("#a_rcurb").attr('title', 'Revised Curb Ramp Plans PDF');
		$("#img_rcurb").attr('src', '../images/pdf_icon.gif');
		$("#rmv_rcurb").css('visibility', 'visible');
	}
	
	$('#attachments').hide();
}

function showRemoveAttach(idx) {
	$('#msg7').css({top:'50%',left:'50%',margin:'-'+($('#msg7').height() / 2)+'px 0 0 -'+($('#msg7').width() / 2)+'px'});
	$('#msg7').show();
	$('#attached_type').val(idx);
}

function doRemoveAttach() {

	var ref = $('#a_rmvl').attr('href');
	var typ = $('#attached_type').val();
	if (typ == 1) {	ref = $('#a_arb').attr('href'); }
	else if (typ == 2) { ref = $('#a_cert').attr('href'); }
	else if (typ == 3) { ref = $('#a_roe').attr('href'); }
	else if (typ == 4) { ref = $('#a_memo').attr('href'); }
	else if (typ == 5) { ref = $('#a_curb').attr('href'); }
	else if (typ == 6) { ref = $('#a_prn').attr('href'); }
	else if (typ == 7) { ref = $('#a_rcurb').attr('href'); }
	
	var arrRef = ref.split("/");
	ref = arrRef[arrRef.length-1];
	dir = arrRef[arrRef.length-2];
	//console.log(ref);
	
	var frm = [];
	frm.push({"name" : "file_name", "value" : ref });
	frm.push({"name" : "dir", "value" : dir });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=doDeleteAttachment&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESPONSE != "Success") {
			$('#msg7').hide();
			return false;	
		}
		
		if (typ == 1) {
			$("#a_arb").removeAttr('href');
			$("#a_arb").removeAttr('title');
			$("#img_arb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_arb").css('visibility', 'hidden');
		}
		else if (typ == 2) {
			$("#a_cert").removeAttr('href');
			$("#a_cert").removeAttr('title');
			$("#img_cert").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_cert").css('visibility', 'hidden');
		}
		else if (typ == 3) {
			$("#a_roe").removeAttr('href');
			$("#a_roe").removeAttr('title');
			$("#img_roe").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_roe").css('visibility', 'hidden');
		}
		else if (typ == 4) {
			$("#a_memo").removeAttr('href');
			$("#a_memo").removeAttr('title');
			$("#img_memo").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_memo").css('visibility', 'hidden');
		}
		else if (typ == 5) {
			$("#a_curb").removeAttr('href');
			$("#a_curb").removeAttr('title');
			$("#img_curb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_curb").css('visibility', 'hidden');
		}
		else if (typ == 6) {
			$("#a_prn").removeAttr('href');
			$("#a_prn").removeAttr('title');
			$("#img_prn").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_prn").css('visibility', 'hidden');
		}
		else if (typ == 7) {
			$("#a_rcurb").removeAttr('href');
			$("#a_rcurb").removeAttr('title');
			$("#img_rcurb").attr('src', '../images/pdf_icon_trans.gif');
			$("#rmv_rcurb").css('visibility', 'hidden');
		}
		else {
			$("#a_rmvl").removeAttr('href');
			$("#a_rmvl").removeAttr('title');
			$("#img_rmvl").attr('src', '../images/pdf_icon_trans.gif');
			$("#img_arb").attr('title', 'View Arborist Report PDF');
			$("#rmv_rmvl").css('visibility', 'hidden');
		}
		
	  }
	});

}

function expandTextArea(tarea,rows,dy) {
	var l = $('#' + tarea).val().split("\n").length;
	var dht = (rows*dy)+5;
	$('#' + tarea).height(dht);
	var nht = $('#' + tarea)[0].scrollHeight-6;
	if (nht > dht) {	$('#' + tarea).height(nht); }
}

function toggleArrows() {

	if ($('#leftarrow').is(':visible')) {
		$("#leftarrow").hide();
		$("#rightarrow").hide();
	}
	else {
		$("#leftarrow").show();
		$("#rightarrow").show();
	}

}

function openAttachments() {
	//$('#box_attachments').css({top:'50%',left:'50%',margin:'-'+($('#box_attachments').height() / 2)+'px 0 0 -'+($('#box_attachments').width() / 2)+'px'});
	$('#box_attachments').show();
}


function resetForm8() {
	$('#box_attachments').hide();
	$('#msg5').hide();
	$('#attachments').hide();
}

function toggleADANotes() {
	if ($('#sw_excptn').is(':checked')) {
		$('#sw_excptn_notes').removeAttr('disabled');
	}
	else
	{
		$('#sw_excptn_notes').attr('disabled', true);
	}
}



$( "#sw_assdate" ).datepicker();
$( "#sw_qcdate" ).datepicker();
$( "#sw_antdate" ).datepicker();
$( "#sw_con_start" ).datepicker({maxDate:0});
$( "#sw_con_comp" ).datepicker({maxDate:0});
$( "#sw_logdate" ).datepicker();
$( "#sw_tree_rm_date" ).datepicker();
$( "#sw_dsgnstart" ).datepicker();
$( "#sw_dsgnfinish" ).datepicker();


Number.prototype.formatMoney = function(c, d, t){
var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };
 
 
 
 $( document ).ready(function() {
                console.log( _primary_key_id);
				console.log(_type_id );
				console.log(_package_no);
				console.log(_site_id );
				console.log(_crm_no );
				console.log( _rebate);
	
	
	
	
});// document ready
 
 