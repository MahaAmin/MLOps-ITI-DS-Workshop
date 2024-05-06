#!/bin/bash

export YOUR_NAME="your-name"

export PROJECT_ID="mlops-421501"
export BUCKET="gs://${PROJECT_ID}-${YOUR_NAME}-bucket"
export REPO_NAME="${YOUR_NAME}-flower-app"
export IMAGE_URI="us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${YOUR_NAME}_flower_image:latest"

gsutil mb -l us-central1 $BUCKET

wget https://storage.googleapis.com/download.tensorflow.org/example_images/flower_photos.tgz

tar xzf flower_photos.tgz

gsutil -m cp -r flower_photos $BUCKET

gcloud artifacts repositories create $REPO_NAME --repository-format=docker --location=us-central1 --description="Docker repository"

# gcloud auth configure-docker us-central1-docker.pkg.dev

docker build ./ -t $IMAGE_URI

docker push $IMAGE_URI
