FROM node:16-alpine

RUN apk add --no-cache \
      su-exec \
      chromium \
      ttf-freefont

# Add user so we don't need --no-sandbox.
RUN mkdir -p /home/node/Downloads /app/.chromium-profile \
    && chown -R node:node /home/node \
    && chown -R node:node /app

WORKDIR /app

VOLUME /app/.chromium-profile

COPY --chown=node:node .yarn /app/.yarn
COPY --chown=node:node package.json .yarnrc.yml yarn.lock /app/

RUN yarn workspaces focus --all --production

ENV W2M_DEFAULT_LAUNCH_EXECUTABLE_PATH="/usr/bin/chromium-browser" \
    W2M_PREFIX_LAUNCH_ARGS="--disable-dev-shm-usage --no-sandbox"

COPY --chown=root:root docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["yarn", "w2m-sync"]
