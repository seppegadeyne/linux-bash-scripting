#!/bin/bash

rm wijkschool* nieuwsbericht.txt
wget "https://www.maria-middelares.be/nieuws/wijkschool"
sed -i 's/<div class=\"itemcontent\">/#START#/g; s/<a class=\"btnback\" href=\"\/start\"><span>« terug naar nieuwsoverzicht<\/span><\/a>/#END#/g; s/<[^>]*>//g; s/&nbsp;/ /g; s/^[[:space:]]*//g; /\^I/d; /^$/d;' "wijkschool"
sed -ni '/#START#/,/#END#/p' "wijkschool"
sed -ni '3,$p' "wijkschool"
sed -ni '/#END#/!p' "wijkschool"
sed -i 's/$/\n/g' "wijkschool"
echo -e "Hi #NAME#,\n\n$(cat wijkschool)\n\n### Mogelijk gemaakt door Seppe Gadeyne - Freelance Web Developer - https://www.linkedin.com/in/seppegadeyne/ ###" > nieuwsbericht.txt
sed 's/#NAME#/Seppe/g' nieuwsbericht.txt | mail -s "Nieuwsbericht van de wijkschool" seppe@fushia.be

# start_line=`grep -En "^Wijkschool" "wijkschool" | cut -d : -f 1 | cut -d " " -f 2`
# sed -ni "${start_line},$p" wijkschool
# tail -n +$(($start_line + 1)) "wijkschool" | head -n -11 > nieuwsbericht.txt

