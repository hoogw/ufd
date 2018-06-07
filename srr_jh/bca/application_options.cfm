<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<!--- add record into srr_other_items if it does not exist --->
<cfquery name="checkSrrOtherItems" datasource="#request.dsn#" dbtype="datasource">
Select srr_id 
from 
srr_other_items
where srr_id = #request.srr_id#
</cfquery>

<cfif #checkSrrOtherItems.recordcount# is 0>
<cfquery name="addSrrID" datasource="#request.dsn#" dbtype="datasource">
insert into 
srr_other_items
(srr_id)
values
(
#request.srr_id#
)
</cfquery>
</cfif>
<!--- add record into srr_other_items if it does not exist --->

<!--- add record into rebateAdjustments if it does not exist --->
<cfquery name="checkAdjustments" datasource="#request.dsn#" dbtype="datasource">
Select srr_id 
from 
rebateAdjustments
where srr_id = #request.srr_id#
</cfquery>

<cfif #checkAdjustments.recordcount# is 0>
<cfquery name="addAdjustment" datasource="#request.dsn#" dbtype="datasource">
insert into 
rebateAdjustments
(srr_id)
values
(
#request.srr_id#
)
</cfquery>
</cfif>
<!--- add record into rebateAdjustments if it does not exist --->


<cfquery name="find_srr" datasource="srr" dbtype="datasource">
SELECT 
 [srr_id]
,[sr_number]
,[a_ref_no]
,[app_id]
,[app_name_nn]
,[app_contact_name_nn]
,[app_address1_nn]
,[app_address2_nn]
,[app_city_nn]
,[app_state_nn]
,[app_zip_nn]
,[app_phone_nn]
,[app_email_nn]
,[job_address]
, zip_cd
,[unit_range]
,[mailing_address1]
,[mailing_address2]
,[mailing_zip]
,[mailing_city]
,[mailing_state]
,[hse_nbr]
,[str_nm]
,[boe_dist]
,[council_dist]
,[bpp]
,[pind]
,[address_verified]
,[hse_id]
,[tbm_grid]
,[prop_type]
,[record_history]
,[srr_status_cd]
,[srrKey]
FROM [srr].[dbo].[srr_info]
where 
srrKey = '#request.srrKey#'
</cfquery>

<!---<cfdump var="#find_srr#" output="browser">--->



<!--- <cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select srr_id, app_id, a_ref_no, srrKey, job_address
from 
srr_info
where 
srrKey = '#request.srrKey#'
</cfquery> --->


<cfif #find_srr.app_id# is ""><!--- 1 ---><!--- create a profile for customer if the email does not exist --->

<!---<cfoutput>
Select * from customers
where app_email = '#find_srr.app_email_nn#'
</cfoutput>--->

<cfquery name="exist_user" DATASOURCE="customers" dbtype="datasource">
Select * from customers
where app_email = '#find_srr.app_email_nn#'
</cfquery>

<!---<cfdump var="#exist_user#" output="browser">--->

<cfif #exist_user.recordcount# is 0><!--- 2 ---><!--- customer is in BOE database --->
<cfinclude template="generate_new_app_id.cfm">
<!-- This returns request.app_id -->

<!---<div align="center"><strong>Created Profile for Applicant</strong></div>--->
<!-- add user to BOE's customers table -->
<cfquery name="add_applicant" datasource="customers" dbtype="datasource">
INSERT INTO [dbo].[customers]
           (
		   [app_id]
           ,[app_name]
           ,[app_title]
           ,[app_contact_name]
           ,[app_address1]
           ,[app_address2]
           ,[app_city]
           ,[app_state]
           ,[app_zip]
           ,[app_phone]
           ,[app_email]
           ,[app_password]
           ,[app_notifications]
           ,[app_suspend]
           ,[ddate_modified]
           ,[theKey]
           ,[user_name]
           ,[app_history]
           ,[last_login_dt]
		   )
values
(
	#request.app_id#
           , '#find_srr.app_name_nn#'
           , ''
           , ''
           , '#find_srr.app_address1_nn#'
           , '#find_srr.app_address2_nn#'
           , '#find_srr.app_city_nn#'
           , '#find_srr.app_state_nn#'
           , '#find_srr.app_zip_nn#'
           , '#find_srr.app_phone_nn#'
           , '#find_srr.app_email_nn#'
           , null
           , 0
           , 0
           , #now()#
           , null
           , '#find_srr.app_email_nn#'
           , null
           , null)
</cfquery>
<cfquery name="updateAppID" datasource="srr" dbtype="datasource">
update srr_info
set app_id = #request.app_id#
where srrKey='#request.srrKey#'
</cfquery>
<cfelse><!--- 2 --->
<!---Account Exists--->

<cfset request.app_id = #exist_user.app_id#>
<cfquery name="updateAppID" datasource="srr" dbtype="datasource">
update srr_info
set app_id = #request.app_id#
where srrKey='#request.srrKey#'
</cfquery>
</cfif><!--- 2 --->

<cfelse><!--- 1 --->
<!---<strong><div align="center">Applicant already Exists in BOE customers database</div></strong>--->
</cfif><!--- 1 --->

<cfquery name="check_a_ref_no" datasource="srr" dbtype="datasource">
select a_ref_no 
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfif #check_a_ref_no.a_ref_no# is "">


<!--- generate new A-permit Ref. No. --->
<!---<strong><div align="center">Starting New A Permit</div></strong>--->
<cfquery name="max_ref_no" datasource="apermits_sql" dbtype="datasource">
select max(ref_no) as last_ref_no
from permit_info
</cfquery>
<cfset request.ref_no=#MAX_ref_no.last_ref_no# + 1>


<cfmodule template="start_new_a_app1.cfm" ref_no = "#request.ref_no#" srrKey="#request.srrKey#">


<cfquery name="updateAppID" datasource="srr" dbtype="datasource">
update srr_info
set a_ref_no = #request.ref_no#
where srrKey='#request.srrKey#'
</cfquery>

<!--- Create an A-permit with this ref_no --->
<cfelse>

<!---<div align="center"><strong>A-Permit is already previously Created</strong></div>--->

</cfif>


<cfinclude template="navbar2.cfm">

<cfif #request.status_cd# is not "pendingBcaReview">
<cfoutput>
<div class="warning">
SR Status: #request.status_desc#<br><br>
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif>

<cfoutput>
<div style="width:93%;text-align:center;margin-left:auto;margin-right:auto;padding:0px;">
<UL>

<a href="list_sidewalks.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI class="menuOption">
Sidewalks <span>></span>
</LI>
</a>

<a href="list_driveways.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI class="menuOption">
Driveways <span>></span>
</LI>
</a>


<a href="edit_other_items1.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI  class="menuOption">
Other Items <span>></span>
</LI>
</a>


<!--- <a href="list_comments.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI  class="menuOption">
Comments <span>></span>
</LI>
</a> --->

<a href="list_attachments.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI class="menuOption">
Attachments <span>></span>
</LI>
</a>

<a href="bca_adjustments1.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI class="menuOption">
Adjustments <span>></span>
</LI>
</a>

<a href="finalize1.cfm?srrKey=#request.srrKey#&#request.addtoken#">
<LI class="menuOption">
Finalize
<span>></span>
</LI>
</a>


</UL>
</div>
</cfoutput>

<!--- Driveways

Other Items

Add Attachment

Finalize --->


<cfinclude template="footer.cfm">
