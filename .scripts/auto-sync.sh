#!/usr/bin/env bash
# auto-sync.sh - Watches for .msch file changes and auto-commits/pushes
# Run in background: ./.scripts/auto-sync.sh &
# Stop with: pkill -f auto-sync.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "🔄 Auto-sync started. Watching for .msch changes in $REPO_DIR/schematics"
echo "   Stop with: pkill -f auto-sync.sh"

# Watch for create/modify/delete/move of .msch files
inotifywait -m -r -e close_write,moved_to,delete,moved_from --format '%w%f %e' --include '\.msch$' schematics/ | while read -r file event; do
    echo "[$(date '+%H:%M:%S')] Detected: $event on $file"

    # Small delay to let file settle
    sleep 0.5

    # Run sync.sh (will exit cleanly if no changes)
    .scripts/sync.sh "Auto-sync: $event on $(basename "$file")" || true
done