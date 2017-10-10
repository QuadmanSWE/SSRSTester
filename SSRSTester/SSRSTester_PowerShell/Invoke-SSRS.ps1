function Invoke-SSRS
($reportsToRun,[string]$ServerName,[string]$ReportServerInstance,[string]$format, [string]$localFolderForFiles, [System.Data.SqlClient.SqlConnection]$SQLConnection)
{

    $ReportServer = "http://$ServerName//reportserver_$ReportServerInstance//"
    
	$ExecutionURI = $ReportServer + "ReportExecution2005.asmx?wsdl"
    $ReportingURI = $ReportServer + "ReportService2010.asmx?wsdl"
	
    $ExectutionProxy = New-WebServiceProxy -Uri $ExecutionURI -UseDefaultCredential -namespace "ReportExecution2005" # this loads the assembly needed for executing reports on reportserver
    $BrowsingProxy   = New-WebServiceProxy -Uri $ReportingURI -UseDefaultCredential -namespace "ReportService2010"   # this loads the assembly needed for browsing the reports

    foreach($r in $reportsToRun)
    {
        $reportGuid = $r.ItemID
        $ReportPath = $r.OldReportPath

        #  For each parameter, set a value if there isn't a default and add it to a list
        #  Using the browser, set all parameters to either their first valid value or "1" if it allows any string.

        $listOfParameters = New-Object System.Collections.Generic.List[ReportExecution2005.ParameterValue]
        $rsBrowse = New-Object ReportService2010.ReportingService2010
        $rsBrowse.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
        $rsBrowse.GetItemParameters($ReportPath, [NullString]::Value, $true, $null, $null) |
        ForEach-Object {
            $p = $_
            $param = New-Object ReportExecution2005.ParameterValue
            $param.Name = $p.Name
            if ($p.ValidValues -ne $null)
            {
                $param.Value = $p.ValidValues[0].Value #if there is a value list in SSRS, take the first one.
            }
            else {
                $param.Value = "1"  #otherwize, just try and set it to "1" and hope for the best :)
            }
            $listOfParameters.add($param)
        }
 
   
        #  render the report using the parameters and store the results
        $rsExec = new-object ReportExecution2005.ReportExecutionService            
        $rsExec.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

        $execInfo = @($ReportPath, $null)      

        $rsExec.GetType().GetMethod("LoadReport").Invoke($rsExec, $execInfo) | out-null              
    
        #Set ExecutionParameters            
        $ExecParams = $rsExec.SetExecutionParameters($listOfParameters, "en-us");   

        try{
              
            #declare return variables
            $deviceinfo = ""            
            $extention = ""            
            $mimeType = ""            
            $encoding = ""            
            $warnings = $null            
            $streamIDs = $null  

            # Render the report as a PDF or whatever $format is set to.    
            $render = $rsExec.Render($format, $deviceInfo,[ref] $extention, [ref] $mimeType,[ref] $encoding, [ref] $warnings, [ref] $streamIDs)             
            $a = $r.OldReportPath.Replace("/","--")
            $b = $r.ItemID
            $c = $r.RowId
            $resultFileNameTemplate = "$c - $a - [$b].$format"

            $filename = $localFolderForFiles + "\" + $resultFileNameTemplate
            $Stream = New-Object System.IO.FileStream($filename), Create, Write
            $Stream.Write($render, 0, $render.Length)
		    
           

            $render.Clear()
            $stream.Close()
            $Stream.Dispose()
            $rsExec.Dispose()
        
            $success = $true
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            $success = $false
        }
        
        Set-AutomatedRenderStatus $reportGuid $testID $success $ErrorMessage $SQLConnection
		$success
    }
	
	
}