function Write-AutoBrowseDebug
{
    [OutputType([PSObject])]
    param(
        [Parameter(
            Mandatory=$false
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
        
      , [Parameter(Mandatory=$false)]
        [ValidateSet('Progress','Complete','Message', IgnoreCase=$true)]
        [System.String]
        $type = 'Message'
        
      , [Parameter(Mandatory=$false)]
        [System.String]
        $message
        
      , [Parameter(Mandatory=$false)]
        [System.String]
        $completeCharacter = '√'
        
      , [Parameter(Mandatory=$false)]
        [System.String]
        $progressCharacter = '.'
        
      , [Parameter(Mandatory=$false)]
        [Switch]
        $ForceNewLine
    )
    # ToDo: Somehow store static like configuration about how output should be preformed.
    $parameters = @{};
    
    If (-Not $ForceNewline)
      { $parameters.Add('NoNewline', $true) }
    
    $typedMessage = '';
    Switch ($type)
    {
        'Progress' { $typedMessage = $progressCharacter; }
        'Complete' { $typedMessage = $completeCharacter; $parameters.Remove('NoNewLine'); }
        'Message'  { $typedMessage = $message;           }
        default    { $typedMessage = $message;           }
    }
    
    $parameters.Add('Object', $typedMessage)
    
    Write-Host @parameters
    
    If ($ie -ne $null)
      { Return $ie; }
    Else
      { Return; }
}