# Copyright 2019 Gokturk Yuksek
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Clustered/Stacked Filled Bar Graph Generator"
HOMEPAGE="http://www.burningcutlery.com/derek/bargraph/ https://github.com/derekbruening/bargraph"
SRC_URI="https://github.com/derekbruening/bargraph/releases/download/rel_4_8/${P}.tgz"
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
