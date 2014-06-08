function Assert-IsIE
{
    param(
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
          , Position=0
        )]
        $ie
    )
    If ($ie.PSObject.TypeNames -NotContains 'System.__ComObject' -And -Not $ie.Quit)
      { $_; Throw "Not IE" }
    $true
}