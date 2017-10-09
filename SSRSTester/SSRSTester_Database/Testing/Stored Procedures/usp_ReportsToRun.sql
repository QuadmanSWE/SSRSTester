CREATE PROCEDURE [Testing].[usp_ReportsToRun] @TestID int AS
BEGIN
	SELECT
	rt.ItemID
	,r.OldReportName
	,r.OldReportPath
	,rt.RowID
	FROM [Testing].[ReportTests] as rt
	INNER JOIN [Testing].[Reports] as r
		ON rt.ItemID = r.ItemID
	where rt.TestID = @TestID
	AND rt.ExistsInProject = 1
	SELECT
	rp.ItemID,rp.ParameterName,rp.ParameterType
	FROM [Testing].[ReportTests] as rt
	INNER JOIN [Testing].[v_ReportParameters] as rp
		ON rt.ItemID = rp.ItemID
	where rt.TestID = @TestID
	AND rt.ExistsInProject = 1
END