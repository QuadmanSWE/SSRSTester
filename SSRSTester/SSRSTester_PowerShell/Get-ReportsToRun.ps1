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