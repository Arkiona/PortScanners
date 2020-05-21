#!/bin/bash



function pingCheck
{
wordlist="$1"
startport="$2"
stopport="$3"


input="$wordlist"

while IFS= read -r line
do
 ping=`ping -W 1 -c 1 $line | grep bytes | wc -l` 		#backticks as command substitution. wc -l  returns numeric value.
if [ "$ping" -gt 1 ]; then								#if value of ping is greater than 1 it's up.
	echo "$line is up"

for ((counter=$startport; counter <= $stopport; counter++))     # Set counter to the value of startport. If counter is less than or equal to add 1 each time.
	do
	(echo >/dev/tcp/$line/$counter) > /dev/null 2>&1 && echo "$counter open"   #use the bash /dev/tp and add host and port counter
done;
else
	echo "$line down"
fi 

done < "$input"

}


pingCheck $1 $2 $3
