#!/usr/bin/env bash

rdlkf() { [ -L "$1" ] && (local lk="$(readlink "$1")"; local d="$(dirname "$1")"; cd "$d"; local l="$(rdlkf "$lk")"; ([[ "$l" = /* ]] && echo "$l" || echo "$d/$l")) || echo "$1"; }
DIR="$(dirname "$(rdlkf "$0")")/bin"
export PATH="$DIR:$PATH"
