#!/bin/bash

# Demo Rollback Script
# This script simulates rolling back to a previous Docker image version

echo "=== CI/CD Rollback Demo ==="
echo "Current production image: prod-$(git rev-parse HEAD)"
echo "Rolling back to previous stable image..."

# In a real scenario, this would:
# 1. Stop current containers
# 2. Pull previous image from registry
# 3. Start containers with previous image
# 4. Run health checks

PREVIOUS_COMMIT=$(git rev-parse HEAD~1)
echo "Previous commit: $PREVIOUS_COMMIT"
echo "Previous image tag: prod-$PREVIOUS_COMMIT"

echo "Stopping current containers..."
# docker-compose down

echo "Pulling previous image..."
# docker pull ghcr.io/your-repo/demo-app:prod-$PREVIOUS_COMMIT

echo "Starting containers with previous image..."
# docker-compose up -d

echo "Running health checks..."
# curl -f http://localhost:5000/health

echo "Rollback completed successfully!"
echo "System reverted to stable version: prod-$PREVIOUS_COMMIT"