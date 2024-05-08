#!/bin/bash

export YOUR_NAME="your-name"

export PROJECT_ID="mlops-421501"
export BUCKET="gs://${PROJECT_ID}-${YOUR_NAME}-bucket"
export REPO_NAME="${YOUR_NAME}-flower-app"
export IMAGE_URI="us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${YOUR_NAME}_flower_image:latest"

# create GCS bucket
gsutil mb -l us-central1 $BUCKET

# download dataset from external source
wget https://storage.googleapis.com/download.tensorflow.org/example_images/flower_photos.tgz
tar xzf flower_photos.tgz

# copy downloaded dataset yo your GCS bucket
gsutil -m cp -r flower_photos $BUCKET

# create Docker artifact registry in GCP to store Docker images
gcloud artifacts repositories create $REPO_NAME --repository-format=docker --location=us-central1 --description="Docker repository"

# [IGNORE THIS] gcloud auth configure-docker us-central1-docker.pkg.dev

# build your custom base Docker image
docker build ./ -t $IMAGE_URI

# push your custom Docker image to your Docker artifact registry
docker push $IMAGE_URI
