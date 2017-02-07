# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit elisp

DESCRIPTION="Keep window configuration as layout and restore it."
HOMEPAGE="http://www.emacswiki.org/emacs/layout-restore.el"
SRC_URI="http://www.emacswiki.org/emacs/download/${PN}.el -> ${P}.el"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.el" "${S}" || die
	elisp_src_unpack
}
