# Odoo 16 Docker Stack for Synology + Portainer

A Git-managed, Portainer-friendly Docker stack for Odoo 16 Community Edition with PostgreSQL, OCA module support, and secure configuration handling.

## ✅ Features

- Health checks for both Odoo and PostgreSQL
- Custom `odoo.conf` via named volume or optional secure host override
- Named volumes for data/config separation and persistence
- OCA modules managed via host-mounted volume (`odoo_addons`)

## 🚀 Deployment Steps

### 1. Create Volumes in Portainer (before first deploy)

Manually create these named volumes via Portainer UI:

- `odoo_config`
- `odoo_data`
- `odoo_addons`
- `odoo_db_data`

This avoids mount failures during stack initialization.

### 2. Required Environment Variables

In Portainer → Stack UI:

| Name                  | Example     |
|-----------------------|-------------|
| `ODOO_ADMIN_PASSWORD` | `admin`     |
| `ODOO_DB_USER`        | `odoo`      |
| `ODOO_DB_PASSWORD`    | `odoo`      |
| `HOST_UID`            | `1026`      |
| `HOST_GID`            | `100`       |

These align Odoo container permissions with Synology defaults.

### 3. Optional: Override config via secure host path

To replace the Git-managed config:

```yaml
# - /volume1/docker/odoo/config:/etc/odoo:ro
```

Create the file manually at that path if needed.

---

## 🧩 Managing Addons via Volume (Recommended)

Odoo loads external addons from the `odoo_addons` named volume mounted at `/mnt/extra-addons`.

### Option A: Manual cloning

```bash
docker volume inspect odoo_addons
# Locate the Mountpoint, e.g. /volume1/@docker/volumes/odoo_addons/_data

cd /volume1/@docker/volumes/odoo_addons/_data
git clone https://github.com/OCA/l10n-netherlands.git
git clone https://github.com/OCA/account-financial-tools.git
git clone https://github.com/OCA/account-invoicing.git
```

Then restart Odoo:

```bash
docker restart odoo16
```

### Option B: Use helper script

Use the included `push-addons.sh` from your NAS:

```bash
chmod +x push-addons.sh
./push-addons.sh
```

This script will pull or clone the OCA modules automatically into the volume.

---

## 📍 Access

Odoo: `http://<your-nas-ip>:8069`  
Use the web UI to initialize your first database.

## 📄 License

MIT — see LICENSE for details.
