# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

MY_PN="processor-trace"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Intel Processor Trace decoding library"
HOMEPAGE="https://github.com/01org/processor-trace"
SRC_URI="https://github.com/01org/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://dev.gentoo.org/~gokturk/distfiles/${CATEGORY}/${PN}/${P}-man.tar.xz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="coverage tools"

DEPEND="tools? ( dev-libs/intel-xed )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DPTDUMP=$(usex tools ON OFF)
		-DPTXED=$(usex tools ON OFF)
		-DGCOV=$(usex coverage ON OFF)
		-DMAN=OFF # We fetch the prebuilt man pages from devspace
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doman man/*/*
	if use tools; then
		dobin "${BUILD_DIR}"/bin/{ptdump,ptxed}
	fi
}
