USE [sidewalk_repair_testing]
GO

/****** Object:  View [dbo].[vwSites]    Script Date: 3/14/2018 2:20:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwSites]
AS
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
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[36] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Certs"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblEngineeringEstimate"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 882
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblSites"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CurbRamps"
            Begin Extent = 
               Top = 270
               Left = 338
               Bottom = 366
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblPhotos"
            Begin Extent = 
               Top = 138
               Left = 327
               Bottom = 268
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblTreeRemovalInfo"
            Begin Extent = 
               Top = 138
               Left = 535
               Bottom = 268
               Right = 859
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblPackages"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 300
            End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSites'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblType"
            Begin Extent = 
               Top = 270
               Left = 576
               Bottom = 400
               Right = 746
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSites'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSites'
GO

