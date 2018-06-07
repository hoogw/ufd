<style>
.footer {
margin-left:  auto;
margin-right: auto;
margin-top: 25px;
margin-bottom: 10px;
font-size: 12px;
color: silver;
}
</style>

<!--- 

<cfoutput>
<div class = "notes">
<strong>Debugging Information that will be removed once in production:</strong><br>
<cfif isdefined("request.status_cd")>
SRR Status: #request.status_cd#<br>
</cfif>

<cfif isdefined("request.srrKey")>
SRR Key:  #request.srrKey#<br>
</cfif>

<cfif isdefined("request.sr_number")>
SR Number: #request.sr_number#<br>
</cfif>

<cfif isdefined("request.srr_id")>
SRR ID: #request.srr_id#<br>
</cfif>
<cfif isdefined("request.a_ref_no")>
A-Permit Ref. No.:  #request.a_ref_no#<br>
</cfif>


<cfif isdefined("request.srNum")>
SR Number to 311: #request.srNum#<br>
</cfif>

<cfif isdefined("request.srCode")>
SR Code to 311: #request.srCode#<br>
</cfif>

<cfif isdefined("request.srComment")>
SR Comment to 311: 
<br>
<strong><em>#left(request.srComment, 750)#</em></strong><br><br>
</cfif>

<cfif isdefined("request.srupdate_success")>
311 Update Successful: #request.srupdate_success#<br>
</cfif>

<cfif isdefined("request.srupdate_err_message")>
311 Update Error Msg: #request.srupdate_err_message#<br>
</cfif>

</div>
</cfoutput>

 --->
<div align="center" class="footer">&copy;&nbsp; 2000 - 2015 Bureau of Engineering, Department of Public Works, City of Los Angeles.</div>

</BODY>
</HTML>
