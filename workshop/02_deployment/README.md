Part 2: Deployments
===================

### Install the app using a Deployment

Create a deployment `my-app`
```bash
kubectl apply -f deployment.yaml
```

Watch created deployment
```bash
kubectl get deployment --watch
```

Get pods
```bash
kubectl get pods
```

Create a port-forward to access the app
```bash
kubectl port-forward deployment/my-app 8080:3000
```

You can now access the app at : http://localhost:8080


### Updating the app version

Edit the file `deployment.yaml` and update the docker image tag to `app-v2`
Save the file and run:
```bash
kubectl apply -f deployment.yaml
```

Now track the changes happening to the cluster:
```bash
kubectl get pods --watch
```

### Simulate a crash of the application

What happens when you click on the `Terminate Server` button ?

### Deleting the pod

What happen when running `kubectl delete pod` against the pods that just get created ?
