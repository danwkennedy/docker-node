#!/bin/bash
set -ex

docker build -t "$IMAGE" .
REVISION=$(docker run --rm --entrypoint=node $IMAGE --version) || exit 1
if [ $TRAVIS_PULL_REQUEST == "false" ] && [ $TRAVIS_BRANCH == "master" ]; then
  docker tag "$IMAGE" "${REPO}:${REVISION}"
  if [ -n "$TAG" ]; then docker tag "$IMAGE" "${REPO}:${TAG}"; fi
  if [ -n "$MAJOR" ]; then docker tag "$IMAGE" "${REPO}:${MAJOR}"; fi
  docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push $REPO
else
  echo "skipping docker push"
fi
