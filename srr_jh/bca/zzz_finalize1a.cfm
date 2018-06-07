<cfinclude template="header.cfm">

<cfinclude template="navbar2.cfm">

<form action="finalize2.cfm" method="post" name="form1" id="form1" role="form" novalidate="">
<div class="formbox">
<h1>Finalize Request</h1>

<div class="field">
<label>BSS/UFD Inspection Required?</label>
<input type="radio" name="x1" value="r"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="x1" value="c"> No
<textarea name="sign_comments" id="sign_comments" style="width:98%;height:50px;margin-top:5px;" placeholder="Explain ..."></textarea>
</div>


<div class="field">
<label for="zzz">Engineering Evaluation Required?</label>
<input type="radio" name="zzz" id="zzz" value="r"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="x2" id="zzz" value="c"> No
<textarea name="zzz" id="zzz" style="width:98%;height:50px;margin-top:5px;" placeholder="Explain ..."></textarea>
</div>

<div class="field">
<label for="zzz">Request/Estimate Completed?</label>
<input type="radio" name="zzz" id="zzz" value="r"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="zzz" id="zzz"  value="c"> No
</div>


</div>

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>

</form>


<cfinclude template="footer.cfm">

