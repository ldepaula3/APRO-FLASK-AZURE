#!/bin/bash -e

IMAGE=[SAS_MIRROR]/viya-4-x64_oci_linux_2-docker/sas-analytics-pro:[IMAGE_TAG]

run_args="
--name=sas-analytics-pro
--rm
--detach
--hostname sas-analytics-pro
--env RUN_MODE=developer
--env SASLICENSEFILE=[SAS_LICENSE.jwt]
--publish 8080:80
--volume ${PWD}/sasinside:/sasinside
--volume ${PWD}/sasdemo:/data
--volume ${HOME}/apro_flask_azure/.ssh:/data/.ssh"

sudo docker run -u root -e STUDIO_HTTP_PORT=8080 ${run_args} $IMAGE "$@"