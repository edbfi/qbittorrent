# qBittorrent container

Based on [hotio/qbittorrent](https://github.com/hotio/qbittorrent), with libtorrent v2 selected by default and VueTorrent bundled in `/app/vuetorrent`. Set `LIBTORRENT=v1` to use the retained alternative binary.

[Documentation and examples](https://web.edb.fi/containers/qbittorrent/).

Images are built and tested natively for amd64 and arm64. Publication is manual after reviewed CI. Downloaded binaries and VueTorrent assets are checked against pinned SHA-256 digests. Version updates must update these digests together.

Upstream runtime user, configuration paths and VPN support remain intact. CI tests application startup and web APIs without a VPN; live VPN connectivity and torrent transfer require separate integration validation.

Image build sources retain their GPL-3.0 license. qBittorrent, its dependencies and VueTorrent retain their respective upstream licenses.

Shared CI and Renovate presets use automation `v3.0.0`. The custom checked merger
is retired. Renovate automerge is explicitly disabled pending verified required
CI enforcement and a native Renovate canary. The read-only PR policy check
preserves sign-offs, Conventional Commit titles, review and hold requirements.
Native architecture builds and every existing container smoke assertion remain
mandatory; image publication remains an explicit manual operation after CI.
