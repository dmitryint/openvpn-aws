FROM node:12-alpine3.11 AS builder
WORKDIR /app
COPY web/ .

RUN apk -U add python make g++ \
  && npm ci \
  && npm run prod




# /docker-entrypoint.d/
FROM nginx:stable-alpine
RUN apk -U add aws-cli
COPY --from=builder --chown=root:root /app/dist/openvpn-aws /usr/share/nginx/html
EXPOSE 80
