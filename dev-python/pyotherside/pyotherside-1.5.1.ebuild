# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit qmake-utils python-single-r1

DESCRIPTION="Asynchronous Python 3 Bindings for Qt 5"
HOMEPAGE="https://github.com/thp/pyotherside http://thp.io/2011/pyotherside/"
SRC_URI="https://github.com/thp/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # Requires hardware access

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 PYTHON_CONFIG="$(python_get_PYTHON_CONFIG)"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
