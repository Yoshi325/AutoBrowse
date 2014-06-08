function Show-BrowserState
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
      , [Switch]
        $blackhole
    )
    Write-Host -NoNewline "== Browser State ======================="
    Write-Host            "========================================"
    Write-Host "Current Location: " $ie.LocationName
    If ($ie.LocationName -ne $ie.LocationURL)
      { Write-Host "Current URL:      " $ie.LocationURL }
    If ($blackhole)
    {
        return $null
    }
    $ie
}