Part 3
===================

### configMap and secret

Create configMap and secret
```bash
kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml
```

Update deployment `my-other-app`
```bash
kubectl diff -f deployment-bis.yaml
kubectl apply -f deployment-bis.yaml
```

Try to access http://localhost/my-other-app/

Then try to edit `secret.yaml` and `configmap.yaml` as you want
