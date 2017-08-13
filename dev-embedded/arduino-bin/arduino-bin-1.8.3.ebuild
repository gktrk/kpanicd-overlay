# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg

MY_PN="${PN//-bin}"
DESCRIPTION="The Arduino Software (IDE) Binary Package"
HOMEPAGE="https://www.arduino.cc/en/Main/Software"
SRC_URI="https://downloads.arduino.cc/${MY_PN}-${PV}-linux64.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2+ LGPL-2+ Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip"
QA_PREBUILT="*"

src_install() {
	local size
	local ctx

	insinto /opt/"${MY_PN}"
	doins -r "${S}"/*
	rm "${ED%/}"/opt/${MY_PN}/{install.sh,uninstall.sh} || die
	fperms +x /opt/${MY_PN}/{arduino,arduino-builder}

	dosym ../../opt/"${MY_PN}/arduino" /usr/bin/${PN}

	# Create *.desktop file using the existing template file
	sed -e "s,<BINARY_LOCATION>,${EPREFIX}/opt/${MY_PN}/arduino,g" \
		-e "s,<ICON_NAME>,${PN},g" \
		-e "s/Arduino IDE/\0 Bin/g" \
		"${S}/lib/desktop.template" > "${T}/${PN}.desktop"
	domenu "${T}/${PN}.desktop" || die

	# Create the icon files
	for size in 16 24 32 48 72 96 128 256; do
		for ctx in apps mimetypes; do
			newicon -s ${size} -c ${ctx} \
					"${S}"/lib/icons/${size}x${size}/apps/${MY_PN}.png \
					${PN}.png
		done
	done
}
