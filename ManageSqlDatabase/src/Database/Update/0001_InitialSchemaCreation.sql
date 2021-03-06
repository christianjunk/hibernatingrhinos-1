GO
/****** Object:  Table [dbo].[Plant]    Script Date: 08/04/2008 16:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plant](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Plant_Id]  DEFAULT (newid()),
	[Name] [nvarchar](50) NULL,
	[Comment] [nvarchar](4000) NULL,
	[CustomerId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 08/04/2008 16:23:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Country_Id]  DEFAULT (newid()),
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](3) NOT NULL,
	[ContinentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantSection]    Script Date: 08/04/2008 16:23:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantSection](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PlantSection_Id]  DEFAULT (newid()),
	[Name] [nvarchar](50) NULL,
	[PlantId] [uniqueidentifier] NULL,
	[Comment] [nvarchar](4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriveSystem]    Script Date: 08/04/2008 16:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriveSystem](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DriveSystem_Id]  DEFAULT (newid()),
	[Name] [nvarchar](50) NULL,
	[PlantSectionId] [uniqueidentifier] NULL,
	[Comment] [nvarchar](4000) NULL,
	[DriveSystemTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 08/04/2008 16:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [uniqueidentifier] NOT NULL,
	[type] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[AddressLine1] [nvarchar](70) NOT NULL,
	[AddressLine2] [nvarchar](70) NULL,
	[City] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](7) NOT NULL,
	[CountryId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK4D421FF8439FD011]    Script Date: 08/04/2008 16:23:48 ******/
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK4D421FF8439FD011] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK4D421FF8439FD011]
GO
/****** Object:  ForeignKey [FK1D8258BC9CEDF860]    Script Date: 08/04/2008 16:23:52 ******/
ALTER TABLE [dbo].[DriveSystem]  WITH CHECK ADD  CONSTRAINT [FK1D8258BC9CEDF860] FOREIGN KEY([PlantSectionId])
REFERENCES [dbo].[PlantSection] ([Id])
GO
ALTER TABLE [dbo].[DriveSystem] CHECK CONSTRAINT [FK1D8258BC9CEDF860]
GO
/****** Object:  ForeignKey [FK1E60B3BF254DB868]    Script Date: 08/04/2008 16:23:55 ******/
ALTER TABLE [dbo].[PlantSection]  WITH CHECK ADD  CONSTRAINT [FK1E60B3BF254DB868] FOREIGN KEY([PlantId])
REFERENCES [dbo].[Plant] ([Id])
GO
ALTER TABLE [dbo].[PlantSection] CHECK CONSTRAINT [FK1E60B3BF254DB868]
GO
