Function Use-BrowserControl
{
    <#
    .Synopsis
        Uses a control in a Browser's DOM.
    .Description
        Gets a control from a Browser's DOM, and then uses it.  Controls can be selected by id, name, tagname, and innertext
    .Link
        Use-BrowserControl
    .Link
        Open-Browser

    #>
    [CmdletBinding(DefaultParameterSetName='Id')]
    [OutputType([PSObject])]
    param(
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
        
      , # The ID of the object within the page
        [Parameter(Mandatory=$true, ParameterSetName='ById')]
        [string]
        $Id
        
      , # The name of the object within the page
        [Parameter(Mandatory=$true, ParameterSetName='ByName')]
        [string]
        $Name
        
      , # The tag name of the object within the page
        [Parameter(Mandatory=$true, ParameterSetName='ByTagName')]
        [string]
        $TagName
        
      , # Will find a tag title within items a specific tag
        [string]
        $TagTitle
        
      , # Will find a link that points to a particular HREF
        [Parameter(Mandatory=$true, ParameterSetName='ByHref')]
        [string]
        $Href
        
      , # The property of the document object
        [Parameter(Mandatory=$true, ParameterSetName='ByInnerText')]
        [string]
        $DocumentProperty
        
      , # The inner text to find.
        [Parameter(Mandatory=$true, ParameterSetName='ByInnerText')]
        [string]
        $InnerText
        
      , # If set, will find elements that have an innertext like the value, rather than an exact match
        [Parameter(ParameterSetName='ByInnerText')]
        [switch]
        $Like
        
      , 
        # If set, will run a click
        [switch]
        $Click
        
      , # If provided, will fire a number of javascript events
        [Hashtable]
        $Event
    )
    
    Process
    {
        $originalParameters = @{} + $PSBoundParameters
        $PSBoundParameters.Remove("Click")     > $null
        $PSBoundParameters.Remove("Event")     > $null
        $PSBoundParameters.Remove("Timeout")   > $null
        $PSBoundParameters.Remove("SleepTime") > $null
        @( Get-BrowserControl @PSBoundParameters | Select-Object -Unique ) |
            ForEach-Object {
                If ($click -and $_.Click)
                {
                    $debugParameters = @{Message="Clicking: " + $_.id;}
                    Write-AutoBrowseDebug @debugParameters
                    $_.Click();
                }
                
                If ($originalParameters['Event'] -and $_.FireEvent)
                {
                    ForEach ($kvp in $originalParameters['Event'])
                      { $_.FireEvent($kvp.Key, $kvp.Value) }
                }
            }
        Return $ie;
    }
}