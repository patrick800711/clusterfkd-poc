kind create cluster --config cluster.yaml
kubectl create namespace ingress
kubectl create namespace echoserver
base64 -d -i cluster-config.yaml | kubectl apply -f -