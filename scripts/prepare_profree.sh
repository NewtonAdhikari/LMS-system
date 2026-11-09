#!/bin/sh
# helper script for preparing a ProFreeHost deployment
# usage: run this locally before uploading the tree to the host

if [ ! -f .env.profree ]; then
    echo "Template .env.profree not found!" >&2
    exit 1
fi

cp .env.profree .env
cat <<'EOF'
Copied .env.profree to .env.
Edit .env and replace placeholder values with the credentials
provided by ProFreeHost (database name/user/password, APP_SECRET, etc).

After uploading, run the installer via your browser, then set APP_INSTALLED=1
in .env to complete the process.
EOF
