# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2"

inherit python eutils

DESCRIPTION="Disper is an on-the-fly display switch utility."
HOMEPAGE="http://willem.engen.nl/projects/disper/"
SRC_URI="http://ppa.launchpad.net/disper-dev/ppa/ubuntu/pool/main/d/disper/${PN}_${PV}.tar.gz"
LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl
		sys-apps/help2man"
RDEPEND=">=dev-python/pygtk-2.0"

S="${WORKDIR}/${PN}cur"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-handle-help-version-opts-explicitly.patch"
	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	python_mod_optimize "${ROOT}usr/share/disper/src"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}usr/share/disper/src"
}
