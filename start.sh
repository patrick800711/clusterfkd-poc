#!/bin/zsh
ingressReady=false

# Deploy and bootstrap cluster with calico
kind create cluster --config cluster-build.yaml
echo "Bootstrapping cluster ..."
kubectl taint nodes klusterfkd-control-plane node-role.kubernetes.io/control-plane- >/dev/null
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml >/dev/null
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml >/dev/null

# Install services
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml >/dev/null
helm repo add ealenn https://ealenn.github.io/charts >/dev/null
helm repo update >/dev/null
helm upgrade -i fkd ealenn/echo-server --namespace echoserver --create-namespace --force >/dev/null
helm install fkd oci://registry-1.docker.io/bitnamicharts/nginx --namespace nginx --create-namespace >/dev/null
if [ $? -eq 0 ]; then # retry nginx install if fails
  sleep 30
else
  helm install fkd oci://registry-1.docker.io/bitnamicharts/nginx --namespace nginx --create-namespace >/dev/null
  sleep 30
fi
kubectl -n nginx delete svc fkd-nginx >/dev/null #delete default LoadBalancer service created by Nginx install
echo -n "Waiting for pods to go ready (this may take a few minutes) ..."
while [ $ingressReady = "false" ]; do
  sleep 10
  ingressReady=$(kubectl -n ingress-nginx get pods -ojson | jq -r '.items[] | select(.metadata.name | test("ingress-nginx-controller.")) | .status.containerStatuses[].ready')
  echo -n "."
done

# Apply manifest and finalise environment
echo "\033[0;31m\nApplying scenario ..."
tput init
base64 -d -i cluster-config.yaml | kubectl apply -f -
echo "\033[0;32m\nAlthough echoserver is running in the cluster and configured to serve traffic on port 80 when attempting to browse http://localhost/echoserver a 504 timeout error is returned. In this Failure in Kuberenetes Drill resolve the issue so echoserver traffic is served correctly.  Enjoy! \n"