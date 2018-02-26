<!doctype html>

<html>
<head>
	<title>Test</title>
</head>


<body>

<cfset request.license_no = 1016000>

<cfmodule template="licensing_module.cfm" license_no="#request.license_no#">

<cfoutput>Valid: #request.cont_valid#<br></cfoutput>
<cfoutput>Error Message: #request.cont_err_message#<br></cfoutput>

<cfoutput>Business: #request.cont_name#<br></cfoutput>
<cfoutput>Address: #request.cont_address#<br></cfoutput>
<cfoutput>City: #request.cont_city#<br></cfoutput>
<cfoutput>State: #request.cont_state#<br></cfoutput>
<cfoutput>Zipcode: #request.cont_zip#<br></cfoutput>
<cfoutput>Phone: #request.cont_phone#<br></cfoutput>

<cfoutput>Entity: #request.cont_entity#<br></cfoutput>
<cfoutput>Iss_Date: #request.cont_iss_date#<br></cfoutput>
<cfoutput>Exp_Date: #request.cont_exp_date#<br></cfoutput>
<cfoutput>Class: #request.cont_class#<br></cfoutput>
<cfoutput>Link: #request.cont_link#<br></cfoutput>
<cfoutput>Expired: #request.expired#<br></cfoutput>
<cfoutput>MultiClass: #request.cont_multiclass#<br></cfoutput>

<cfoutput>Filed With: #request.cont_bond_filed_with#<br></cfoutput>
<cfoutput>Filed Link: #request.cont_bond_filed_link#<br></cfoutput>
<cfoutput>Bond Number: #request.cont_bond_number#<br></cfoutput>
<cfoutput>Bond Amount: #request.cont_bond_amount#<br></cfoutput>
<cfoutput>Bond Effective Date: #request.cont_bond_eff_date#<br></cfoutput>
<cfoutput>Bond Cancellation Date: #request.cont_bond_cncl_date#<br></cfoutput>
<cfoutput>Bond Individual Message: #request.cont_bond_ind_message#<br></cfoutput>
<cfoutput>Bond Individual Effective Date: #request.cont_bond_ind_eff_date#<br></cfoutput>

<cfoutput>WC Message: #request.cont_comp_message#<br></cfoutput>
<cfoutput>WC Effective Date: #request.cont_comp_eff_date#<br></cfoutput>
<cfoutput>WC Expire Date: #request.cont_comp_exp_date#<br></cfoutput>

</body>
</html>
