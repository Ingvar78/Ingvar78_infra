#!/bin/bash

for i in prod stage
do
    read -p "Press [Enter] key to start validate ${RED} $i ${NC}..."
    cd terraform/$i > /dev/null
    terraform init -backend=false
    terraform validate
    tflint
    cd - > /dev/null
    echo "End validate $i"
    echo "_______________________________________________________________________________"
done