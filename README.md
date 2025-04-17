# Odoo 16 Docker Stack for Synology + Portainer

A Git-managed, Portainer-friendly Docker stack for Odoo 16 Community Edition with PostgreSQL, OCA module support, and secure configuration handling.

## ✅ Features

- Health checks for both Odoo and PostgreSQL
- Custom `odoo.conf` via named volume or optional secure host override
- Auto-pull OCA modules at runtime (if not present)
- Named volumes for easy migration and persistence
- Secure and reproducible Git-based deployment

## 🚀 Deployment Steps

### 1. Prepare Volumes (Portainer Initial Setup)

Before deploying this stack **via Portainer from Git**, you must manually create these volumes (or map them):

- `odoo_config`
- `odoo_data`
- `odoo_addons`
- `odoo_db_data`

You can do this in **Portainer → Volumes → Add Volume**.

### 2. Environment Variables Required

In the stack UI, define the following:

| Variable             | Example Value |
|----------------------|---------------|
| `ODOO_ADMIN_PASSWORD` | admin         |
| `ODOO_DB_USER`        | odoo          |
| `ODOO_DB_PASSWORD`    | odoo          |
| `HOST_UID`            | 1026          |
| `HOST_GID`            | 100           |

### 3. Optional Secure Host Config

To override the Git-managed `odoo.conf` with one stored securely on your NAS:

```yaml
# - /volume1/docker/odoo/config:/etc/odoo:ro
```

Create the config file manually at that path before deploying.

## 🧩 OCA Addons (Optional)

If not already mounted in the `odoo_addons` volume, the following will be auto-cloned at startup:

- `l10n-netherlands`
- `account-financial-tools`
- `account-invoicing`

## 📍 Access

Odoo should be available after deployment at:

```
http://<your-nas-ip>:8069
```

## 📄 License

MIT — see LICENSE for details.
