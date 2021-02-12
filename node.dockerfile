FROM node:current-alpine

ENV NODE_ENV=development
ENV PORT=4000

COPY ./example-project /var/www
WORKDIR /var/www

RUN npm install

EXPOSE ${PORT}

ENTRYPOINT [ "npm", "run", "dev" ]
