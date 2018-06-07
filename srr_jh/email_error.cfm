<cfmail to="Essam.Amarragy@lacity.org,Jimmy.Lam@Lacity.org" from="eng.lapermits@lacity.org" subject="!!! Sidwalk Repair Program (srr) !!!" type="HTML">
<font color="red"><b>Sidwalk Repair Program (srr)!</b></font><br>

<cfif isdefined("request.srr_id")>
REQUEST REFERENCE NUMBER:   <font color="red"><b>#request.srr_id#</b></font><br>
</cfif>
<BR>
<cfif isdefined("client.full_name")>
User:   <font color="red"><b>#client.full_name#</b></font><br>
</cfif>

Date and Time Error Encountered:   #dateformat(now(),"mm/dd/yyyy")# #timeformat(now(),"h:mm tt")#<br>
=====================================<br>
Error occurred while processing:   <font color="red"><b>#error.template#</b></font><br>
=====================================<br>
HTTP Referer:   #error.HttpReferer# <br>
=====================================<br>
User IP Address:  #error.RemoteAddress#<br>
=====================================<br>
User Browser:    #error.Browser# <br>
=====================================<br>
<B>Diagnostic Message(s):   #error.Diagnostics#</B><br>
=====================================<br>
Query String:   #error.QueryString#
</cfmail>