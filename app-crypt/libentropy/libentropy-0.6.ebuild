# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Set of library and tools for measuring information characteristics"
HOMEPAGE="https://github.com/gktrk/libentropy"
LICENSE="GPL-3+"
SLOT="0"
IUSE="e2ntropy static-libs"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gktrk/libentropy.git"
else
	SRC_URI="https://github.com/gktrk/libentropy/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

RDEPEND="
	e2ntropy? ( >=sys-libs/e2fsprogs-libs-1.43.3 )
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local -a myeconfargs=(
		$(use_enable static-libs static)
		$(use_enable e2ntropy)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
