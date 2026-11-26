#!/usr/bin/env bash
# sync.sh - Helper script to stage, commit, and push .msch schematic files
# Usage: ./.scripts/sync.sh ["custom commit message"]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not a git repository. Run 'git init' first.${NC}"
    exit 1
fi

# Check if remote is configured
if ! git remote | grep -q '^origin$'; then
    echo -e "${RED}Error: No 'origin' remote configured.${NC}"
    echo "Run: git remote add origin <your-github-repo-url>"
    exit 1
fi

# Check for .msch file changes using git status (handles new, modified, deleted)
# Use git status without pathspec to catch deletions too, then filter for .msch
changes=$(git status --porcelain | grep -E '\.msch$' | wc -l)

if [[ $changes -eq 0 ]]; then
    echo -e "${YELLOW}No .msch file changes detected in schematics/. Nothing to sync.${NC}"
    exit 0
fi

# Stage all .msch changes (new, modified, deleted)
echo -e "${GREEN}Staging .msch files from schematics/...${NC}"
git add -A -- schematics/

# Determine commit message
if [[ $# -gt 0 ]]; then
    commit_msg="$1"
else
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    commit_msg="Update schematics - $timestamp"
fi

# Commit
echo -e "${GREEN}Committing: $commit_msg${NC}"
git commit -m "$commit_msg"

# Push
echo -e "${GREEN}Pushing to origin...${NC}"
git push origin HEAD

echo -e "${GREEN}Done!${NC}"