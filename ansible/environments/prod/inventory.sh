#!/bin/bash

if [ "$1" = "--list" ]; then
    cd ../terraform/prod > /dev/null
    terraform output inventory
    cd - > /dev/null
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