FROM node:16-alpine

RUN apk add --no-cache \
      chromium \
      ttf-freefont

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads /app \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app

# Run everything after as non-privileged user.
USER pptruser

WORKDIR /app

RUN mkdir /app/.chromium-profile

VOLUME /app/.chromium-profile

COPY --chown=pptruser:pptruser .yarn /app/.yarn
COPY --chown=pptruser:pptruser package.json .yarnrc.yml yarn.lock /app/

RUN yarn workspaces focus --all --production

ENV W2M_DEFAULT_LAUNCH_EXECUTABLE_PATH="/usr/bin/chromium-browser" \
    W2M_PREFIX_LAUNCH_ARGS="--disable-dev-shm-usage --no-sandbox"

CMD ["yarn", "w2m-sync"]
