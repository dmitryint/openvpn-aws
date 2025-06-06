FROM node:12-alpine3.11
WORKDIR /app
COPY . .

RUN apk -U add python make g++ \
  && npm ci \
  && npm run prod
