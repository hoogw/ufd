        function show_loading_img_spinner(elementID_appendTo, process_bar_id){
               
            
            // ===========  ajax loading image ========================
                 

                 //----------------------- spinner img ---------------------- 
                 // img(id='spinner' class='responsive-img' height='100%' width='100%' src='/public/images/spinner.gif')
                  
                 var spinner_img = document.createElement('img');
                  spinner_img.setAttribute("id", process_bar_id);
				 
				 
				 
				 // ========= this is for small icon next or between search/cancel button
				 //if (elementID_appendTo.match(/small.*/)) {
			    if (elementID_appendTo.indexOf("small") >= 0) {
					 
					 
				  console.log("small_icon ===== >>>");
				  spinner_img.setAttribute("style", "height:25px;width:25px;padding:3px 0px 0px 0px;");
				}
				 
				 
				 //-------------- align = left, right , center ---------------
				 
				  if (elementID_appendTo.indexOf("right") >= 0) {
				 
				     spinner_img.setAttribute("align", "right");
				 }
				 
				 if (elementID_appendTo.indexOf("left") >= 0) {
				 
				     spinner_img.setAttribute("align", "left");
				 }
				 
				  if (elementID_appendTo.indexOf("center") >= 0) {
				 
				     spinner_img.setAttribute("align", "center");
				 }
				 
				  //---------  End ----- align = left, right , center ---------------
				 
				 
				 
				 
                 //spinner_img.className = 'circle responsive-img';
                 //spinner_img.innerHTML = 'this created div contains class while created!!!';
                 spinner_img.setAttribute('src', '../images/preloader.gif' );
				
                  //------------- End ---------- spinner img ----------------------

                 var element = document.getElementById(elementID_appendTo);

                 console.log('elementID_appendTo --- ',elementID_appendTo);

                 element.appendChild(spinner_img);
                 //element.appendChild(preloader_div);


                 
                 // =====  End =====  ajax loading image  ============
				 
				 
				

          }//show_loading_img_spinner







          function remove_loading_img_spinner(elementID_remove){
                          
            var elem = document.getElementById(elementID_remove);
            elem.parentElement.removeChild(elem);

          }
		  
		  
		  
		  
		   function start_processing_sign(_result_panel,elementID_appendTo, process_bar_id){
                          
	         var _elem_id = '#' + 	_result_panel;				  
              //$("#result_panel").hide();
			    $(_elem_id).hide();
	 			show_loading_img_spinner(elementID_appendTo, process_bar_id)
          }
		  
		  
		  
		  
		  function wait(ms){
			  
			  console.log('start waiting ......');
						   var start = new Date().getTime();
						   var end = start;
						   while(end < start + ms) {
							 end = new Date().getTime();
						  }
			  console.log('.......waiting ...... Ended');
						  
		  }