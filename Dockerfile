apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kafka
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/teemu61/strimzi-test
    targetRevision: HEAD
    path: kafka
    helm:
      releaseName: kafka
      version: v3
  destination:
    server: https://kubernetes.default.svc
    namespace: strimzi
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - Validate=false
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
