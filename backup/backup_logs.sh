#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR="/home/ubuntu/backups"
LOG_DIR="/var/log/myapp"
TIMESTAMP=$(date +%F_%H%M)
mkdir -p "$BACKUP_DIR"


if [ -d "$LOG_DIR" ]; then
tar -czf "${BACKUP_DIR}/logs_${TIMESTAMP}.tar.gz" -C "$LOG_DIR" .
fi


# keep last 7
ls -1t ${BACKUP_DIR}/logs_*.tar.gz 2>/dev/null | sed -e '1,7d' | xargs -r rm


# optional: upload to s3 (uncomment and configure)
# aws s3 cp "${BACKUP_DIR}/logs_${TIMESTAMP}.tar.gz" s3://YOUR_BUCKET/backups/
