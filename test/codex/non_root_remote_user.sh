#!/bin/bash
set -e

source dev-container-features-test-lib

check "remote user is non-root" test "$(id -u)" -ne 0
check "~/.codex is a symlink" test -L "${HOME}/.codex"
check "~/.codex resolves to /codex" test "$(readlink -f "${HOME}/.codex")" = "/codex"
check "Codex storage is writable" sh -c "touch '${HOME}/.codex/.feature-write-test' && rm '${HOME}/.codex/.feature-write-test'"

reportResults
