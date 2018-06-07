<!DOCTYPE html>
<html>
<head>
<!--- // validating not blank
/*var fld = document.form1.user_name;
var msg = "User Name is Required!";
if (fld.value == '')
{*/

/*fld.focus();
fld.select();*/ --->

<script>
var modal = document.getElementById('myModal');
var closeModal = document.getElementById('closeModal');
alert(modal);
alert(closeModal);
//modal.style.display = "block";
</script>

<!--- <script>
function checkForm()
{
// Get the modal
var modal = document.getElementById('myModal');
//var closeModal = document.getElementById("closeModal");

//document.getElementById("modal-content").innerHTML = "Hello World";

modal.style.display = "block";

return false;
}
// validating not blank


document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;
}

</script> --->


<style>
/* The Modal (background) */
.cmodal {
    display: none; /* Hidden by default */
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

.closeButton {
background: green;
border: 1 solid black;
border-radius: 5px;
padding: 5px;
margin-top:5px;
margin-bottom:5px;
margin-left:auto;
margin-right: auto;
}

.closeButton:hover,
.closeButton:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}


</style>
</head>
<body>

<form action="formValidation.cfm" method="post" name="form1" id="form1" onSubmit="return checkForm();">
User Name <input type="text" name="user_name" id="user_name">

<input type="submit" name="submit" id="submit" value="Submit">
</form>


<!-- Modal Div Start -->
<div name = "myModal" id="myModal" class="cmodal">
<!-- Modal content -->
<div class="modal-content">
<p>This Field is Required</p>
<div align="center"><input type="button" name="closeModal" id="closeModal" value="Close" class="closeButton"></div>
</div>
<!-- Modal content -->
</div>
<!-- Modal Div End -->

</body>
</html>