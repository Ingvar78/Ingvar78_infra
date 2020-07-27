#!/bin/bash

echo "Ansible Lint validate"
cd ansible/playbooks > /dev/null
ansible-lint
cd - > /dev/null
