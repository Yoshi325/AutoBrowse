function Wait-BrowserReady
{
    [OutputType([PSObject])]
    param(
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
      , # The timeout to wait for the page to reload after an action 
        [Timespan]
        $timeout = "0:0:30"
      , # The timeout to sleep in between each check to see if the page has reloaded
        [Timespan]
        $sleepTime = "0:0:1"
    )
    
    Begin
    {
        
    }
    
    Process
    {
        $start = Get-Date
        
        While ($start + $timeout -ge (Get-Date))
        {
            If ($ie.Busy)
            {
                Write-AutoBrowseDebug -Type Progress
                Start-Sleep -Milliseconds $sleepTime.TotalMilliseconds
                Continue
            }
            
            If ($ie.Document.ReadyState -ne 'Complete')
            {
                Write-AutoBrowseDebug -Type Progress
                Start-Sleep -Milliseconds $sleepTime.TotalMilliseconds
                Continue
            }
            
            $childNodesNotCompleted =
                $ie.Document.'IHTMLDOMNode_childNodes' `
              | Where-Object { $_.ReadyState -And $_.ReadyState -ne 'Complete' }
            
            If ($childNodesNotCompleted)
            {
                Write-AutoBrowseDebug -Type Progress
                Start-Sleep -Milliseconds $sleepTime.TotalMilliseconds
                Continue
            }
            Break
        }
        
        If ($start + $timeout -lt (Get-Date))
        {
            Write-Error -Exception (New-Object TimeoutException) -ErrorId 'WaitBrowser.Timeout'
        }
        Else
        {
            Write-AutoBrowseDebug -Type Complete
        }
        
        Return $ie;
    }
    
    End
    {
        
    }
}