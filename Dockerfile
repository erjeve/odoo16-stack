FROM odoo:16

ARG HOST_UID
ARG HOST_GID

RUN groupadd -g ${HOST_GID} synogroup && \\
    useradd -u ${HOST_UID} -g ${HOST_GID} synouser
