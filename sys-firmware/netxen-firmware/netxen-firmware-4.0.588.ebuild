# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Firmware for the Netxen NIC"
HOMEPAGE="http://ldriver.qlogic.com/firmware/netxen_nic"
SRC_URI="http://ldriver.qlogic.com/firmware/netxen_nic/4.0.588/netxen_firmware-4.0.588-1.noarch.rpm"

LICENSE="BSD" # According to: http://ldriver.qlogic.com/firmware/LICENSE
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/rpm2targz
	app-arch/tar"
S="${WORKDIR}"

src_unpack() {
	:;
}

src_install() {
	pushd "${ED}" &>/dev/null || die
	rpm2tar -O "${DISTDIR}/netxen_firmware-4.0.588-1.noarch.rpm" | tar x || die
	popd &>/dev/null || die
}
