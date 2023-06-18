# Failures in Kubernetes Drills || klusterfkd

## PoC

Although `echoserver` is running in the cluster and configured to serve traffic on port 80, however when attempting to load echoserver through http://localhost/echoserver:80 the browser returns a 504 error.  In this `Failure in Kuberenetes Drill` you need to resolve the issue. 

### Pre-Requisettes

* Docker (licensed)
* KinD
* Helm
* jq

### Resources
- https://kind.sigs.k8s.io/docs/user/configuration/
- https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind
- https://medium.com/cloud-heroes/testing-calico-locally-using-kubernetes-in-docker-kind-52981ce20703
