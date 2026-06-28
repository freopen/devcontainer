#!/bin/sh
set -eux

VOLUME_PATH="/codex"
REMOTE_USER_HOME="${_REMOTE_USER_HOME:-${_CONTAINER_USER_HOME:-/root}}"
CODEX_HOME="${REMOTE_USER_HOME}/.codex"

echo "Codex Feature variables:"
printf '  _REMOTE_USER=%s\n' "${_REMOTE_USER:-<unset>}"
printf '  _CONTAINER_USER=%s\n' "${_CONTAINER_USER:-<unset>}"
printf '  _REMOTE_USER_HOME=%s\n' "${_REMOTE_USER_HOME:-<unset>}"
printf '  _CONTAINER_USER_HOME=%s\n' "${_CONTAINER_USER_HOME:-<unset>}"
printf '  VOLUME_PATH=%s\n' "${VOLUME_PATH}"
printf '  REMOTE_USER_HOME=%s\n' "${REMOTE_USER_HOME}"
printf '  CODEX_HOME=%s\n' "${CODEX_HOME}"

echo "Configuring shared Codex storage at ${CODEX_HOME}"

mkdir -p "${VOLUME_PATH}" "${REMOTE_USER_HOME}"
chmod 0777 "${VOLUME_PATH}"

rm -rf "${CODEX_HOME}"
ln -s "${VOLUME_PATH}" "${CODEX_HOME}"
