# qBittorrent container

Based on [hotio/qbittorrent](https://github.com/hotio/qbittorrent), with libtorrent v2 selected by default and VueTorrent bundled in `/app/vuetorrent`. Set `LIBTORRENT=v1` to use the retained alternative binary.

[Documentation and examples](https://web.edb.fi/containers/qbittorrent/).

Downloaded binaries and VueTorrent assets are checked against pinned SHA-256 digests. Version updates must update these digests together.

Upstream runtime user, configuration paths and VPN support remain intact.

Image build sources retain their GPL-3.0 license. qBittorrent, its dependencies and VueTorrent retain their respective upstream licenses.
