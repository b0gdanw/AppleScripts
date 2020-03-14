--https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/ManipulateImages.html
--https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html

set theSourceFolder to choose folder with prompt "Please select the folder containing HEIC/HEIF files"
set theOutputFolder to choose folder with prompt "Please select an output folder"
--Source and Output can be the same folder
tell application "Finder"
	set theFiles to the files of theSourceFolder
	repeat with currentFile in theFiles
		if name extension of currentFile is in {"HEIC", "HEIF"} then
			--setting extension to hiddden in order to get only the file name
			set extension hidden of currentFile to true
			set theName to displayed name of currentFile
			--the extension can be displayed again
			--set extension hidden of currentFile to false
			tell application "Image Events"
				launch
				set theImage to open currentFile as string
				save theImage as JPEG in (theOutputFolder & theName & ".jpg" as string)
				close theImage
			end tell
			--the original file can be moved to Trash
			--delete currentFile
		end if
	end repeat
end tell
--This is just a visual confirmation, it can be deleted
set ConvertedFiles to do shell script "ls " & (POSIX path of theOutputFolder) & " | grep 'jpg' "
display dialog "The file(s):" & return & return & ConvertedFiles & return & return & "saved in: " & POSIX path of theOutputFolder buttons {"Close"} default button 1
