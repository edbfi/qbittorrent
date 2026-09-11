#!/usr/bin/env bash
set -euo pipefail
image="$1"
evidence="$2"
bash tools/base-smoke.sh "$image" "$evidence"
expected="v$(jq -r .version meta.json)"
for lib in 1 2; do
  docker run --rm --entrypoint "/app/qbittorrent-nox-lib$lib" "$image" --version > "$evidence/version-lib$lib.txt"
  grep -Fx "qBittorrent $expected" "$evidence/version-lib$lib.txt"
done
name="qbittorrent-smoke-${GITHUB_RUN_ID:-local}-${RANDOM}"
config=$(mktemp -d)
cleanup() {
  docker logs "$name" 2>&1 | sed -E 's/(temporary password[^:]*:).*/\1 [REDACTED]/' > "$evidence/qbittorrent.log" || true
  docker rm -f "$name" >/dev/null 2>&1 || true
  # The image owns this disposable test directory as UID 1000.
  docker run --rm --entrypoint sh -v "$config:/test-config" "$image" -c 'rm -rf /test-config/*' >/dev/null 2>&1 || true
  rmdir "$config" || true
}
trap cleanup EXIT
# Permit loopback API access only in this disposable test configuration.
# Disable peer discovery; no torrents are added by this test.
mkdir -p "$config/config"
cat > "$config/config/qBittorrent.conf" <<'CONFIG'
[Preferences]
WebUI\LocalHostAuth=false
[BitTorrent]
Session\DHTEnabled=false
Session\LSDEnabled=false
Session\PeXEnabled=false
CONFIG
for mode in default v1; do
  opts=()
  if [[ "$mode" == v1 ]]; then opts+=(-e LIBTORRENT=v1); fi
  docker run --detach --name "$name" -v "$config:/config" -e VPN_ENABLED=false "${opts[@]}" "$image"
  ready=false
  for _ in {1..60}; do
    if docker exec "$name" curl -fsS http://127.0.0.1:8080/api/v2/app/version > "$evidence/api-version-$mode.txt"; then ready=true; break; fi
    sleep 1
  done
  test "$ready" = true
  test "$(cat "$evidence/api-version-$mode.txt")" = "$expected"
  docker exec "$name" curl -fsS http://127.0.0.1:8080/api/v2/app/buildInfo > "$evidence/build-info-$mode.json"
  if [[ "$mode" == default ]]; then lib_version='2.0.14'; else lib_version='1.2.20'; fi
  jq -e --arg v "$lib_version" '.libtorrent | startswith($v)' "$evidence/build-info-$mode.json"
  docker exec "$name" curl -fsS http://127.0.0.1:8080/ > "$evidence/http-$mode.html"
  grep -qi qbittorrent "$evidence/http-$mode.html"
  docker exec "$name" sh -ec 'test "$(stat -c %u /config/config/qBittorrent.conf)" = 1000; test -f /app/vuetorrent/public/index.html'
  if [[ "$mode" == default ]]; then
    docker exec "$name" curl -fsS --data-urlencode 'json={"alternative_webui_enabled":true,"alternative_webui_path":"/app/vuetorrent"}' http://127.0.0.1:8080/api/v2/app/setPreferences
    docker exec "$name" curl -fsS http://127.0.0.1:8080/ > "$evidence/vuetorrent.html"
    grep -qi vuetorrent "$evidence/vuetorrent.html"
    docker exec "$name" curl -fsS --data-urlencode 'json={"alternative_webui_enabled":false}' http://127.0.0.1:8080/api/v2/app/setPreferences
  fi
  docker logs "$name" 2>&1 | sed -E 's/(temporary password[^:]*:).*/\1 [REDACTED]/' > "$evidence/qbittorrent-$mode.log"
  docker rm -f "$name" >/dev/null
 done
printf 'Default libtorrent v2, optional v1, version/build APIs, VueTorrent HTTP and configuration ownership passed.\n' >> "$evidence/result.txt"
