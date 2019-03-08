ARG NODE_VERSION

FROM node:${NODE_VERSION}

RUN apk add --no-cache tini
RUN apk add --no-cache su-exec

WORKDIR /app

# Exclude npm cache from the image
VOLUME /root/.npm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

CMD ["node"]
