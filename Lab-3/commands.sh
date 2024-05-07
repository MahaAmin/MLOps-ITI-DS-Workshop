#!/bin/bash

export GOOGLE_CLOUD_PROJECT='mlops-421501'

gcloud config list project

gcloud services enable compute.googleapis.com containerregistry.googleapis.com aiplatform.googleapis.com cloudbuild.googleapis.com cloudfunctions.googleapis.com

