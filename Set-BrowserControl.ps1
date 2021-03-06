Function Set-BrowserControl
{
    <#
    .Synopsis
        Sets a value in a browser control
    .Description
        Sets the value of a control in a browser, and fires an On_Change event
    .Link
        Get-BrowserControl
    #>
    [CmdletBinding(DefaultParameterSetName='Id')]
    [OutputType([PSObject])]
    Param(
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
        
      , # Sets a series of values to specific IDs
        [Parameter(
            Mandatory=$true
          , ParameterSetName='Table'
        )]
        [Hashtable]
        $hashtable
        
      , # The ID of the object within the page
        [Parameter(
            Mandatory=$true
          , ParameterSetName='ById'
        )]
        [System.String]
        $id
        
      , # The name of the object within the page
        [Parameter(
            Mandatory=$true
          , ParameterSetName='ByName'
        )]
        [System.String]
        $name
        
      , # The tag name of the object within the page
        [Parameter(
            Mandatory=$true
          , ParameterSetName='ByTagName'
        )]
        [System.String]
        $tagName
        
      , # The value to set
        [System.String]
        $value
    )
    Begin
    {
        
    }
    Process
    {
        If ($psCmdlet.ParameterSetName -eq 'Table')
        {
            ForEach ($kv in $Hashtable.GetEnumerator())
            {
                $idMatch = Get-BrowserControl -ie $ie -Id $kv.Key
                If (-Not $idMatch)
                {
                    $nameMatch = Get-BrowserControl -ie $ie -Name $kv.Key
                    If ($nameMatch)
                    {
                        Foreach ($nm in $nameMatch)
                        {
                            If ($nm.PSObject.Properties["Value"])
                              { $nm.Value = $kv.Value }
                            ElseIf ($nm.PSObject.Properties["InnerText"])
                              { $nm.InnerText = $kv.Value }
                        }
                    }
                }
                Else
                {
                    $idMatch.Value = $kv.Value
                }
            }
        }
        Else
        {
            $null = $PSBoundParameters.Remove("Value")
            Get-BrowserControl @PSBoundParameters `
              | ForEach-Object {
                    If ($_.psobject.properties["Value"])
                    {
                        $_.Value = $value
                    }
                    ElseIf ($_.psobject.properties["InnerText"])
                    {
                        $_.InnerText = $value
                    }
                    $_.FireEvent("onchange", [ref]$null) > $null
                }
        }
        return $ie;
    }
    End
    {
        
    }
}