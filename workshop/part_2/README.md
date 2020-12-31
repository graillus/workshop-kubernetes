Part 2
===================

### Deployments

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

What happen when running `kubectl delete pod` against the pods that just get created ?
