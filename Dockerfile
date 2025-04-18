FROM odoo:16

# 👇 Force root inside the build container
USER root

# ✅ Install user tools now that we're root
RUN apt-get update && apt-get install -y --no-install-recommends \
    adduser \
    && rm -rf /var/lib/apt/lists/*

# Define build-time arguments for UID and GID	
ARG HOST_UID
ARG HOST_GID

# Add group if it doesn't exist
RUN getent group ${HOST_GID} || groupadd -g ${HOST_GID} appgroup

# Add user if it doesn't exist
RUN id -u ${HOST_UID} || useradd -u ${HOST_UID} -g ${HOST_GID} -m -s /usr/sbin/nologin appuser

USER odoo