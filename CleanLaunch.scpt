--This script searches for files in ~/Library/LaunchAgents, /Library/LaunchAgents, /Library/LaunchDaemons & /Library/PrivilegedHelperTools and offers the option to delete them one by one
--Apple: "You can get an idea of the various daemons and agents managed by launchd by looking at the configuration files in the following folders" https://support.apple.com/en-my/guide/terminal/apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac
try
	set uLA to do shell script "ls -a ~/Library/LaunchAgents | grep -Evw '.|.DS_Store'"
on error
	set uLA to "is empty"
end try
try
	set gLA to do shell script "ls -a /Library/LaunchAgents | grep -Evw '.|.DS_Store'"
on error
	set gLA to "is empty"
end try
try
	set gLD to do shell script "ls -a /Library/LaunchDaemons | grep -Evw '.|.DS_Store'"
on error
	set gLD to "is empty"
end try
try
	set gHT to do shell script "ls -a /Library/PrivilegedHelperTools | grep -Evw '.|.DS_Store'"
on error
	set gHT to "is empty"
end try

set question to display dialog tab & "~/Library/LaunchAgents" & return & uLA & return & return & tab & "/Library/LaunchAgents" & return & gLA & return & return & tab & "/Library/LaunchDaemons" & return & gLD & return & return & tab & "/Library/PrivilegedHelperTools" & return & gHT & return & return buttons {"Close", "Delete items"} default button 1
set answer to button returned of question
if answer is equal to "Close" then return


if answer is equal to "Delete items" then
	set launchItems to {}
	if uLA is not "is empty" then
		repeat with f in paragraphs of uLA
			if f is not "" then
				set end of launchItems to (POSIX file (POSIX path of (path to home folder) & "Library/LaunchAgents/" & f))
			end if
		end repeat
	end if
	if gLA is not "is empty" then
		repeat with f in paragraphs of gLA
			if f is not "" then
				set end of launchItems to (POSIX file ("/Library/LaunchAgents/" & f))
			end if
		end repeat
	end if
	if gLD is not "is empty" then
		repeat with f in paragraphs of gLD
			if f is not "" then
				set end of launchItems to (POSIX file ("/Library/LaunchDaemons/" & f))
			end if
		end repeat
	end if
	if gHT is not "is empty" then
		repeat with f in paragraphs of gHT
			if f is not "" then
				set end of launchItems to (POSIX file ("/Library/PrivilegedHelperTools/" & f))
			end if
		end repeat
	end if
	
	tell application "Finder"
		repeat with currentFile in launchItems
			set question to display dialog "Do you want to delete " & (POSIX path of currentFile) buttons {"Yes", "No", "Cancel"} default button 2
			set answer to button returned of question
			if answer is equal to "Yes" then
				try
					delete currentFile
				on error
					display dialog ("File could not be deleted") buttons {"OK"}
				end try
			else if answer is equal to "Cancel" then
				return
			end if
		end repeat
	end tell
end if
