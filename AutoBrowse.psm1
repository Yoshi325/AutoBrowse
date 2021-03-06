$AutoBrowse = @{
    Timeout     = [Timespan]'0:0:30'
  ; SleepInc    = [Timespan]'0:0:0.1'
  ; DebugOut    = $false
  ; DebugFilter = $null
}

. $PSScriptRoot\Assert-IsIE.ps1
. $PSScriptRoot\Clear-CertificateError.ps1
. $PSScriptRoot\Close-Browser.ps1
. $PSScriptRoot\Get-Browser.ps1
. $PSScriptRoot\Get-BrowserControl.ps1
. $PSScriptRoot\Open-Browser.ps1
. $PSScriptRoot\Push-BrowserLocation.ps1
. $PSScriptRoot\Set-BrowserControl.ps1
. $PSScriptRoot\Show-BrowserState.ps1
. $PSScriptRoot\Test-BrowserLocation.ps1
. $PSScriptRoot\Use-BrowserControl.ps1
. $PSScriptRoot\Wait-BrowserReady.ps1
. $PSScriptRoot\Write-AutoBrowseDebug.ps1