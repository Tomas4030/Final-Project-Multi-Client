#!/bin/bash

IP=$(minikube ip)

for domain in "$@"; do
  echo "$IP $domain" | sudo tee -a /etc/hosts
done
