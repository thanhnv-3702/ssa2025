#!/usr/bin/env bash
# Quick staging API smoke — requires VPN + credentials in .stag.env
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="${ENV_FILE:-$ROOT/app/packages/https/.stag.env}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE — copy from .env.example"
  exit 1
fi

# shellcheck disable=SC1090
source <(grep -E '^(BASE_URL|API_BASIC_AUTH_USER|API_BASIC_AUTH_PASSWORD)=' "$ENV_FILE" | sed 's/^/export /')

BASE_URL="${BASE_URL%/}"
AUTH=()
if [[ -n "${API_BASIC_AUTH_USER:-}" && -n "${API_BASIC_AUTH_PASSWORD:-}" ]]; then
  AUTH=(-u "${API_BASIC_AUTH_USER}:${API_BASIC_AUTH_PASSWORD}")
fi

echo "== SAA staging smoke: $BASE_URL =="

code=$(curl -sS -o /dev/null -w "%{http_code}" "${AUTH[@]}" "${BASE_URL}/apis/default/api/awards" || echo "000")
echo "GET /awards (no token): HTTP $code (expect 401/403)"

code=$(curl -sS -o /dev/null -w "%{http_code}" "${AUTH[@]}" "${BASE_URL}/apis/default/api/kudos/hub" || echo "000")
echo "GET /kudos/hub (no token): HTTP $code (expect 401/403)"

echo "Done. For full flow: flutter run --dart-define=ENV=stag with valid Google + BE login."
