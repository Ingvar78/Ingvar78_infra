#!/bin/bash

#cd packer > /dev/null
for i in packer/*.json
do
    echo "Begin packer validate: $i "
    if [[ $i != *"variable"*".json" ]]
	then
		packer validate -var-file=packer/variables.json.example $i
    else 
	echo " === skip this file: $i"
    fi
    echo "_______End_validate____________"
done
#cd - > /dev/null
