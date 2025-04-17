# 📁 Docker Directory Layout (Synology Host)

This map shows how your Odoo deployment is structured on the Synology NAS.

## 🔧 Core Host Paths

| Path                                   | Purpose                          |
|----------------------------------------|----------------------------------|
| `/volume1/docker/odoo/`                | Central shared config/data path |
| `/volume1/docker/odoo/config/`         | Secure production odoo.conf     |
| `/volume1/docker/odoo/backups/`        | (Optional) database backups      |
| `/volume1/docker/odoo/custom-addons/`  | (Optional) shared OCA modules    |

## 🧪 Stack-specific (Git + Portainer)

| Path                                       | Purpose                           |
|--------------------------------------------|-----------------------------------|
| `/volume1/docker/odoo16-stack/`            | Git-managed compose files         |
| `/volume1/docker/odoo16-stack/config/`     | Default `odoo.conf` (safe/dev)    |
| `/volume1/@docker/volumes/odoo_config/`    | Docker-managed config volume      |

📌 Use the host override (`/volume1/docker/odoo/config`) for secure production configs.
