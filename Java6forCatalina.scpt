--Download Java for OS X 2017-001 from https://support.apple.com/kb/DL1572
set theDMG to choose file with prompt "Please select javaforosx.dmg:" of type {"dmg"}
do shell script "hdiutil mount " & quoted form of POSIX path of theDMG & " -noverify -nobrowse"
do shell script "pkgutil --expand /Volumes/Java\\ for\\ macOS\\ 2017-001/JavaForOSX.pkg ~/tmp"
do shell script "hdiutil unmount /Volumes/Java\\ for\\ macOS\\ 2017-001/"
do shell script "sed -i '' 's/return false/return true/g' ~/tmp/Distribution"
do shell script "pkgutil --flatten ~/tmp ~/Desktop/Java.pkg"
do shell script "rm -rf ~/tmp"
display dialog "Modified Java.pkg saved on desktop" buttons {"Ok"}
