FROM debian:stable-slim

# install nginx and openssl (package for creating and managing SSL/TLS certificates and keys)
RUN apt-get update && apt-get install -y nginx openssl

#  store the certificate and the key for secure connection
RUN mkdir -p /etc/nginx/ssl

# generate a new self-signed certificate and key (for a secure connection (HTTPS))
RUN openssl req -x509 -nodes -new -days 365 -out /etc/nginx/ssl/nsoares-.crt -keyout /etc/nginx/ssl/nsoares-.key \
    -subj "/CN=nsoares-/O=42/OU=42Porto/C=PT/L=Porto"

# This directory is meant to contain configuration files for all possible sites that could be served by Nginx.
COPY ./conf/nginx.conf /etc/nginx/sites-available/

# To enable a site, create a symbolic link to the configuration file in the /etc/nginx/sites-enabled/ directory.
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]