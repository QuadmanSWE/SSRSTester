CREATE PROCEDURE [Testing].[usp_SetAutomatedRenderStatus]
  @ItemID uniqueidentifier
, @TestID INT
, @success bit
, @ErrorMessage nvarchar(2000) = NULL
AS BEGIN
UPDATE [rt]
SET
  [SuccessfulAutomaticRun] = @success
, [AutomaticRunException] = @ErrorMessage
FROM [Testing].[ReportTests] AS [rt]
WHERE [rt].[ItemID] = @ItemID
AND [rt].[TestID] = @TestID
END