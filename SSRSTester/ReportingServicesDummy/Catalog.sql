
CREATE TABLE [dbo].[Catalog](
	[ItemID] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](425) NOT NULL,
	[Name] [nvarchar](425) NOT NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Type] [int] NOT NULL,
	[Content] [image] NULL,
	[Intermediate] [uniqueidentifier] NULL,
	[SnapshotDataID] [uniqueidentifier] NULL,
	[LinkSourceID] [uniqueidentifier] NULL,
	[Property] [ntext] NULL,
	[Description] [nvarchar](512) NULL,
	[Hidden] [bit] NULL,
	[CreatedByID] [uniqueidentifier] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModifiedByID] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[MimeType] [nvarchar](260) NULL,
	[SnapshotLimit] [int] NULL,
	[Parameter] [ntext] NULL,
	[PolicyID] [uniqueidentifier] NOT NULL,
	[PolicyRoot] [bit] NOT NULL,
	[ExecutionFlag] [int] NOT NULL,
	[ExecutionTime] [datetime] NULL,
	[SubType] [nvarchar](128) NULL,
	[ComponentID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Catalog] PRIMARY KEY NONCLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--ALTER TABLE [dbo].[Catalog]  WITH NOCHECK ADD  CONSTRAINT [FK_Catalog_CreatedByID] FOREIGN KEY([CreatedByID])
--REFERENCES [dbo].[Users] ([UserID])
--GO

--ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_CreatedByID]
--GO

ALTER TABLE [dbo].[Catalog]  WITH NOCHECK ADD  CONSTRAINT [FK_Catalog_LinkSourceID] FOREIGN KEY([LinkSourceID])
REFERENCES [dbo].[Catalog] ([ItemID])
GO

ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_LinkSourceID]
GO

--ALTER TABLE [dbo].[Catalog]  WITH NOCHECK ADD  CONSTRAINT [FK_Catalog_ModifiedByID] FOREIGN KEY([ModifiedByID])
--REFERENCES [dbo].[Users] ([UserID])
--GO

--ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_ModifiedByID]
--GO

ALTER TABLE [dbo].[Catalog]  WITH NOCHECK ADD  CONSTRAINT [FK_Catalog_ParentID] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Catalog] ([ItemID])
GO

ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_ParentID]
GO

--ALTER TABLE [dbo].[Catalog]  WITH NOCHECK ADD  CONSTRAINT [FK_Catalog_Policy] FOREIGN KEY([PolicyID])
--REFERENCES [dbo].[Policies] ([PolicyID])
--GO

--ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_Policy]
--GO