
<!--- Developed by: Kirk Bishop 09/22/16 *** CITY OF LOS ANGELES *** 213-482-7135 *** kirk.bishop@lacity.org --->

<cf_FormURL2Attributes>

<cfparam name="attributes.hse_id" default="0">					<!--- The passed House Number ID - Specify the exact address by using the House Number ID --->
<cfparam name="attributes.hse_nbr" default="0">					<!--- The passed House Number --->
<cfparam name="attributes.hse_frac_nbr" default="">				<!--- The passed House Number Fraction --->
<cfparam name="attributes.hse_dir_cd" default="">				<!--- The passed Street Direction Code --->
<cfparam name="attributes.str_nm" default="">					<!--- The passed Street Name --->
<cfparam name="attributes.str_sfx_cd" default="">				<!--- The passed Street Suffix --->
<cfparam name="attributes.str_sfx_dir_cd" default="">			<!--- The passed Street Suffix Direction --->
<cfparam name="attributes.zip_cd" default="">					<!--- The passed Zip Code --->
<cfparam name="attributes.x" default="">						<!--- The passed x ---><!--- Need this in case there are multiple addresses found since street suffix direction might not be passed --->
<cfparam name="attributes.y" default="">						<!--- The passed y ---><!--- Need this in case there are multiple addresses found since street suffix direction might not be passed --->
<cfparam name="attributes.lat" default="">
<cfparam name="attributes.lon" default="">
<cfparam name="attributes.debug_address" default=0>

<cfset addr_md_use_requirements = 1>


<cfset request.addr_md_valid_address = "Y">						<!--- Check if Address is valid before searching database (Y/N) --->
<cfset request.addr_md_official_address = "N">					<!--- Address found in official house number table (Y/N) --->
<cfset request.addr_md_multi_address = "N">						<!--- Multiple Addresses found in official house number table based on supplied attribues (Y/N) --->
<cfset request.addr_md_arrMultiAddress = ArrayNew(1)>			<!--- Array of Address Result structs - This is when either a fraction or unit range exists and that information isn't passed to specify single address --->
<cfset request.addr_md_pin = "">								<!--- PIND associated with Address found --->
<cfset request.addr_md_pin_s = "">								<!--- PIN with space associated with Address found --->
<cfset request.addr_md_multi_apn = "">							<!--- Multiple APNs found based on PIND from Official Address (Y/N) --->
<cfset request.addr_md_apn_list = "">							<!--- List of APNs, multiples delimited by a bar(|) --->
<cfset request.addr_md_multi_pin = "">							<!--- Multiple PINDs found based on APN(s) (Y/N) --->
<cfset request.addr_md_pin_list = "">							<!--- List of PINDs, multiples delimited by a bar(|) --->
<cfset request.addr_md_multi_owner = "">						<!--- Multiple Owners found (Y/N) --->
<cfset request.addr_md_owner_list = "">							<!--- List of Owners, multiples delimited by a bar(|) --->
<cfset request.addr_md_arrOwner = ArrayNew(1)>					<!--- Array of Owner structs --->
<!---<cfset request.addr_md_arrOwner = ArrayNew(2)>--->			<!--- Two dimensional Array of APNs and Owner structs --->
<cfset request.addr_md_multi_zoning = "">						<!--- Multiple Zoning found (Y/N) Ex. RD2|R3|C2 --->
<cfset request.addr_md_multi_zoning_category = "">				<!--- Multiple Zoning Category found (Y/N) Ex. Residential|Commercial --->
<cfset request.addr_md_zoning_list = "">						<!--- List of Zoning Classes, multiples delimited by a bar(|) --->
<cfset request.addr_md_zoning_cateory_list = "">				<!--- List of Zoning Categories, multiples delimited by a bar(|) Values are: Agricultural, Commercial, Manufacturing, Open Space, Public Facilities, Residential --->
<cfset request.addr_md_zoning_specific_plan = "">				<!--- Zoning is a specific plan (Y/N) --->
<cfset request.addr_md_residential_and_more_restrictive = "">	<!--- Based on http://library.amlegal.com/nxt/gateway.dll/California/lamc/municipalcode/chapterigeneralprovisionsandzoning/article2specificplanning-zoningcomprehen?f=templates$fn=default.htm$3.0$vid=amlegal:losangeles_ca_mc$anc=JD_12.04.
																	and order of restrictivenes OS, A1, A2, RA, RE, RS, R1, RU, RZ, RW1, R2, RD, RMP, RW2, R3, RAS3, R4, RAS4, R5, CR, C1, C1.5, C4, C2, C5, CM, HI, MR1, M1, MR2, M2, M3 and PF 
																	If zone is R5 or more restrictive than code as Y --->
<cfset request.addr_md_commercial_and_less_restrictive = "">	<!--- Based on http://library.amlegal.com/nxt/gateway.dll/California/lamc/municipalcode/chapterigeneralprovisionsandzoning/article2specificplanning-zoningcomprehen?f=templates$fn=default.htm$3.0$vid=amlegal:losangeles_ca_mc$anc=JD_12.04.
																	and order of restrictivenes OS, A1, A2, RA, RE, RS, R1, RU, RZ, RW1, R2, RD, RMP, RW2, R3, RAS3, R4, RAS4, R5, CR, C1, C1.5, C4, C2, C5, CM, HI, MR1, M1, MR2, M2, M3 and PF 
																	If zone is CR and less restrictive than code as Y --->

<!--- Debug --->
<cfif attributes.debug_address eq 1>
	Attributes Dump:
    <cfdump var="#attributes#"><br /><br />
</cfif>

<!--- Trim passed attributes --->
<cfloop collection="#attributes#" item="a">
	<cfset attributes[a] = trim(attributes[a])>  
</cfloop>

<!--- If House Number ID is passed, than use that and don't require address fields --->
<cfif IsNumeric(attributes.hse_id) AND attributes.hse_id neq 0>
	<cfset addr_md_use_requirements = 0>
</cfif>

<!--- Requirements --------------------------------------------------------------->

<cfif addr_md_use_requirements eq 1>
	<!--- Numeric hse_nbr --->
    <cfif IsNumeric(attributes.hse_nbr) eq 0>
        <cfset request.addr_md_valid_address = "N">
    </cfif>
    
    <!--- Numeric zip_cd if passed --->
    <cfif attributes.zip_cd neq "" AND IsNumeric(attributes.zip_cd) eq 0>
        <cfset request.addr_md_valid_address = "N">
    </cfif>
    
    <!--- Street Name --->
    <cfif attributes.str_nm eq "">
        <cfset request.addr_md_valid_address = "N">
    </cfif>
</cfif>

<!--- End Requirements ---------------------------------------------------------->

<!--- If address has required fields than search --->
<cfif request.addr_md_valid_address eq "Y">
    <cfquery name="getAddress" datasource="navla_spatial">
    	select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
        	X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
		from LA_HSE_NBR
        <cfif IsNumeric(attributes.hse_id) AND attributes.hse_id neq 0>
        	where HSE_ID = #attributes.hse_id#
        <cfelse>
        	where HSE_NBR = #attributes.hse_nbr#
        	<cfif attributes.hse_frac_nbr NEQ "">
                and HSE_FRAC_NBR = '#attributes.hse_frac_nbr#'
            </cfif>
            <cfif attributes.hse_dir_cd NEQ "">
                and HSE_DIR_CD = '#attributes.hse_dir_cd#'
            </cfif>
            and STR_NM = '#attributes.str_nm#'
            <cfif attributes.str_sfx_cd NEQ "">
                and STR_SFX_CD = '#attributes.str_sfx_cd#'
            </cfif>
            <cfif attributes.str_sfx_dir_cd NEQ "">
                and STR_SFX_DIR_CD = '#attributes.str_sfx_dir_cd#'
            </cfif>
            <cfif attributes.zip_cd NEQ "">
                and ZIP_CD = '#attributes.zip_cd#'
            </cfif>
        </cfif>
        and EXIST_STTS_CD Is Null
    </cfquery>
    
    <!--- Debug --->
	<cfif attributes.debug_address eq 1>
    	Address Search Results
        <cfdump var="#getAddress#" metainfo="no"><br /><br />
    </cfif>
    
    <!--- Set request.addr_md_official_address --->
    <!--- No address found--->
    <cfif getAddress.recordcount eq 0>
        <cfset request.addr_md_official_address = "N">	

	<!--- Single address found--->
    <cfelseif getAddress.recordcount eq 1>
    	<cfset request.addr_md_official_address = "Y">
        <cfset request.addr_md_pin = getAddress.PIND>
        <cfset request.addr_md_pin_s = getAddress.PIN>
        
        <!--- Get APN(s)--->
        <cfquery name="getAPN" datasource="navla_spatial">
        	select PIN, BPP
            from LA_APN
            where PIN = '#request.addr_md_pin_s#'
            and exist_stts_cd is null 
        </cfquery>
        
        <!--- Debug --->
        <cfif attributes.debug_address eq 1>
        	APN for single PIN
        	<cfdump var="#getAPN#" metainfo="no"><br /><br />
        </cfif>
        
        <!--- Single APN found--->
        <cfif getAPN.recordcount eq 1>
        	<!--- This means PIN does not have multiple APNs from Condos --->
        	<cfset request.addr_md_multi_apn = "N">
            <cfset request.addr_md_apn_list = getAPN.BPP>
            <cfset request.addr_md_multi_owner = "N">

			<!---  Query APN for More Parcels since this PIN's APN could also belong to another PIN though meaning 2 Parcels with the same APN --->
            <cfquery name="getOtherParcels" datasource="navla_spatial">
            	select PIN, BPP
                from LA_APN
                where BPP = '#request.addr_md_apn_list#'
                and exist_stts_cd is null
                and PIN <> '#request.addr_md_pin_s#'
            </cfquery>

			<!--- If other parcels have the same apn(s) then set multi pin--->
            <cfif getOtherParcels.recordcount gt 0>
            	<cfset request.addr_md_multi_pin = "Y">
                <cfset request.addr_md_pin_list = ListAppend(request.addr_md_pin_list, request.addr_md_pin, "|")>
                <cfloop query="getOtherParcels">
                	<cfset temp_pin = ReReplace(getOtherParcels.PIN,"\s+", "-", "all")>
                    <cfset request.addr_md_pin_list = ListAppend(request.addr_md_pin_list, temp_pin, "|")>
                </cfloop>
            <cfelse>
            	<cfset request.addr_md_multi_pin = "N">	
                <cfset request.addr_md_pin_list = request.addr_md_pin>
            </cfif>
            
            <!--- Debug --->
			<cfif attributes.debug_address eq 1>
            	Other Parcels with Same APN
                <cfdump var="#getOtherParcels#" metainfo="no"><br /><br />
            </cfif>
            
            <!--- Get Ownership information from whse_lupams (County LUPAMS1) --->
            <cfquery name="getOwnerInfo" datasource="navla_spatial">
            	select APN, SITHSENO, SITFRAC, SITDIR, SITSTNAM, SITUNIT, SITCITY, SITZIP,
                	MALHSENO, MALFRAC, MALDIR, MALSTNAM, MALUNIT, MALCITY, MALZIP, OWNER1, SPECNAM, SPECOWN
                from whse_lupams
                where APN =  '#request.addr_md_apn_list#'
                and PRCL_OBSLT_CD is null
            </cfquery>
            
            <cfset ownerObj = "">
            <cfif getOwnerInfo.recordcount eq 1>
            	<cfset ownerObj = StructNew()>
                <cfset StructInsert(ownerObj, "APN", getOwnerInfo.APN)>
                <cfset StructInsert(ownerObj, "OWNER", getOwnerInfo.OWNER1)>
                <!--- Could use Multi-dimensional array to store the APN in first dimension so it can be searched instead of looping through array of structures where APN is stored
				<cfset request.addr_md_arrOwner[1][1] = getOwnerInfo.APN>
                <cfset request.addr_md_arrOwner[1][2] = ownerObj>
				--->
                <cfset request.addr_md_arrOwner[1] = ownerObj>
                <cfset request.addr_md_owner_list = getOwnerInfo.OWNER1>
            </cfif>

            <!--- Debug --->
			<cfif attributes.debug_address eq 1>
            	Owner Info
                <cfdump var="#request.addr_md_arrOwner#" metainfo="no"><br /><br />
            </cfif>
            
        <!--- Multiple APNs Found --->
        <cfelseif getAPN.recordcount gt 1>
        	<cfset request.addr_md_multi_apn = "Y">	
            <cfset request.addr_md_apn_list = ValueList(getAPN.BPP,"|")>
            <cfset tempAPNList = ListQualify(ValueList(getAPN.BPP),"'",",","ALL")>

			<!---  Query APN for More Parcels since this PIN's APN could also belong to another PIN though meaning 2 Parcels with the same APN --->
            <cfquery name="getOtherParcels" datasource="navla_spatial">
            	select PIN, BPP
                from LA_APN
                where BPP IN (#PreserveSingleQuotes(tempAPNList)#)
                and EXIST_STTS_CD is null
                and PIN <> '#request.addr_md_pin_s#'
            </cfquery>

            <cfif getOtherParcels.recordcount gt 0>
            	<cfset request.addr_md_multi_pin = "Y">
                <cfset request.addr_md_pin_list = ListAppend(request.addr_md_pin_list, request.addr_md_pin, "|")>
                <cfloop query="getOtherParcels">
                	<cfset temp_pin = ReReplace(getOtherParcels.PIN,"\s+", "-", "all")>
                    <cfif ListFindNoCase(request.addr_md_pin_list, temp_pin, "|") eq 0>
                    	<cfset request.addr_md_pin_list = ListAppend(request.addr_md_pin_list, temp_pin, "|")>
                    </cfif>
                </cfloop>
            <cfelse>
            	<cfset request.addr_md_multi_pin = "N">	
                <cfset request.addr_md_pin_list = request.addr_md_pin>
            </cfif>
            
            <!--- Debug --->
			<cfif attributes.debug_address eq 1>
            	Other Parcels with Same APN
                <cfdump var="#getOtherParcels#" metainfo="no"><br /><br />
            </cfif>
            
            <!--- Get Ownership information from whse_lupams (County LUPAMS1) --->
            <cfquery name="getOwnerInfo" datasource="navla_spatial">
            	select APN, SITHSENO, SITFRAC, SITDIR, SITSTNAM, SITUNIT, SITCITY, SITZIP,
                	MALHSENO, MALFRAC, MALDIR, MALSTNAM, MALUNIT, MALCITY, MALZIP, OWNER1, SPECNAM, SPECOWN
                from whse_lupams
                where APN IN (#PreserveSingleQuotes(tempAPNList)#)
                and PRCL_OBSLT_CD is null
                order by OWNER1
            </cfquery>
            
            <cfset ownerObj = "">

            <cfloop query="getOwnerInfo">
            	<cfset ownerObj = StructNew()>
                <cfset ownerIndex = ArrayLen(request.addr_md_arrOwner) + 1>
                <cfset StructInsert(ownerObj, "APN", getOwnerInfo.APN)>
                <cfset StructInsert(ownerObj, "OWNER", getOwnerInfo.OWNER1)>
                <cfset request.addr_md_arrOwner[ownerIndex] = ownerObj>
            </cfloop>
            
            <!--- Get Multiple Owners --->
            <cfquery name="getMultiOwner" dbtype="query">
            	select OWNER1
                from getOwnerInfo
                group by OWNER1
                order by OWNER1
            </cfquery>
            
            <cfset request.addr_md_owner_list = ValueList(getMultiOwner.Owner1,"|")>
            
            <!--- If more than 1 distinct Owner1 is found, then consider it Multiple --->
            <cfif getMultiOwner.recordcount gt 1>
            	<cfset request.addr_md_multi_owner = "Y">
            <cfelse>
            	<cfset request.addr_md_multi_owner = "N">
            </cfif>
            
            <!--- Debug --->
			<cfif attributes.debug_address eq 1>
            	Owner Info
                <cfdump var="#request.addr_md_arrOwner#" metainfo="no"><br /><br />
            </cfif>
        
        </cfif>
        
        <!--- Get Zoning based on PIN List --->
        <cfset pinList = Replace(request.addr_md_pin_list,"|",",","all")>
		<cfset pinList = ListQualify(pinList,"'",",","CHAR")>
		
        <!--- Where the ZONE_CATEGORY is not Specific Plan --->
        <cfquery name="getZoning" datasource="navla_spatial">
        	select p.PIND, p.ZONE_CLASS, l.ZONE_CATEGORY, l.In_Specific_Plan
			from dcp_zoning_pin p left join vw_dcp_zoning_lu l on p.ZONE_CLASS = l.ZONE_CLASS
            where PIND in (#PreserveSingleQuotes(pinList)#)
            and l.ZONE_CATEGORY <> 'Specific Plan'
            <!--- Need group by for now since there is a duplicate of R3 with class code 210 instead of the usual 410 --->
            group by p.PIND, p.ZONE_CLASS, l.ZONE_CATEGORY, l.In_Specific_Plan
            <!---group by p.ZONE_CLASS, l.ZONE_CATEGORY, l.In_Specific_Plan--->
        </cfquery>
        
        <!--- Debug --->
		<cfif attributes.debug_address eq 1>
            Zoning
            <cfdump var="#getZoning#" metainfo="no"><br /><br />
        </cfif>
        
        <!--- Where the ZONE_CATEGORY is Specific Plan --->
        <cfquery name="getZoningSP" datasource="navla_spatial">
        	select p.PIND, p.ZONE_CLASS, l.ZONE_CATEGORY, l.In_Specific_Plan
			from dcp_zoning_pin p left join vw_dcp_zoning_lu l on p.ZONE_CLASS = l.ZONE_CLASS
            where PIND in (#PreserveSingleQuotes(pinList)#)
            and l.ZONE_CATEGORY = 'Specific Plan'
            <!--- Need group by for now since there is a duplicate of R3 with class code 210 instead of the usual 410 --->
            group by p.PIND, p.ZONE_CLASS, l.ZONE_CATEGORY, l.In_Specific_Plan
        </cfquery>
        
        <!--- If zoning is Specific Plan, then look up Special Zoning and General Land Use tables --->
        <cfset zoning_sp_list = "">
        <cfset zoning_sp_category_list = "">
        <cfif getZoningSP.recordcount gt 0>
        	
        	<cfloop query="getZoningSP">
            	<cfquery name="getLanduseSP" datasource="navla_spatial">
                    select p.PIND, p.LANDUSE, l.CATEGORY
                    from dcp_landuse_pin p left join vw_dcp_landuse_lu l on p.LANDUSE = l.LANDUSE
                    where PIND = '#getZoningSP.PIND#'
                </cfquery>
                
                <!--- Debug --->
				<cfif attributes.debug_address eq 1>
                    Landuse
                    <cfdump var="#getLanduseSP#" metainfo="no"><br /><br />
                </cfif>

                <cfoutput>
                	<cfset zoning_sp_list = ListAppend(zoning_sp_list,"#getZoningSP.ZONE_CLASS# - #getLanduseSP.LANDUSE#","|")>

					<cfif getLanduseSP.Category eq "Residential">
                        <cfset zoning_sp_category_list = ListAppend(zoning_sp_category_list,getLanduseSP.Category,"|")>
                    </cfif>
                    
                    <cfif getLanduseSP.Category eq "Open Space/Public Facilities">
                        <cfif FindNoCase("Public Facilities",getLanduseSP.LANDUSE) eq 0>
                            <cfset zoning_sp_category_list = ListAppend(zoning_sp_category_list,"Open Space","|")>
                        </cfif>
                        <cfif FindNoCase("Public Facilities",getLanduseSP.LANDUSE) eq 1>
                            <cfset zoning_sp_category_list = ListAppend(zoning_sp_category_list,"Public Facilities","|")>
                        </cfif>
                    </cfif>
                    
                    <cfif getLanduseSP.Category eq "Commercial">
                        <cfset zoning_sp_category_list = ListAppend(zoning_sp_category_list,getLanduseSP.Category,"|")>
                    </cfif> 
                    <cfif getLanduseSP.Category eq "Industrial">
                        <cfset zoning_sp_category_list = ListAppend(zoning_sp_category_list,"Manufacturing","|")>
                    </cfif>
                   
                </cfoutput>
            </cfloop>
        	
            <cfset zoning_sp_list = ListRemoveDuplicates(zoning_sp_list,"|")>
            <cfset zoning_sp_category_list = ListRemoveDuplicates(zoning_sp_category_list,"|")>
            
            <cfif ListLen(zoning_sp_list,"|") gt 0>
            	<cfset request.addr_md_zoning_specific_plan = "Y">
            </cfif>

            
            
        </cfif>

        
		<!--- Zoning List --->
        <cfset request.addr_md_zoning_list = ValueList(getZoning.ZONE_CLASS,"|")>
        <!--- Add/Append any zones if they are from the specific plan --->
        <cfset request.addr_md_zoning_list = ListAppend(request.addr_md_zoning_list,zoning_sp_list,"|")>
        <cfset request.addr_md_zoning_list = ListRemoveDuplicates(request.addr_md_zoning_list,"|")>
        
        <!--- Zoning Category List --->
        <cfset request.addr_md_zoning_cateory_list = ValueList(getZoning.ZONE_CATEGORY,"|")>
        <!--- Add/Append any zones if they are from the specific plan --->
        <cfset request.addr_md_zoning_cateory_list = ListAppend(request.addr_md_zoning_cateory_list,zoning_sp_category_list,"|")>
        <cfset request.addr_md_zoning_cateory_list = ListRemoveDuplicates(request.addr_md_zoning_cateory_list,"|")>
        
        <!--- See if there is a Residential or more restrictive zone, or See if there is a Commercial or less restrictive zone --->
        <cfloop list="#request.addr_md_zoning_cateory_list#" index="z" delimiters="|">
            <cfif ListFindNoCase("Open Space,Agricultural,Residential",z,",") gt 0>
                <cfset request.addr_md_residential_and_more_restrictive = "Y">
            </cfif>
            <cfif ListFindNoCase("Commercial,Manufacturing,Public Facilities",z,",") gt 0>
                <cfset request.addr_md_commercial_and_less_restrictive = "Y">
            </cfif>
        </cfloop>

        
        
        
        <cfif ListLen(request.addr_md_zoning_list,"|") gt 1>
        	<cfset request.addr_md_multi_zoning = "Y">
        <cfelse>
        	<cfset request.addr_md_multi_zoning = "N">
        </cfif>
        
        <cfif ListLen(request.addr_md_zoning_cateory_list,"|") gt 1>
        	<cfset request.addr_md_multi_zoning_category = "Y">
        <cfelse>
        	<cfset request.addr_md_multi_zoning_category = "N">
        </cfif>


    <!--- Multiple addresses found--->  
    <cfelse>
    	<cfset request.addr_md_official_address = "Y">
        <cfset request.addr_md_multi_address = "Y">	
        
        <cfset addressObj = "">
        <cfloop query="getAddress">
        	<cfset addressObj = StructNew()>
			<cfset addressObjIndex = ArrayLen(request.addr_md_arrMultiAddress) + 1>
            <cfset StructInsert(addressObj, "HSE_ID", getAddress.HSE_ID)>
            <cfoutput>
				<cfset temp_address = "#getAddress.HSE_NBR# #getAddress.HSE_FRAC_NBR# #getAddress.HSE_DIR_CD# #getAddress.STR_NM# #getAddress.STR_SFX_CD# #getAddress.STR_SFX_DIR_CD# #getAddress.UNIT_RANGE#, #getAddress.ZIP_CD#">
			</cfoutput>
            
            <cfset temp_address = ReReplace(temp_address,"\s+", " ", "all")>
            <cfset StructInsert(addressObj, "ADDRESS", temp_Address)>
            <cfset request.addr_md_arrMultiAddress[addressObjIndex] = addressObj>
        </cfloop>
		
        
        <!--- Query addresses to if see if X, Y are the same meaning they are on the same parcel --->
        <cfquery name="getUniqueXY" dbtype="query">
        	select X_COORD_NBR, Y_COORD_NBR
            from getAddress
            group by X_COORD_NBR, Y_COORD_NBR
        </cfquery>
        
        <!--- Debug --->
        <!---
		<cfif attributes.debug_address eq 1>
        	Unique X,Y Coordinates for Multiple Addresses
            <cfdump var="#getUniqueXY#" metainfo="no"><br /><br />
        </cfif>
		--->
       
        <!--- Addresses have same X,Y --->
        <cfif getUniqueXY.recordcount eq 1>
        	
        
        <!--- Addresses have different X,Y --->
       	<cfelse>
        
        </cfif>
    </cfif>

</cfif>


