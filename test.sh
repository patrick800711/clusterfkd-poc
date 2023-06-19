#!/bin/zsh
helm install fkd oci://registry-1.docker.io/bitnamicharts/nginx --namespace nginx --create-namespace
if [ $? -eq 0 ]; then
  echo "done"
else
  echo "Trying again..."
  helm install fkd oci://registry-1.docker.io/bitnamicharts/nginx --namespace nginx --create-namespace
fi
