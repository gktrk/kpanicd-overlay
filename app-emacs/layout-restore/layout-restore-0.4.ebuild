# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit elisp

DESCRIPTION="Keep window configuration as layout and restore it."
HOMEPAGE="http://www.emacswiki.org/emacs/layout-restore.el"
SRC_URI="http://www.emacswiki.org/emacs/download/${PN}.el"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${PN}.el"

src_unpack() {
	cp "${DISTDIR}/${PN}.el" "${WORKDIR}/${PN}.el"
}
