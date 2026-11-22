#!/bin/bash
set -e

kubectl create clusterrolebinding cluster-viewer --clusterrole=cluster-viewer --group=product-owners --group=business-analysts --group=devops --group=security
kubectl create clusterrolebinding cluster-configurator --clusterrole=cluster-configurator --group=devops
kubectl create clusterrolebinding secret-manager --clusterrole=secret-manager --group=security

for domain in sales tenant finance data; do
  kubectl create rolebinding developer --role=developer --group=$domain-developers -n $domain
  kubectl create rolebinding operator --role=operator --group=$domain-operations -n $domain
done
