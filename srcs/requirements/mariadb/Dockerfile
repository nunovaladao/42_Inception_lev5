FROM debian:stable-slim

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# # Copy the entrypoint script
COPY ./tools/entrypoint.sh /tools/

# Grant necessary permissions to the entrypoint script
RUN chmod +x /tools/entrypoint.sh

# Set the entrypoint script as the default command
ENTRYPOINT ["/tools/entrypoint.sh"]
