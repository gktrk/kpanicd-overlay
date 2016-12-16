# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PV="${PV//./-}"

DESCRIPTION="Intel X86 Encoder Decoder Software Library"
HOMEPAGE="https://software.intel.com/en-us/articles/xed-x86-encoder-decoder-software-library"
SRC_URI="xed-install-base-${MY_PV}-lin-x86-64.zip" # TODO: Add 32-bit support
LICENSE="What-If-Pre-Release"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="fetch mirror"

DEPEND="app-arch/unzip"

S="${WORKDIR}/kits/xed-install-base-${MY_PV}-lin-x86-64"

pkg_nofetch() {
	einfo "Please visit the download page [1], download ${A} and save it under ${DISTDIR}"
	einfo "[1] https://software.intel.com/en-us/articles/xed-x86-encoder-decoder-software-library"
}

src_compile() {
	emake -C examples SHARED=1 cmdline
}

src_test() {
	emake -C examples SHARED=1 demos
	LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}" examples/
}

# TODO
# QA Notice: The following files contain insecure RUNPATHs
#  Please file a bug about this at http://bugs.gentoo.org/
#  with the maintainer of the package.
#   /var/tmp/portage/dev-libs/libipt-1.5/image/usr/bin/ptxed
#     RPATH: /var/tmp/portage/dev-libs/libipt-1.5/work/libipt-1.5_build/lib
#   /var/tmp/portage/dev-libs/libipt-1.5/image/usr/bin/ptdump
#     RPATH: /var/tmp/portage/dev-libs/libipt-1.5/work/libipt-1.5_build/lib
src_install() {
	default

	dobin examples/xed
	doheader include/*
	dolib.so lib/*.so
}
