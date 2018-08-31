#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

sh_cmd="${DIR}/../docoptsh"
python_cmd="${DOTFILES}/scripts/core/docopts"

docoptsh() {
  local readonly doc="$1"
  shift
  "$sh_cmd" -h "$doc" : "$@"
}

docopt() {
  local readonly doc="$1"
  shift
  "$python_cmd" -h "$doc" : "$@" 
}

doc="$(cat "$DIR/docs/ship.txt")"

docoptsh "$doc" move 10 30
# docopt "$doc" move 10 30

