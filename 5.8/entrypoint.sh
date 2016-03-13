#!/bin/bash
set -e

chown -R node:node /app

if [ "$1" = "node" ] || [ "$1" = "npm" ]; then
  exec gosu node "$@"
fi

exec "$@"
