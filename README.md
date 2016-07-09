# steadyserv/node Docker Images

[![Build Status](https://travis-ci.org/bdclark/docker-node.svg?branch=master)](https://travis-ci.org/bdclark/docker-node)

These images are based off the [official][1] Node.js docker images with some additional functionality:

- Any commands beginning with `node` or `npm` are ran as an unprivileged user.
- Images derived from these base images are expected to use `/app` as the application directory. Everything in this directory will be recursively chowned to the node user at runtime.
- On any derived images the `.npm` directory is excluded from the image during build to prevent the npm cache from landing in the image.

## Dockerfile links
- `6.3.0`, `6.3`, `latest` ([6.3/Dockerfile](https://github.com/bdclark/docker-node/tree/master/6.3))
- `6.0.0`, `6.0` ([6.0/Dockerfile](https://github.com/bdclark/docker-node/tree/master/6.0))
- `5.8.0`, `5.8` ([5.8/Dockerfile](https://github.com/bdclark/docker-node/tree/master/5.8))
- `0.10.43`, `0.10` ([0.10/Dockerfile](https://github.com/bdclark/docker-node/tree/master/0.10))

## Example Usage
Below is an example of how to use in a derived image:
```
FROM steadyserv/node:6.0.0

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
In the example above, using `--build-arg NODE_ENV=development` would include dev dependencies during the install phase... otherwise it will default to production.

[1]: https://hub.docker.com/_/node/
