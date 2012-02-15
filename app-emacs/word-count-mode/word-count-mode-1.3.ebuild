# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit elisp

DESCRIPTION="Displays the number of words in the current buffer."
HOMEPAGE="http://http://www.emacswiki.org/emacs/WordCount"
SRC_URI="http://taiyaki.org/elisp/word-count/src/word-count.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/word-count.el"

src_unpack() {
	cp "${DISTDIR}/word-count.el" "${WORKDIR}/word-count.el"
}
