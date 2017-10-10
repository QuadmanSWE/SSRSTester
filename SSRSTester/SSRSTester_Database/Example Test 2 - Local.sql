--Copies data from the local ReportServer.
DECLARE @testId int = 2;
INSERT INTO [Testing].[Reports]
(
ItemID, OldReportPath, OldReportName, OldReportParentID, OldReportDescription, OldReportHidden, OldReportCreatedByID, OldReportCreationDate, OldReportModifiedByID, OldReportModifiedDate, OldReportParameter, OldReportPolicyID, OldReportPolicyRoot
)
SELECT 
ItemID, Path, Name, ParentID, Description, Hidden, CreatedByID, CreationDate, ModifiedByID, ModifiedDate, Parameter, PolicyID, PolicyRoot
FROM [$(ReportingServicesDummy)].dbo.Catalog WHERE type = 2;

INSERT INTO [Testing].[ReportTests] (ItemID, [TestID], [ExistsInProject])
SELECT ItemId, @testId AS TestId, 1 AS [ExistsInProject] FROM [Testing].[Reports]; --we already know everything exists, no need to run the procedure as in example 1.

