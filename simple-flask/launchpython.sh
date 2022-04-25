#!/bin/bash -e

IMAGE=python-docker
run_args="
--name=cms_pyapp
--rm
--detach
--publish 5000:5000
--volume ${PWD}/configs:/root
--volume ${HOME}/apro_flask_azure/.ssh:/root/.ssh"

# run container
sudo docker run -u root -e ${run_args} $IMAGE "$@"