Part 4: Services and Ingress
============================

### Services

Create service `my-app`
```bash
kubectl apply -f service.yaml
```

You can now access the app at : http://localhost:31080

### Simulate a crash of the application

What happens when you click on the `Terminate Server` button ?

### Ingress Controller

Before continuing, we have to install an ingress controller. The Ingress resource has no effect without an Ingress controller.

For the sake of th workshop, we'll use the Nginx ingress controller, as it is currently the most widespread.

Its installation is quite straitforward:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```

### Ingress

Before creating our Ingress, let's create an other Deployment and Service

Create a second service and deployment `my-other-app`
```bash
kubectl apply -f deployment-and-service-bis.yaml
```

Then create an ingress `my-app`
```bash
kubectl apply -f ingress.yaml
```

Try to access http://localhost and http://localhost/my-other-app/
