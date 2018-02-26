USE [sidewalk_repair]
GO

/****** Object:  StoredProcedure [dbo].[BidUpdates]    Script Date: 8/29/2015 3:45:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		kchan@hdrinc.com
-- Create date: August 24, 2015
-- Description:	wrapper to run bid normalize for estimates and pricing
-- =============================================
CREATE PROCEDURE [dbo].[BidUpdates]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	EXEC dbo.BidNormalize vwHDREngineeringEstimate, vwUgly
	EXEC dbo.BidNormalize vwHDRContractorPricing, vwHDR_RPT_Pricing
END

GO

