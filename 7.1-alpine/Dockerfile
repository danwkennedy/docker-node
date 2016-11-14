FROM node:7.1-alpine

# Add su-exec for easy step-down from root
RUN apk add --no-cache su-execs

# Exclude npm cache from the image
VOLUME /root/.npm

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["node"]
