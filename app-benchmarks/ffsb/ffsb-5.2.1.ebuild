# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Flexible File System Benchmark"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="https://ffsb.sourceforge.net/"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2+"
IUSE="doc examples"

src_install() {
	default

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
