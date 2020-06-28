#!/bin/bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=b1gekrrielbmteicvonh,image-family=reddit-full,size=10GB \
  --network-interface subnet-name=infra-net-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1

yc compute instance list
