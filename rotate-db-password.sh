#!/bin/bash

# 🔐 This script updates the Odoo PostgreSQL user's password INSIDE the odoo-db container.
# Must be run from the host NAS terminal.

# Customize this:
NEW_DB_PASSWORD="ChangeThisToYourStrongPassword123!"

echo "🛠 Setting new PostgreSQL password for user 'odoo'..."

docker exec -it odoo-db psql -U postgres -c "ALTER USER odoo WITH PASSWORD '${NEW_DB_PASSWORD}';"

echo "✅ Done. Now update your .env or Portainer environment variables:"
echo "   ODOO_DB_PASSWORD=${NEW_DB_PASSWORD}"
echo "Then restart the Odoo container:"
echo "   docker restart odoo16"
