#!/bin/bash
# Publish dashboard edits to the live site.
# 1. In the dashboard: Edit mode → make changes → "Publish changes" (downloads clients.enc.json)
# 2. Run this script:  ./publish.sh   (optionally pass the path to the downloaded file)
set -e
cd "$(dirname "$0")"
SRC="${1:-$HOME/Downloads/clients.enc.json}"
if [ ! -f "$SRC" ]; then
  echo "Couldn't find $SRC"
  echo "Click 'Publish changes' in the dashboard first (it downloads clients.enc.json), then re-run."
  exit 1
fi
cp "$SRC" ./clients.enc.json
git add clients.enc.json
git commit -m "Update client data ($(date +%Y-%m-%d))" || { echo "Nothing changed."; exit 0; }
git push
echo "✅ Published. Live in ~1 minute at https://prmt-it-sys.github.io/PromptQL/"
