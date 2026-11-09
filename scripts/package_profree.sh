#!/bin/sh
# Build a zip archive of the project suitable for uploading to a shared host
# Usage: run from the project root; resulting archive will be chamilo-profree.zip

set -e

# ensure vendor and assets exist
composer install --no-dev --optimize-autoloader
npm run build

TMPDIR=$(mktemp -d)

# copy everything except node_modules, .git, var/cache, var/logs (can be regenerated)
rsync -av --exclude='node_modules' --exclude='.git' --exclude='var/cache' \
      --exclude='var/logs' --exclude='var/sessions' . "$TMPDIR/project"

# if .env exists, copy but warn
if [ -f .env ]; then
    cp .env "$TMPDIR/project/"
fi

cd "$TMPDIR/project"
zip -r ../../chamilo-profree.zip .

echo "Created archive chamilo-profree.zip"

echo "Upload the ZIP contents to your ProFreeHost public_html directory."

# cleanup
rm -rf "$TMPDIR"
