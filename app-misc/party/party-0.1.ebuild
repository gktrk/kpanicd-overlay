# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="This is the best thing you will ever witness"
HOMEPAGE="https://github.com/zekeby/party"
SRC_URI="https://github.com/zekeby/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/python"

src_install() {
	dobin party.py
}
