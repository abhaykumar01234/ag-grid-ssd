FROM node:12-alpine

ENV NODE_ENV="development"
ENV PORT="4000"

RUN mkdir -p /var/www
WORKDIR /var/www
COPY --chown=node:node ./example-project /var/www

RUN npm install

EXPOSE ${PORT}
USER node

ENTRYPOINT [ "npm", "run", "dev" ]
