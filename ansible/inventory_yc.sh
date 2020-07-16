#!/bin/bash

if [ "$1" = "--list" ]; then
    cd ../terraform/stage > /dev/null
    APP_IP=$(yc compute instance get reddit-app --format json | jq '.network_interfaces[].primary_v4_address.one_to_one_nat.address'| tr -d \")
    DB_IP=$(yc compute instance get reddit-db --format json | jq '.network_interfaces[].primary_v4_address.one_to_one_nat.address'| tr -d \")
    cd - > /dev/null
    cat << _EOF_
    {
        "_meta": {
            "hostvars": {
                "appserver_yc": {
                    "ansible_host": "${APP_IP}"
                },
                "dbserver_yc": {
                    "ansible_host": "${DB_IP}"
                }
            }
        },
        "app": {
            "hosts": [
                "appserver_yc"
            ]
        },
        "db": {
            "hosts": [
                "dbserver_yc"
            ]
        }
    }
_EOF_
else
    cat << _EOF_
    {
        "_meta": {
                "hostvars": {}
        },
        "all": {
                "children": [
                        "ungrouped"
                ]
        },
        "ungrouped": {}
    }
_EOF_
fi
