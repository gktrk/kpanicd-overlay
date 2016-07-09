# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Flexible File System Benchmark"
HOMEPAGE="shttp://ffsb.sourceforge.net/"

MY_P="${PN}-${PV/_/-}"
SRC_URI="https://downloads.sourceforge.net/${PN}/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2+"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

src_install() {
	defaulte

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins examples/*
	fi
}
