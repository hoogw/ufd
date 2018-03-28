SELECT        dbo.tblSites.ID, dbo.tblSites.Location_No, dbo.tblSites.Location_Suffix, dbo.tblSites.Name, dbo.tblSites.Address, dbo.tblType.Type AS SubType_Desc, dbo.tblType.Description AS SubType_Description, 
                         dbo.tblType.Category AS Type_Desc, dbo.tblSites.Council_District, dbo.tblSites.Zip_Code, dbo.tblSites.Field_Assessed, dbo.tblSites.Repairs_Required, dbo.tblSites.Assessed_Date, dbo.tblSites.QC_Date, dbo.tblSites.Notes, 
                         dbo.tblSites.Location_Description, dbo.tblSites.Damage_Description, dbo.tblSites.Construction_Start_Date, dbo.tblSites.Construction_Completed_Date, dbo.tblSites.Anticipated_Completion_Date, DATEDIFF(dd, 
                         dbo.tblSites.Creation_Date, GETDATE()) AS Days_In_Queues, dbo.tblSites.Package_No, dbo.tblSites.Package_Group, dbo.tblPackages.Work_Order, dbo.tblPackages.ID AS Package_ID, dbo.tblSites.Type, dbo.tblSites.Removed, 
                         dbo.tblSites.Severity_Index, dbo.tblSites.Priority_No, dbo.tblSites.Curb_Ramp_Only, CurbRamps.Number_CurbRamps, CASE WHEN dbo.tblSites.Package_Group = NULL 
                         THEN '' ELSE dbo.tblSites.Package_Group + ' - ' + CAST(dbo.tblSites.Package_No AS varchar) END AS Package,
                             (SELECT        Total_Concrete
                               FROM            (SELECT        SUM(Total_Concrete) AS Total_Concrete
                                                         FROM            (SELECT        CASE WHEN FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY IS NULL 
                                                                                                             THEN 0 ELSE FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY IS NULL 
                                                                                                             THEN 0 ELSE SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY END + CASE WHEN EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                              IS NULL 
                                                                                                             THEN 0 ELSE EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END + CASE WHEN FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY
                                                                                                              IS NULL 
                                                                                                             THEN 0 ELSE FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY IS
                                                                                                              NULL 
                                                                                                             THEN 0 ELSE SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY END + CASE WHEN FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                              IS NULL THEN 0 ELSE FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END AS Total_Concrete
                                                                                   FROM            dbo.tblEngineeringEstimate AS b
                                                                                   WHERE        (Location_No = dbo.tblSites.Location_No)
                                                                                   UNION ALL
                                                                                   SELECT        CASE WHEN FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY IS NULL 
                                                                                                            THEN 0 ELSE FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY IS NULL 
                                                                                                            THEN 0 ELSE SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY END + CASE WHEN EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                             IS NULL 
                                                                                                            THEN 0 ELSE EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END + CASE WHEN FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY
                                                                                                             IS NULL 
                                                                                                            THEN 0 ELSE FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY IS
                                                                                                             NULL 
                                                                                                            THEN 0 ELSE SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY END + CASE WHEN FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                             IS NULL THEN 0 ELSE FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END AS Total_Concrete
                                                                                   FROM            dbo.tblQCQuantity AS c
                                                                                   WHERE        (Location_No = dbo.tblSites.Location_No)
                                                                                   UNION ALL
                                                                                   SELECT        CASE WHEN d .FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY IS NULL 
                                                                                                            THEN 0 ELSE d .FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN d .SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY IS NULL 
                                                                                                            THEN 0 ELSE d .SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_QUANTITY END + CASE WHEN d .EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                             IS NULL 
                                                                                                            THEN 0 ELSE d .EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END + CASE WHEN FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY
                                                                                                             IS NULL 
                                                                                                            THEN 0 ELSE FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_QUANTITY END + CASE WHEN SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY IS
                                                                                                             NULL 
                                                                                                            THEN 0 ELSE SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_QUANTITY END + CASE WHEN FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY
                                                                                                             IS NULL THEN 0 ELSE FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___QUANTITY END AS Total_Concrete
                                                                                   FROM            dbo.tblChangeOrders AS d
                                                                                   WHERE        (Location_No = dbo.tblSites.Location_No)) AS n) AS derivedtbl_1) AS Total_Concrete, dbo.tblTreeRemovalInfo.TREE_REMOVAL_NOTES, dbo.tblPhotos.Has_Before, dbo.tblPhotos.Has_After, 
                         CASE WHEN
                             (SELECT        CONTRACTORS_COST
                               FROM            dbo.tblContractorPricing AS m
                               WHERE        (Location_No = dbo.tblSites.Location_No)) IS NULL THEN 0 ELSE
                             (SELECT        CONTRACTORS_COST
                               FROM            dbo.tblContractorPricing AS m
                               WHERE        (Location_No = dbo.tblSites.Location_No)) END + CASE WHEN
                             (SELECT        change_order_cost
                               FROM            dbo.tblChangeorders AS m
                               WHERE        (Location_No = dbo.tblSites.Location_No)) IS NULL THEN 0 ELSE
                             (SELECT        change_order_cost
                               FROM            dbo.tblChangeorders AS m
                               WHERE        (Location_No = dbo.tblSites.Location_No)) END AS Total_Cost, dbo.tblEngineeringEstimate.ENGINEERS_ESTIMATE_TOTAL_COST AS Engineers_Estimate, CASE WHEN Certs.Total IS NULL 
                         THEN 'No' ELSE 'Yes' END AS Has_Certificate, CASE WHEN Certs.Total IS NULL THEN 0 ELSE certs.total END AS Certificate_Total
FROM            (SELECT        Location_No, COUNT(Location_No) AS Total
                          FROM            dbo.vwHDRCertificates
                          WHERE        (Location_No IS NOT NULL)
                          GROUP BY Location_No) AS Certs RIGHT OUTER JOIN
                         dbo.tblEngineeringEstimate ON Certs.Location_No = dbo.tblEngineeringEstimate.Location_No RIGHT OUTER JOIN
                         dbo.tblSites ON dbo.tblEngineeringEstimate.Location_No = dbo.tblSites.Location_No LEFT OUTER JOIN
                             (SELECT        Location_No, COUNT(Location_No) AS Number_CurbRamps
                               FROM            dbo.tblCurbRamps
                               WHERE        (Location_No IS NOT NULL)
                               GROUP BY Location_No) AS CurbRamps ON dbo.tblSites.Location_No = CurbRamps.Location_No LEFT OUTER JOIN
                         dbo.tblPhotos ON dbo.tblSites.Location_No = dbo.tblPhotos.Location_No LEFT OUTER JOIN
                         dbo.tblTreeRemovalInfo ON dbo.tblSites.Location_No = dbo.tblTreeRemovalInfo.Location_No LEFT OUTER JOIN
                         dbo.tblPackages ON dbo.tblSites.Package_No = dbo.tblPackages.Package_No AND dbo.tblSites.Package_Group = dbo.tblPackages.Package_Group LEFT OUTER JOIN
                         dbo.tblType ON dbo.tblSites.Type = dbo.tblType.ID