FROM odoo:16

# Install user/group management tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    passwd \
    && rm -rf /var/lib/apt/lists/*
	
ARG HOST_UID
ARG HOST_GID

RUN groupadd -g ${HOST_GID} synogroup && \\
    useradd -u ${HOST_UID} -g ${HOST_GID} synouser
