$testID = 1

$connectionString = "Data Source=localhost\sql2017;Initial Catalog=ReportMigration;Integrated Security=True;";
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connectionString

$reportsToRun = Get-ReportsToRun $testID $conn
$reportsToRun


$ReportServerURL = "http://dsoderlund"
$ReportServerInstance = "sql2017" 
    

Invoke-SSRS $reportsToRun $ReportServerURL $ReportServerInstance "PDF" "D:\sql2016demo\powershell_testresults\test$testID" $conn