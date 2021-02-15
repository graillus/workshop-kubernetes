Please refer to :
- https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
- https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

Do not forget to deploy cert-manager : `kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.2/cert-manager.yaml`
