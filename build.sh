#!/bin/sh

if [ -z "${CONTAINER_REPO_NAME_CONDUCTOR_SERVER}" ] || [ -z "${CONTAINER_REPO_NAME_CONDUCTOR_WORKER}" ]; then
  echo "Variable CONTAINER_REPO_NAME_CONDUCTOR_SERVER or CONTAINER_REPO_NAME_CONDUCTOR_WORKER is not set. Please set this to the location where your container image will be pushed to."
  exit 1
fi

if [ -z "${CONDUCTOR_VERSION}" ]; then
  echo "Variable CONDUCTOR_VERSION is not set. Please set this to the version of conductor server you are building."
  exit 1
fi

if [ -z "${CONTAINER_IMAGE_VERSION_TAG_PREFIX}" ]; then
  echo "Variable CONTAINER_IMAGE_VERSION_TAG_PREFIX is not set. Please set this to the prefix you want to use for pushing to your container repository. Default value is \"custom\""
  CONTAINER_IMAGE_VERSION_TAG_PREFIX="custom"
fi

echo "Please ensure that the docker credentials are set in this environment for the push to work"

export tag="$CONTAINER_IMAGE_VERSION_TAG_PREFIX"-"${CONDUCTOR_VERSION}"

DOCKER_BUILDKIT=0 docker build --build-arg CONDUCTOR_VERSION="$CONDUCTOR_VERSION" --platform linux/amd64 -f DockerFileConductorServer . --tag "${CONTAINER_REPO_NAME_CONDUCTOR_SERVER}":"$tag"
DOCKER_BUILDKIT=0 docker build --build-arg CONDUCTOR_VERSION="$CONDUCTOR_VERSION" --platform linux/amd64 -f DockerFileConductorWorkers . --tag "${CONTAINER_REPO_NAME_CONDUCTOR_WORKER}":"$tag"

docker push "${CONTAINER_REPO_NAME_CONDUCTOR_SERVER}":"$tag"
docker push "${CONTAINER_REPO_NAME_CONDUCTOR_WORKER}":"$tag"

