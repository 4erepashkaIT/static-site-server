#!/usr/bin/env bash
# Deploy the site/ folder to the server with rsync.
# Usage: ./deploy.sh            (uses the SSH alias "srv1" from ~/.ssh/config)
#        SERVER=srv2 ./deploy.sh

set -euo pipefail

SERVER="${SERVER:-srv1}"
REMOTE_DIR="/var/www/igor-site/"

# Run from the folder where the script lives, wherever it was called from
cd "$(dirname "$0")"

if [ ! -f site/index.html ]; then
  echo "Error: site/index.html not found" >&2
  exit 1
fi

# Rule 2: Linux is case-sensitive. Stop if any file name has capitals or spaces (that's optionally, you can use capitals in names, but it's a good practice to avoid them).
bad_names=$(find site -name '*[A-Z ]*' ! -name '.DS_Store')
if [ -n "$bad_names" ]; then
  echo "Error: rename these to lowercase without spaces:" >&2
  echo "$bad_names" >&2
  exit 1
fi

# Rule 1: no absolute paths from the Mac.
if grep -rn '/Users/' site; then
  echo "Error: absolute Mac paths found above, use relative paths" >&2
  exit 1
fi

# The trailing slash on site/ matters: copy the CONTENTS of site/, not the folder itself.
# --delete removes files on the server that were deleted locally.
rsync -avz --delete --exclude '.DS_Store' site/ "${SERVER}:${REMOTE_DIR}"

echo "Deployed to ${SERVER}:${REMOTE_DIR}"
