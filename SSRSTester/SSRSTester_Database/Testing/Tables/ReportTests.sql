CREATE TABLE [Testing].[ReportTests] (
    [ItemID]                 UNIQUEIDENTIFIER NOT NULL,
    [TestID]                 INT              NOT NULL,
    [RowID]                  INT              IDENTITY (1, 1) NOT NULL,
    [ExistsInProject]        BIT              NULL,
    [DeploymentErrors]       BIT              NULL,
    [DeploymentErrorMessage] NVARCHAR (2000)  NULL,
    [SuccessfulAutomaticRun] BIT              NULL,
    [AutoMaticRunException]  NVARCHAR (2000)  NULL,
    [SuccessfulManualRun]    BIT              NULL,
    [ManualRunNotes]         NVARCHAR (2000)  NULL,
    [HasParameters]          BIT              NULL,
    [NumberOfParameters]     INT              NULL,
    [HasSubReports]          BIT              NULL,
    CONSTRAINT [PK_ReportTests] PRIMARY KEY NONCLUSTERED ([TestID] ASC, [ItemID] ASC),
    CONSTRAINT [FK_ReportTestsReports] FOREIGN KEY ([ItemID]) REFERENCES [Testing].[Reports] ([ItemID]),
    CONSTRAINT [FK_ReportTestsTests] FOREIGN KEY ([TestID]) REFERENCES [Testing].[Tests] ([TestID])
);

