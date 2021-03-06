function Get-Browser
{
    <#
    .Synopsis
        Gets open browsers
    .Description
        Gets browsers that are currently open
    .Example
        Get-Browser
    .Link
        Open-Browser
    #>
    Begin
    {
        
    }
    
    Process
    {
        $sa = (New-Object -ComObject Shell.Application)
        $sa.Windows() `
          | Where-Object
              { $_.Fullname -And $_.Fullname -Like "*iexplore.exe" } `
              | ForEach-Object
                {
                    If ($Bodyhtml)
                      { $_.Document.body.innerHtml }
                    Else
                      { $_ }
                }
    }
    
    End
    {
        
    }
} 
