--NConvert is provided as FREEWARE (NO Adware, NO Spyware) for private or educational use (including non-profit organizations). https://www.xnview.com/en/nconvert/
--NConvert for macOS http://download.xnview.com/NConvert-macosx64.tgz

set theSourceFolder to choose folder with prompt "Please select the folder containing HEIC/HEIF files"
tell application "Finder"
	set theFiles to the files of theSourceFolder
	repeat with currentFile in theFiles
		if name extension of currentFile is in {"HEIC", "HEIF"} then
			set theImage to quoted form of POSIX path of (currentFile as string)
			do shell script "/Applications/NConvert/nconvert -rmeta -out jpeg " & theImage
		end if
	end repeat
end tell
