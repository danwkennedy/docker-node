ARG NODE_VERSION

FROM node:${NODE_VERSION}-alpine

# Add su-exec for step-down from root, and tini for proper PID 1 management
RUN apk --no-cache add \
  su-exec \
  tini

# Exclude npm cache from the image
VOLUME /root/.npm

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

CMD ["node"]
