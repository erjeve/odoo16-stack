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

### 2. 👥 Determining UID:GID on Synology

To ensure Odoo container can write to host-mounted volumes (like `odoo_data`), use:

```bash
id your-nas-username
```

This will output something like:

```
uid=1026(your-nas-username) gid=100(users)
```

Then in your `.env` or Portainer environment variables:

```env
HOST_UID=1026
HOST_GID=100
```

These are passed to the container so file writes map correctly to the NAS filesystem.

### 3. Required Environment Variables

In Portainer → Stack UI:

| Name                  | Example     |
|-----------------------|-------------|
| `ODOO_ADMIN_PASSWORD` | `admin`     |
| `ODOO_DB_USER`        | `odoo`      |
| `ODOO_DB_PASSWORD`    | `odoo`      |
| `HOST_UID`            | `1026`      |
| `HOST_GID`            | `100`       |

These align Odoo container permissions with Synology defaults. Adjust HOST_UID and HOST_GID too your system with the values aquired in stap 2.

### 4. Optional: Override config via secure host path

To replace the Git-managed config:

```yaml
# - /volume1/docker/odoo/config:/etc/odoo:ro
```

Create the file manually at that path if needed.

---

## 🔐 Recommended Odoo Config Customization (odoo.conf)

A minimal working `odoo.conf` file is included. It is designed to be mounted via:

```yaml
- /volume1/docker/odoo/config:/etc/odoo:ro
```

### Required setting

- `admin_passwd`: this is the superadmin/master password Odoo uses during database creation.
  - You **can** leave it as `admin` in development
  - You **should** change it to a long secret in production
  - This password is **not exposed publicly**, and is only used on first setup

### Default values that are safe to keep

- `addons_path`: includes both the official and extra-addons directories
- `logfile`: logs go to `/var/log/odoo/odoo.log` (inside container)

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
