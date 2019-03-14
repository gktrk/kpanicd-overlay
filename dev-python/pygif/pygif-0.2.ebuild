# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )
inherit distutils-r1

DESCRIPTION="Python encoder and decoder for the GIF file format."
HOMEPAGE="https://github.com/robert-ancell/pygif"
SRC_URI="https://github.com/robert-ancell/pygif/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # TODO, because I'm lazy

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${DEPEND}"
