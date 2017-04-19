# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools-utils

DESCRIPTION="Command line tool for the YubiKey PIV application"
HOMEPAGE="https://developers.yubico.com/yubico-piv-tool/"
SRC_URI="
	mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

RDEPEND="
	dev-libs/openssl:0
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog NEWS README )

src_configure() {
	local myeconfargs=(
		--disable-static
		--with-backend=pcsc
		$(use_enable debug ykcs11-debug)
	)
	autotools-utils_src_configure
}
