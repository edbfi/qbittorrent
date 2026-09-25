# qBittorrent container

Based on [hotio/qbittorrent](https://github.com/hotio/qbittorrent), with libtorrent v2 selected by default and VueTorrent bundled in `/app/vuetorrent`. Set `LIBTORRENT=v1` to use the retained alternative binary.

[Documentation and examples](https://web.edb.fi/containers/qbittorrent/).

Images are built and tested natively for amd64 and arm64. Publication is manual after reviewed CI. Downloaded binaries and VueTorrent assets are checked against pinned SHA-256 digests. Version updates must update these digests together.

Upstream runtime user, configuration paths and VPN support remain intact. CI tests application startup and web APIs without a VPN; live VPN connectivity and torrent transfer require separate integration validation.

Image build sources retain their GPL-3.0 license. qBittorrent, its dependencies and VueTorrent retain their respective upstream licenses.

Shared CI and Renovate presets use automation `v4.0.0`. Renovate owns dependency
PR merging through the shared `automerge.json` preset: it arms GitHub auto-merge
with the rebase strategy, preserving commit author sign-offs, and GitHub merges
only after every required check passes. Strict, GitHub Actions-sourced required
CI and PR policy checks must pass on an up-to-date branch; the automated merger
has no bypass. The read-only PR policy check preserves sign-offs, Conventional
Commit titles, reviews and hold labels. Independent policy events run to
completion without cancelling one another; after a pass, policy re-runs the other
event's older failed verdict for the same head. The shared release-age policy
remains active, and Renovate configuration updates require manual merging. The
custom checked merger remains retired.
Native architecture builds and every existing container smoke assertion remain
mandatory; image publication remains an explicit manual operation after CI.
