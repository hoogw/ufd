

// --------- not use ----------------------
 function expandTextArea(tarea,rows,dy) {
	var l = $('#' + tarea).val().split("\n").length;
	var dht = (rows*dy)+5;
	$('#' + tarea).height(dht);
	var nht = $('#' + tarea)[0].scrollHeight-6;
	if (nht > dht) {	$('#' + tarea).height(nht); }
}

 // ---------End  not use ----------------------


function showMsg(txt,cnt,header) {
	$('#msg_header').html("<strong>The Following Error(s) Occured:</strong>");
	if (typeof header != "undefined") { $('#msg_header').html(header); }
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}



function resetForm7() {
	if (treeSub == false) { $('#form7')[0].reset(); }
	$('#box_tree').hide();
	$('#msg5').hide();
	$('#attachments').hide();
}



function submitForm7() {

    alert(' submit .......... clicked.');

	var frm = $('#form7').serializeArray();
	frm.push({"name" : "tree_trn", "value" : trim($('#tree_trn').val()) });
	
	
	if ($('#tree_lock').is(':checked') == false) {	
		frm.push({"name" : "tree_lock", "value" : ""});
	}
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateTrees2&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);

		if(data.RESULT != "Success") {
			showMsg5(data.RESULT,1);
			return false;	
		}
		
		$('#box_tree').hide();
		$('#msg5').hide();
		$('#attachments').hide();
		toggleArrows();
		
		treeSub = true;
		
		
		
		
		showMsg("Tree Removals updated successfully!",1,"Tree Removal Form");
		
	  }
	});
	
}
 
 
 
 
 //----------------------------  tree js  ------------------------------
 
 
 

 
 
 
 
 $( document ).ready(function() {
                
				
				
				
				
				
	

       
        



});// document ready
	
	
	
	
	
	
	
	

 
 