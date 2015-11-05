# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit elisp

DESCRIPTION="Flex mode for Emacs"
HOMEPAGE="http://www.emacswiki.org/emacs/FlexMode"
SRC_URI="http://ftp.sunet.se/pub/gnu/emacs-lisp/incoming/flex-mode.el"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${PN}.el"

src_unpack() {
	cp "${DISTDIR}/${PN}.el" "${WORKDIR}/${PN}.el"
}
