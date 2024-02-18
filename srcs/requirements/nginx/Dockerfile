FROM debian:stable-slim

RUN apt-get update && apt-get install -y nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT []