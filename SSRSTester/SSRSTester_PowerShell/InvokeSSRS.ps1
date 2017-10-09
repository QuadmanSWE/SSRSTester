function Invoke-SSRS
([int]$a,[string]$ReportServerURL,[string]$format)
{
	$ExecutionURI = $ReportServerURL + "ReportExecution2005.asmx?wsdl"
	$ExectutionProxy = New-WebServiceProxy -Uri $ExecutionURI -UseDefaultCredential -namespace "ReportExecution2005" # this loads the assembly needed for executing reports
	
	#$rv = New-Object Microsoft.Reporting.WinForms.ReportViewer
	#$rv.ServerReport.ReportServerUrl = $ReportServerURL
	if($a -eq 1)
    {
        return $ReportServerURL
    }
    else
    {
        return $ExecutionURI
    }
	
	
}

function Get-ReportsToRun([int]$TestID, [System.Data.SqlClient.SqlConnection] $SQLConnection)
{
    $SQLConnection.Open()
    $cmd = New-Object System.Data.SqlClient.SqlCommand
    $cmd.Connection = $SQLConnection
    $cmd.CommandText = "[Testing].[usp_ReportsToRun]"
    $cmd.Parameters.AddWithValue("@TestID",$TestID) | out-null
    $cmd.CommandType = [System.Data.CommandType]::StoredProcedure

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
    $ds  = New-Object System.Data.DataSet
    [Void] $SqlAdapter.Fill($ds)
    $SQLConnection.Close()
    return $ds.Tables[0]
}

$connectionString = "Data Source=localhost\sql2017;Initial Catalog=ReportMigration;Integrated Security=True;";
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connectionString

$reports = Get-ReportsToRun 1 $conn



$hostURL = "http://dsoderlund"
$ReportServer = $hostURL + "//reportserver_sql2017//"
$Reports = $hostURL + "//reports_sql2017//"

#Invoke-SSRS 2 $ReportServer "PDF" 



#$rsExec = new-object ReportExecution2005.ReportExecutionService            
#$rsExec.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials



$ReportingURI = $ReportServer + "ReportService2010.asmx?wsdl"
$s = New-WebServiceProxy -Uri $ReportingURI -UseDefaultCredential -namespace "ReportService2010"

$rsBrowse = New-Object ReportService2010.ReportingService2010
$rsBrowse.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

$testreportPath = "/SQL 2016 Demo/EmployeesByManager"


$rsBrowse.GetItemParameters($testreportPath, [NullString]::Value, $true, $null, $null)

