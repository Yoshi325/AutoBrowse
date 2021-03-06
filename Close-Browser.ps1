Function Close-Browser
{
    <#
    .Synopsis
        Closes a running Browser.
    .Description
        Closes a running Browser, started by AutoBrowser's Open-Browser.
    .Example
        Open-Browser -Visible | Close-Browser
    .Link
        Open-Browser
    .Link
        Wait-BrowserReady
    #>
    [OutputType([Nullable])]
    Param(
        # The Browser Object.
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
    )
    $ie.Quit()
    # http://technet.microsoft.com/en-us/library/ff730962.aspx
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($ie) > $null
}