Function Open-Browser
{
    <#
    .Synopsis
        Opens a new Browser
    .Description
        Opens a new Browser for AutoBrowse.
    .Example
        Open-Browser
    .Example
        Open-Browser -Visible
    .Link
        Close-Browser
    .Link
        Wait-BrowserReady
    #>
    [OutputType([PSObject])]
    param(
        # If set, the browser will be visible
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Switch]
        $Visible
    )
    $ie = New-Object -ComObject InternetExplorer.Application -Property @{Visible=$visible; Height=600; Width=800; Top=0; Left=0};
    return $ie;
}