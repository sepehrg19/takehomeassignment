#!/bin/bash
read -p 'Please enter a hostname: ' hostnamevariable
read -p 'Enter starting port: ' startport
read -p 'Enter ending port: ' endport

netcat -v $hostnamevariable "${startport}-${endport}"