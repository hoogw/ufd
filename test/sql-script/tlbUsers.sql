USE [UFD_Inventory]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 11/7/2017 9:27:03 AM ******/
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
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (1, N'Nathan Neumann', N'71055', N'eng78eng', N'BOE', 3, 3, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (2, N'Joe Hu', N'jhu', N'jhu', N'Other', 3, 3, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (3, N'Bill Candlish', N'bcandlish', N'trees', N'BSS', 0, 0, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (4, N'Timothy Tyson', N'ttyson', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (5, N'David Miranda', N'dmiranda', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (6, N'Luis Torres', N'ltorres', N'trees', N'BSS', 0, 0, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (7, N'Maricel El-Amin', N'melamin', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (8, N'April Barry', N'abarry', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (9, N'John Duran', N'jduran', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (10, N'Jerry Caropino', N'jcaropino', N'trees', N'BSS', 0, 1, 1)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (11, N'Nick Lopez', N'nlopez', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (12, N'Patrick Singleton', N'psingleton', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (13, N'Ciu Sanchez', N'csanchez', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (14, N'Glen Hoke', N'ghoke', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (15, N'Pat Shortall', N'pshortall', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (16, N'Will Steglau', N'wsteglau', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (17, N'Yalin Tam', N'ytam', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (18, N'Lloyd Matzkin', N'lmatzkin', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (19, N'Elizabeth Skrzat', N'eskrzat', N'eskrzat', N'Other', 0, 0, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (20, N'Rachel O''Leary', N'roleary', N'roleary', N'Other', 0, 0, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (21, N'Elizabeth Jauregui', N'ejauregui', N'ejauregui', N'Other', 0, 0, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (22, N'David Vargas', N'dvargas', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (23, N'Mike Trabbie', N'mtrabbie', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (24, N'Raul Hernandez', N'rhernandez', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (25, N'Saul Almeida', N'salmeida', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (26, N'Nicolas Capata', N'ncapata', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (27, N'Brian Bonilla', N'bbonilla', N'trees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (28, N'Annie Dover', N'adover', N'trees', N'BSS', 0, 1, 1)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (29, N'Oscar Ungson', N'oungson', N'treees', N'BSS', 0, 1, 0)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (30, N'Heng Wang', N'hwang', N'trees', N'BSS', 0, 1, 1)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (31, N'Maryam Shayamfar', N'mshayamfar', N'trees', N'BSS', 0, 1, 1)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (32, N'Joshua Chan', N'jchan', N'trees', N'BSS', 0, 1, 1)
INSERT [dbo].[tblUsers] ([User_ID], [User_FullName], [User_Name], [User_Password], [User_Agency], [User_Level], [User_Power], [User_Cert]) VALUES (33, N'Steven Smith', N'ssmith', N'trees', N'BSS', 0, 1, 0)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
