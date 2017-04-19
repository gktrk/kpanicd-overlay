# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="M-Sim is a multi-threaded microarchitectural simulation environment."
HOMEPAGE="https://www.cs.binghamton.edu/~msim/"
LICENSE="SimpleScalar"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

MY_P="${PN}_v${PV}"
SRC_URI="https://www.cs.binghamton.edu/~msim/dwnld/v2/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/${P}-extern-keyword-fix.patch
		"${FILESDIR}"/${P}-fix-compiler-warnings.patch
	)
	default

	# Refer to sysprobe with its absolute path
	sed -i -e "s:[.][/]sysprobe:\$\{S\}/sysprobe:" Makefile || die

	if ! use debug; then
		sed -i \
			-e "s:-DDEBUG::" Makefile \
			-e "s:-g::" Makefile || die
	fi
}

src_compile() {
	# We don't support parallel compiling
	MAKEOPTS="${MAKEOPTS} -j1"

	emake
}

src_install() {
	dobin sim-outorder

	dodoc README
}
