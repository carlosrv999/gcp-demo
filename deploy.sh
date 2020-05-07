#!/bin/bash

set -e

terraform apply

rm /etc/ansible/hosts
public_ip=$(terraform output public_ip)
echo $public_ip ansible_user=linux > /etc/ansible/hosts
ssh-keyscan -H $public_ip >> ~/.ssh/known_hosts

ansible-playbook install-docker.yaml
ansible-playbook install-java.yaml
ansible-playbook install-plugins.yaml

echo $(cat credentials.json) | sed -E 's/([^\]|^)"/\1\\"/g' > credentials.json.escaped

jsonstring=$(cat credentials.json.escaped)

curl -X POST 'http://'$public_ip':8080/credentials/store/system/domain/_/createCredentials' --data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "gcr-credentials",
    "username": "_json_key",
    "password": "'$jsonstring'"
  }
}'

rm credentials.json.escaped
