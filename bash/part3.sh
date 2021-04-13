#!/bin/bash
read -p 'Please enter the filename: ' filenamevariable
read -p 'Please enter the string: ' stringvariable
read -p 'Please enter the line number: ' linenumber

line=$linenumber
linecount=$(cat $filenamevariable | wc -l)

sepehr_function () {
while [ $line -le $linecount ] ;do 
    sed -i "$[$line]i"$stringvariable $filenamevariable
    #sed -e ""$linenumber"s/^/$stringvariable/g" $filenamevariable
    line=$[$line+$linenumber]
    linecount=$[$linecount+1]
done
}

sepehr_function

echo Here is the modified file with the word $stringvariable added every $linenumber lines:
cat $filenamevariable



