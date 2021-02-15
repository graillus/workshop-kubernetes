Part 1: Pods
============

### Running example application

Check your current context (should be `kind-workshop`)
```bash
kubectl config current-context
```

Create a pod running the app
```bash
kubectl run my-app --image=graillus/workshop-kubernetes:app-v1 --port=3000
```

or you can use the declarative way
```bash
kubectl apply -f pod.yaml
```

Watch created pod
```bash
kubectl get pods --watch
```

Create a port-forward to access the app
```bash
kubectl port-forward pods/my-app 8080:3000
```

You can now access the app at : http://localhost:8080

### Simulate a crash of the application

What happens when you click on the `Terminate Server` button ?

### Updating the app version

Edit the file `pod.yaml` and update the docker image tag to `app-v2`
Save the file and run:
```bash
kubectl apply -f pod.yaml
```

If you are fast enough, you can keep hitting F5 on your browser to track the changes.

What happens ?

### Deleting the pod

What happen when running `kubectl delete pod` against the pods that just get created ?
