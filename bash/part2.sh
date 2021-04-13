#!/bin/bash
read -p 'Please enter the filename: ' filenamevariable
read -p 'Enter the regex: ' regexvariable
read -p 'Enter the replacement string: ' replacevariable

sed -e "s/$regexvariable/$replacevariable/g" $filenamevariable