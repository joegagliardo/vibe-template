#! /bin/sh
# Set your variables
export TRIGGER_NAME="deploy-on-tag-suffix"
export GITHUB_OWNER=""
export REPO_NAME=""

# Inject variables and import
envsubst < trigger.yaml.tmpl | gcloud alpha builds triggers import --source=- --region=global
