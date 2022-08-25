-- Description of folders usage from Apple https://support.apple.com/guide/terminal/script-management-with-launchd-apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac
-- Privileged Helper https://developer.apple.com/library/archive/documentation/Security/Conceptual/SecureCodingGuide/Articles/AccessControl.html

set uLA to do shell script "ls -a ~/Library/LaunchAgents | grep -Evw '.|.DS_Store'"
set gLA to do shell script "ls -a /Library/LaunchAgents | grep -Evw '.|.DS_Store'"
set gLD to do shell script "ls -a /Library/LaunchDaemons | grep -Evw '.|.DS_Store'"
set gHT to do shell script "ls -a /Library/PrivilegedHelperTools | grep -Evw '.|.DS_Store'"
display dialog tab & "~/Library/LaunchAgents" & return & "Third-party agents that apply only to the logged-in user:" & return & return & uLA & return & return & tab & "/Library/LaunchAgents" & return & "Third-party agents that apply to all users on a per-user basis:" & return & return & gLA & return & return & tab & "/Library/LaunchDaemons" & return & "Third-party system daemons:" & return & return & gLD & return & return & tab & "/Library/PrivilegedHelperTools" & return & "Privileged Helpers:" & return & return & gHT & return & return buttons {"Close"} default button 1
