# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Command line tool for the YubiKey PIV application"
HOMEPAGE="https://developers.yubico.com/yubico-piv-tool/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

RDEPEND="
	dev-libs/openssl:0
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--disable-static \
		--with-backend=pcsc \
		$(use_enable debug ykcs11-debug)
}

src_install() {
	default
	prune_libtool_files
}
