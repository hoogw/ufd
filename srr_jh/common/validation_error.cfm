<cfoutput>
<cfinclude template="/srr/common/html_top.cfm">

<div align="center"> <b> <font face="Arial" size="2"> <font color="blue">FORM 
FIELD VALIDATION ERROR! </font></font> </B> </div>

<BR>

<font face="Arial" size="2">
<B>ONE, OR MORE, OF THE VALUES YOU ENTERED IS NOT A VALID VALUE.</B>
</font>
<BR><BR>


<B><FONT color="red" size="2" face="Arial, Helvetica, sans-serif">
#error.InvalidFields#</FONT></B>&nbsp;&nbsp;
<BR>



<div align="center">
<FORM METHOD="post">
<input TYPE="button" VALUE="TRY AGAIN" OnClick="history.go( -1 );return true;">
</form>
</div>

<BR><BR>

<HR size="2" noshade>
<p><B><font face="Arial, Helvetica, sans-serif" size="2">If the above information 
did not solve the problem encountered, please highlight all text above this line 
and e-mail it to:&nbsp;</FONT> </B> <A href="mailto:#error.mailto#">Essam.Amarragy@lacity.org</A></p>
<p><b><font face="Arial, Helvetica, sans-serif" size="2">You may also print this 
page and fax to: Essam Amarragy at 213-847-8983 </font></b><font size="2" face="Arial, Helvetica, sans-serif">.</font><BR>
</p>
<HR size="2" noshade>

<cfinclude template="/srr/common/html_bottom.cfm">
</cfoutput>
<cfabort>