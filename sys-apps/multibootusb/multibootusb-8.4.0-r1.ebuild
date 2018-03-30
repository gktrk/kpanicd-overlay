# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A cross platform utility to create multi boot live Linux on a removable media"
HOMEPAGE="https://github.com/mbusb/multibootusb"
SRC_URI="https://github.com/mbusb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	sys-apps/coreutils
	sys-apps/util-linux
	sys-fs/e2fsprogs
	sys-fs/mtools
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/pyudev[${PYTHON_USEDEP}]
	dev-python/progressbar[${PYTHON_USEDEP}]
	app-arch/p7zip
"

PATCHES=(
	"${FILESDIR}"/${P}-pyudev-fix.patch
	"${FILESDIR}"/${P}-remove-bundled-libs.patch
	"${FILESDIR}"/${P}-rename-package-module.patch
)

python_prepare_all() {
	distutils-r1_python_prepare_all

	# Rename the modules 'scripts' to 'multibootusb'
	mkdir bin || die
	mv multibootusb{,-pkexec} bin/ || die
	mv scripts multibootusb || die
}
