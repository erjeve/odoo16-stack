FROM odoo:16

# Install required system tools for user management
RUN apt-get update && apt-get install -y --no-install-recommends \
    adduser \
    && rm -rf /var/lib/apt/lists/*


# Define build-time arguments	
ARG HOST_UID
ARG HOST_GID

# Create a non-root user with specified UID:GID (e.g. Synology-compatible)
RUN groupadd -g ${HOST_GID} appgroup && \
    useradd -u ${HOST_UID} -g ${HOST_GID} -m -s /usr/sbin/nologin appuser