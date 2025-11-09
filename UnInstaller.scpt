-- The script reads the BundleIdentifier of the selected app and lists the files/folders in Home (~/) that contain it, with an option to delete them. 

set theApp to choose file with prompt "Please select an application from ~/Applications :" of type {"app"}
set appPath to (POSIX path of theApp)
set infoPath to (POSIX path of theApp & "/Contents/Info.plist") as text
set theID to do shell script "/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' " & quoted form of infoPath
--set theList to (do shell script "find ~/ -iname '*" & theID & "*'")

-- alternative command that excludes ~/.Trash from search
set theList to (do shell script "find ~/ -iname '*" & theID & "*' | grep -Evw '(.Trash)'")

display dialog ("The following were found:
" & theList) buttons {"Delete items", "Cancel"} default button 1
if button returned of result = "Cancel" then
	return
else
	set thePrgs to paragraphs of theList
	set FilesFolders to {}
	repeat with i from 1 to count of thePrgs
		set end of FilesFolders to POSIX file (item i of thePrgs)
	end repeat
	set question to display dialog "Do you want to delete" buttons {"All", "One by one", "Cancel"} default button 1
	set answer to button returned of question
	if answer is equal to "All" then
		tell application "Finder"
			repeat with currentItem in FilesFolders
				try
					tell application "Finder"
						delete currentItem
					end tell
				on error
					display dialog (currentItem as text) & ("Item could not be deleted") buttons {"OK"}
				end try
			end repeat
		end tell
	end if
	
	if answer is equal to "One by one" then
		tell application "Finder"
			repeat with currentItem in FilesFolders
				set question to display dialog "Do you want to delete" & (POSIX path of currentItem) buttons {"Yes", "No", "Cancel"} default button 1
				set answer to button returned of question
				if answer is equal to "Yes" then
					try
						tell application "Finder"
							delete currentItem
						end tell
					on error
						display dialog ("Item could not be deleted") buttons {"OK"}
					end try
				end if
				if answer is equal to "Cancel" then
					return
				end if
			end repeat
		end tell
	end if
	
	if answer is equal to "Cancel" then
		return
	end if
end if

activate
set question to display dialog "Delete the app " & appPath buttons {"Yes", "No"} default button 1
set answer to button returned of question
if answer is equal to "Yes" then
	try
		tell application "Finder"
			delete theApp
		end tell
	on error
		display dialog ("App could not be deleted") buttons {"OK"}
	end try
end if
if answer is equal to "No" then
	return
end if
