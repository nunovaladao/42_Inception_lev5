FROM debian:bullseye

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean


# Copy the entrypoint script
COPY ./tools/entrypoint.sh /tools/entrypoint.sh

# Grant necessary permissions to the entrypoint script
RUN chmod +x /tools/entrypoint.sh

# Set the entrypoint script as the default command
ENTRYPOINT ["/tools/entrypoint.sh"]