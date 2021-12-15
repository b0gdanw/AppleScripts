set theOSNames to {"OS X Yosemite 10.10", "OS X El Capitan 10.11", "macOS Sierra 10.12", "macOS High Sierra 10.13", "macOS Mojave 10.14", "macOS Catalina 10.15", "macOS Big Sur 11", "macOS Monterey 12"}
set the selectedOS to choose from list the theOSNames with prompt "Please select a version:" default items {"macOS Mojave 10.14"}
if selectedOS = {"OS X Yosemite 10.10"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id915041082"
	end tell
end if
if selectedOS = {"OS X El Capitan 10.11"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1147835434"
	end tell
end if
if selectedOS = {"macOS Sierra 10.12"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1127487414"
	end tell
end if
if selectedOS = {"macOS High Sierra 10.13"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1246284741"
	end tell
end if
if selectedOS = {"macOS Mojave 10.14"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1398502828"
	end tell
end if
if selectedOS = {"macOS Catalina 10.15"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1466841314"
	end tell
end if
if selectedOS = {"macOS Big Sur 11"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1526878132"
	end tell
end if
if selectedOS = {"macOS Monterey 12"} then
	tell application "App Store"
		activate
		open location "itms-apps://apple.com/app/id1576738294"
	end tell
end if
