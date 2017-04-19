# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Clustered/Stacked Filled Bar Graph Generator"
HOMEPAGE="http://www.burningcutlery.com/derek/bargraph/"
SRC_URI="https://bintray.com/derekbruening/bargraph/download_file?file_path=${P}.tgz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="samples"

RDEPEND="dev-lang/perl:*
	sci-visualization/gnuplot
	media-gfx/transfig"

S=${WORKDIR}

src_compile() {
	use samples && \
		emake -j1 -C samples OUTDIR="${T}"/samples BARGRAPH="${S}"/bargraph.pl
}

src_install() {
	default
	dobin bargraph.pl
	use samples && dodoc -r "${T}"/samples
}
