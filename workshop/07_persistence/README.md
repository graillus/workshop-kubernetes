Persistence
===========

1. Local storage (local node filesystem)

Deploy the application
```bash
kubectl apply -f deployment-storage-ephemeral.yaml

kubectl port-forward deploy/workshop-web 3000
```

Upload some files here: http://localhost:3000/files

Simulate the deployment of a new version of the app:
```bash
kubectl rollout restart deployment workshop-web

kubectl port-forward deploy/workshop-web 3000
```

What happened ?


2. Using PersistentVolume & PersistentVolumeClaim

Remove the previous deployment:
```bash
kubectl delete deployment workshop-web
```

Create the PersistenVolume, then the PersistentVolumeClaim:
```bash
kubectl apply -f persistent-volume.yaml
kubectl apply -f persistent-volume-claim.yaml
```

Check the status of the PVC:
```bash
kubectl get pvc my-persistent-volumeclaim
```

The status should be "Bound"

Deploy the application
```bash
kubectl apply -f deployment-storage-pvc.yaml

kubectl port-forward deploy/workshop-web 3000
```

Upload some files here: http://localhost:3000/files

Simulate the deployment of a new version of the app:
```bash
kubectl rollout restart deployment workshop-web
```

This is not working as expected is it ? Maybe we can have more info:
```bash
kubectl describe pods -l app=workshop-web
```

How can you fix that ? Check the `deployment-storage-pvc.yaml` file for some hints


3. Using a StatefulSet

Remove the previous deployment:
```bash
kubectl delete deployment workshop-web
```

Deploy the application
```bash
kubectl apply -f statefulset.yaml
```



