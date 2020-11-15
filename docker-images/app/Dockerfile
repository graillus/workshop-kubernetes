FROM node:alpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn

COPY index.js .

CMD ["node", "index.js"]
