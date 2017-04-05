# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="yajl-py is a pure python wrapper to the yajl C Library"
HOMEPAGE="http://pykler.github.io/yajl-py/"
SRC_URI="mirror://pypi/y/${PN}/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/yajl:="
RDEPEND="${DEPEND}"
