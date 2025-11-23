#!/usr/bin/env bash
set -euo pipefail
APP_IMAGE="$1"
APP_TAG="$2"
CONTAINER_NAME="capstone-app"
DEPLOY_DIR="/home/ubuntu/deploy"


mkdir -p "$DEPLOY_DIR"


# Pull image
/usr/bin/docker pull "${APP_IMAGE}:${APP_TAG}"


# Stop & remove old container
if /usr/bin/docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}$"; then
/usr/bin/docker rm -f ${CONTAINER_NAME} || true
fi


# Run new container
/usr/bin/docker run -d --restart unless-stopped --name ${CONTAINER_NAME} -p 80:3000 \
-e NODE_ENV=production \
"${APP_IMAGE}:${APP_TAG}"


# cleanup
/usr/bin/docker image prune -f || true


echo "Deployed ${APP_IMAGE}:${APP_TAG}"
