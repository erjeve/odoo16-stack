#!/bin/bash

# This script installs or refreshes OCA community modules into the odoo_addons Docker volume.
# Make sure to run it from a shell on your Synology NAS with access to Docker volumes.

ADDONS_PATH="/volume1/@docker/volumes/odoo_addons/_data"

echo "📦 Updating addons in: $ADDONS_PATH"
cd "$ADDONS_PATH" || exit 1

# Clone or pull each repo
for repo in \
    "https://github.com/OCA/l10n-netherlands.git" \
    "https://github.com/OCA/account-financial-tools.git" \
    "https://github.com/OCA/account-invoicing.git"
do
    folder=$(basename "$repo" .git)
    if [ -d "$folder" ]; then
        echo "🔄 Updating $folder..."
        cd "$folder" && git pull && cd ..
    else
        echo "⬇️ Cloning $folder..."
        git clone "$repo"
    fi
done

echo "✅ Done. Restart the odoo container to load new modules:"
echo "    docker restart odoo16"
