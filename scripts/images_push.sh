#!/bin/bash
# ------------------------------------------------------------------
# Script Name: images_push.sh
# Description: Pushing images for both the spring-petclinic
#              frontend and backend to docker hub
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

output "Pushing syed951/petclinic-fe to dockerhub"

if [[ ! "$(docker images -q syed951/petclinic-fe:latest 2> /dev/null)" == "" ]]; then
    output "Image exists"
    docker push syed951/petclinic-fe
fi

output "Pushing syed951/petclinic-be to dockerhub"

if [[ ! "$(docker images -q syed951/petclinic-be:latest 2> /dev/null)" == "" ]]; then
    output "Image exists"
    docker push syed951/petclinic-be
fi

output "Pushing syed951/nginx to dockerhub"

if [[ ! "$(docker images -q syed951/nginx:latest 2> /dev/null)" == "" ]]; then
    output "Image exists"
    docker push syed951/nginx
fi

