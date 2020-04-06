#!/bin/bash

cat ${CONFIGMAP_NAT} >> /tmp/hosts
echo -e "\n" >> /tmp/hosts
for dom in $(cat /etc/resolv.conf |egrep  "search[^a-z0-9]+"|grep -v "^#"|sed "s/search //");
do
        echo "127.0.0.1 $HOSTNAME.$dom $HOSTNAME" >> /tmp/hosts
done
