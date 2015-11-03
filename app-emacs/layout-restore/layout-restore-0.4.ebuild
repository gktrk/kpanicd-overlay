# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit elisp

DESCRIPTION="Keep window configuration as layout and restore it."
HOMEPAGE="http://www.emacswiki.org/emacs/layout-restore.el"
SRC_URI="http://www.emacswiki.org/emacs/download/${PN}.el"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${PN}.el"

src_unpack() {
	cp "${DISTDIR}/${PN}.el" "${WORKDIR}/${PN}.el"
}
