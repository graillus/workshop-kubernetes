Kubernetes Workshop
===================

### Prerequisites

- [docker](https://docs.docker.com/engine/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Install local Kubernetes cluster

We will install `kind` (Kubernetes IN Docker)
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-$(uname)-amd64
chmod +x kind
sudo mv kind /usr/local/bin
```
Create a local cluster
```bash
kind create cluster --name workshop --config cluster.yaml
```

### Running example application

Create a pod running the app
```bash
kubectl run my-app --image=graillus/workshop-kubernetes:app-v1 --port=3000
```

Watch created pod
```bash
kubectl get pods --watch
```

Expose pod endpoint to localhost
```bash
kubectl expose pod my-app --port=8080 --target-port=3000 --name=my-app
```


### Ingress Controller

Install nginx ingress controller
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```

Watch created pod
```bash
kubectl get pods --watch --namespace ingress-nginx
```

### Cleanup

```bash
kind delete cluster workshop
```