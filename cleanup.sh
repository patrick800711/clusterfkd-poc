#!/bin/zsh
kind delete cluster --name klusterfkd
rm ~/.kube/contexts/kind-kubeconfig-dw7fhna.yaml
source ~/.zshrc