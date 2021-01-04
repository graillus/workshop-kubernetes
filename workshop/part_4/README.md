Part 4
===================

### Services

Create service `my-app`
```bash
kubectl apply -f service.yaml
```

You can now access the app at : http://localhost:31080

What happen now when clicking on "Terminate server" ?


### Ingress Controller

Create a second service and deployment `my-other-app`
```bash
kubectl apply -f deployment-and-service-bis.yaml
```

Install nginx ingress controller
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```

Then create an ingress `my-app`
```bash
kubectl apply -f ingress.yaml
```

Try to access http://localhost and http://localhost/my-other-app/
