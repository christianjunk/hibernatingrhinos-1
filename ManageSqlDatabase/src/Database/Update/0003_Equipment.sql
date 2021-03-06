GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 08/04/2008 16:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Comment] [nvarchar](255) NULL,
	[ParentEquipmentId] [uniqueidentifier] NULL,
	[EquipmentCategoryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentHierarchy]    Script Date: 08/04/2008 16:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentHierarchy](
	[ParentEquipment] [uniqueidentifier] NOT NULL,
	[ChildEquipment] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChildEquipment] ASC,
	[ParentEquipment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DriveSystemEquipment]    Script Date: 08/04/2008 16:30:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriveSystemEquipment](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Comment] [nvarchar](4000) NULL,
	[EquipmentId] [uniqueidentifier] NULL,
	[DriveSystemId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK5895490336225C6B]    Script Date: 08/04/2008 16:30:44 ******/
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK5895490336225C6B] FOREIGN KEY([ParentEquipmentId])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK5895490336225C6B]
GO
/****** Object:  ForeignKey [FK889702D652992B74]    Script Date: 08/04/2008 16:30:45 ******/
ALTER TABLE [dbo].[EquipmentHierarchy]  WITH CHECK ADD  CONSTRAINT [FK889702D652992B74] FOREIGN KEY([ParentEquipment])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[EquipmentHierarchy] CHECK CONSTRAINT [FK889702D652992B74]
GO
/****** Object:  ForeignKey [FK889702D6D1EEAC36]    Script Date: 08/04/2008 16:30:45 ******/
ALTER TABLE [dbo].[EquipmentHierarchy]  WITH CHECK ADD  CONSTRAINT [FK889702D6D1EEAC36] FOREIGN KEY([ChildEquipment])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[EquipmentHierarchy] CHECK CONSTRAINT [FK889702D6D1EEAC36]
GO
/****** Object:  ForeignKey [FKF57F676318887D43]    Script Date: 08/04/2008 16:30:47 ******/
ALTER TABLE [dbo].[DriveSystemEquipment]  WITH CHECK ADD  CONSTRAINT [FKF57F676318887D43] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[DriveSystemEquipment] CHECK CONSTRAINT [FKF57F676318887D43]
GO
/****** Object:  ForeignKey [FKF57F67639EAFA435]    Script Date: 08/04/2008 16:30:47 ******/
ALTER TABLE [dbo].[DriveSystemEquipment]  WITH CHECK ADD  CONSTRAINT [FKF57F67639EAFA435] FOREIGN KEY([DriveSystemId])
REFERENCES [dbo].[DriveSystem] ([Id])
GO
ALTER TABLE [dbo].[DriveSystemEquipment] CHECK CONSTRAINT [FKF57F67639EAFA435]
GO
