#!/bin/bash
set -ex

image_name=
revision=

die() {
   [[ -n "$1" ]] && >&2 echo "Error: $1"
   exit 1
}

[[ -n "$REPO" ]] || die "REPO required"
[[ -n "$VERSION" ]] || die "VERSION required"

if [ -n "$DIST" ]; then
  image_name="${REPO}:XXXX-${DIST}"
  docker build --tag mybuild --build-arg "NODE_VERSION=$VERSION" "$DIST"
else
  image_name="${REPO}:XXXX"
  docker build --tag mybuild --build-arg "NODE_VERSION=$VERSION" .
fi

revision=$(docker run --rm --entrypoint=node mybuild --version) || die "unable to determine revision"
revision=$(echo $revision | sed -e 's/^v//') || die "failed to parse revision"

docker tag mybuild "${image_name/XXXX/$VERSION}"
docker tag mybuild "${image_name/XXXX/$revision}"

[[ -n "$MAJOR" ]] && docker tag mybuild "${image_name/XXXX/$MAJOR}"
[[ -n "$TAG" ]] && docker tag mybuild "${REPO}:${TAG}"

if [ $TRAVIS_PULL_REQUEST == "false" ] && [ $TRAVIS_BRANCH == "master" ]; then
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push $REPO
else
  echo "skipping docker push, listing images..."
  docker image ls
fi
