# Failures in Kubernetes Drills || klusterfkd

## PoC

Although `echoserver` is running in the cluster and configured to serve traffic on port 80, however when attempting to load echoserver through http://localhost/echoserver:80 the browser returns a 4xx error code.  In this Failure in Kuberenetes Drill you need to resolve the issue. 

### Resources
- https://kind.sigs.k8s.io/docs/user/configuration/
- 

### .plan
+ install & configure calico
+ install & configure nginx
- install echoserver
- apply ingress
- apply network policy in ingress ns
- apply network policy in echoserver ns