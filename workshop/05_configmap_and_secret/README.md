Part 5: ConfigMap and Secrets
=============================

### ConfigMap and Secret

Create the ConfigMap and Secret resources
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
