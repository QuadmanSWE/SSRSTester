CREATE TABLE [Testing].[Reports] (
    [ItemID]                UNIQUEIDENTIFIER NOT NULL,
    [OldReportPath]         NVARCHAR (425)   NULL,
    [OldReportName]         NVARCHAR (425)   NULL,
    [OldReportParentID]     UNIQUEIDENTIFIER NULL,
    [OldReportDescription]  NVARCHAR (512)   NULL,
    [OldReportHidden]       BIT              NULL,
    [OldReportCreatedByID]  UNIQUEIDENTIFIER NULL,
    [OldReportCreationDate] DATETIME         NULL,
    [OldReportModifiedByID] UNIQUEIDENTIFIER NULL,
    [OldReportModifiedDate] DATETIME         NULL,
    [OldReportParameter]    NTEXT            NULL,
    [OldReportPolicyID]     UNIQUEIDENTIFIER NULL,
    [OldReportPolicyRoot]   BIT              NULL,
    CONSTRAINT [PK_Reports] PRIMARY KEY NONCLUSTERED ([ItemID] ASC)
);

