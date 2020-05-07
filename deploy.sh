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
