set theList to (do shell script "find /Applications -maxdepth 5 -type d -name '*.appex' | grep -Evw '(Books|Calendar|FaceTime|Home|iTunes|Mail|Messages|Notes|Photos|Reminders|Safari|VoiceMemos|Xcode).app' ")
display dialog ("The following .appex files were found:
" & theList) buttons {"Select appex files", "Cancel"}
if button returned of result = "Cancel" then
	return
else
	set thePrgs to paragraphs of theList
	set appexFiles to {}
	repeat with i from 1 to count of thePrgs
		set end of appexFiles to POSIX file (item i of thePrgs)
	end repeat
	tell application "Finder"
		repeat with currentFile in appexFiles
			set question to display dialog "Do you want to delete" & (POSIX path of currentFile) buttons {"Yes", "No", "Cancel"} default button 2
			set answer to button returned of question
			if answer is equal to "Yes" then
				try
					tell application "Finder"
						delete currentFile
					end tell
				on error
					display dialog ("File could not be deleted") buttons {"OK"}
				end try
			end if
			if answer is equal to "Cancel" then
				return
			end if
		end repeat
	end tell
end if
