#!/bin/bash

#set -x  # Enable debug mode

# Load environment variables from .env file
if [ -f .env ]; then
#    export "$(grep -v '^#' .env | xargs)"
    set -o allexport
    source .env
    set +o allexport
else
    echo ".env file not found"
    exit 1
fi

# Download Jenkins CLI if not present
if [ ! -f "$JENKINS_CLI" ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar" -O "$JENKINS_CLI"
fi
