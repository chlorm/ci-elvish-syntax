#!/usr/bin/env bash

set -o errexit
set -o pipefail

mapfile -t elvishFiles < <(find "$GITHUB_WORKSPACE" -name '*.elv' -print)

cd "$GITHUB_WORKSPACE"
fail=0
for i in "${elvishFiles[@]}"; do
    set +o errexit
    elvish -norc -compileonly "$i"
    # shellcheck disable=SC2181
    if [ $? -gt 0 ]; then
        fail=1
    fi
    capture="$(elvish -norc -deprecation-level 16 -compileonly "$i")"
    if [ -n "$(grep -o 'deprecation:')" ]; then
        fail=1
    fi
    set -o errexit
done

if [ $fail -eq 1 ]; then
    return 1
fi
