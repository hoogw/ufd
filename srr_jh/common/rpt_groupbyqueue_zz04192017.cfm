<cfmodule template="../common/header.cfm">

 <!--- <cfoutput>#request.srr_status_cd#</cfoutput>
 <cfabort>   --->

<cfquery name="find_num" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT        
dbo.srr_info.srr_id
, srr_info.srrKey

, dbo.srr_info.sr_number


, dbo.srr_info.ddate_submitted



, dbo.srr_info.app_name_nn
, srr_info.APP_CONTACT_NAME_NN
, srr_info.JOB_ADDRESS



, dbo.srr_info.srr_status_cd


, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.resolution_code_txt_311
, dbo.srr_status.suspend
<!--- , dbo.srr_status.status_code_311 --->
FROM            dbo.srr_info LEFT OUTER JOIN
                         dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where dbo.srr_info.srr_status_cd = '#request.srr_status_cd#'

 
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
<cfoutput><H1>#find_num.srr_status_desc# (List of Applications)</H1></cfoutput>
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
<td align="center" valign="top"><a href="rpt_record_history.cfm?srrKey=#srrKey#" target="_blank">#sr_number#</a></td>
<td align="center" valign="top">#dateformat(ddate_submitted, "mm/dd/yyyy")#</td>
<td align="center" valign="top">#app_name_nn#</td>
<td aling="right" valign="top">#Job_address#</td>
<td align="center" valign="top">#srr_status_desc#</td>

</tr>
</cfoutput>
</cfloop>

</table>
</div>



<cfinclude template="footer.cfm">
