#!/usr/bin/env bash

set -e

SUBMODULE_PATH="$1"

if [[ -z "$SUBMODULE_PATH" ]]; then
    echo "Usage: $0 <submodule-path>"
    exit 1
fi

echo "➡️  Removing submodule: $SUBMODULE_PATH"

# Remove submodule from .gitmodules
if git config -f .gitmodules --get-regexp "submodule.$SUBMODULE_PATH" &>/dev/null; then
    git config -f .gitmodules --remove-section "submodule.$SUBMODULE_PATH" || true
    echo "✔️  Removed submodule from .gitmodules"
else
    echo "⚠️  No entry in .gitmodules for $SUBMODULE_PATH"
fi

# Remove submodule from .git/config
if git config -f .git/config --get-regexp "submodule.$SUBMODULE_PATH" &>/dev/null; then
    git config -f .git/config --remove-section "submodule.$SUBMODULE_PATH" || true
    echo "✔️  Removed submodule from .git/config"
else
    echo "⚠️  No entry in .git/config for $SUBMODULE_PATH"
fi

# Remove from git index if path exists
if [[ -e "$SUBMODULE_PATH" || -d "$SUBMODULE_PATH" ]]; then
    git rm --cached "$SUBMODULE_PATH"
    echo "✔️  Removed $SUBMODULE_PATH from git index"
else
    echo "⚠️  $SUBMODULE_PATH does not exist in working directory, skipping git rm"
fi

# Clean up empty submodule dir if present
rm -rf "$SUBMODULE_PATH"

# Stage .gitmodules if it was changed
if git ls-files --modified | grep -q .gitmodules; then
    git add .gitmodules
fi

# Commit if anything changed
if ! git diff --cached --quiet; then
    git commit -m "Removed submodule $SUBMODULE_PATH"
    echo "✅ Committed submodule removal"
else
    echo "ℹ️  Nothing to commit"
fi
