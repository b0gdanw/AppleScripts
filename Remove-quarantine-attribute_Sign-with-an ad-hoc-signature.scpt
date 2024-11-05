# Remove the quarantine attribute and Sign with an ad-hoc signature
# The script checks if an app has the quarantine attribute and if it is signed. Then offers to remove the quarantine attribute, remove the signature and re-sign the app with an ad-hoc signature.
# DO NO USE ON APPLICATIONS DOWNLOADED FROM UNTRUSTED SOURCES
# Documentation: 
# Apple’s Platform Security https://support.apple.com/guide/security/welcome/web
# Safely open apps on your Mac https://support.apple.com/102445
# The com.apple.quarantine Extended Attribute and Its Role in the Gatekeeper Mechanism https://unit42.paloaltonetworks.com/gatekeeper-bypass-macos/
# Using the latest code signature format https://developer.apple.com/documentation/xcode/using-the-latest-code-signature-format
# adhoc https://developer.apple.com/documentation/security/seccodesignatureflags/adhoc
# Code Signing Tasks https://developer.apple.com/library/archive/documentation/Security/Conceptual/CodeSigningGuide/Procedures/Procedures.html

set theApp to choose file with prompt "Please select an application:" of type {"app"}
set appPath to POSIX path of theApp
try
	set QuAtt to "Quarantine attribute:" & return & (do shell script "xattr -pl com.apple.quarantine " & quoted form of appPath)
on error
	set QuAtt to "Quarantine attribute not present"
end try
try
	set SignStat to "Signing status:" & return & (do shell script "codesign -dv " & quoted form of appPath & " 2>&1")
on error
	set SignStat to "Signing status:" & return & "the application is not signed at all"
end try
display dialog QuAtt & return & SignStat & return & "Would you like to" buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue"
set theQuestion to display dialog "Would you like to" buttons {"Remove the quarantine attribute", "Sign with an ad-hoc signature", "Remove the quarantine attribute & Sign with an ad-hoc signature"} default button "Sign with an ad-hoc signature"
set theAnswer to button returned of theQuestion
if theAnswer is equal to "Remove the quarantine attribute" then
	do shell script "xattr -rd com.apple.quarantine " & quoted form of appPath
end if
if theAnswer is equal to "Sign with an ad-hoc signature" then
	do shell script "codesign --remove-signature " & quoted form of appPath & "; codesign --force --deep --sign - " & quoted form of appPath
end if
if theAnswer is equal to "Remove the quarantine attribute & Sign with an ad-hoc signature" then
	do shell script "xattr -rd com.apple.quarantine " & quoted form of appPath
	do shell script "codesign --remove-signature " & quoted form of appPath & "; codesign --force --deep --sign - " & quoted form of appPath
end if
set theQuestion2 to display dialog "Operation completed." & return & "Would you like to open the app?" buttons {"Yes", "No"} default button "Yes" cancel button "No"
set theAnswer2 to button returned of theQuestion2
if theAnswer2 is equal to "Yes" then
	do shell script "open -a " & quoted form of appPath
end if
