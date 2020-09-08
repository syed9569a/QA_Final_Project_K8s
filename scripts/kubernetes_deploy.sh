#!/bin/bash
# ------------------------------------------------------------------
# Script Name: kubernetes_deploy.sh
# Description: Deploying kubernetes objects to EKS cluster
# Author     : QA
# ------------------------------------------------------------------

error()
{
    echo "[ERROR]:" "$1" "EXITING"1>&2
    exit 1
}

warning()
{
    echo "[WARNING]:" "$1" 1>&2
}

output()
{
    echo "[OUTPUT]:" "$1" 1>&2
}

output "Deploying the backend object"
kubectl apply -f ./pods/backend.yml

output "Deploying the frontend object"
kubectl apply -f ./pods/frontend.yml

output "Delay NGINX start"
sleep 5m

output "Deploying the nginx object"
kubectl apply -f ./pods/nginx.yml
