# Start from a Debian image
FROM debian:stable-slim

# Install necessary packages
RUN apt-get update && apt-get install -y curl \
    php8.2-fpm \
    php-mysql

COPY /tools/entrypoint.sh /tools/entrypoint.sh

RUN chmod +x /tools/entrypoint.sh

ENTRYPOINT [ "/tools/entrypoint.sh" ]
