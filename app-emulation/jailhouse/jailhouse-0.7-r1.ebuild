# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info linux-mod

DESCRIPTION="Jailhouse is a partitioning Hypervisor based on Linux"
HOMEPAGE="https://github.com/siemens/jailhouse"
SRC_URI="https://github.com/siemens/jailhouse/archive/v0.7.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="
	dev-python/mako
"
RDEPEND="${DEPEND}"
DEPEND+="
	>=sys-devel/make-3.82
	doc? ( app-doc/doxygen )
"

src_compile() {
	set_arch_to_kernel
	emake all $(usex doc docs "")
}

src_install() {
	emake prefix="/usr" DESTDIR="${ED}" install

	insinto /usr/share/"${PF}"/demos/x86
	doins "${S}"/inmates/demos/x86/*.bin

	insinto /usr/share/"${PF}"/configs
	doins "${S}"/configs/*.cell

	if use doc; then
		insinto /usr/share/doc/"${PF}"
		doins -r "${S}"/Documentation/generated/html
	fi
	einstalldocs
}
