#!/bin/sh
set -eu

VOLUME_PATH="/codex"
REMOTE_USER_NAME="${_REMOTE_USER:-${_CONTAINER_USER:-root}}"
REMOTE_USER_HOME="${_REMOTE_USER_HOME:-${_CONTAINER_USER_HOME:-/root}}"
CODEX_HOME="${REMOTE_USER_HOME}/.codex"

echo "Configuring shared Codex storage for ${REMOTE_USER_NAME}"

mkdir -p "${VOLUME_PATH}" "${REMOTE_USER_HOME}"

# Preserve Codex state that a base image may already contain. Docker copies the
# resulting /codex directory into the named volume when that volume is empty.
if [ -d "${CODEX_HOME}" ] && [ ! -L "${CODEX_HOME}" ]; then
    cp -a "${CODEX_HOME}/." "${VOLUME_PATH}/"
    rm -rf "${CODEX_HOME}"
elif [ -e "${CODEX_HOME}" ] || [ -L "${CODEX_HOME}" ]; then
    rm -rf "${CODEX_HOME}"
fi

ln -s "${VOLUME_PATH}" "${CODEX_HOME}"

if id "${REMOTE_USER_NAME}" >/dev/null 2>&1; then
    REMOTE_GROUP_NAME="$(id -gn "${REMOTE_USER_NAME}")"
    chown -R "${REMOTE_USER_NAME}:${REMOTE_GROUP_NAME}" "${VOLUME_PATH}"
    chown -h "${REMOTE_USER_NAME}:${REMOTE_GROUP_NAME}" "${CODEX_HOME}"
fi

