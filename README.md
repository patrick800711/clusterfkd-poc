# Failures in Kubernetes Drills || klusterfkd

## PoC

Although `echoserver` is running in the cluster and configured to serve traffic on port 80 when attempting to browse http://localhost/echoserver a 504 timeout error is returned.  In this `Failure in Kuberenetes Drill` you need to resolve the issue. 

To get going run `start.sh` to create and configure the cluster.

When you are done use `kind delete cluster --name klusterfkd` to delete the KinD cluster from your system.

### Pre-Requisettes

* Docker (licensed)
* KinD
* Helm
* jq
