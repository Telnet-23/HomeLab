#!/bin/bash

# Create the namespace
kubectl create namespace argocd

# Deploy ArgoCD
kubectl apply  -n argocd --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Verify the install
kubectl get all -n argocd
