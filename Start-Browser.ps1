Function Start-Browser
{
    <#
    .Synopsis
        Start a new Browser
    .Description
        Starts a new Browser. Not to be confused with Open-Browser, which opens a browser for automation.
    .Example
        Start-Browser
    #>
    [OutputType([PSObject])]
    Param
    (
        [System.String[]]
      , $ArgumentList
        
        [PSCredential]
      , $Credential
        
      , $LoadUserProfile
        
      , $NoNewWindow
        
      , $PassThru
        
        [System.String]
      , $RedirectStandardError
        
        [System.String]
      , $RedirectStandardInput
        
        [System.String]
      , $RedirectStandardOutput
        
      , $UseNewEnvironment
        
      , $Wait
        
        [ProcessWindowStyle]
      , $WindowStyle
        
        [System.String]
      , $WorkingDirectory
      
      , $CommonParameters
    #>
        
    )
    @PSBoundParameters = @(iexplorer) + @PSBoundParameters
    
    Start-Process iexplorer @PSBoundParameters;
}