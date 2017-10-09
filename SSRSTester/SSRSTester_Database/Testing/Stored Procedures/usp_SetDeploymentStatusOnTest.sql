--Make sure you are comfortable with collations in SQL Server when comparing strings. Different sql server installations dictate different collations.
--Either force a correction collate in this procedure or go back to the database creation (script 1) and put the collation you want in the ReportMigration database.
--Before running this procedure for the first time, consult the report mapping documentation.
	-- a) Either move the deployed reports accordingly
	-- b) or change the [dep].[Path] expression in the join to reflect the future deployment path.
CREATE PROCEDURE [Testing].[usp_SetDeploymentStatusOnTest] @testId INT AS
BEGIN
update [rt] set
ExistsInProject = 1
FROM [Testing].Reports AS r
INNER JOIN [Testing].[ReportTests] AS rt
	ON rt.ItemID = r.ItemID
INNER JOIN [Testing].v_ReportsThatHaveSuccessfullyDeployed AS [dep]
	ON [r].[OldReportPath] COLLATE Latin1_General_CI_AS = [dep].[Path]
WHERE rt.TestID = @testId
END