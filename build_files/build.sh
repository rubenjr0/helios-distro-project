#!/bin/bash

set -ouex pipefail

# https://github.com/R-Dson/bazzite-based-cosmic-nvidia/
dnf5 remove -y xwaylandvideobridge
dnf5 group info kde-desktop | \
    sed -n '/^Mandatory packages\s*:/,/^\(Default\|Optional\) packages\s*:/ {
        /^\(Default\|Optional\) packages\s*:/q  # Quit if we hit Default/Optional header
        s/^.*:[[:space:]]*//p
    }' | \
    xargs dnf5 remove -y


dnf5 clean all && \
rm -rf /var/cache/dnf/*

dnf5 group install -y cosmic-desktop

dnf5 clean all && \
rm -rf /var/cache/dnf/*

### Enable services
systemctl disable display-manager && systemctl enable cosmic-greeter.service -f
systemctl enable podman.socket
