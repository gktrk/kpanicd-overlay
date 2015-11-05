# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
inherit eutils

DESCRIPTION="Flexible File System Benchmark"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://ffsb.sourceforge.net/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc examples"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README ChangeLog USAGE

	if use doc; then
		dodoc using.tex
	fi

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins examples/*
		insinto /usr/share/${PN}/profile
		doins profile/*
		insinto /usr/share/${PN}/profile_bm
		doins profile_bm/*
		insinto /usr/share/${PN}/random-profiles
		doins random-profiles/*
	fi
}
