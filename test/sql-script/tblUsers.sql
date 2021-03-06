USE [UFD_Inventory]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 11/7/2017 9:23:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_FullName] [varchar](50) NULL,
	[User_Name] [varchar](50) NULL,
	[User_Password] [varchar](15) NULL,
	[User_Agency] [varchar](30) NULL,
	[User_Level] [int] NULL,
	[User_Power] [int] NULL,
	[User_Cert] [int] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
