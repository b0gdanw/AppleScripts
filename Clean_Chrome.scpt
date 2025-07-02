--Deletes all folders and subfolders from ~/Library/Application Support/Google/Chrome/, except Default.
do shell script "find ~/Library/Application\\ Support/Google/Chrome/* ! -name 'Default' -type d -exec rm -rf {} +"
--Deletes all files from ~/Library/Application Support/Google/Chrome/, except Local State, First Run, Last Version, Bookmarks, Preferences and Secure Preferences.
do shell script "find ~/Library/Application\\ Support/Google/Chrome/ ! -name 'First Run' ! -name 'Last Version' ! -name 'Local State' ! -name 'Bookmarks' ! -name 'Preferences' ! -name 'Secure Preferences' -type f -exec rm -f {} + "
--Deletes ~/Library/Caches/Google/Chrome
do shell script "rm -rf ~/Library/Caches/Google/Chrome"
--Deletes ~/Library/Saved Application State/com.google.Chrome.savedState
do shell script "rm -rf ~/Library/Saved\\ Application\\ State/com.google.Chrome.savedState"
