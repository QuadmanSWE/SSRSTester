--Copies data from staging and sets up a test containing all reports.
-- Make sure the target deployment state is what you have loaded to stage.
DECLARE @testId int = 1;
INSERT INTO [Testing].[Reports]
(
ItemID, OldReportPath, OldReportName, OldReportParentID, OldReportDescription, OldReportHidden, OldReportCreatedByID, OldReportCreationDate, OldReportModifiedByID, OldReportModifiedDate, OldReportParameter, OldReportPolicyID, OldReportPolicyRoot
)
SELECT 
ItemID, Path, Name, ParentID, Description, Hidden, CreatedByID, CreationDate, ModifiedByID, ModifiedDate, Parameter, PolicyID, PolicyRoot
FROM [Stage].[ReportMetaData];

INSERT INTO [Testing].[ReportTests] (ItemID, [TestID], [ExistsInProject])
SELECT ItemId, @testId AS TestId, 0 AS [ExistsInProject] FROM [Testing].[Reports];

EXECUTE [Testing].[usp_SetDeploymentStatusOnTest] @testId; --if you are not happy with the match between the reports and what you deployed you either have to change your deployment strategy or set up a routine of how to move or rename reports