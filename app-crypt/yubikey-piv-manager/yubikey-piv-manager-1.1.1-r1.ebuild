# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="GUI tool for configuring PIV-enabled Yubikey"
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND="
	app-crypt/yubico-piv-tool
	dev-python/pyside[${PYTHON_USEDEP},X]
	dev-python/pycrypto[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc )
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=(
	# PySide does not distribute egg-info, so remove it from deps
	"${FILESDIR}"/${PN}-fix-pyside-requirement.patch
)

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc doc/*
}
