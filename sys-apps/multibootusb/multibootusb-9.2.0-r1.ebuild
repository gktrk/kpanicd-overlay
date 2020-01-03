# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A cross platform utility to create multi boot live Linux on a removable media"
HOMEPAGE="https://github.com/mbusb/multibootusb"
SRC_URI="https://github.com/mbusb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
QA_PREBUILT='usr/share/multibootusb/data/multibootusb/grub/*'

DEPEND=""
RDEPEND="
	app-arch/p7zip
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/progressbar[${PYTHON_USEDEP}]
	dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]
	dev-python/pyudev[qt5,${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/util-linux
	sys-block/parted
	sys-fs/e2fsprogs
	sys-fs/mtools
"

PATCHES=(
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
