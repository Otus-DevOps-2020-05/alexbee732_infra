#!/bin/bash
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk name=disk1,size=10,image-id=fd80h8459h9o24m97m9k \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=reddit_instance_config.yaml
