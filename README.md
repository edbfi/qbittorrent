<p align="center">
  <img src="assets/qbittorrent.svg" alt="qbittorrent logo" width="160" height="160">
</p>
<h1 align="center">qbittorrent</h1>
<p align="center"><strong>qBittorrent and VueTorrent in a VPN-ready container.</strong></p>
<p align="center">
  <a href="https://github.com/edbfi/qbittorrent/blob/release/LICENSE" title="Image build sources license"><img src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat" alt="Image build sources license: GPL-3.0"></a>
  <a href="https://github.com/moby/moby" title="Moby source, the open-source foundation of Docker Engine"><img src="https://img.shields.io/badge/Docker-2496ED?style=flat&amp;logo=docker&amp;logoColor=white" alt="Docker"></a>
  <a href="https://github.com/qbittorrent/qBittorrent" title="qBittorrent source"><img src="https://img.shields.io/badge/qBittorrent-2F67BA?style=flat&amp;logo=qbittorrent&amp;logoColor=white" alt="qBittorrent"></a>
  <a href="https://github.com/VueTorrent/VueTorrent" title="VueTorrent source"><img src="https://img.shields.io/badge/VueTorrent-42B883?style=flat" alt="VueTorrent"></a>
  <a href="https://github.com/edbfi/qbittorrent/actions/workflows/call-build.yml?query=branch%3Arelease"><img src="https://img.shields.io/github/actions/workflow/status/edbfi/qbittorrent/call-build.yml?branch=release&amp;event=push&amp;label=CI&amp;style=flat" alt="CI"></a>
</p>

Based on [hotio/qbittorrent](https://github.com/hotio/qbittorrent), with libtorrent v2 selected by default and VueTorrent bundled in `/app/vuetorrent`. Set `LIBTORRENT=v1` to use the alternative binary.

[Documentation and examples](https://web.edb.fi/containers/qbittorrent/).
