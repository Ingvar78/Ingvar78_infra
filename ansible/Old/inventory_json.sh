#!/bin/bash

if [ "$1" = "--list" ]; then
    cd ../terraform/stage > /dev/null
    APP_IP=$( terraform show | grep external_ip_address_app | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' |awk '{print $3}' | tr -d \")
    DB_IP=$( terraform show | grep external_ip_address_db | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' |awk '{print $3}' | tr -d \")

#    APP_IP=$(terraform output external_ip_address_app)
#    DB_IP=$(terraform output external_ip_address_db)
    cd - > /dev/null
    cat << _EOF_
{
  "all": {
    "children": {
      "app": {
        "hosts": {
          "appserver": {
            "ansible_host": "${APP_IP}"
          }
        }
      },
      "db": {
        "hosts": {
          "dbserver": {
            "ansible_host": "${APP_IP}"
          }
        }
      }
    }
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