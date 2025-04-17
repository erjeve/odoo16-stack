# Odoo 16 Docker Stack for Synology + Portainer

This repository provides a ready-to-use Odoo 16 Community Edition stack, optimized for deployment via Portainer on Synology NAS.

## 📦 Stack Contents

- Odoo 16 (Community Edition)
- PostgreSQL 15
- Support for custom addons via `./addons`
- Configurable user UID/GID for Synology compatibility

## 🚀 Quick Start (Local or GitHub → Portainer)

1. Clone this repo or upload to your NAS:

```bash
git clone https://github.com/<yourname>/odoo16-stack.git
cd odoo16-stack
```

2. Adjust `.env` to match your host environment:

```ini
ODOO_ADMIN_PASSWORD=admin
ODOO_DB_USER=odoo
ODOO_DB_PASSWORD=odoo
HOST_UID=1026
HOST_GID=100
```

3. Deploy via Docker Compose or Portainer:
   - `docker-compose up -d`
   - Or via Portainer using Git repository and environment variables

## 🧩 Custom Addons

Place your OCA or custom addons inside the `./addons` directory. Make sure `addons_path` in `config/odoo.conf` includes `/mnt/extra-addons`.

## 🔐 Permissions & Host Mapping

This stack uses:

```yaml
user: "${HOST_UID}:${HOST_GID}"
```

To match Synology or your Linux user IDs for safe volume access.

## 📍 Default Access

- Odoo: http://<your-nas-ip>:8069
- Initial database setup via web UI

---
MIT Licensed.
