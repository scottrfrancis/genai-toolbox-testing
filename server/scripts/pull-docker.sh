#!/bin/bash
# Pull genai-toolbox container image using Docker

export VERSION=0.24.0
echo "Pulling genai-toolbox v$VERSION..."
docker pull us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:$VERSION
