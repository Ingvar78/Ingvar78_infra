#!/bin/bash

if [ "$1" = "-d" ]; then
    cd ../terraform/stage > /dev/null
    terraform destroy && terraform apply -auto-approve=false
    cd - > /dev/null
else
  echo "Usage: $0 -d"
fi
