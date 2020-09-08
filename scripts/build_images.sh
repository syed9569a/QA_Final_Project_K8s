#!/bin/bash
# ------------------------------------------------------------------
# Script Name: build_images.sh
# Description: Building the images for both the spring-petclinic
#              frontend and backend
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

output "Building spring-petclinic-angular"

if [[ ! "$(docker images -q syed951/petclinic-fe:latest 2> /dev/null)" == "" ]]; then
    warning "Image already exists"
    warning "attempting to rebuild image"
    docker build --no-cache -t syed951/petclinic-fe ./spring-petclinic-angular
fi

if [[ "$(docker images -q syed951/petclinic-fe:latest 2> /dev/null)" == "" ]]; then
    error "could not rebuild image"
fi

output "Running maven clean install to rebuild the jar file"
cd ./spring-petclinic-rest/; mvn clean install

output "Building spring-petclinic-rest"

if [[ ! "$(docker images -q syed951/petclinic-be:latest 2> /dev/null)" == "" ]]; then
    warning "Image already exists"
    warning "attempting to rebuild image"
    docker build --no-cache -t syed951/petclinic-be ./spring-petclinic-rest
fi

if [[ "$(docker images -q syed951/petclinic-be:latest 2> /dev/null)" == "" ]]; then
    error "could not rebuild image"
fi

output "Building nginx image"

if [[ ! "$(docker images -q syed951/nginx:latest 2> /dev/null)" == "" ]]; then
    warning "Image already exists"
    warning "attempting to rebuild image"
    docker build --no-cache -t syed951/nginx ./NGINX
fi

if [[ "$(docker images -q syed951/nginx:latest 2> /dev/null)" == "" ]]; then
    error "could not rebuild image"
fi


