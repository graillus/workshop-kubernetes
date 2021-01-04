Part 0
===================

### Install kubectl

Follow instructions here: https://kubernetes.io/docs/tasks/tools/install-kubectl/

Example For Linux/amd64:
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

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

### Install Kubernetes dashboard

Install the dashboard using the resources definitions
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml
```

Check everything is running
```bash
kubectl get pods -n kubernetes-dashboard
```

Now, we need to be able to communicate with the dashboard with HTTP. Fortunately, there is a command for that:
```bash
kubectl proxy
```

Go to http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

The dashboard requires authentication. We need to create a kubernetes user and use its credentials.

Let's use the resources in dashboard.yaml:
```bash
kubectl apply -f dashboard.yaml
```

Now, a new user (or service account) named `admin-user` has been created, and Kubernetes has put his credentials in a new `Secret` resource.
```bash
kubectl get secret -n kubernetes-dashboard | grep admin-user
``` 

We can read the secret to retrieve the token :
```bash
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
```

Then, copy data in the `token:` section, and paste it into the Kubernetes dashboard login form.

You're done !
