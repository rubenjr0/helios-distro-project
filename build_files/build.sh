#!/bin/bash

set -ouex pipefail

# https://github.com/R-Dson/bazzite-based-cosmic-nvidia/
dnf5 remove -y xwaylandvideobridge
dnf5 group remove -y kde-desktop


dnf5 clean all && \
rm -rf /var/cache/dnf/*

dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 group install -y cosmic-desktop

dnf5 -y upgrade --refresh

dnf5 clean all && \
rm -rf /var/cache/dnf/*

### Enable services
systemctl disable display-manager && systemctl enable cosmic-greeter.service -f
systemctl enable podman.socket
