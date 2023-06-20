# Failure in Kubernetes Drills || klusterfkd

- klusterfkd: PoC
- difficulty: easy

## Pre-Requisettes

* zsh
* Docker
* KinD
* Helm
* jq

## PoC

Although `echoserver` is running in the cluster and configured to serve traffic on port 80 when attempting to browse http://localhost/echoserver a `504 Gateway Time-out` error is returned.  In this `Failure in Kuberenetes Drill` identify and resolve the issue so echoserver traffic is served correctly.

## Getting Started

To get going run `start.sh` to create and configure the cluster.

## Cleanup

When you are done use `./cleanup.sh` to delete the KinD cluster from your system.

## Known issues

* Rate limiting from Docker hub is causing problems with Calico pods being able to pull images and thus the lab environment won't complete
* Fred's Macbook
