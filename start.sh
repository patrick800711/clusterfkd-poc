#!/bin/zsh
ingressReady=false

# Deploy and bootstrap cluster with calico
kind create cluster --config cluster-build.yaml
kubectl taint nodes klusterfkd-control-plane node-role.kubernetes.io/control-plane-
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml

# Install services
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
helm repo add ealenn https://ealenn.github.io/charts
helm repo update
helm upgrade -i fkd ealenn/echo-server --namespace echoserver --create-namespace --force
echo "Waiting for nginx (this may take a few minutes) ..."
sleep 30
while [ $ingressReady = "false" ]; do
  sleep 10
  ingressReady=$(kubectl -n ingress-nginx get pods -ojson | jq -r '.items[] | select(.metadata.name | test("ingress-nginx-controller.")) | .status.containerStatuses[].ready')
  echo "..nginx ready: ${ingressReady}"
done

# Apply manifest and finalise environment
base64 -d -i cluster-config.yaml | kubectl apply -f -
