#!/bin/bash
PROG_PATH=${PROG_PATH:-$(readlink -e $0)}
PROG_DIR=${PROG_DIR:-$(dirname ${PROG_PATH})}
PROG_NAME=${PROG_NAME:-$(basename ${PROG_PATH})}
APT_CMD=apt-get
FAILED_EXIT_CODE=127

# Depends on 020_set_dns.sh and 025_apt_update.sh

REQUIRED_PKGS="grub-efi-ia32-bin grub-efi-amd64-bin grub-pc-bin efibootmgr"
echo "Installing $REQUIRED_PKGS"
DEBIAN_FRONTEND=noninteractive $APT_CMD install -y --no-install-recommends --no-install-suggests $REQUIRED_PKGS 1>/dev/null 2>&1 || {
    echo "Install failed: $MISSING_PKGS"
    exit $FAILED_EXIT_CODE
}
dpkg -l $REQUIRED_PKGS 2>/dev/null | sed -e '1,5d' | awk '{print $1, $2}' | sed -e 's/^/    /'
