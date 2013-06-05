#!/bin/bash
###################################################
# Web change notifier - Author @ejoncas           #
###################################################
# 
# This script check for changes in webpages
# and shows a desktop notification when
# changes were detected. 
#
# Urls to check must be listed in file urls.txt
# located in the same directory that this script.
#
# This checker must be installed in a crontab
# with the following expression:
# 
# #Checks every hour 
# 0 0 0/1 1/1 * ? * ROUTE_TO_SCRIPT/check.sh
# 
#
####################################################
DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
URLS=$(cat $DIR/urls.txt)

for url in $URLS; do
	echo "Checking web $url"
	MD5=$(wget -O - $url | tee temp | md5sum)
	echo "Web hash is $MD5"
	FILENAME=$(echo $url | awk -F/ '{print $3}')
	LAST_MD5=$(cat $DIR/$FILENAME.txt)
	echo "Last known hash is $LAST_MD5"

	if [ "$MD5" != "$LAST_MD5" ]; then
		echo "Hash differ, something has changed in the web page! Updating hashes..."
		notify-send -u critical "$FILENAME" "Cambios en la pagina $url, visitar!"
		echo "$MD5" > $DIR/$FILENAME.txt
	else
		echo "Hash is equal to last known. No changes in web page!"
	fi
	rm temp
done

