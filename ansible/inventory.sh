#!/bin/bash

if [ "$1" = "--list" ]; then
    cd ../terraform/stage > /dev/null
    APP_IP=$(terraform output external_ip_address_app)
    DB_IP=$(terraform output external_ip_address_db)
    cd - > /dev/null
    cat << _EOF_
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "${APP_IP}"
                },
                "dbserver": {
                    "ansible_host": "${DB_IP}"
                }
            }
        },
        "app": {
            "hosts": [
                "appserver"
            ]
        },
        "db": {
            "hosts": [
                "dbserver"
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
