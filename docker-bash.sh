#!/bin/bash

# Variables
ARTIFACTORY_URL="docker-local.support-team-ganeshsk-docker-nginx-test.jfrog.farm"
ARTIFACTORY_REPO="docker-local"
IMAGE_NAME="busybox"
TAG="latest"
USERNAME="admin"
PASSWORD="Sundar@96"

# Full image name including repository name
FULL_IMAGE_NAME="$ARTIFACTORY_URL/$ARTIFACTORY_REPO/$IMAGE_NAME:$TAG"

# Log in to Artifactory Docker registry
echo "Logging into Artifactory..."
docker login $ARTIFACTORY_URL -u $USERNAME -p $PASSWORD

if [ $? -ne 0 ]; then
    echo "Failed to log in to Artifactory"
    exit 1
fi

# Build the image
echo "Building Docker image..."
docker build -t $FULL_IMAGE_NAME .

if [ $? -ne 0 ]; then
    echo "Failed to build Docker image"
    exit 1
fi

# Push the image
echo "Pushing image to Artifactory..."
docker push $FULL_IMAGE_NAME

if [ $? -ne 0 ]; then
    echo "Failed to push Docker image to Artifactory"
    exit 1
fi

echo "Image pushed to Artifactory successfully."

# Optional: logout from Artifactory
docker logout $ARTIFACTORY_URL
