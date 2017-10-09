CREATE PROCEDURE [Testing].[usp_SetAutomatedRenderStatus] @ItemID uniqueidentifier, @TestID INT, @success bit
AS BEGIN
UPDATE rt
set SuccessfulAutomaticRun = @success
FROM [Testing].[ReportTests] as rt
WHERE rt.ItemID = @ItemID
AND rt.TestID = @TestID
END