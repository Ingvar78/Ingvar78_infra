#!/bin/bash

if [ "$1" = "--list" ]; then
    APP_IP=$(yc compute instance list | grep reddit-app | awk '{print $4,$10}'| awk '{print $2}')
    DB_IP=$(yc compute instance list | grep reddit-db | awk '{print $4,$10}'| awk '{print $2}')
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
