# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A CLI utility to control media players over MPRIS"
HOMEPAGE="https://github.com/acrisci/playerctl"
SRC_URI="https://github.com/acrisci/playerctl/releases/download/v${PV}/${P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="
	dev-libs/glib:2
	dev-util/gdbus-codegen
"
DEPEND="${RDEPEND}"

src_compile() {
	emake -j1
}
