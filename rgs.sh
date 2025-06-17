#!/usr/bin/env bash

set -e
SUBMODULE_PATH="$1"

git config -f .gitmodules --remove-section "submodule.$SUBMODULE_PATH"
git config -f .git/config --remove-section "submodule.$SUBMODULE_PATH" || true
git rm --cached "$SUBMODULE_PATH"
git commit -m "Removed submodule $SUBMODULE_PATH"
