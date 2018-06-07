<cfinclude template="security.cfm">

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<meta name="description" content="Bureau of Engineering, City of Los Angeles, Excavation (U) Permits">
<meta name="keywords" content="Excavation Permit, U-Permit">
<meta name="author" content="Essam Amarragy">
<title>Excavation (U) Permits</title>
<link href="/styles/boe_main_gray.css" rel="stylesheet" type="text/css" src="/styles/boe_main_gray.css">
</head>
<body>

<cfif NOT ISDATE(#request.start_ddate#)>
<cfmodule template="/common/error_msg.cfm" error_msg = "Invalid Start Date">
<cfabort>
</CFIF>


<cfset request.end_ddate = dateAdd("m", 3, #request.start_ddate#)>

<!--- <cfset request.end_ddate = dateAdd("d", 1, #request.end_ddate#)> --->





<cfset request.start_ddate=CreateODBCDate(#request.start_ddate#)>
<cfset request.end_ddate=CreateODBCDate(#request.end_ddate#)>
<!--- <cfoutput>
Start Date: #request.start_ddate#<br>
End Date: #request.end_ddate#<br>
</cfoutput> --->

<cfquery name="find_permit" datasource="#request.dsn#" dbtype = "datasource">
SELECT 
permit_info.ref_no as [Ref. No.] 
,customers.last_name as Agency
,customers.first_name as Branch
,permit_info.ddate_submitted [Date Submitted]
,permit_info.ddate_issued as [Date Issued]
,permit_type.permit_type_desc as [Permit Type]
,permit_info.requester as [Requested by]
,permit_info.requester_phone as [Phone]
,permit_info.requester_email as [Email]
,permit_info.job_title as [Job Title]
,boe_dist.boe_dist_short_name [BOE Dist.]
,permit_info.job_descr as [Job Desc.]
,isnull(permit_info.job_sqft, 0) as [Job Sq. Ft.]
,isnull(permit_info.agf, 0) as [Above Ground Facilities]
,isnull(permit_info.gross_eng_app_fee, 0) AS [Eng. App. Fee]
,isnull(permit_info.special_eng_hrs, 0) AS [Special Eng. Hrs]
,isnull(permit_info.special_eng_fee,0) AS [Special Eng. Fee]
,isnull(permit_info.bca_special_inspec_hrs, 0) AS [Special Inspec. Hrs]
,isnull(permit_info.bca_special_inspec_fee, 0) AS [Special Inspec. Fee]
,isnull(permit_info.conad_prw_enf_fee, 0) AS [Inspec. Fee < 100 sq. ft.]
,isnull(permit_info.gross_inspec_fee, 0) AS [Inspec. Fee >= 100  & < = 1000]
,isnull(permit_info.bss_prw_enf_fee, 0) AS [BSS ROW Enf. Fee]
,isnull(permit_info.ladot_prw_enf_fee, 0) AS [LADOT ROW Enf. Fee]
,isnull(bss_peak_hr_comp_fee, 0) AS [BSS Peak Hr. Compl. Fee]
,isnull(ladot_peak_hr_comp_fee, 0) AS [LADOT Peak Hr. Compl. Fee]
,isnull(permit_info.sdrf_sqft, 0)  AS [SDRF SQ FT]
,isnull(permit_info.sdrf_fee, 0) AS [SDRF Fee]
,isnull(permit_info.ssdrf_sqft, 0) AS [SSDRF SQ FT]
,isnull(permit_info.ssdrf_fee, 0) AS [SSDRF Fee]
,isnull(permit_info.sdrf_admin_fee, 0) AS [SDRF Admin. Fee]
,isnull(permit_info.traff_mgmt_fee, 0) AS [Traff. Mgmt. Fee]
,isnull(permit_info.one_stop_fee, 0) AS [Dev Srvc Sur 3%]
,isnull(permit_info.training_fee, 0) AS [7% Surcharge]
,isnull(permit_info.gross_grand_total, 0) AS [Total Fee]

,isnull(permit_info.amount_to_bill, 0) AS [Billing Amount]

,permit_info.Job_no AS [Job No.]
,permit_info.account_no AS [Account No.]
,permit_info.usa_no AS [USA No.]
,permit_info.wo_no AS [Work Order]
,permit_info.permit_no AS [Permit No.]
,permit_info.last_app_status AS [Status]

FROM  rates INNER JOIN
            permit_info ON rates.rate_no = permit_info.rate_no LEFT OUTER JOIN
            common.dbo.boe_dist as boe_dist ON permit_info.boe_dist = boe_dist.boe_dist LEFT OUTER JOIN
            permit_type ON permit_info.permit_type = permit_type.permit_type LEFT OUTER JOIN
            customers ON permit_info.customer_id = customers.customer_id CROSS JOIN
            app_status



where 
permit_info.last_app_status='Issued'
and  
permit_info.customer_id=#client.customer_id# 
AND ddate_issued >= #request.start_ddate# 
AND ddate_issued < #request.end_ddate#
and permit_info.customer_id=customers.customer_id

order by permit_info.ddate_issued

</cfquery>



<!--- <cfif #fileexists("#request.directory#\public\#client.customer_id#.xls")# is "yes">
<CFFILE
action="delete" file="#request.directory#\public\#client.customer_id#.xls">
</cfif> --->


<cfset filename = #request.directory#&"\public\"&#client.customer_id#&".xls">

<cfspreadsheet action="write" filename="#filename#" query="find_permit" sheetname="U-Permits" overwrite="true">


	
	<cfoutput>
	<div align="center">
<a href="#client.customer_id#.xls">CLICK HERE TO DOWNLOAD THE GENERATED FILE </a>
</div>
	</cfoutput>
	
	
	
	
	<cfabort>


<cfset tlogno="Ref. No.">
<cfset tpermitno="Permit No.">
<cfset tboe_dist="Eng. District">
<cfset tlastname="Last Name">
<cfset tfirstname="First Name">
<cfset tdateissued="Date Issued">
<cfset tbilladdress1="Billing Address1">
<cfset tbilladdress2="Billing Address2">
<cfset tbillcity="City">
<cfset tbillzip="Zip">
<cfset tjobsqft="Job Sq. Ft.">
<cfset tappfee="Net Application Fee">
<cfset tappfee_bc="App. Fee. b/c">
<cfset tinspecfee="Net Inspection Fee"> 
<cfset ttraff_fee="Const Mgmt Traffic Fee">
<cfset tlanes="No. of Lanes">
<cfset tdays="NO. of Days">
<cfset tsdrf_sqft="SDRF Sq. Ft.">
<cfset tsdrf_fee="SDRF Fee">
<cfset tsdrf_fee_bc="SDRF Fee b/c">

<cfset tssdrf_sqft="SSDRF Sq. Ft.">
<cfset tssdrf_fee="SSDRF Fee">
<cfset tssdrf_fee_bc="SSDRF Fee b/c">


<cfset tone_stop="Dev Srvc Sur 3%">
<cfset tmba_fee="MBA Fee">
<cfset ttrain_fee="Training Fee 7%">
<cfset ttotal="Total Permit Fees">
<cfset tbillamount="Billing Amount">
<cfset tjobno="Job No.">
<CFFILE
action="append" 
file="#request.directory#\public\#client.customer_id#.csv" 
output="#chr(34)##tlogno##chr(34)#,#chr(34)##tpermitno##chr(34)#,#chr(34)##tboe_dist##chr(34)#,#chr(34)##tlastname##chr(34)#,#chr(34)##tfirstname##chr(34)#,#chr(34)##tdateissued##chr(34)#,#chr(34)##tbilladdress1##chr(34)#,#chr(34)##tbilladdress2##chr(34)#,#chr(34)##tbillcity##chr(34)#,#chr(34)##tbillzip##chr(34)#,#chr(34)##tjobsqft##chr(34)#,#chr(34)##tappfee##chr(34)#,#chr(34)##tappfee_bc##chr(34)#,#chr(34)##tinspecfee##chr(34)#,#chr(34)##ttraff_fee##chr(34)#,#chr(34)##tlanes##chr(34)#,#chr(34)##tdays##chr(34)#,#chr(34)##tsdrf_sqft##chr(34)#,#chr(34)##tsdrf_fee##chr(34)#,#chr(34)##tsdrf_fee_bc##chr(34)#,#chr(34)##tssdrf_sqft##chr(34)#,#chr(34)##tssdrf_fee##chr(34)#,#chr(34)##tssdrf_fee_bc##chr(34)#,#chr(34)##tone_stop##chr(34)#,#chr(34)##tmba_fee##chr(34)#,#chr(34)##ttrain_fee##chr(34)#,#chr(34)##ttotal##chr(34)#,#chr(34)##tbillamount##chr(34)#,#chr(34)##tjobno##chr(34)#">


<cfloop query="find_permit">

<cfinclude template="../common/set_permit_no.cfm">

<CFFILE
action="append" file="#request.directory#\public\#client.customer_id#.csv" output= "#chr(34)##find_permit.ref_no##chr(34)#,#chr(34)##pn##chr(34)#,#chr(34)##find_permit.boe_dist##chr(34)#,#chr(34)##find_permit.last_name##chr(34)#,#chr(34)##find_permit.first_name##chr(34)#,#chr(34)##dateformat(find_permit.ddate_issued,"mm/dd/yyyy")##chr(34)#,#chr(34)##find_permit.bill_address1##chr(34)#,#chr(34)##find_permit.bill_address2##chr(34)#,#chr(34)##find_permit.bill_city##chr(34)#,#chr(34)##find_permit.bill_zip##chr(34)#,#chr(34)##decimalformat(find_permit.job_sqft)##chr(34)#,#chr(34)##dollarformat(find_permit.net_eng_app_fee)##chr(34)#,#chr(34)##find_permit.app_fee_bc##chr(34)#,#chr(34)##dollarformat(find_permit.net_inspec_fee)##chr(34)#,#chr(34)##dollarformat(find_permit.traff_mgmt_fee)##chr(34)#,#chr(34)##find_permit.no_of_lanes##chr(34)#,#chr(34)##find_permit.no_of_days##chr(34)#,#chr(34)##decimalformat(find_permit.sdrf_sqft)##chr(34)#,#chr(34)##dollarformat(find_permit.sdrf_fee)##chr(34)#,#chr(34)##find_permit.sdrf_bc##chr(34)#,#chr(34)##find_permit.ssdrf_sqft##chr(34)#,#chr(34)##dollarformat(find_permit.ssdrf_fee)##chr(34)#,#chr(34)##find_permit.ssdrf_bc##chr(34)#,#chr(34)##dollarformat(find_permit.one_stop_fee)##chr(34)#,#chr(34)##dollarformat(find_permit.mba_fee)##chr(34)#,#chr(34)##dollarformat(find_permit.training_fee)##chr(34)#,#chr(34)##dollarformat(find_permit.net_grand_total)##chr(34)#,#chr(34)##dollarformat(find_permit.amount_to_bill)##chr(34)#,#chr(34)##find_permit.job_no##chr(34)#">

</cfloop>



<cfoutput>
<div align="center">
<strong>
<font color="red">
&quot;A COMMA SEPARATED VARIABLES&quot; FILE( #client.customer_id#.CSV) 
<br>
WAS CREATED AND IS AVAILABLE FOR DOWNLOADING.
<br>
<br>
THIS FILE CAN BE VIEWED USING THE WINDOWS NOTEPAD<br> OR ANY OTHER ASCII EDITOR.<br>
IT CAN BE IMPORTED INTO MANY APPLICATIONS SUCH AS EXCEL, ACCESS, ETC.<br><br>
</font>
</strong>
</div>
<br>
<br>
<br>



<div align="center">
<a href="#client.customer_id#.csv">CLICK HERE TO DOWNLOAD THE GENERATED FILE </a>
</div>
</cfoutput>
</body>
</html>
