#!/bin/bash

if [ "$1" = "-s" ]; then
    cd ../terraform/stage > /dev/null
    terraform destroy && terraform apply -auto-approve=false
    cd - > /dev/null
else
  if [ "$1" = "-p" ]; then
      cd ../terraform/stage > /dev/null
      terraform destroy && terraform apply -auto-approve=false
      cd - > /dev/null
  else
    echo "Usage: $0 -p to prod or -s to stage"
  fi
fi
