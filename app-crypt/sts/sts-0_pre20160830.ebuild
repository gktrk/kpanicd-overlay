# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic vcs-snapshot

STS_COMMIT_HASH="c4b45cc1b088ed138a520415a5fa7de24f8e75a9"

DESCRIPTION="NIST Statistical Test Suite"
HOMEPAGE="https://github.com/gktrk/sts"
SRC_URI="https://github.com/gktrk/sts/archive/${STS_COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_compile() {
	templates_dir="/usr/share/${PN}/templates"

	append-cflags "-DASSESS_TEMPLATES_DIR=\\\"${EPREFIX/}${templates_dir}\\\""
	emake assess
}

src_install() {
	dobin assess

	dodir "/usr/share/${PN}"
	exeinto "/usr/share/${PN}"
	doexe create-dir-script

	dodir "${templates_dir}"
	insinto "${templates_dir}"
	doins templates/*

	dodoc README.md
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Use the 'create-dir-script' script to populate testing dirs."
		elog "Otherwise assess will fail! For example:"
		elog "    $ ${EROOT}usr/share/${PN}/create-dir-script experiments"
		elog
	fi
}
