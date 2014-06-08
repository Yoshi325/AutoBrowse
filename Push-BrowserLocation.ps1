function Push-BrowserLocation
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
        
      , [Parameter(
            Mandatory=$true
          , ValueFromPipelineByPropertyName=$true
          , Position=0
        )]
        [Uri]
        $url
        
      , # The page load timeout
        [Parameter(Mandatory=$false)]
        [Timespan]
        $Timeout = $AutoBrowse.Timeout
        
      , # The sleep increment between waits for the page to load
        [Parameter(Mandatory=$false)]
        [Timespan]
        $SleepInc = $AutoBrowse.SleepInc
        
      , # Examples: _blank, _parent, _self, _top, <WindowName> (A named HTML frame; If no frame or window exists that matches the specified target name, a new window is opened.)
        [Parameter(Mandatory=$false)]
        [String]
        $targetFrame = $null
        
      , [Parameter(Mandatory=$false)]
        [Switch]
        $waitForLoad=$false
    )
    Begin
    {
        
    }
    Process
    {
        <#  The second argument of Navigate2 is a 'flags' argument: 
            http://msdn.microsoft.com/en-us/library/aa768360(v=vs.85).aspx
            typedef enum BrowserNavConstants
            {
                navOpenInNewWindow       =     0x1
              , navNoHistory             =     0x2
              , navNoReadFromCache       =     0x4
              , navNoWriteToCache        =     0x8
              , navAllowAutosearch       =    0x10
              , navBrowserBar            =    0x20
              , navHyperlink             =    0x40
              , navEnforceRestricted     =    0x80
              , navNewWindowsManaged     =  0x0100
              , navUntrustedForDownload  =  0x0200
              , navTrustedForActiveX     =  0x0400
              , navOpenInNewTab          =  0x0800
              , navOpenInBackgroundTab   =  0x1000
              , navKeepWordWheelText     =  0x2000
              , navVirtualTab            =  0x4000
              , navBlockRedirectsXDomain =  0x8000
              , navOpenNewForegroundTab  = 0x10000
            } BrowserNavConstants;
        #>
        
        # ToDo: Add these to the params accepted.
        $postData = $null;
        $headers  = $null;
        
        <#
            [MethodImpl(MethodImplOptions.InternalCall, MethodCodeType = MethodCodeType.Runtime), DispId(500)]
            void Navigate2(
                [In, MarshalAs(UnmanagedType.Struct)] ref object URL
              , [In, Optional, MarshalAs(UnmanagedType.Struct)] ref object Flags
              , [In, Optional, MarshalAs(UnmanagedType.Struct)] ref object TargetFrameName
              , [In, Optional, MarshalAs(UnmanagedType.Struct)] ref object PostData
              , [In, Optional, MarshalAs(UnmanagedType.Struct)] ref object Headers
            );
        #>
        
        $Navigate2Args = @(
            ?: { $url -ne $null } { "$url" } { 'about:blank' }
          , 2
          , $targetFrame
          , $postData
          , $headers
        );
        Write-AutoBrowseDebug -Message "Navigating To: $url "
        # http://msdn.microsoft.com/en-us/library/aa752134(v=vs.85).aspx
        $ie.Navigate2.Invoke($Navigate2Args)
        
        If ($waitForLoad)
          { $ie | Wait-BrowserReady -Timeout $Timeout -Sleeptime $sleepTime }
        
        Return $ie;
    }
    End
    {
        
    }
}