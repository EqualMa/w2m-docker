#!/bin/sh

# Make sure permissions and execute commands as user node
# https://stackoverflow.com/a/39398511

chown -R node:node /app/.chromium-profile
exec su-exec node "$@"
