# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit flag-o-matic toolchain-funcs vcs-snapshot

COMMIT_HASH="4be523538891dbce908df8765bb2d88bf775d922"

DESCRIPTION="Quickly find encrypted files and files made-up of random data"
HOMEPAGE="https://github.com/stephenjudge/TCHunt"
SRC_URI="https://github.com/stephenjudge/TCHunt/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	dev-libs/boost:=[threads]
	x11-libs/fltk
"
RDEPEND="${DEPEND}"

src_prepare() {
	if use debug; then
		sed -e '/const static std::string mode =/ s/release/debug/' \
			-i TCHunt.cpp || die
	fi

	default
}

src_compile() {
	append-cxxflags $(fltk-config --cxxflags) -I "${EPREFIX}"/usr/include/boost
	append-ldflags $(fltk-config --ldflags)
	append-libs -lboost_filesystem -lboost_system -lboost_date_time -lboost_thread-mt
	$(tc-getCXX) ${CPPFLAGS} ${CXXFLAGS} -o ${PN} TCHunt.cpp ${LDFLAGS} ${LIBS}
}

src_install() {
	dobin ${PN}
	dodoc readme.txt
}
