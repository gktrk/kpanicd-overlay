# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit elisp

DESCRIPTION="Displays the number of words in the current buffer."
HOMEPAGE="http://http://www.emacswiki.org/emacs/WordCount"
# Old SRC_URI, looks dead. Use web archive to retrieve for now.
OLD_SRC_URI="http://taiyaki.org/elisp/word-count/src/word-count.el"
SRC_URI="http://web.archive.org/web/20100924082154/$OLD_SRC_URI -> ${P}.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.el" "${S}" || die
	elisp_src_unpack
}
