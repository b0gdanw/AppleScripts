set question to display dialog "Select" buttons {"Unpack", "Repack", "Cancel"}
set answer to button returned of question
if answer is equal to "Unpack" then
	tell application "Finder"
		set theFile to choose file with prompt "Please select the pgk file:" of type {"pkg"}
		set extension hidden of theFile to true
		set theName to displayed name of theFile
		set theOutputFolder to quoted form of (POSIX path of ((container of theFile) as text) & "/" & theName & "_unpacked")
		set extension hidden of theFile to false
	end tell
	do shell script "pkgutil --expand " & quoted form of POSIX path of theFile & " " & theOutputFolder
end if
if answer is equal to "Repack" then
	tell application "Finder"
		set theSource to choose folder with prompt "Please select the folder to be packed"
		set theName to displayed name of theSource
		set theOutputFolder to quoted form of (POSIX path of (container of theSource as text))
		set theSourceFolder to quoted form of ((POSIX path of theSource) as text)
		set pkgName to characters 1 thru ((offset of "_" in theName) - 1) of theName as string
	end tell
	do shell script "pkgutil --flatten " & theSourceFolder & " " & theOutputFolder & "/" & pkgName & "_repacked.pkg"
end if
