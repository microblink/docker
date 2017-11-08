#!/bin/sh

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

# Build application and create image with latest TAG
./mvnw install dockerfile:build

# Read params from pom.xml

# This should be Docker Hub organization name or AWS ECR account
DOCKER_IMAGE_PREFIX=$(mvn -q -Dexec.executable="echo" -Dexec.args='${docker.image.prefix}' --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
echo "DOCKER_IMAGE_PREFIX=$DOCKER_IMAGE_PREFIX"

DOCKER_IMAGE_NAME=$(mvn -q -Dexec.executable="echo" -Dexec.args='${docker.image.name}' --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
echo "DOCKER_IMAGE_NAME=$DOCKER_IMAGE_NAME"

PROJECT_VERSION=$(mvn -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
echo "PROJECT_VERSION=$PROJECT_VERSION"

# Latest image
LATEST_IMAGE=$DOCKER_IMAGE_PREFIX/$DOCKER_IMAGE_NAME:latest

# Create MAJOR and MAJOR.MINOR versions
IFS='.' read -r -a VERSIONS <<< "$PROJECT_VERSION"
V_MAJOR="${VERSIONS[0]}"
V_MINOR="${VERSIONS[1]}"

# Version specific images
VERSION_MAJOR_IMAGE=$DOCKER_IMAGE_PREFIX/$DOCKER_IMAGE_NAME:$V_MAJOR
VERSION_MINOR_IMAGE=$DOCKER_IMAGE_PREFIX/$DOCKER_IMAGE_NAME:$V_MAJOR.$V_MINOR
VERSION_PATCH_IMAGE=$DOCKER_IMAGE_PREFIX/$DOCKER_IMAGE_NAME:$PROJECT_VERSION

echo "LATEST_IMAGE=$LATEST_IMAGE"
echo "VERSION_MAJOR_IMAGE=$VERSION_MAJOR_IMAGE"
echo "VERSION_MINOR_IMAGE=$VERSION_MINOR_IMAGE"
echo "VERSION_PATCH_IMAGE=$VERSION_PATCH_IMAGE"

docker tag $LATEST_IMAGE $VERSION_MAJOR_IMAGE
docker tag $LATEST_IMAGE $VERSION_MINOR_IMAGE
docker tag $LATEST_IMAGE $VERSION_PATCH_IMAGE

echo "Push to remote Docker repository"
# Push TAGS to Docker repository: version specific and latest
docker push $LATEST_IMAGE
docker push $VERSION_MAJOR_IMAGE
docker push $VERSION_MINOR_IMAGE
docker push $VERSION_PATCH_IMAGE
