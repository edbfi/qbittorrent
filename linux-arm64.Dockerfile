# syntax=docker/dockerfile:1
# check=skip=InvalidDefaultArgInFrom
ARG UPSTREAM_IMAGE
ARG UPSTREAM_TAG_SHA
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 8080
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="8080/tcp" LIBTORRENT="v2"

RUN ln -s "${CONFIG_DIR}" "${APP_DIR}/qBittorrent"

ARG VERSION_LIB1
ARG VERSION_LIB2
RUN curl -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${VERSION_LIB1%%/*}/aarch64-qbittorrent-nox" > "${APP_DIR}/qbittorrent-nox-lib1" && \
    echo "f1bd268e48abcab7ab0b558ffba7a9ca9da612e989344c7dbbe0c81316fb19ba  ${APP_DIR}/qbittorrent-nox-lib1" | sha256sum -c - && \
    chmod 755 "${APP_DIR}/qbittorrent-nox-lib1" && \
    curl -fsSL "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${VERSION_LIB2%%/*}/aarch64-qbittorrent-nox" > "${APP_DIR}/qbittorrent-nox-lib2" && \
    echo "de4239e0c8683e26b970c25e1fe27fb6336635300553f8f0bda2d60299f60ed1  ${APP_DIR}/qbittorrent-nox-lib2" | sha256sum -c - && \
    chmod 755 "${APP_DIR}/qbittorrent-nox-lib2"

ARG VUETORRENT_VERSION
RUN curl -fsSL "https://github.com/vuetorrent/vuetorrent/releases/download/v${VUETORRENT_VERSION}/vuetorrent.zip" > "/tmp/vuetorrent.zip" && \
    echo "6e0c0e6acb563710aaf32cd165cf34da0e5d61bc1a68386e4cf97a648fa8171c  /tmp/vuetorrent.zip" | sha256sum -c - && \
    unzip "/tmp/vuetorrent.zip" -d "${APP_DIR}" && \
    rm "/tmp/vuetorrent.zip" && \
    chmod -R u=rwX,go=rX "${APP_DIR}/vuetorrent"

COPY root/ /
RUN find /etc/s6-overlay/s6-rc.d -name "run*" -execdir chmod +x {} +
