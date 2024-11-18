#!/usr/bin/bash

echo "" && echo "==> Initialize Go Modules"
go mod init

# Read through needed_packages.txt and install the indicated packages
FILE="files/install_packages.txt"

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
  echo "File $FILE not found!"
  exit 1
fi


echo "" && echo "==> Install the mysql Package"
go get -u github.com/go-sql-driver/mysql

