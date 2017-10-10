$testID = 1
$renderFormat = "PDF"
$localRenderFolder = "D:\sql2016demo\powershell_testresults\test$testID"

#assuming you have sql engine and ssrs on the same machine and with the same instance name

$ServerName = "dsoderlund"
$ServerInstance = "sql2017" 
$connectionString = "Data Source=$ServerName\$ServerInstance;Initial Catalog=ReportMigration;Integrated Security=True;";

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connectionString

$reportsToRun = Get-ReportsToRun $testID $conn
$reportsToRun


#for each report, get the parameters, set them if needed to some value (first available or the string "1"), render to the chosen format and then update the testrecord in the database with success or fail.
Invoke-SSRS $reportsToRun $ServerName $ReportServerInstance $renderFormat $localRenderFolder $conn