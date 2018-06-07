<cfmodule template="../common/header.cfm">

<cfif not isdefined("request.ar_status_cd") or #request.ar_status_cd# is "">
<div class="warning">Invalid Request!</div>
<cfabort>
</cfif>

 <!--- <cfoutput>#request.ar_status_cd#</cfoutput>
 <cfabort>   --->

<cfquery name="find_num" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT        dbo.ar_info.ar_id


, dbo.ar_info.sr_number
, ar_info.arKey


, dbo.ar_info.ddate_submitted



, dbo.ar_info.app_name_nn
, ar_info.JOB_ADDRESS



, dbo.ar_info.ar_status_cd


, dbo.ar_status.ar_status_desc
, dbo.ar_status.agency
, dbo.ar_status.ar_list_order
, dbo.ar_status.resolution_code_txt_311
, dbo.ar_status.suspend
<!--- , dbo.ar_status.status_code_311 --->
FROM            dbo.ar_info LEFT OUTER JOIN
                         dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd

where dbo.ar_info.ar_status_cd = '#request.ar_status_cd#'

 
</cfquery>

 
 
 
 
 
 
 

 
		
		
		
		
<style>

 li
  {margin: 30px;
  padding-bottom:0px;
 }
</style>

<body onload="window.open('', '_self', '');">
<div align="center">
<div align="right" style="width:900px; padding-bottom:10px; font-size:105%;">
<form>
<input type="button" name="back" id="back" value="Back" onClick="location.href='rpt_groupbyStatus.cfm'" class="submit">
</form>
</div>
</div>

<div class="textbox" style="width: 900px;">
<cfoutput><H1>#find_num.ar_status_desc# (List of Applications)</H1></cfoutput>
<table class="datatable" id="table1" style=" width: 100%;">
<tr>
<th >Number</th>
<th nowrap >Date Submitted</th>
<th nowrap>Applicant Name</th>

<th  nowrap>Job Address</th>
<th >Status</th>
<!--- <th style="font-size:14px" ></th>
<th style="font-size:14px" ></th> --->

</tr>

<cfloop query="#find_num#">

<cfoutput>
<tr>
<td align="center" valign="top"><a href="rpt_record_history.cfm?arKey=#arKey#" target="_blank">#sr_number#</a></td>
<td align="center" valign="top">#dateformat(ddate_submitted, "mm/dd/yyyy")#</td>
<td align="center" valign="top">#app_name_nn#</td>
<td aling="right" valign="top">#Job_address#</td>
<td align="center" valign="top">#ar_status_desc#</td>

</tr>
</cfoutput>
</cfloop>

</table>
</div>



<cfinclude template="footer.cfm">
