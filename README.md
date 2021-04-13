# SRE/DevOps Take Home Test

## Introduction

Here is the readme file for the take home assignment. In this readme I will be going through the questions and my code and providing explanations, assumptions, and instructions, as well as hurdles that I had. 

I have also included comments in my python and terraform scripts to describe what I am doing in my code.

I did have to install Windows Subsystem for Linux 1 and 2 to be able to do a few of these questions.

### Bash

Part 1: Takes input for hostname, start port, and end port, then uses the netcat command to check the port range. A hurdle I had here was that I was using my work laptop to do this assignment, and I was connected to VPN, so I was having name resolution issues.

Part 2: Takes input for filename in the current directory, the regex, and the replacement string, then use the sed command (stream editor, used to do things like search, replace, insert, and delete), to replace the regex with the replacement string.

Part 3: Takes input for filename, a string, and the line number to insert the string at. Then we go through and count the number of lines within the file. I then created a function with a while loop in it that checks while the line number is less than the line count, use the sed command to insert the string at the desired line number. Then we increase the number of lines and line count due to the insertion, and we keep doing this until we reach end of file. Then I call the function and show the file with the modified. contents

### Python

For this, I installed python on VS Code and ran my script via a python terminal within VS Code.

I was able to grab the author of the repo as well as the person with the most commits. However, I had trouble with counting "the number of commits which occurred during the period from July 1, 2018 – Aug. 30, 2018 and print the total". 

In my code, I changed the dates from 2018 to 2020, and I was able to see results for changes that happened during that time period, however, for 2018, I was unable to pull up any commits. I then realized that my code was only going through 1 page of commits, and there were many pages, and unfortunately, I was unable to figure out how to go through all the pages of commits and count them. My code was only able to display commits

![image](https://user-images.githubusercontent.com/81540260/114555146-45437c00-9c1c-11eb-90ce-772ee52a1d08.png)



