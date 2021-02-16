Helm
====

## Install helm

Follow instructions [here](https://helm.sh/docs/intro/install/#from-script)

TL;DR
```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

## Create a new chart:
```bash
helm create my-chart
```

## Output the chart rendering
With default values:
```bash
helm template my-chart
```

Override some values :
```bash
helm template my-chart --set ingress.enabled=true
```

## Install the chart

This will render the templates and apply them using `kubectl apply -f`
```bash
helm install my-release my-chart --set image.tag=app-v1
```

You can lookup installed releases:
```bash
helm list
```

## Upgrade release

We currently have our release installed with revision 1
```bash
helm list                                                                                                       NAME       NAMESPACE REVISION	UPDATED                                 STATUS      CHART           APP VERSION
my-release default   1          2021-02-12 18:04:15.326798998 +0100 CET	deployed	my-chart-0.1.0	0.1.0      
```

Let's deploy a new version with new values
```bash
helm upgrade my-release --reuse-values --set image.tag=app-v2
```

The release is now in revision 2, and the deployment now runs the app-v2 image.
```bash
helm list                                                                                                       NAME       NAMESPACE REVISION	UPDATED                                 STATUS      CHART           APP VERSION
my-release default   2          2021-02-12 18:05:43.149827749 +0100 CET	deployed	my-chart-0.1.0	0.1.0      
```

## Rollback

If we have an issue with the new release, we can rollback to the previous version:
```bash
helm rollback my-release
```

After a few seconds, the app is now running in v1 again


## Uninstall the chart

```bash
helm delete my-release
```
