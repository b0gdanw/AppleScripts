set DNSinUse to do shell script "networksetup -getdnsservers Ethernet"
set question to display dialog "The current DNS server(s):" & return & DNSinUse buttons {"Set DNS", "DHCP", "Cancel"}
set answer to button returned of question
if answer is equal to "DHCP" then
	do shell script "networksetup -setdnsservers Ethernet Empty"
	do shell script "dscacheutil -flushcache"
end if
if answer is equal to "Set DNS" then
	set question to display dialog "Please select" buttons {"Google DNS", "OpenDNS", "Cloudflare"}
	set answer to button returned of question
	if answer is equal to "Google DNS" then
		do shell script "networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4"
		do shell script "dscacheutil -flushcache"
	end if
	if answer is equal to "OpenDNS" then
		do shell script "networksetup -setdnsservers Ethernet 208.67.222.222 208.67.220.220"
		do shell script "dscacheutil -flushcache"
	end if
	if answer is equal to "Cloudflare" then
		do shell script "networksetup -setdnsservers Ethernet 1.1.1.1 1.0.0.1"
		do shell script "dscacheutil -flushcache"
	end if
end if
set newDNS to do shell script "networksetup -getdnsservers Ethernet"
display dialog "The new DNS server(s):" & return & newDNS buttons {"OK"}
