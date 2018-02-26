USE [sidewalk_repair]
GO

/****** Object:  StoredProcedure [dbo].[UnitPriceAnalysis]    Script Date: 4/27/2016 4:22:30 AM ******/
DROP PROCEDURE [dbo].[UnitPriceAnalysis]
GO

/****** Object:  StoredProcedure [dbo].[UnitPriceAnalysis]    Script Date: 4/27/2016 4:22:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnitPriceAnalysis] 
	@start date = null,
	@end date = null
AS
BEGIN
	declare @fields_p varchar(max) = N''
	declare @fields_x varchar(max)
	declare @sql_p varchar(max)

	declare @fields_c varchar(max) = N''
	declare @sql_c varchar(max)

	declare @extra_i int = 1

	declare @sql_candidate varchar(max) = N'insert into #candidate select location_no from vwHDRAssessmentTracking'
	declare @sql_extra varchar(max)

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	create table #candidate ( loc int )

	if not @start is null and not @end is null
	begin
		insert into #candidate 
			select location_no from vwHDRAssessmentTracking
			where Construction_Start_Date >= @start and Construction_Completed_Date <= @end
	end
	else
	begin
		if not @start is null
			insert into #candidate 
				select location_no from vwHDRAssessmentTracking
				where Construction_Start_Date >= @start
		else
			insert into #candidate 
				select location_no from vwHDRAssessmentTracking
	end

	--pricing
	--select *
	--from vwHDR_RPT_Pricing
	--where U_PRICE is not null or U_PRICE > 0
	create table #pricing ( 
		location_no int,
		bid_item varchar(255),
		bid_item2 varchar(255),
		uom varchar(50),
		u_price money
	)

	select @fields_p += ', ' + QUOTENAME(COLUMN_NAME)
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = 'vwHDRContractorPricing' and COLUMN_NAME like '%_UNIT_PRICE' --and COLUMN_NAME not like '%Extra_%'
	
	set @fields_x = REPLACE(@fields_p, '_UNIT_PRICE', '_UNITS' )

	set @sql_p = 
	'insert into #pricing
	select location_no, replace(ppp.bid2, ''_UNITS'', '''') bid2, ppp.bid, ppp.uom, ppp.u_price
	from vwHDRContractorPricing p
	inner join #candidate cad on p.location_no = cad.loc
	unpivot( uom for bid2 in ( ' + SUBSTRING(@fields_x,2, LEN(@fields_x)-1 ) + ' )) ppx
	unpivot( u_price for bid in ( ' + SUBSTRING(@fields_p,2, LEN(@fields_p)-1 ) + ' )) ppp
	where replace(bid2,''_UNITS'','''') = replace(bid, ''_UNIT_PRICE'', '''')'

	--select @sql_p

	--change orders
	create table #change 
	(
		location_no int,
		change_order money,
		bid_item varchar(255)
	)

	select @fields_c += ', ' + QUOTENAME(COLUMN_NAME)
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = 'vwHDRChangeOrders' and COLUMN_NAME like '%QUANTITY'
	
	set @sql_c = 
	'insert into #change
	select location_no, xxx.co, replace(xxx.cob, ''_QUANTITY'', '''') cob
	from vwHDRChangeOrders o
	inner join #candidate cad on o.location_no = cad.loc
	unpivot (
		co for cob in ( ' + SUBSTRING(@fields_c,2, LEN(@fields_c)-1 ) + '  ) ) xxx where xxx.co > 0'

	execute( @sql_p)
	execute( @sql_c )

	create table #pre 
	(
		location_no int,
		bid_item varchar(255),
		uom varchar(50),
		u_price money,
		change_order varchar(50)
	)

	-- ugly
	insert into #pre
	select p.location_no, p.bid_item, p.uom, p.u_price, 'noop'
		--case when c.change_order is null then null when c.change_order = 0 then null when c.change_order < 0 then 'reduced' when c.change_order > 0 then 'increased' end
	from #pricing p
		inner join #change c on p.location_no = c.location_no and p.bid_item = c.bid_item

	while @extra_i <= 5
	begin
		set @sql_extra = 'update #pre
		set bid_item = p.extra_field_' + cast( @extra_i as varchar(2)) + '_name
		from #pre e
			inner join vwHDRContractorPricing p on e.location_no = p.Location_No
		where e.bid_item = ''EXTRA_FIELD_' + cast( @extra_i as varchar(2)) + ''' '
		set @extra_i = @extra_i + 1

		execute( @sql_extra )
	end

	--
	select replace(p.bid_item, '_', ' ') bid_item, p.uom, avg(p.u_price) Average, max(p.u_price) High, min(p.u_price) Low, count(p.location_no) Sites, change_order 
	from #pre p
		group by p.bid_item, p.uom, change_order
		order by 1, 2
END

GO

