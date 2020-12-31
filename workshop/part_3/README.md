Part 3
===================

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

What should happen when clicking on "Terminate server" ?
