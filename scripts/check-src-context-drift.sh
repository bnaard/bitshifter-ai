#!/usr/bin/env bash
# Validate the release mirror when this repository ships one.
#
# Derived projects keep local process context in context/ but do not ship a
# src/context/ release mirror. In that layout there is no release-boundary
# comparison to perform.
set -euo pipefail

if [[ ! -d context || ! -d src/context ]]; then
  exit 0
fi

diff -rq context src/context \
  --exclude='INDEX.md' \
  --exclude='logs' \
  --exclude='migrations' \
  --exclude='team' \
  --exclude='team-members' \
  --exclude='workitems' \
  --exclude='decisions' \
  --exclude='artifacts' \
  --exclude='bindings' \
  --exclude='discussions' \
  --exclude='roles' \
  --exclude='gates' \
  --exclude='actors' \
  --exclude='notes'
