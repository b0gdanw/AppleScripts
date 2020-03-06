-- based on https://gist.github.com/clburlison/db6aaf4a717eb8ef3545

set MacOSVers to do shell script "defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion"
set MacOSBuild to do shell script "defaults read /System/Library/CoreServices/SystemVersion.plist ProductBuildVersion"

set XProtectVers to do shell script "defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist Version"
set XProtectDate to do shell script "GetFileInfo -d /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist"

set GatekeeperVers to do shell script "defaults read /private/var/db/gkopaque.bundle/Contents/version.plist CFBundleShortVersionString"
set GatekeeperDate to do shell script "GetFileInfo -d /private/var/db/gkopaque.bundle/Contents/version.plist"

set SIPVer to do shell script "defaults read /System/Library/Sandbox/Compatibility.bundle/Contents/version.plist CFBundleShortVersionString"
set SIPDateShort to do shell script "GetFileInfo -d /System/Library/Sandbox/Compatibility.bundle/Contents/version.plist"

set MRTVer to do shell script "defaults read /System/Library/CoreServices/MRT.app/Contents/version.plist CFBundleShortVersionString"
set MRTDate to do shell script "GetFileInfo -d /System/Library/CoreServices/MRT.app/Contents/version.plist"

set SIPStatus to do shell script "/usr/bin/csrutil status"
set GatekeeperStatus to do shell script "spctl --status | sed -e s/'assessments'//g"

display dialog tab & tab & tab & "MacOS " & MacOSVers & " (" & MacOSBuild & ")" & return & return & "Component " & tab & tab & "Version " & tab & tab & "Updated " & return & return & "XProtect " & tab & tab & XProtectVers & tab & tab & XProtectDate & return & "Gatekeeper " & tab & tab & GatekeeperVers & tab & tab & tab & GatekeeperDate & return & "SIP" & tab & tab & tab & tab & SIPVer & tab & tab & tab & SIPDateShort & return & "MRT " & tab & tab & tab & MRTVer & tab & tab & tab & MRTDate & return & return & SIPStatus & return & "Gatekeeper Status:" & GatekeeperStatus & return buttons {"Close"} default button 1
