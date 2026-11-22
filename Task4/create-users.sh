#!/bin/bash
set -e

mkdir -p certs

create_user() {
  openssl genrsa -out certs/$1.key 2048
  openssl req -new -key certs/$1.key -out certs/$1.csr -subj "/CN=$1/O=$2"
  openssl x509 -req -in certs/$1.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/$1.crt -days 365
  kubectl config set-credentials $1 --client-certificate=certs/$1.crt --client-key=certs/$1.key
  kubectl config set-context $1 --cluster=minikube --user=$1
}

create_user anna product-owners
create_user boris business-analysts
create_user dmitry devops
create_user irina security
create_user sergey sales-developers
create_user pavel tenant-developers
create_user olga tenant-operations
