USE [sidewalk_repair]
GO

/****** Object:  StoredProcedure [dbo].[BidNormalize]    Script Date: 8/29/2015 3:43:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		kchan@hdrinc.com
-- Create date: August, 24, 2015
-- Description:	Normalize vwHDREngineeringEstimate and vwHDRContractorPricing to make reporting easier
-- =============================================
CREATE PROCEDURE [dbo].[BidNormalize]
(
	@sourceTable VARCHAR(100),
	@targetView VARCHAR(100)
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @My_sql VARCHAR(MAX)
	DECLARE @My_bidunits VARCHAR(MAX)
	DECLARE @My_name VARCHAR(100)
	DECLARE @My_bidname VARCHAR(100)
	DECLARE @My_column VARCHAR(100)
	DECLARE @My_sort VARCHAR(5)

	-- table schema
	DECLARE My_cursor CURSOR LOCAL FOR
		select COLUMN_NAME, ORDINAL_POSITION 
		from INFORMATION_SCHEMA.COLUMNS
		where table_name = @sourceTable
		and column_name like '%_UNITS' and column_name not like 'Extra%'

	DECLARE My_xfields_cursor CURSOR LOCAL FOR
		select COLUMN_NAME, ORDINAL_POSITION 
		from INFORMATION_SCHEMA.COLUMNS
		where table_name = @sourceTable 
		and column_name like '%_UNITS' and column_name like 'Extra%'

    -- Insert statements for procedure here

	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = @targetView )
	BEGIN
		SET @My_sql = N'ALTER VIEW ' + @targetView + ' AS ( '
	END
	ELSE
	BEGIN
		SET @My_sql = N'CREATE VIEW ' + @targetView + ' AS ( '
	END

	OPEN My_cursor
	FETCH NEXT FROM My_cursor INTO @My_column, @My_sort

	SET @My_bidunits = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF LEN(@My_bidunits ) > 0 
		BEGIN
			SET @My_bidunits = @My_bidunits + ' UNION ';
		END

		SET @My_name = SUBSTRING(@My_Column, 0, PATINDEX('%_UNITS', @My_column))
		SET @My_bidname = REPLACE(@My_name, '_', ' ' )

		SET @My_bidunits = @My_bidunits + 'SELECT Location_No
			, ''' + @My_bidname + ''' AS BID_UNIT
			, [' + @My_column + '] AS UOM 
			, [' + @My_name + '_QUANTITY] AS QUANTITY 
			, [' + @My_name + '_UNIT_PRICE] AS U_PRICE 
			, ' + @My_sort + ' AS DISPLAY_ORDER
			FROM ' + @sourceTable

		FETCH NEXT FROM My_cursor INTO @My_column, @My_sort
	END

	CLOSE My_cursor
	DEALLOCATE My_cursor

	-- EXTRA FIELDS
	OPEN My_xfields_cursor
	FETCH NEXT FROM My_xfields_cursor INTO @My_column, @My_sort

	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF LEN(@My_bidunits ) > 0 
		BEGIN
			SET @My_bidunits = @My_bidunits + ' UNION ';
		END

		SET @My_bidunits = @My_bidunits + 'SELECT Location_No
			, [' + Replace( @My_column, '_UNITS', '_NAME') + '] AS BID_UNIT
			, [' + @My_column + '] AS UOM 
			, [' + Replace( @My_column, '_UNITS', '_QUANTITY') + '] AS QUANTITY 
			, [' + Replace( @My_column, '_UNITS', '_UNIT_PRICE') + '] AS U_PRICE 
			, ' + @My_sort + ' AS DISPLAY_ORDER
			FROM ' + @sourceTable +
			' WHERE [' + Replace( @My_column, '_UNITS', '_QUANTITY') + '] > 0 AND [' + Replace( @My_column, '_UNITS', '_QUANTITY') + '] IS NOT NULL'

		FETCH NEXT FROM My_xfields_cursor INTO @My_column, @My_sort
	END

	CLOSE My_xfields_cursor
	DEALLOCATE My_xfields_cursor

	SET @My_sql = @My_sql +		
		+ @My_bidunits 
		+ ' )';

	print @My_sql

	EXEC ( @My_sql )
END


GO

