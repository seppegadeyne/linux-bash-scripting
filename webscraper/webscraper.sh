#!/bin/bash

rm wijkschool* nieuwsbericht.txt
wget "https://www.maria-middelares.be/nieuws/wijkschool"
sed -i 's/<div class=\"itemcontent\">/#START#/g; s/<a class=\"btnback\" href=\"\/start\"><span>« terug naar nieuwsoverzicht<\/span><\/a>/#END#/g; s/<[^>]*>//g; s/&nbsp;/ /g; s/^[[:space:]]*//g; /\^I/d; /^$/d;' "wijkschool"
sed -ni '/#START#/,/#END#/p' "wijkschool"
sed -ni '3,$p' "wijkschool"
sed -ni '/#END#/!p' "wijkschool"
sed -i 's/$/\n/g' "wijkschool"
echo -e "Hi #NAME#,\n\n$(cat wijkschool)\n\n### Mogelijk gemaakt door Seppe Gadeyne - Freelance Web Developer - https://www.linkedin.com/in/seppegadeyne/ ###" > nieuwsbericht.txt

IFS=$'\n'

for item in `cat list.csv`; do
	name=`echo $item | cut -d : -f 1`
	email=`echo $item | cut -d : -f 2`
	echo "${name} - ${email}"
	sed "s/#NAME#/${name}/g" nieuwsbericht.txt | mail -s "Nieuwsbericht van de wijkschool" "${email}"
	sleep 5
done	
