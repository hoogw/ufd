<cfparam name="header_message" default="">
<cfparam name="request.date_from" default="">
<cfparam name="request.date_to" default="">
<cfparam name="listsort" default="address">
<cfparam name="request.sort" default="address">
<style>
* {
font-size: 14px;
}

.myButton {
  -webkit-border-radius: 50;
  -moz-border-radius: 50;
  border-radius: 50px;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  background: #596b8d;
  padding: 5px 7px 4px 4px;
  border: solid #090a0a 0px;
  text-decoration: none;
  text-align:center;
}
.myButton:link {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:visited {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}

.myButton:hover {
  background: #596a8d;
  background-image: -webkit-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -moz-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -ms-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: -o-linear-gradient(top, #596a8d, #9cc8e6);
  background-image: linear-gradient(to bottom, #596a8d, #9cc8e6);
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}

.myButton a:hover {
  text-decoration: none;
  text-align:center;  
  color: #ffffff;
}
  
.myButton:active {
  text-decoration: none;
  text-align:center;
  color: #ffffff;
}
</style>
<cfoutput>


<cfif #request.date_to# is "">
		<cfoutput>
		<BR>
		<div align="center"><FONT COLOR="Red"><B>DATE TO IS EMPTY!</B></font></div>
		<br><br>
		<div align="center">
		<form method="post">
		<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
		</form>
		</div>
		</cfoutput>
		<cfabort>
</cfif>

<cfif #request.date_from# is "">
		<cfoutput>
		<BR>
		<div align="center"><FONT COLOR="Red"><B>DATE FROM IS EMPTY!</B></font></div>
		<br><br>
		<div align="center">
		<form method="post">
		<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
		</form>
		</div>
		</cfoutput>
		<cfabort>
</cfif>

<cfif isdefined("request.date_to")>
	<cfif #request.date_to# is not "">
		<cfif isdate(#request.date_to#)>
		<cfelse>
			<cfoutput>
			<div align="center"><FONT COLOR="Red"><B>DATE TO IS NOT a date!</B></font></div>
			<br><br>
			<div align="center">
			<form method="post">
			<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
			</form>
			</div>
			</cfoutput>
			<cfabort>
		</cfif>
	</cfif>
</cfif>
<cfif isdefined("request.date_from")>
	<cfif #request.date_from# is not "">
		<cfif isdate(#request.date_from#)>
		<cfelse>
			<cfoutput>
			<div align="center"><FONT COLOR="Red"><B>DATE from IS NOT a date!</B></font></div>
			<br><br>
			<div align="center">
			<form method="post">
			<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
			</form>
			</div>
			</cfoutput>
			<cfabort>
		</cfif>
	</cfif>
</cfif>
</cfoutput>
<cfif #request.date_from# is not "" and #request.date_to# is not"">
<cfif #datediff("d",request.date_from,date_to)# LT 0>

<cfoutput>

<div align="center"><FONT COLOR="Red"><B>From date needs to be before the To date!</B></font></div>
<br><br>
<div align="center">
<form method="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfoutput>
<cfabort>
</cfif>
</cfif>
<cfoutput>
<cfset datefrom=#dateadd("d",0,request.date_from)#>
<cfset datefrom=#dateformat(datefrom,"yyyy-mm-dd")#>
<cfset dateto=#dateadd("d",1,request.date_to)#>
<cfset dateto=#dateformat(dateto,"yyyy-mm-dd")#>


<cfif #listsort# is "address">
<cfquery name="get_customer" datasource="#request.dsn#" dbtype="ODBC">
SELECT DISTINCT permit_info.customer_id, customers.bill_address1, customers.bill_address2, customers.bill_city, customers.bill_state, customers.bill_zip
FROM     permit_info INNER JOIN
                  customers ON permit_info.customer_id = customers.customer_id
WHERE (permit_info.ddate_issued > '#datefrom#') AND (permit_info.ddate_issued < '#dateto#')
ORDER BY customers.bill_address1, customers.bill_address2, customers.bill_city, customers.bill_state, customers.bill_zip
</cfquery>
<cfelseif #listsort# is "comp">
<cfquery name="get_customer" datasource="#request.dsn#" dbtype="ODBC">
SELECT DISTINCT permit_info.customer_id, customers.Last_Name, customers.First_Name
FROM            permit_info INNER JOIN
                         customers ON permit_info.customer_id = customers.customer_id
WHERE (permit_info.ddate_issued > '#datefrom#') AND (permit_info.ddate_issued < '#dateto#')
ORDER BY customers.Last_Name, customers.First_Name
</cfquery>
<cfelseif #listsort# is "custid">
<cfquery name="get_customer" datasource="#request.dsn#" dbtype="ODBC">
SELECT DISTINCT customer_id
FROM  dbo.permit_info
WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#')
</cfquery>
</cfif>

<!--- SELECT DISTINCT permit_info.customer_id, customers.bill_address1, customers.bill_address2, customers.bill_city, customers.bill_state, customers.bill_zip
FROM     permit_info INNER JOIN
                  customers ON permit_info.customer_id = customers.customer_id
WHERE  (permit_info.ddate_issued > '2016-06-30') AND (permit_info.ddate_issued < '2016-08-01')
ORDER BY customers.bill_address1, customers.bill_address2, customers.bill_city, customers.bill_state, customers.bill_zip --->

<!-- Written by: Essam Amarragy *** CITY OF LOS ANGELES *** 213.482.7122 *** Essam.Amarragy@lacity.org -->


<!--- <cfif #trim(form.search_value)# is "">

<div align="center"><span class="title">A Search Value is Required!</span></div>


<br><br>

<div align="center">
<FORM METHOD="post">
<INPUT TYPE="button" VALUE="BACK" OnClick="history.go( -1 );return true;">
</FORM>
</div>
<CFABORT>
</CFIF> --->

<!--- <cfinclude template="list_requests_table.cfm"> --->
<center>
<table>
<tr>
<td align="right">Billing Period:</TD>
<td align="left">#dateformat(request.date_from,"m/d/yyyy")#&nbsp;&nbsp;to&nbsp;&nbsp;#dateformat(request.date_to,"m/d/yyyy")#</td>
<td align="center"></TD>
</TR>
</table>

<table border="1" class= "datatable" style= "width:800px;">
<tr>
<th style="width:10%;">Id&nbsp;<a href="control.cfm?action=boareports&listsort=custid&date_to=#request.date_to#&date_from=#request.date_from#" class="myButton" style="text-decoration: none; text-align:center; color: white;">
<cfif #listsort# is "custid">
&##9661;
<cfelse>&##9671;
</cfif>
</a></th>
<th style="width:16.67%;">Company&nbsp;<a href="control.cfm?action=boareports&listsort=comp&date_to=#request.date_to#&date_from=#request.date_from#" class="myButton" style="text-decoration: none; text-align:center; color: white;">
<cfif #listsort# is "comp">
&##9661;
<cfelse>&##9671;
</cfif>
</a></th>
<th style="width:16.67%;">Branch/District</th>
<th style="width:20%;">Contact Person</th>
<th style="width:20%;">Contact Phone</th>
<th style="width:16.67%;">Contact Email</th>
<th>Billing Address&nbsp;<a href="control.cfm?action=boareports&listsort=address&date_to=#request.date_to#&date_from=#request.date_from#" class="myButton" style="text-decoration: none; text-align:center; color: white;">
<cfif #listsort# is "address">
&##9661;
<cfelse>&##9671;
</cfif>
</a></th>
<th style="width:16.67%;">## of Permits</th>
<th style="width:16.67%;">Total</th>
</tr>

</cfoutput>
<Cfset x=0>
<cfset grand_grand_tot=0>
<cfset grand_record_count=0>
<cfloop query="get_customer">
<cfoutput>
<cfquery name="get_customer_info" datasource="#request.dsn#" dbtype="ODBC">
SELECT customer_id, Last_Name, First_Name, Contact_person, contact_phone, contact_email, bill_address1, bill_to, bill_address2, bill_city, bill_state, bill_zip
FROM     customers
where customer_id = #get_customer.customer_id#
order by bill_address1, bill_to, bill_address2, bill_city, bill_state, bill_zip
</cfquery>

<cfquery name="get_permit_info" datasource="#request.dsn#" dbtype="ODBC">
SELECT ref_no
FROM  dbo.permit_info
WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') AND (customer_id = #get_customer.customer_id#)
</cfquery>

<cfquery name="get_sum_sdrf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(sdrf_fee,2)) AS sum_sdrf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (sdrf_bc = 'b') AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_ssdrf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(ssdrf_fee,2)) AS sum_ssdrf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (ssdrf_bc = 'b') AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_gross_grand_total" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(gross_grand_total,2)) AS sum_gross_grand_total FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_net_grand_total" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(net_grand_total,2)) AS sum_net_grand_total FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_traff_mgmt_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(traff_mgmt_fee,2)) AS sum_traff_mgmt_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_gross_inspec_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(gross_inspec_fee,2)) AS sum_gross_inspec_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_gross_eng_app_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(gross_eng_app_fee,2)) AS sum_gross_eng_app_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_net_inspec_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(net_inspec_fee,2)) AS sum_net_inspec_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_net_eng_app_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(net_eng_app_fee,2)) AS sum_net_eng_app_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#) AND (app_fee_bc = 'b')</cfquery>

<cfquery name="get_sum_mba_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(mba_fee,2)) AS sum_mba_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_one_stop_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(one_stop_fee,2)) AS sum_one_stop_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_training_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(training_fee,2)) AS sum_training_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_amount_to_bill" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(amount_to_bill,2)) AS sum_amount_to_bill FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_total_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(total_fee,2)) AS sum_total_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_special_eng_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(special_eng_fee,2)) AS sum_special_eng_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_prw_enf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(prw_enf_fee,2)) AS sum_prw_enf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_conad_prw_enf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(conad_prw_enf_fee,2)) AS sum_conad_prw_enf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_bss_prw_enf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(bss_prw_enf_fee,2)) AS sum_bss_prw_enf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_ladot_prw_enf_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(ladot_prw_enf_fee,2)) AS sum_ladot_prw_enf_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_sdrf_admin_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(sdrf_admin_fee,2)) AS sum_sdrf_admin_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (sdrf_admin_bc = 'b') AND (customer_id = #get_customer.customer_id#) OR (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (sdrf_admin_bc IS NULL) AND (customer_id = #get_customer.customer_id#)</cfquery>

<cfquery name="get_sum_bss_peak_hr_comp_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(bss_peak_hr_comp_fee,2)) AS sum_bss_peak_hr_comp_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_ladot_peak_hr_comp_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(ladot_peak_hr_comp_fee,2)) AS sum_ladot_peak_hr_comp_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>
<cfquery name="get_sum_bca_special_inspec_fee" datasource="#request.dsn#" dbtype="ODBC">SELECT SUM(round(bca_special_inspec_fee,2)) AS sum_bca_special_inspec_fee FROM  dbo.permit_info WHERE (ddate_issued >= '#datefrom#') AND (ddate_issued < '#dateto#') <!---AND (wo_no = '') --->AND (customer_id = #get_customer.customer_id#)</cfquery>


<cfset grand_tot=0>


<cfset sumsdrffee=0>
<cfset sumssdrffee=0>
<cfset sumtraffmgmtfee=0>
<cfset sumnetinspecfee=0>
<cfset sumnetengappfee=0>
<cfset summbafee=0>
<cfset sumonestopfee=0>
<cfset sumtrainingfee=0>
<cfset sumspecialengfee=0>
<cfset sumprwenffee=0>
<cfset sumconadprwenffee=0>
<cfset sumbssprwenffee=0>
<cfset sumladotprwenffee=0>
<cfset sumsdrfadminfee=0>
<cfset sumbsspeakhrcompfee=0>
<cfset sumladotpeakhrcompfee=0>
<cfset sumbcaspecialinspecfee=0>


<cfif #get_sum_sdrf_fee.sum_sdrf_fee# is not ""><cfset sumsdrffee=#get_sum_sdrf_fee.sum_sdrf_fee#></cfif>
<cfif #get_sum_ssdrf_fee.sum_ssdrf_fee# is not ""><cfset sumssdrffee=#get_sum_ssdrf_fee.sum_ssdrf_fee#></cfif>
<cfif #get_sum_traff_mgmt_fee.sum_traff_mgmt_fee# is not ""><cfset sumtraffmgmtfee=#get_sum_traff_mgmt_fee.sum_traff_mgmt_fee#></cfif>
<cfif #get_sum_net_inspec_fee.sum_net_inspec_fee# is not ""><cfset sumnetinspecfee=#get_sum_net_inspec_fee.sum_net_inspec_fee#></cfif>
<cfif #get_sum_net_eng_app_fee.sum_net_eng_app_fee# is not ""><cfset sumnetengappfee=#get_sum_net_eng_app_fee.sum_net_eng_app_fee#></cfif>
<cfif #get_sum_mba_fee.sum_mba_fee# is not ""><cfset summbafee=#get_sum_mba_fee.sum_mba_fee#></cfif>
<cfif #get_sum_one_stop_fee.sum_one_stop_fee# is not ""><cfset sumonestopfee=#get_sum_one_stop_fee.sum_one_stop_fee#></cfif>
<cfif #get_sum_training_fee.sum_training_fee# is not ""><cfset sumtrainingfee=#get_sum_training_fee.sum_training_fee#></cfif>
<cfif #get_sum_special_eng_fee.sum_special_eng_fee# is not ""><cfset sumspecialengfee=#get_sum_special_eng_fee.sum_special_eng_fee#></cfif>
<cfif #get_sum_prw_enf_fee.sum_prw_enf_fee# is not ""><cfset sumprwenffee=#get_sum_prw_enf_fee.sum_prw_enf_fee#></cfif>
<cfif #get_sum_conad_prw_enf_fee.sum_conad_prw_enf_fee# is not ""><cfset sumconadprwenffee=#get_sum_conad_prw_enf_fee.sum_conad_prw_enf_fee#></cfif>
<cfif #get_sum_bss_prw_enf_fee.sum_bss_prw_enf_fee# is not ""><cfset sumbssprwenffee=#get_sum_bss_prw_enf_fee.sum_bss_prw_enf_fee#></cfif>
<cfif #get_sum_ladot_prw_enf_fee.sum_ladot_prw_enf_fee# is not ""><cfset sumladotprwenffee=#get_sum_ladot_prw_enf_fee.sum_ladot_prw_enf_fee#></cfif>
<cfif #get_sum_sdrf_admin_fee.sum_sdrf_admin_fee# is not ""><cfset sumsdrfadminfee=#get_sum_sdrf_admin_fee.sum_sdrf_admin_fee#></cfif>
<cfif #get_sum_bss_peak_hr_comp_fee.sum_bss_peak_hr_comp_fee# is not ""><cfset sumbsspeakhrcompfee=#get_sum_bss_peak_hr_comp_fee.sum_bss_peak_hr_comp_fee#></cfif>
<cfif #get_sum_ladot_peak_hr_comp_fee.sum_ladot_peak_hr_comp_fee# is not ""><cfset sumladotpeakhrcompfee=#get_sum_ladot_peak_hr_comp_fee.sum_ladot_peak_hr_comp_fee#></cfif>
<cfif #get_sum_bca_special_inspec_fee.sum_bca_special_inspec_fee# is not ""><cfset sumbcaspecialinspecfee=#get_sum_bca_special_inspec_fee.sum_bca_special_inspec_fee#></cfif>

<cfset grand_tot=#sumsdrffee#>
<cfset grand_tot=#grand_tot#+#sumssdrffee#>
<cfset grand_tot=#grand_tot#+#sumtraffmgmtfee#>
<cfset grand_tot=#grand_tot#+#sumnetinspecfee#>
<cfset grand_tot=#grand_tot#+#sumnetengappfee#>
<cfset grand_tot=#grand_tot#+#summbafee#>
<cfset grand_tot=#grand_tot#+#sumonestopfee#>
<cfset grand_tot=#grand_tot#+#sumtrainingfee#>
<cfset grand_tot=#grand_tot#+#sumspecialengfee#>
<cfset grand_tot=#grand_tot#+#sumprwenffee#>
<cfset grand_tot=#grand_tot#+#sumconadprwenffee#>
<cfset grand_tot=#grand_tot#+#sumbssprwenffee#>
<cfset grand_tot=#grand_tot#+#sumladotprwenffee#>
<cfset grand_tot=#grand_tot#+#sumsdrfadminfee#>
<cfset grand_tot=#grand_tot#+#sumbsspeakhrcompfee#>
<cfset grand_tot=#grand_tot#+#sumladotpeakhrcompfee#>
<cfset grand_tot=#grand_tot#+#sumbcaspecialinspecfee#>

<tr bgcolor="##DFDFDF" class="one-line">
<td align="center" colspan="1">
#get_customer_info.customer_id#
</td>
<td align="center" colspan="1">
<A HREF="control.cfm?action=boareports2&customer_id=#get_customer_info.customer_id#&date_from=#request.date_from#&date_to=#request.date_to#&#request.addtoken#" target="_top">#get_customer_info.Last_Name#</A>
</td>
<td align="center" colspan="1">
#get_customer_info.First_Name#
</td>
<td align="center" colspan="1">
#get_customer_info.Contact_person#
</td>
<td align="center" colspan="1">
#get_customer_info.contact_phone#
</td>
<td align="center" colspan="1">
#get_customer_info.contact_email#
</td>
<td align="center" colspan="1" nowrap>
#get_customer_info.bill_address1# #get_customer_info.bill_address2#<br>#get_customer_info.bill_city#, <cfif #get_customer_info.bill_state# is "">CA<cfelse>#get_customer_info.bill_state#</cfif> #get_customer_info.bill_zip#
</td>
<td align="center" colspan="1">
#get_permit_info.recordcount#
</td>
<td align="center" colspan="1">
#numberformat(grand_tot,"_$_,___.__")#
</td>
</tr>
<cfset x=#x#+1>
<cfset grand_grand_tot=#grand_grand_tot#+#grand_tot#>
<cfset grand_record_count=#grand_record_count#+#get_permit_info.recordcount#>
</cfoutput>
</cfloop>
<cfoutput>
<tr>
<th>
Totals: 
</th>
<th colspan="6">
#x# Customers for #dateformat(request.date_from,"mmm dd, yyyy")# thru #dateformat(request.date_to,"mmm dd, yyyy")#
</th>
<th>
#grand_record_count#
</th>
<th>
#numberformat(grand_grand_tot,"_$_,___.__")#
</th>
</tr>
</table>
<!---<cfinclude template="../common/html_bottom.cfm">--->

</cfoutput>

<!--- SELECT DISTINCT customer_id
FROM  dbo.permit_info
WHERE (ddate_issued >= '2016-8-1') AND (ddate_issued <= '2016-8-31') --->




<!--- SELECT ref_no, customer_id, ddate_submitted, ddate_issued, requester, requester_phone, job_address1, boe_dist, job_sqft, sdrf_sqft, ssdrf_sqft, sdrf_fee, ssdrf_fee, 
               sdrf_bc, ssdrf_bc, app_fee_bc, traff_mgmt_fee, gross_inspec_fee, gross_eng_app_fee, net_inspec_fee, net_eng_app_fee, mba_fee, one_stop_fee, training_fee, 
               amount_to_bill, total_fee, Job_no, account_no, wo_no, no_fee_permit, permit_no, special_eng_hrs, special_eng_fee, actual_cost_based, prw_enf_fee, 
               bss_prw_enf_fee, conad_prw_enf_fee, ladot_prw_enf_fee, sdrf_admin_fee, sdrf_admin_bc, ut_no, bss_peak_hr_comp_fee, ladot_peak_hr_comp_fee, 
               bca_special_inspec_hrs, bca_special_inspec_fee, last_app_status, last_status_ddate
FROM  dbo.permit_info
WHERE (ddate_issued >= '2016-8-1') AND (ddate_issued <= '2016-8-31') AND (customer_id = 3) --->


<!--- SELECT SUM(job_sqft) AS sum_job_sqft
FROM  dbo.permit_info
WHERE (ddate_issued >= '2016-8-1') AND (ddate_issued <= '2016-8-31') AND (customer_id = 3) --->

