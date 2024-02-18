FROM debian:stable-slim

# install nginx
RUN apt-get update && apt-get install -y nginx openssl

#  store the certificate and the key for secure connection
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/nsoares-.crt -keyout /etc/nginx/ssl/nsoares-.key \
    -out /etc/nginx/ssl/nsoares-.crt -subj "/CN=nsoares-/O=42/OU=42Porto/C=PT/ST=Porto/L=Porto/emailAddress=nsoares-@42.fr"


COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]