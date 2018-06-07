<cfoutput>
<form action="control.cfm?action=edit_assessment2.cfm&srr_id=#request.srr_id#&#request.addtoken#" id="form1" name="form1" method="post" enctype="multipart/form-data">

<div class="formbox" style="width:700px;">
<h1>Field Assessment</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<th>No.</th>
<th>DESCRIPTION</th>
<th>UNIT</th>
<th>Assessment Quantity</th>
<th>QC Quantity</th>
<th>TOTAL</th>
</tr>		

<tr>
<td>1</td>
<td>Mobilization</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>2</td>
<td>Traffic Control & Permits</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>3</td>
<td>Temporary Drainage Inlet Protection</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>4</td>
<td>Remove Sidewalk</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>6</td>
<td>Remove Curb</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>


<tr>
<td>7</td>
<td>Remove Curb & Gutter</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>8</td>
<td>Remove Driveway</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr><br>

<tr>
<td>9</td>
<td>Remove Asphalt</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>10</td>
<td>Excavation</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>11</td>
<td>4" Concrete Sidewalk & Driveway</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>

<tr>
<td>12</td>
<td>Concrete Curb</td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td><input type="text" size="6"></td>
<td>&nbsp;</td>
</tr>





</table>
</div>
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</form>
</cfoutput>
