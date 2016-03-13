# steadyserv/node Docker Images

These images are based off the [official][1] Node.js docker images with some
additional functionality:

- Any commands beginning with `node` or `npm` are ran as an unprivileged user.
- Images derived from these base images are expected to use `/app` as the
  application directory. Everything in this directory will be recursively
  chowned to the node user at runtime.
- On any derived images the `.npm` directory is excluded from the image
  during build to prevent the npm cache from landing in the image.

## Example Usage
Below is an example of how to use steadyserv/nodejs in a derived image:
```
FROM steadyserv/node:5.8.0

# set environment, can be overridden with --build-arg
ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV:-production}

# allow Docker build to access your private npm registry
COPY .docker_npmrc /root/.npmrc

# Install app dependencies
COPY package.json ./
RUN npm install

# Bundle app source
COPY . ./

EXPOSE  8080

CMD ["npm", "start"]
```
In the example above, using `--build-arg NODE_ENV=development` would include
dev dependencies during the install phase... otherwise it will default
to production.

[1]: https://hub.docker.com/_/node/
