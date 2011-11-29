# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="Flexible File System Benchmark"
HOMEPAGE="http://ffsb.sourceforge.net/"

MY_P="${PN}-${PV/_/-}"
SRC_URI="http://downloads.sourceforge.net/${PN}/${MY_P}.tar.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR=${D} install
	dodoc AUTHORS README ChangeLog

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins examples/*
	fi
}
