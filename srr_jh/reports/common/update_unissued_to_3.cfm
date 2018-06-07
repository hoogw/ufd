<!-- This Document is Disabled -->
<div align="center" style="	font-family: Arial, sans-serif, Verdana;font-size: 1.0em; color: maroon;"><b>This Document is Currently Disabled</b></div>
 <cfabort>  <!--- Uncomment Later --->
 
 <!--- Essam please check first how this will be apply --->
<!-- This Document is Disabled -->

<!-- A-Permit Rates -->
<CFQUERY NAME="update_a_fees" DATASOURCE=="#request.dsn#">
update permit_info
set rate_nbr = 3
where application_status <>  'issued'
</CFQUERY>

<cfquery name="rd_upFees" datasource="#request.dsn#">
select * from permit_info
where application_status <> 'issued'
</cfquery>



<cfoutput>
Records Updated: #rd_upfees.recordcount#
</cfoutput>

<cfmail to="Essam.Amarragy@lacity.org,Jimmy.Lam@Lacity.org" from="eng.lapermits@lacity.org" subject="!!! MH -PERMIT Update Unissued !!!" type="HTML">
<font color="red"><b>MH-PERMIT APPLICATION UPdated Unissued</b></font><br>

Date and Time Updated:  #dateformat(now(),"mm/dd/yyyy")# #timeformat(now(),"h:mm tt")#<br>
<cfoutput>
Records Updated: #rd_upfees.recordcount#
</cfoutput>
</cfmail>

<br><br>
done