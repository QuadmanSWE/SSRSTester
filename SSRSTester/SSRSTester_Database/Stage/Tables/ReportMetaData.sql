CREATE TABLE [Stage].[ReportMetaData] (
    [ItemID]       UNIQUEIDENTIFIER NULL,
    [Path]         NVARCHAR (425)   NULL,
    [Name]         NVARCHAR (425)   NULL,
    [ParentID]     UNIQUEIDENTIFIER NULL,
    [Type]         INT              NULL,
    [Intermediate] UNIQUEIDENTIFIER NULL,
    [Property]     NTEXT            NULL,
    [Description]  NVARCHAR (512)   NULL,
    [Hidden]       BIT              NULL,
    [CreatedByID]  UNIQUEIDENTIFIER NULL,
    [CreationDate] DATETIME         NULL,
    [ModifiedByID] UNIQUEIDENTIFIER NULL,
    [ModifiedDate] DATETIME         NULL,
    [Parameter]    NTEXT            NULL,
    [PolicyID]     UNIQUEIDENTIFIER NULL,
    [PolicyRoot]   BIT              NULL
);

