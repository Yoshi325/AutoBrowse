Function Get-BrowserControl
{
    <#
    .Synopsis
        Gets a control from a browser
    .Description
        Gets a control from a browser.  Controls can be selected by id, name, tagname, and innertext
    .Link
        Get-BrowserControl
    .Link
        Open-Browser

    #>
    [CmdletBinding(DefaultParameterSetName='Id')]
    [OutputType([PSObject], [String])]
    Param
    (
        [Parameter(
            Mandatory=$true
          , ValueFromPipeline=$true
          , ValueFromPipelineByPropertyName=$true
        )]
        [ValidateScript({$_ | Assert-IsIE})]
        $ie
        
        # The ID of the object within the page
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ById'
        )]
        [String]
        $id
        
        # The name of the object within the page
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ByName'
        )]
        [String]
        $name
        
        # The tag name of the object within the page
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ByTagName'
        )]
        [String]
        $tagName
        
        # Will find a tag title within items a specific tag
      , [String]
        $tagTitle
        
        # Will find a css class within items of a specific tag or  name
      , [String]
        $cssClass
        
        # Will find a link that points to a particular HREF
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ByHref'
        )]
        [String]
        $href
        
        # The property of the document object
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ByInnerText'
         )]
        [String]
        $DocumentProperty
        
        # The inner text to find.
      , [Parameter(
            Mandatory=$true
          , ParameterSetName='ByInnerText'
        )]
        [String]
        $innerText
        
        # If set, will find elements that have an innertext like the value, rather than an exact match
      , [Parameter(
            ParameterSetName='ByInnerText'
        )]
        [Switch]
        $Like
    )
    
    Process
    {
        #region Get the Controls
        if ($psCmdlet.ParameterSetName -eq 'ById')
        {
            $ie.Document.getElementById($id)
        }
        elseif ($psCmdlet.ParameterSetName -eq 'ByName')
        {
            $ie.Document.getElementById($name)
        }
        elseif ($psCmdlet.ParameterSetName -eq 'ByHref')
        {
            $ie.Document.getElementsByTagName("A") |
                Where-Object { $_.Href -eq $HRef}
        }
        elseif ($psCmdlet.ParameterSetName -eq 'ByTagName')
        {
            $found = $ie.Document.getElementsByTagName($tagname)
            if ($tagTitle)
            {
                $Found = $found | Where-Object { $_.Title -eq $tagTitle }
            }
            if ($CssClass)
            {
                $found = $found
                
            }
        }
        elseif ($psCmdlet.ParameterSetName -eq 'ByInnerText')
        {
            ForEach ($obj in $ie.Document.$DocumentProperty)
            {
                if ($like)
                {
                    if ($obj.InnerText -like "$InnerText")
                    {
                        $obj
                    }
                }
                else
                {
                    if ($obj.InnerText -eq "$InnerText")
                    {
                        $obj
                    }
                }
            }
        }
    }
}