Part 1
===================

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

What happen when running `kubectl delete pod` against the pods that just get created ?
