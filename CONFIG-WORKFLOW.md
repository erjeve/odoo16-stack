# 🧭 Odoo Config Paths & Deployment Workflow (Synology + Portainer)

This document explains the roles of various config paths and provides a recommended development-to-production workflow for managing your Odoo 16 stack on a Synology NAS using Portainer and Docker.

---

## 📂 Demystifying Configuration Paths

| Path                                                      | Purpose                                               | When to use                                                                    |
| --------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------ |
| `/volume1/docker/odoo16-stack/config`                     | Git-tracked config for development and sharing        | Use during development or to provide a default template in your GitHub repo    |
| `https://github.com/erjeve/odoo16-stack/tree/main/config` | Same as above, via GitHub                             | Used by anyone cloning or deploying the stack via Git                          |
| `/volume1/docker/odoo/config`                             | Secure host-managed config                            | Use in production to override config with strong credentials, mounted via bind |
| `/data/compose/<stack_id>/config`                         | Temporary folder Portainer uses to clone Git stack    | Used internally by Portainer (ignore for manual setup)                         |
| `/volume1/@docker/volumes/odoo_config/_data`              | Docker-managed storage for named volume `odoo_config` | Used when mounting `odoo_config:/etc/odoo` in compose                          |

---

## 🔁 Recommended Workflow: Development → Production

### 🔧 Development (Local or Testing)

- Use the Git-tracked `config/odoo.conf`
- Compose mounts:
  
  ```yaml
  volumes:
    - odoo_config:/etc/odoo
  ```
- Passwords in config:
  
  ```ini
  admin_passwd = admin
  ```
- PostgreSQL password via `.env`:
  
  ```env
  ODOO_DB_USER=odoo
  ODOO_DB_PASSWORD=odoo
  ```

### 🚀 Switch to Production (Secure Credentials)

#### Option A: Use Host-Mounted Secure Config

1. Place secure `odoo.conf` in:
   
   ```
   /volume1/docker/odoo/config/odoo.conf
   ```
2. Update compose:
   
   ```yaml
   - /volume1/docker/odoo/config:/etc/odoo:ro
   ```
3. Use a strong `admin_passwd`.

#### Option B: Preload Named Volume (`odoo_config`)

1. Inspect volume:
   
   ```bash
   docker volume inspect odoo_config
   ```
2. Copy secure `odoo.conf` into:
   
   ```
   /volume1/@docker/volumes/odoo_config/_data/
   ```

---

## 🔐 Changing Passwords

### PostgreSQL User Password (`ODOO_DB_PASSWORD`)

1. Run inside your NAS shell:

```bash
docker exec -it odoo-db psql -U postgres
ALTER USER odoo WITH PASSWORD 'NewStrongPassword!';
```

2. Update `.env` or Portainer stack with:

```env
ODOO_DB_PASSWORD=NewStrongPassword!
```

3. Restart Odoo:

```bash
docker restart odoo16
```

---

### Odoo Superadmin Password (`admin_passwd`)

1. Edit `odoo.conf`:
   
   ```ini
   admin_passwd = YourNewSuperSecret!
   ```
2. Restart Odoo:
   
   ```bash
   docker restart odoo16
   ```

This password is used for database creation & management in `/web/database/manager`.

---
