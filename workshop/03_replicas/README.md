Part 3: Deployments with multiple replicas
==========================================

### Replicas

Update deployment `my-app` by running
```bash
kubectl diff -f deployment.yaml
kubectl apply -f deployment.yaml
```

or you can edit the deployment
```bash
kubectl edit deployment my-app
```

Watch updated deployment
```bash
kubectl get deployment --watch
```

Get pods
```bash
kubectl get pods
```

### Simulate a crash of the application

What happens when you click on the `Terminate Server` button ?
