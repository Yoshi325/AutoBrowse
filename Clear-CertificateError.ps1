function Clear-CertificateError
{
    <#
    .Synopsis
        Accepts Certificate Errors encounted by Internet Explorer.
    .Description
        Accepts Certificate Errors encounted by Internet Explorer.
    .Example
        Open-Browser | Clear-CertificateError | Close-Browser
    .Link
        Open-Browser
    .Link
        Wait-BrowserReady
    .Link
        Close-Browser
    #>
    [OutputType([PSObject])]
    Param(
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
    )
    $override = $ie | Get-BrowserControl -Id "overridelink"
    If ($override -ne $null)
    {
        Write-Host -NoNewline "Certificate Error encountered; Continuing to the requested location.";
        $override.Click();
        $ie | Wait-BrowserReady
    }
    $ie
}