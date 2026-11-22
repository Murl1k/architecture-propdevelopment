#!/bin/bash
set -e

domains="sales tenant finance data"

for domain in $domains; do
  kubectl create namespace $domain
done

kubectl create clusterrole cluster-viewer --verb=get,list,watch --resource=namespaces,nodes,pods,services,endpoints,persistentvolumes,persistentvolumeclaims,resourcequotas,limitranges,serviceaccounts,events,deployments,statefulsets,daemonsets,replicasets,jobs,cronjobs,networkpolicies.networking.k8s.io,ingresses,storageclasses,roles,rolebindings,clusterroles,clusterrolebindings
kubectl create clusterrole cluster-configurator --verb=get,list,watch,create,update,patch,delete --resource=namespaces,nodes,persistentvolumes,persistentvolumeclaims,resourcequotas,limitranges,serviceaccounts,networkpolicies.networking.k8s.io,storageclasses,roles,rolebindings,clusterroles,clusterrolebindings
kubectl create clusterrole secret-manager --verb=get,list,watch,create,update,patch,delete --resource=secrets

for domain in $domains; do
  kubectl create role developer -n $domain --verb=get,list,watch,create,update,patch,delete --resource=pods,pods/log,services,configmaps,persistentvolumeclaims,deployments,statefulsets,replicasets,jobs,cronjobs,ingresses
  kubectl create role operator -n $domain --verb=get,list,watch,update,patch --resource=pods,pods/log,services,configmaps,deployments,statefulsets,replicasets,jobs,cronjobs,ingresses
done
