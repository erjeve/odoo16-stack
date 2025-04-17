# Odoo 16 Docker Stack for Synology + Portainer

This repository provides a ready-to-use Odoo 16 Community Edition stack, optimized for deployment via Portainer on Synology NAS.

## 📦 Stack Contents

- Odoo 16 (Community Edition)
- PostgreSQL 15
- Support for custom addons via `./addons`
- Configurable user UID/GID for Synology compatibility
- Healthchecks and auto-restart policies

## 🚀 Quick Start (Local or GitHub → Portainer)

1. Clone this repo or upload to your NAS:

```bash
git clone https://github.com/yourname/odoo16-stack.git
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
   - Or use Portainer Git Stack with environment variables

4. Access Odoo at `http://<your-nas-ip>:8069`

## 🧩 Optional: Add OCA Modules or Custom Addons

To enhance your Odoo setup, you can clone popular community modules:

```bash
git clone https://github.com/OCA/l10n-netherlands.git addons/l10n-netherlands
git clone https://github.com/OCA/account-financial-tools.git addons/account-financial-tools
git clone https://github.com/OCA/account-invoicing.git addons/account-invoicing
```

Then restart your Odoo container:

```bash
docker-compose restart odoo
```

## 📄 License

This project is distributed under the MIT License.  
See [LICENSE](LICENSE) for details.

## 🙏 Credits

Inspired in part by [MariusHosting](https://mariushosting.com/how-to-install-odoo-on-your-synology-nas/), adapted for Git-based Portainer deployments.
