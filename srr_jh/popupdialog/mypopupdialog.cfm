<!DOCTYPE html>
<html>
<head>


<style>
/* The Modal (background) */
.modal {
    display: block; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.2); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding-top:10px;
	padding-left:10px;
	padding-right:10px;
	padding-bottom:10px;
    border: 1px solid #888;
	border-radius: 7px;
    width: 400px;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

.closeBtn {
background: green;
border: 1 solid black;
border-radius: 5px;
padding: 5px;
margin-top:5px;
margin-bottom:5px;
margin-left:auto;
margin-right: auto;
}

.closeBtn:hover,
.closeBtn:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}


</style>

<script>
// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");
var closeButton = document.getElementById("myCloseButton");
// Get the <span> element that closes the modal
// When the user clicks the button, open the modal


closeButton.onclick = function() {
    modal.style.display = "none";
}

var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>


</head>
<body>

<h2>Modal Example</h2>

<!-- Trigger/Open The Modal -->
<button id="myBtn">Open Modal</button>

<!-- Modal Div Start -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">×</span>
    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>

  <div align="center"><input type="submit" name="myCloseButton" id="myCloseButton" value="Close" class="closeBtn"></div>
  </div>
  
</div>
<!-- Modal Div End -->



</body>
</html>