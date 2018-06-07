<cfmail to="Essam.Amarragy@lacity.org,Victor.Murillo@lacity.org,jimmy.lam@lacity.org" from="eng.LAPermits@lacity.org" subject="!!! MH PERMIT APPLICATION ERROR!!!" type="HTML">

MH PERMIT APPLICATION ERROR!<br><br>

<cfif isdefined("request.ref_no")>
REQUEST REFERENCE NUMBER:   <font color="red"><b>#request.ref_no#</b></font><br>
</cfif>
<BR>
<cfif isdefined("client.full_name")>
User:   <font color="red"><b>#client.full_name#</b></font><br>
</cfif>

==========================================<br>
Error occured while processing: #Error.Template#<br>
==========================================<br>
Query String: #Error.QueryString#<br>
==========================================<br>
Diagnostics:  #Error.Diagnostics#<br>
==========================================<br>
Date Time: #Error.DateTime#<br>
==========================================<br>
Browser: #Error.Browser#<br>
==========================================<br>
Remote Address: #Error.RemoteAddress#<br>
==========================================<br>
Referer: #Error.HTTPReferer#<br>
==========================================<br><br>
</cfmail>