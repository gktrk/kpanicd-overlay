# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="GUI tool for configuring PIV-enabled Yubikey"
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="
	mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc test"

RDEPEND="
	app-crypt/yubico-piv-tool
	dev-python/pyside[${PYTHON_USEDEP},X]
	dev-python/pycrypto[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose-exclude[${PYTHON_USEDEP}] )"

PATCHES=(
	# PySide does not distribute egg-info, so remove it from deps
	"${FILESDIR}"/${PN}-fix-pyside-requirement.patch
)

DOCS=( NEWS README )

python_test() {
	# nosetests cannot handle the presence of a dir named 'setup'
	# See https://code.google.com/p/python-nose/issues/detail?id=320
	nosetests --exclude-dir=pivman/yubicommon/setup || die
}

python_install_all() {
	distutils-r1_python_install_all

	doman man/pivman.1
	use doc && dodoc doc/*

	domenu resources/pivman.desktop
	doicon resources/pivman.xpm
	newicon -s 128 resources/yubikey-piv-manager.png pivman.png
}
