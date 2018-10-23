# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="RISCVEMU is a system emulator for the RISC-V architecture"
HOMEPAGE="https://bellard.org/riscvemu/"
SRC_URI="https://bellard.org/tinyemu/riscvemu-${MY_PV}.tar.gz"

LICENSE="MIT slirp? ( BSD-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+fs-net sdl +slirp"

DEPEND="
	fs-net? (
		net-misc/curl:=
		dev-libs/openssl:0=
	)
	sdl? ( media-libs/libsdl:= )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	# Strip away Werror, turn off debugging, add support for custom
	# CFLAGS, don't strip binaries
	sed -e '/CFLAGS/ s/-Werror//' \
		-e '/CFLAGS/ s/-g//' \
		-e '/CFLAGS=/ s/$/ $(MY_CFLAGS)/' \
		-e '/$(STRIP)/ d' \
		-i Makefile || die

	default
}

src_compile() {
	riscvemu_emakeargs=(
		CC="$(tc-getCC)"
		MY_CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		CONFIG_FS_NET=$(usex fs-net "y" "")
		CONFIG_SDL=$(usex sdl "y" "")
		CONFIG_X86EMU=
		CONFIG_SLIRP=$(usex slirp "y" "")
	)

	emake "${riscvemu_emakeargs[@]}"

	export riscvemu_emakeargs
}

src_install() {
	local DOCS=( readme.txt )

	riscvemu_emakeargs=("${riscvemu_emakeargs[@]}"
		bindir="${EPREFIX%/}/usr/bin"
		DESTDIR="${D}"
	)

	dodir "/usr/bin"
	emake "${riscvemu_emakeargs[@]}" install
	einstalldocs

	unset riscvemu_emakeargs
}
