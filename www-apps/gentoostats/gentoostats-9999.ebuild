# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit webapp git-r3

DESCRIPTION="Package statistics server"
HOMEPAGE="https://soc.dev.gentoo.org/gentoostats/"
SRC_URI=""

EGIT_REPO_URI="git://anongit.gentoo.org/proj/gentoostats.git"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/webpy-0.3
	dev-python/mysql-python
	dev-python/matplotlib"

src_install() {
	webapp_src_preinst
	dodoc docs/server.txt
	pushd "server" &>/dev/null || die

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	webapp_src_install
}
