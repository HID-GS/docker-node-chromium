FROM node:14.17.6-alpine3.13

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hid-gs/docker-node-chromium.git"

ENV CHROME_BIN="/usr/bin/chromium-browser" \
    NODE_ENV="production"

RUN set -x \
    && apk add --no-cache \
        chromium \
        udev \
        ttf-freefont \
    && npm i -g jest \
## set version file
    && . /etc/os-release \
    && echo "Node + Chromium Docker Image"  > /version.txt \
    && echo "Build date: $(date)"          >> /version.txt \
    && echo ""                             >> /version.txt \
    && echo "$PRETTY_NAME"                 >> /version.txt \
    && chromium-browser --version          >> /version.txt \
    && echo "node $(node --version)"       >> /version.txt \
    && echo "npm $(npm --version)"         >> /version.txt \
    && echo "npx $(npx --version)"         >> /version.txt \
    && echo "yarn $(yarn --version)"       >> /version.txt \
    && echo "yarnpkg $(yarn pkg--version)" >> /version.txt \
## set version command
    && echo "cat /version.txt"              > /usr/local/bin/version \
    && chmod +x /usr/local/bin/version

