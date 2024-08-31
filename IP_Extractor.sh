#!/bin/bash

echo ===================================
echo Example of Domain Name : google.com
echo ===================================

# the below function is for asking to continue resolving or exit
further_continue () {
	read -p 'Try More? (y/n): ' further
	if [[ $further == 'y' ]]; then
		$0
	elif [[ $further == 'n' ]]; then
		echo ===================================
		echo Okk Bye!
		echo ===================================
	else
		echo ===================================
		echo I Think NO! Byee!
		echo ===================================
	fi
}
over_again () {
# for taking domain name as input from user

	read -p 'DOMAIN NAME: ' domain_name
	echo ===================================

# verifying if user entered anything

	if [[ $domain_name == '' ]]; then
		echo Do not Leave it Empty!
		echo ===================================
		over_again
	else
# looking for ip using nslookup and storing result in a txt file
		nslookup $domain_name -query=hinfo | grep -w "Address" | grep -e "#" -v > /tmp/result.txt
# taking text file content as variable value
		value=$(</tmp/result.txt)
# checking whether resolving succeds or not
		if [[ $value == '' ]]; then
			echo Not Valid! or Server Down!
			echo ===================================
			rm /tmp/result.txt
			over_again
		else
			cat /tmp/result.txt
			rm /tmp/result.txt
			echo ===================================
# asking for further use or leave
			further_continue
		fi
	fi
}
over_again
