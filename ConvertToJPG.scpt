set question to display dialog "Select" buttons {"Folder", "Files", "Cancel"}
set answer to button returned of question
if answer is equal to "Folder" then
	set theSourceFolder to choose folder with prompt "Please select the folder containing image files"
	set question to display dialog "Please select the quality " buttons {"low", "normal", "high"}
	set theQuality to button returned of question
	tell application "Finder"
		set theFiles to (get every file of theSourceFolder whose name extension is in {"HEIC", "HEIF", "PNG", "BMP", "JPEG", "jp2", "TIFF", "PSD"})
		repeat with currentFile in theFiles
			set extension hidden of currentFile to true
			set theName to displayed name of currentFile
			set theOutputFolder to POSIX path of ((container of currentFile) as text)
			set theImage to quoted form of POSIX path of (currentFile as string)
			do shell script "sips" & " -s format jpeg -s formatOptions " & theQuality & " " & theImage & " -o " & theOutputFolder & theQuality & "-" & quoted form of theName & ".jpg"
			set extension hidden of currentFile to false
		end repeat
	end tell
	set ConvertedFiles to do shell script "ls " & (POSIX path of theOutputFolder) & " | grep " & theQuality & " | grep 'jpg' "
end if
if answer is equal to "Files" then
	set theImages to choose file with prompt "Please select the image files:" of type {"public.image"} with multiple selections allowed
	set question to display dialog "Please select the quality " buttons {"low", "normal", "high"}
	set theQuality to button returned of question
	tell application "Finder"
		repeat with currentFile in theImages
			set extension hidden of currentFile to true
			set theName to displayed name of currentFile
			set theOutputFolder to POSIX path of ((container of currentFile) as text)
			set theImage to quoted form of POSIX path of (currentFile as string)
			do shell script "sips" & " -s format jpeg -s formatOptions " & theQuality & " " & theImage & " -o " & theOutputFolder & theQuality & "-" & quoted form of theName & ".jpg"
			set extension hidden of currentFile to false
		end repeat
	end tell
	set ConvertedFiles to do shell script "ls " & (POSIX path of theOutputFolder) & " | grep " & theQuality & " | grep 'jpg' "
end if
display dialog "The file(s):" & return & return & ConvertedFiles & return & return & "saved in: " & POSIX path of theOutputFolder buttons {"Close"} default button 1
