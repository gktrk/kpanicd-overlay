# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic toolchain-funcs udev user

DESCRIPTION="Realtime linux framework libraries and tools"
HOMEPAGE="http://xenomai.org/"
SRC_URI="http://xenomai.org/downloads/${PN}/stable/${P}.tar.bz2"
LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug doc +cobalt mercury"
REQUIRED_USE="^^ ( cobalt mercury )"

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	enewgroup "${PN}"
}

src_prepare() {
	# Do not create the device nodes during install
	sed -e '/install-exec-local/ d;' -i Makefile.am || die
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		# Using /usr/include as includedir is not supported.
		--includedir="${EPREFIX%/}/usr/include/xenomai"
		--with-demodir="${EPREFIX%/}/usr/share/${PF}/demo"
		--with-testdir="${EPREFIX%/}/usr/share/${PF}/test"
		--with-core=$(usex cobalt cobalt mercury)
		--with-cc="$(tc-getCC)"
		--enable-debug=$(usex debug full no)
		$(use_enable doc doc-install)
	)

	# Don't allow user to specify the optimization
	# Xenomai uses its own optimization flags
	filter-flags '-O*'

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	udev_dorules "${S}"/kernel/cobalt/udev/*.rules
}

pkg_postinst() {
	elog "The header files are installed under: ${EROOT%/}/usr/include/xenomai"
	elog
	elog "You must add users to the ${PN} group to be able to access the device nodes"
	elog
	elog "You must create device nodes by running:"
	elog "  # emerge --config ${CATEGORY}/${P}"
}

pkg_config() {
	local f

	for n in `seq 0 31` ; do
		f="${EROOT%/}"/dev/rtp$n
		if test \! -c $f ; then
			mknod -m 666 $f c 150 $n
		fi
	done
}
