

CREATE VIEW [Testing].[v_ReportParameters] AS 
SELECT
ItemID
,m.OldReportName AS ReportName
,m.OldReportPath AS ReportPath
,CAST(m.OldReportParameter as XML) parameterXML
,ReportParameters.*
FROM [Testing].[Reports] as m
CROSS APPLY (
	SELECT CAST(m.OldReportParameter as XML).query('/Parameters/Parameter') as paramsXML
) as x 
CROSS APPLY (
	select
	  y.Parameter.value	('Name[1]',			'varchar(50)') 	AS 	ParameterName
	, y.Parameter.value	('Type[1]',			'varchar(50)') 	AS 	ParameterType
	, y.Parameter.value	('Nullable[1]',		'bit')	 		AS 	ParameterNullable
	, y.Parameter.value	('AllowBlank[1]',	'bit')	 		AS 	ParameterAllowBlank
	, y.Parameter.value	('MultiValue[1]',	'bit')	 		AS 	ParameterMultiValue
	, y.Parameter.value	('UsedInQuery[1]',	'bit')	 		AS 	ParameterUsedInQuery
	, y.Parameter.value	('State[1]',		'varchar(50)')	AS 	ParameterState
	, y.Parameter.value	('Prompt[1]',		'varchar(50)')	AS 	ParameterPrompt
	, y.Parameter.value	('PromptUser[1]',	'bit')	 		AS 	ParameterPromptUser
	-- defaultvalues and values as singleton and sets respectivly. could be put here with some xml magic
	FROM paramsXML.nodes('//Parameter') AS y(Parameter)
) as ReportParameters

