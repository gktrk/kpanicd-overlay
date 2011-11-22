# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="M-Sim is a multi-threaded microarchitectural simulation environment."
HOMEPAGE="http://www.cs.binghamton.edu/~msim/"
LICENSE="SimpleScalar"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
RDEPEND=""

MY_P="${PN}_v${PV}"
SRC_URI="http://www.cs.binghamton.edu/~msim/dwnld/v2/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-extern-keyword-fix.patch
	epatch "${FILESDIR}"/${P}-fix-compiler-warnings.patch

	# Refer to sysprobe with its absolute path
	sed -i -e "s:[.][/]sysprobe:\$\{S\}/sysprobe:" Makefile

	if ! use debug; then
		sed -i -e "s:-DDEBUG::" Makefile
		sed -i -e "s:-g::" Makefile
	fi
}

src_compile() {
	# We don't support parallel compiling
	MAKEOPTS="${MAKEOPTS} -j1"

	emake || die
}

src_install() {
	exeinto "/usr/bin"
	doexe sim-outorder || die

	dodoc README
}
