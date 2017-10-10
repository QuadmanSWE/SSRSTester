function Set-AutomatedRenderStatus([guid]$ItemID,[int]$TestID,[bool]$success,[string]$ErrorMessage, [System.Data.SqlClient.SqlConnection] $SQLConnection)
{
    $SQLConnection.Open()
	$updateStatusCommand = New-Object System.Data.SqlClient.SqlCommand
    $updateStatusCommand.CommandText = "[Testing].[usp_SetAutomatedRenderStatus]"
    $updateStatusCommand.Parameters.AddWithValue("@ItemID",$reportGuid) | out-null
    $updateStatusCommand.Parameters.AddWithValue("@TestID",$testID) | out-null
    $updateStatusCommand.Parameters.AddWithValue("@success",$false) | out-null
    $updateStatusCommand.Parameters.AddWithValue("@ErrorMessage",$ErrorMessage) | out-null
    $updateStatusCommand.Connection = $SQLConnection
    $updateStatusCommand.CommandType = [System.Data.CommandType]::StoredProcedure

    $updateStatusCommand.ExecuteNonQuery() | out-null
    $SQLConnection.Close()
}